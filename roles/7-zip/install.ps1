<#
.SYNOPSIS
    Installs 7-Zip using Chocolatey.

.DESCRIPTION
    Installs 7-Zip using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\7-zip\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing 7-Zip...'

& choco.exe install 7zip --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install 7-Zip (exit code $LASTEXITCODE)."
}

