<#
.SYNOPSIS
    Installs RustDesk using Chocolatey.

.DESCRIPTION
    Installs RustDesk using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\rustdesk\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing RustDesk...'

& choco.exe install rustdesk.install --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install RustDesk (exit code $LASTEXITCODE)."
}

