<#
.SYNOPSIS
    Installs Foxit PDF Reader using Chocolatey.

.DESCRIPTION
    Installs Foxit PDF Reader using Chocolatey. Throws an exception if
    Chocolatey reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\foxit-reader\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Foxit PDF Reader...'

& choco.exe install foxitreader --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Foxit PDF Reader (exit code $LASTEXITCODE)."
}
