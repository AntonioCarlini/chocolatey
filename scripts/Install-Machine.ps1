<#
.SYNOPSIS
    Installs a machine configuration profile.

.DESCRIPTION
    Loads a machine configuration profile and executes the installation
    script for each role defined in that profile. Throws an exception if
    the profile is invalid or a role installation fails.

.PARAMETER Profile
    The name of the machine configuration profile to install, without the
    .psd1 extension. Must contain only lowercase letters, digits and hyphens.

.NOTES
    Requires administrator privileges and Chocolatey to be installed.
    Profile files are loaded from the repository's profiles directory.
    Role installation scripts are loaded from the repository's roles directory.

.EXAMPLE
    .\scripts\Install-Machine.ps1 -Profile desktop
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[a-z0-9-]+$')]
    [string]$Profile
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Require administrator privileges.
$principal = [Security.Principal.WindowsPrincipal]::new(
    [Security.Principal.WindowsIdentity]::GetCurrent()
)

if (-not $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)) {
    throw 'Run this script from an elevated PowerShell session.'
}

# Require Chocolatey to be installed.
if (-not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    throw 'Chocolatey is not installed. Run Install-Chocolatey.ps1 first.'
}

# Locate and load the requested profile.
$repository_root = Split-Path -Parent $PSScriptRoot
$profile_path = Join-Path $repository_root "profiles\$Profile.psd1"

if (-not (Test-Path -LiteralPath $profile_path -PathType Leaf)) {
    throw "Profile file not found: $profile_path"
}

$machine = Import-PowerShellDataFile -Path $profile_path

if (-not $machine.ContainsKey('Roles')) {
    throw "Profile '$Profile' does not define a Roles list."
}

Write-Host "Installing profile '$Profile'..."

# Execute each role in the profile.
foreach ($role in $machine.Roles) {
    if ($role -notmatch '^[a-z0-9-]+$') {
        throw "Invalid role name in profile: $role"
    }

    $role_script = Join-Path $repository_root "roles\$role\install.ps1"

    if (-not (Test-Path -LiteralPath $role_script -PathType Leaf)) {
        throw "Installation script not found for role '$role': $role_script"
    }

    Write-Host ''
    Write-Host "=== Role: $role ==="

    & $role_script

    Write-Host "Role '$role' completed."
}

Write-Host ''
Write-Host "Installation completed for '$Profile'."
