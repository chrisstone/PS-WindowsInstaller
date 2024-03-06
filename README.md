# PS-WindowsInstaller

PowerShell Module to wrap the WindowInstaller Objects, Methods, and Properties

https://learn.microsoft.com/en-us/windows/win32/msi/windows-installer-reference

## Installation

Available via [PowerShell Gallery](https://www.powershellgallery.com/packages/PS-WindowsInstaller/), or download/clone this repository.

```powershell
Install-Module -Name PS-WindowsInstaller
# -- OR --
Import-Module "C:\Path\To\Downloaded_Cloned\Repository\PS-Installer.psd1"
```

## Basic Usage

### Install an MSI

```powershell

$PackageSession = Open-WindowsInstallerPackage -PackagePath 'C:\MyInstaller.msi'
$Return = Invoke-WindowsInstallerSessionAction -Session $PackageSession -Action 'INSTALL'
```

### Silently Uninstall 'BadProduct' with Logging

```powershell
$Installer = New-WindowsInstallerInstaller

Set-WindowsInstallerInstallerLog -LogMode 'v+'  -LogFile 'C:\Temp\My.Log' -Installer $Installer
Set-WindowsInstallerInstallerUILevel -UILevel 2 -Installer $Installer

$AllProducts = Get-WindowsInstallerInstallerProduct |% { Get-WindowsInstallerInstallerProductInfo $_ }
$BadProducts = $AllProducts |?{$_.ProductName -match 'BadProduct'}

$BadProducts.ProductCode |%{
	Write-Host ('Uninstalling {0}' -f $_)
	Set-WindowsInstallerInstallerProduct -ProductCode $_ -InstallState msiInstallStateAbsent -Installer $Installer
}
```