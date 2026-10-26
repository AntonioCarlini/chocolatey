<#
.SYNOPSIS
    Installs PuTTY using Chocolatey.

.DESCRIPTION
    Installs PuTTY using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\putty\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing PuTTY...'

& choco.exe install putty --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install PuTTY (exit code $LASTEXITCODE)."
}

