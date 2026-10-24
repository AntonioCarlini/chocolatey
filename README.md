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

| Name | Type | Summary |
|------|------|---------|
| [Install-Chocolatey](scripts/Install-Chocolatey.ps1) | Script | Installs Chocolatey if it is not already installed. |


