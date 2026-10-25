<#
.SYNOPSIS
    Installs Arduino IDE using Chocolatey.

.DESCRIPTION
    Installs Arduino IDE using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\arduino-ide\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Arduino IDE...'

& choco.exe install arduino --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Arduino IDE (exit code $LASTEXITCODE)."
}

