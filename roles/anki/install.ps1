<#
.SYNOPSIS
    Installs Anki using Chocolatey.

.DESCRIPTION
    Installs Anki using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\anki\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Anki...'

& choco.exe install anki --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Anki (exit code $LASTEXITCODE)."
}

