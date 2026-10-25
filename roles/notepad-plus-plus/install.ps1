<#
.SYNOPSIS
    Installs Notepad++ using Chocolatey.

.DESCRIPTION
    Installs Notepad++ using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\notepad-plus-plus\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Notepad++...'

& choco.exe install notepadplusplus --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Notepad++ (exit code $LASTEXITCODE)."
}
