<#
.SYNOPSIS
    Installs TortoiseGit using Chocolatey.

.DESCRIPTION
    Installs TortoiseGit using Chocolatey. Throws an exception if Chocolatey
    reports a failure.

.NOTES
    Requires Chocolatey and Git for Windows to be installed.

.EXAMPLE
    .\roles\tortoisegit\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing TortoiseGit...'

& choco.exe install tortoisegit --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install TortoiseGit (exit code $LASTEXITCODE)."
}
