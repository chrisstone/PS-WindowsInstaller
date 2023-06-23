# PS-WindowsInstaller

PowerShell Module to expose WindowInstaller Objects, Methods, and Properties

https://learn.microsoft.com/en-us/windows/win32/msi/windows-installer-reference

## Installation

Not available via PowerShell Gallery (yet). Download/clone this repository.

```powershell
Import-Module "C:\Path\To\PS-Installer\PS-Installer.psd1"
```

## Basic Usage

### Silently Uninstall 'BadProduct'

```powershell
$Installer = New-WindowsInstallerInstaller

Set-WindowsInstallerInstallerLog -LogMode '+'  -LogFile 'C:\Windows\Temp\My.Log' -Installer $Installer
Set-WindowsInstallerInstallerUILevel -UILevel 2 -Installer $Installer

$AllProducts = Get-WindowsInstallerInstallerProduct |% { Get-WindowsInstallerInstallerProductInfo $_ }
$BadProducts = $AllProducts |?{$_.ProductName -match 'BadProduct'}

$BadProducts.ProductCode |%{
	Write-Host ('Uninstalling {0}' -f $_)
	Set-WindowsInstallerInstallerProduct -ProductCode $_ -InstallState msiInstallStateAbsent -Installer $Installer
}
