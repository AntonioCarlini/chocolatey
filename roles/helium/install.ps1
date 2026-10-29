<#
.SYNOPSIS
    Installs Helium using Chocolatey.

.DESCRIPTION
    Installs Helium using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\helium\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Helium...'

& choco.exe install helium --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Helium (exit code $LASTEXITCODE)."
}
