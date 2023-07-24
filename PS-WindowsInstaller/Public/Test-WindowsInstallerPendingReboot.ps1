<#
.SYNOPSIS
Checks if a reboot is pending due to a Windows Installer operation.

.DESCRIPTION
The Test-WindowsInstallerPendingReboot function checks specific registry keys which Windows Installer sets when a reboot is needed. If any of the keys exist or meet certain conditions, a reboot is likely pending.

.EXAMPLE
Test-WindowsInstallerPendingReboot

In this example, the function checks the registry and returns $true if a reboot is pending, and $false otherwise.

.OUTPUTS
System.Boolean
This function returns $true if a reboot is pending and $false if it is not.
#>
function Test-WindowsInstallerPendingReboot {
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param()

	if (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations") {
		return $true
	}
	if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") {
		return $true
	}
	try {
		if ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Updates").UpdateExeVolatile -ne 0) {
			return $true
		}
	} catch {
		Write-Verbose 'Updates key not present'
	}

	return $false
}
Export-ModuleMember -Function Test-WindowsInstallerPendingReboot
