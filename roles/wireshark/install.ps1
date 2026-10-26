<#
.SYNOPSIS
    Installs Wireshark using Chocolatey.

.DESCRIPTION
    Installs Wireshark using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\wireshark\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Wireshark...'

& choco.exe install wireshark --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Wireshark (exit code $LASTEXITCODE)."
}

