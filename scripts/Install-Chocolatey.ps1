<#
.SYNOPSIS
    Installs Chocolatey if it is not already installed.

.DESCRIPTION
    Checks whether Chocolatey is available. If it is already installed,
    the script verifies that it runs and exits without reinstalling it.
    Otherwise, it downloads and executes the official Chocolatey installer
    and verifies the installation.

.NOTES
    Requires an elevated PowerShell session and an internet connection.

.EXAMPLE
    .\scripts\Install-Chocolatey.ps1

    Installs Chocolatey if necessary.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$principal = [Security.Principal.WindowsPrincipal]::new(
    [Security.Principal.WindowsIdentity]::GetCurrent()
)

if (-not $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)) {
    throw 'Run this script from an elevated PowerShell session.'
}

$choco = Get-Command choco.exe -ErrorAction SilentlyContinue

if ($choco) {
    Write-Host 'Chocolatey is already installed.'
    & $choco.Source --version

    if ($LASTEXITCODE -ne 0) {
        throw 'The Chocolatey version check failed.'
    }

    return
}

[Net.ServicePointManager]::SecurityProtocol = (
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12
)

$installer_url = 'https://community.chocolatey.org/install.ps1'
$installer_path = Join-Path $env:TEMP 'Install-Chocolatey-upstream.ps1'

try {
    Write-Host 'Downloading the official Chocolatey installer...'

    Invoke-WebRequest -Uri $installer_url -OutFile $installer_path
    Unblock-File -Path $installer_path

    Write-Host 'Running the Chocolatey installer...'

    & $installer_path

    # Refresh PATH after installation.
    $machine_path = [Environment]::GetEnvironmentVariable(
        'Path', 'Machine'
    )
    $user_path = [Environment]::GetEnvironmentVariable(
        'Path', 'User'
    )

    $env:Path = "$machine_path;$user_path"

    $choco = Get-Command choco.exe -ErrorAction SilentlyContinue

    if (-not $choco) {
        throw 'Chocolatey was not found on PATH after installation.'
    }

    & $choco.Source --version

    if ($LASTEXITCODE -ne 0) {
        throw 'Chocolatey was installed, but its version check failed.'
    }

    Write-Host 'Chocolatey installation verified successfully.'
}
finally {
    Remove-Item $installer_path -Force -ErrorAction SilentlyContinue
}
