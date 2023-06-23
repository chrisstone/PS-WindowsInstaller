<#
.SYNOPSIS
   Retrieves the UILevel of the Windows Installer

.DESCRIPTION
   The function Get-InstallerUILevel gets the UILevel of the Windows Installer.

.EXAMPLE
   Get-InstallerUILevel
#>
function Get-InstallerUILevel {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[System.__ComObject]	$Installer
	)

	Process {
		return $Installer.GetType().InvokeMember('UILevel', [System.Reflection.BindingFlags]::GetProperty, $null, $Installer, $null)
	}

}
Export-ModuleMember -Function Get-InstallerUILevel
