<#
.SYNOPSIS
    Installs KDiff3 using Chocolatey.

.DESCRIPTION
    Installs KDiff3 using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\kdiff3\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing KDiff3...'

& choco.exe install kdiff3 --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install KDiff3 (exit code $LASTEXITCODE)."
}

