<#
.SYNOPSIS
   Sets the UILevel of the Windows Installer

.DESCRIPTION
   The function Set-InstallerUILevel sets the UILevel of the Windows Installer.

.PARAMETER UILevel
   The UILevel to be set for the Windows Installer.

.EXAMPLE
   Set-InstallerUILevel -UILevel (msiUILevelDefault -bor msiUILevelReduced)
#>
function Set-WindowsInstallerInstallerUILevel {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateRange(0, 255)]
		[msiUILevel] $UILevel,

		[Parameter(Mandatory = $true)]
		[System.__ComObject] $Installer
	)

	Process {
		$Installer.GetType().InvokeMember('UILevel', [System.Reflection.BindingFlags]::SetProperty, $null, $Installer, $UILevel)
	}

}
Export-ModuleMember -Function Set-WindowsInstallerInstallerUILevel
