<#
.SYNOPSIS
   Gets a property of a Windows Installer Session.

.DESCRIPTION
   The function Get-WindowsInstallerSessionProperty gets the value of a specified property from a Windows Installer Session.

.PARAMETER Session
   The Windows Installer Session COM object.

.PARAMETER PropertyName
   The name of the property to get.

.EXAMPLE
   Get-WindowsInstallerSessionProperty -Session $Session -PropertyName "ProductName"
#>
function Get-WindowsInstallerSessionProperty {
	[CmdletBinding()]
	[OutputType([String])]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.__ComObject]		$Session,

		[Parameter(Mandatory = $true)]
		[string]					$PropertyName
	)

	Process {
		return $Session.GetType().InvokeMember('Property', [System.Reflection.BindingFlags]::GetProperty, $null, $Session, $PropertyName)
	}
}
Export-ModuleMember -Function Get-WindowsInstallerSessionProperty
