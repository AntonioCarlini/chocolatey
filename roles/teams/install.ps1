<#
.SYNOPSIS
    Installs Microsoft Teams using Chocolatey.

.DESCRIPTION
    Installs the new Microsoft Teams client using Chocolatey.
    Throws an exception if Chocolatey reports a failure.

.NOTES
    Requires Chocolatey to be installed.
    Installs Teams for all users on the machine.

.EXAMPLE
    .\roles\teams\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Microsoft Teams...'

& choco.exe install microsoft-teams-new-bootstrapper --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Microsoft Teams (exit code $LASTEXITCODE)."
}

