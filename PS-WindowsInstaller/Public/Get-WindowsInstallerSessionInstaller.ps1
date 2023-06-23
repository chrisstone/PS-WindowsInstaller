<#
.SYNOPSIS
   Gets the Installer of a Windows Installer Session.

.DESCRIPTION
   The function Get-WindowsInstallerSessionInstaller gets the Installer property from a Windows Installer Session.

.PARAMETER Session
   The Windows Installer Session COM object.

.EXAMPLE
   Get-WindowsInstallerSessionInstaller -Session $Session
#>
function Get-WindowsInstallerSessionInstaller {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[System.__ComObject] $Session
	)

	Process {
		return $Session.GetType().InvokeMember('Installer', [System.Reflection.BindingFlags]::GetProperty, $null, $Session, $null)
	}

}
Export-ModuleMember -Function Get-WindowsInstallerSessionInstaller
