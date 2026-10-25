<#
.SYNOPSIS
    Installs IrfanView using Chocolatey.

.DESCRIPTION
    Installs IrfanView using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\irfanview\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing IrfanView...'

& choco.exe install irfanview --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install IrfanView (exit code $LASTEXITCODE)."
}
