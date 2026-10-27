<#
.SYNOPSIS
    Installs the HP LaserJet Professional P1102w printer driver.

.DESCRIPTION
    There is no Chocolatey package for this driver, so this script:
      1. Downloads the HP "Full Solution" package to %TEMP% if it is not
         already there.
      2. Extracts only the driver files (not HP's GUI installer) to a
         scratch folder under %TEMP%.
      3. Stages the driver in the Windows driver store (pnputil) and
         registers it with the print spooler (Add-PrinterDriver).
      4. Optionally installs HP's port monitor MSI.
      5. Removes the extracted files on success. On failure they are kept
         so they can be inspected or deleted by hand.

    No printer queue is created. The printer is used over USB, so Windows
    creates the queue itself when the printer is first plugged in.

    The script is idempotent: if the driver is already registered with the
    spooler it does nothing.

.PARAMETER CleanupDownload
    Delete the downloaded installer on success, but only if this run
    downloaded it. A pre-existing download is left alone.

.PARAMETER ForceCleanup
    Delete the downloaded installer on success even if it was already
    present before this run. Takes precedence over -CleanupDownload.

.PARAMETER SkipPortMonitor
    Do not install HP's port monitor (PortMonitorInstaller64.msi).

.NOTES
    Requires an elevated PowerShell session and 7-Zip (the 7-zip role).
    Install-Machine.ps1 runs role scripts without parameters, so the
    switches only apply when this script is run directly.

    Not verifiable without the hardware: that Windows selects this driver
    when the printer is plugged in, and that the firmware upload works.
    Check both on first connection.

.EXAMPLE
    .\roles\hp-laserjet-p1102w\install.ps1

.EXAMPLE
    .\roles\hp-laserjet-p1102w\install.ps1 -CleanupDownload
#>

[CmdletBinding()]
param(
    [switch]$CleanupDownload,
    [switch]$ForceCleanup,
    [switch]$SkipPortMonitor
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$driver_name    = 'HP LaserJet Professional P1102w'
$download_url   = 'https://ftp.hp.com/pub/softlib/software13/COL32431/bi-80329-12/hp_LJP1100_P1560_P1600_Full_Solution-v20180815-50157037_1.exe'
$installer_name = 'hp_LJP1100_P1560_P1600_Full_Solution-v20180815-50157037_1.exe'
$installer_path = Join-Path $env:TEMP $installer_name
$extract_dir    = Join-Path $env:TEMP 'hp-laserjet-p1102w-extract'
$msi_log        = Join-Path $env:TEMP 'hp-laserjet-p1102w-portmonitor.log'

# Files to pull out of the archive. HP1100.INF resolves most of its files from
# the cabs, but its default LANGDIR is "English", so the remaining files come
# from the English and English\x64 folders next to the INF. Paths are kept
# relative to the INF, which is what pnputil expects.
$driver_files = @(
    'HP1100.INF'
    'drv32.cab'
    'drv64.cab'
    'hp110032.cat'
    'hp110064.cat'
    'HP1100SU.VER'
    'English\HP1100SD.chm'
    'English\HP1100SD.SDD'
    'English\HP1100SU.ent'
    'English\HP1600SD.SDD'
    'English\P1100OS.htm'
    'English\HP1100SMs.dll'
    'English\Strings.dll'
    'English\x64\HP1100SMs.dll'
)
$port_monitor_files = @(
    'PortMonitorInstaller64.msi'
    'PortMonitorInstallerRes.cab'
)

# Require administrator privileges.
$principal = [Security.Principal.WindowsPrincipal]::new(
    [Security.Principal.WindowsIdentity]::GetCurrent()
)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Run this script from an elevated PowerShell session.'
}

# Idempotency: nothing to do if the driver is already registered.
if (Get-PrinterDriver -Name $driver_name -ErrorAction SilentlyContinue) {
    Write-Host "Printer driver '$driver_name' is already installed; nothing to do."
    return
}

# Locate 7-Zip.
$seven_zip = @(
    (Join-Path $env:ProgramFiles '7-Zip\7z.exe')
    (Join-Path ${env:ProgramFiles(x86)} '7-Zip\7z.exe')
) | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1

if (-not $seven_zip) {
    throw '7-Zip not found. Install the 7-zip role first.'
}

# 1. Download, unless already present. Remember whether we did it.
$downloaded_by_this_run = $false

if (Test-Path -LiteralPath $installer_path -PathType Leaf) {
    Write-Host 'Installer already exists; skipping download.'
}
else {
    Write-Host 'Downloading HP LaserJet P1102w driver...'

    # Download to a temporary name so an interrupted download is never
    # mistaken for a complete installer on the next run.
    $partial_path = "$installer_path.part"
    Remove-Item -LiteralPath $partial_path -Force -ErrorAction SilentlyContinue

    Invoke-WebRequest -Uri $download_url -OutFile $partial_path -ErrorAction Stop
    Move-Item -LiteralPath $partial_path -Destination $installer_path

    $downloaded_by_this_run = $true
}

Get-ChildItem -LiteralPath $installer_path |
    Format-List Name, FullName, Length, LastWriteTime

# 2. Extract, install, register. The extract folder is kept if anything fails.
try {
    Write-Host "Extracting driver files to $extract_dir ..."

    if (Test-Path -LiteralPath $extract_dir) {
        Remove-Item -LiteralPath $extract_dir -Recurse -Force
    }

    $files_to_extract = $driver_files
    if (-not $SkipPortMonitor) {
        $files_to_extract += $port_monitor_files
    }

    # The HP exe is a 7-Zip SFX with a trailing signature, so 7-Zip reports
    # a warning (exit code 1). That is expected; only 2 and above are errors.
    & $seven_zip x -t7z $installer_path "-o$extract_dir" -y @files_to_extract | Out-Null
    if ($LASTEXITCODE -gt 1) {
        throw "7-Zip extraction failed (exit code $LASTEXITCODE)."
    }

    foreach ($file in $files_to_extract) {
        if (-not (Test-Path -LiteralPath (Join-Path $extract_dir $file) -PathType Leaf)) {
            throw "Expected file missing after extraction: $file"
        }
    }

    # Stage the driver in the Windows driver store.
    Write-Host 'Staging driver in the Windows driver store...'
    $inf_path = Join-Path $extract_dir 'HP1100.INF'

    & pnputil.exe /add-driver $inf_path /install
    # 3010 means success, reboot required.
    if ($LASTEXITCODE -notin 0, 3010) {
        throw "pnputil failed to add the driver (exit code $LASTEXITCODE)."
    }

    # Register the driver with the print spooler.
    Write-Host 'Registering driver with the print spooler...'
    Add-PrinterDriver -Name $driver_name

    if (-not (Get-PrinterDriver -Name $driver_name -ErrorAction SilentlyContinue)) {
        throw "Driver '$driver_name' is not registered after Add-PrinterDriver."
    }

    # Optional: HP's port monitor.
    if (-not $SkipPortMonitor) {
        Write-Host 'Installing HP port monitor...'
        $msi_path = Join-Path $extract_dir 'PortMonitorInstaller64.msi'

        $msi_process = Start-Process -FilePath 'msiexec.exe' `
            -ArgumentList "/i `"$msi_path`" /qn /norestart /l*v `"$msi_log`"" `
            -Wait -PassThru -NoNewWindow

        if ($msi_process.ExitCode -notin 0, 3010) {
            throw "Port monitor installation failed (exit code $($msi_process.ExitCode)). See $msi_log"
        }
    }
}
catch {
    Write-Host ''
    Write-Host "Installation failed. Extracted files kept for inspection: $extract_dir"
    throw
}

# 3. Success: clean up.
Write-Host 'Removing extracted files...'
Remove-Item -LiteralPath $extract_dir -Recurse -Force

if ($ForceCleanup) {
    Write-Host 'Removing downloaded installer (-ForceCleanup)...'
    Remove-Item -LiteralPath $installer_path -Force
}
elseif ($CleanupDownload -and $downloaded_by_this_run) {
    Write-Host 'Removing downloaded installer (downloaded by this run)...'
    Remove-Item -LiteralPath $installer_path -Force
}
elseif ($CleanupDownload) {
    Write-Host 'Keeping installer: it was already present before this run.'
}

Write-Host ''
Write-Host "Driver '$driver_name' installed."
Write-Host 'Plug the printer in via USB to complete setup. Windows should create the queue itself.'