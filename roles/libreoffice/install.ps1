<#
.SYNOPSIS
    Installs LibreOffice using Chocolatey.

.DESCRIPTION
    Installs LibreOffice Still using Chocolatey. Throws an exception if
    Chocolatey reports a failure.

.NOTES
    Requires Chocolatey to be installed.
    Install the "Still" release (more tested than "Fresh")

.EXAMPLE
    .\roles\libreoffice\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing LibreOffice...'

& choco.exe install libreoffice-still --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install LibreOffice (exit code $LASTEXITCODE)."
}

