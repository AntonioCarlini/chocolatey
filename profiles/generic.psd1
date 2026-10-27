<#
.SYNOPSIS
    Generic configuration profile for Windows systems.

.DESCRIPTION
    Defines a baseline software install for most Windows systems.
#>

@{
    Roles = @(
        'firefox'
        'notepad-plus-plus'
        '7-zip'
        'irfanview'
        'kdiff3'
        'libreoffice'
        'putty'
        'python'
        'teams'
        'wireshark'
        'anki'
    )
}
