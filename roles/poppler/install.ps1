<#
.SYNOPSIS
    Installs Poppler using Chocolatey.

.DESCRIPTION
    Installs Poppler using Chocolatey, providing PDF utilities such as
    pdfimages and pdfinfo. Throws an exception if Chocolatey reports
    a failure.
	
	This is the full list of installed utilities:

    | Utility       | Purpose                                                                     |
    | ------------- | --------------------------------------------------------------------------- |
    | `pdfattach`   | Add an embedded file to a PDF.                                              |
    | `pdfdetach`   | List or extract embedded attachments from a PDF.                            |
    | `pdffonts`    | List fonts used in a PDF and their properties.                              |
    | `pdfimages`   | List and extract images embedded in a PDF.                                  |
    | `pdfinfo`     | Display PDF metadata, page count, page size and other document information. |
    | `pdfseparate` | Extract individual pages into separate PDF files.                           |
    | `pdfsig`      | Inspect and verify PDF digital signatures.                                  |
    | `pdftocairo`  | Convert PDF pages to formats such as PNG, JPEG, SVG and PostScript.         |
    | `pdftohtml`   | Convert a PDF to HTML.                                                      |
    | `pdftoppm`    | Render PDF pages as PPM, PGM or PBM images.                                 |
    | `pdftops`     | Convert a PDF to PostScript.                                                |
    | `pdftotext`   | Extract text from a PDF.                                                    |
    | `pdfunite`    | Combine multiple PDF files into one PDF.                                    |


.NOTES
    Requires Chocolatey to be installed.

.EXAMPLE
    .\roles\poppler\install.ps1
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Poppler...'

& choco.exe install poppler --yes --no-progress

if ($LASTEXITCODE -ne 0) {
    throw "Chocolatey failed to install Poppler (exit code $LASTEXITCODE)."
}
