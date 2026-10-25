<#
.SYNOPSIS
    Installs Firefox using Chocolatey.

.DESCRIPTION
    Installs Firefox using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\firefox\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Firefox...'

& choco.exe install firefox --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Firefox (exit code $LASTEXITCODE)."
}

