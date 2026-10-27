<#
.SYNOPSIS
    Installs the generic laptop configuration profile.

.DESCRIPTION
    Invokes Install-Machine.ps1 to install the roles defined in the
    laptop-generic profile.

.NOTES
    Requires administrator privileges and Chocolatey to be installed.

.EXAMPLE
    .\scripts\install-profile-laptop-generic.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repository_root = Split-Path -Parent $PSScriptRoot
$install_script = Join-Path $PSScriptRoot 'Install-Machine.ps1'

if (-not (Test-Path -LiteralPath $install_script -PathType Leaf)) {
    throw "Machine installation script not found: $install_script"
}

& $install_script -Profile 'generic'
