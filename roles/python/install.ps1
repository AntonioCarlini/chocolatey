<#
.SYNOPSIS
    Installs Python using Chocolatey.

.DESCRIPTION
    Installs Python using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\python\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Python...'

& choco.exe install python --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Python (exit code $LASTEXITCODE)."
}

