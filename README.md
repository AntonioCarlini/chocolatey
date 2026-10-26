# Windows configuration using Chocolatey

This repository holds PowerShell scripts and configuration files for installing and configuring applications on Windows systems using Chocolatey.

Machine-specific profiles define which roles are to be installed. Roles provide reusable installation and configuration logic for individual applications or groups of applications.

## Preparation

The scripts assume that Git for Windows is installed and that this repository has been cloned locally.

### Install Git

* Download Git for Windows from the official website: https://git-scm.com/install/windows
* Install Git
* Open PowerShell and verify the installation:

  ```powershell
  git --version
  ```

### Clone this repository

Clone the repository and change to its directory:

```powershell
git clone https://github.com/AntonioCarlini/chocolatey
cd chocolatey
```

### Allow PowerShell scripts to run

Windows 10's PowerShell's default execution policy prevents PowerShell scripts from running. Before executing the installation scripts, you must either change the policy permanently for your user account or temporarily for the current PowerShell session.

**Option 1: Allow scripts persistently for the current user**

Run the following command in PowerShell:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

This allows locally created scripts to run but requires downloaded scripts to be signed by a trusted publisher. The setting persists across PowerShell sessions and does not require administrator privileges.

**Option 2: Allow scripts for the current session only**

Alternatively, run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```

This applies only to the current PowerShell process and its child processes. The setting is discarded when the session closes. Run this command again in any new PowerShell session in which you want to execute PowerShell scripts.

Execution policies enforced through Group Policy can override these settings.

### Install Chocolatey

Chocolatey is used to install and manage application packages.

Open PowerShell as an administrator, change to the repository directory, and run:

```powershell
.\scripts\Install-Chocolatey.ps1
```

The script checks whether Chocolatey is already installed and installs it if necessary.

### Install a machine profile

Once Chocolatey is installed, use `Install-Machine.ps1` to install the roles defined in a machine profile.

For example, to configure the generic laptop:

```powershell
.\scripts\Install-Machine.ps1 -Profile laptop-generic
```

Run PowerShell as an administrator when executing these scripts.

To ppen PowerShell as an administrator: open the Start menu, search for PowerShell, right-click Windows PowerShell, and select Run as administrator. Approve the User Account Control prompt if requested. Run the installation commands from that window.

## Profiles, Roles and Scripts

Profiles define which roles are required for a particular machine. Roles provide reusable installation and configuration logic. Scripts provide the bootstrap and orchestration functionality.

This table lists the available profiles, roles and scripts.

## Scripts

| Name | Type | Summary |
|------|------|---------|
| [Install-Chocolatey](scripts/Install-Chocolatey.ps1) | Script | Installs Chocolatey if it is not already installed. |
| [Windows-10-adjust-configuration](scripts/Windows-10-adjust-configuration.ps1)| Script | Adjusts various Windows 10 settings and removes some cruft. |

## Roles

| Name | Type | Summary |
|------|------|---------|
| [7-zip](roles/7-zip/install.ps1) | Role | Installs the7-zip archive tool. |
| [Anki](roles/anki/install.ps1) | Role | Installs Anki flashcard software. |
| [Arduino IDE](roles/arduino-ide/install.ps1) | Role | Installs the Arduino IDE. |
| [Firefox](roles/firefox/install.ps1) | Role | Installs the Firefox web browser. |
| [Foxit Reader](roles/foxit-reader/install.ps1) | Role | Installs Foxit Reader PDF viewer. |
| [KDiff3](roles/kdiff3/install.ps1) | Role | Installs the KDiff3 GUI file-difference viewer. |
| [IrfanView](roles/irfanview/install.ps1) | Role | Installs IrfanView image viewer and editor. |
| [LibreOffice](roles/libreoffice/install.ps1) | Role | Installs the LibreOffice suite. |
| [Notepad++](roles/notepad-plus-plus/install.ps1) | Role | Installs Notepad++ text and source-code editor. |
| [Poppler](roles/poppler/install.ps1) | Role | Installs the Poppler PDF tool suite. |
| [PuTTY](roles/putty/install.ps1) | Role | Installs PuTTY a free SSH, Telnet and serial client. |
| [RustDesk](roles/rustdesk/install.ps1) | Role | Installs RustDesk remote desktop software. |
| [Teams](roles/teams/install.ps1) | Role | Installs Microsoft Teams collaboration software. |
| [Wireshark](roles/wireshark/install.ps1) | Role | Installs Wireshark network analysis tool. |

## Profiles

<!-- Add machine profiles here when available. -->


