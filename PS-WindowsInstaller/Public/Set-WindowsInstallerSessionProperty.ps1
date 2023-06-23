<#
.SYNOPSIS
   Sets a property of a Windows Installer Session.

.DESCRIPTION
   The function Set-WindowsInstallerSessionProperty sets the value of a specified property in a Windows Installer Session.

.PARAMETER Session
   The Windows Installer Session COM object.

.PARAMETER PropertyName
   The name of the property to set.

.PARAMETER PropertyValue
   The value to set the property to.

.EXAMPLE
   Set-WindowsInstallerSessionProperty -Session $Session -PropertyName "ProductName" -PropertyValue "NewProductName"
#>
function Set-WindowsInstallerSessionProperty {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[System.__ComObject]	$Session,

		[Parameter(Mandatory = $true)]
		[string]				$PropertyName,

		[Parameter(Mandatory = $true)]
		[string]				$PropertyValue
	)

	Process {
		$Session.GetType().InvokeMember('Property', [System.Reflection.BindingFlags]::SetProperty, $null, $Session, @($PropertyName, $PropertyValue))
	}

}
Export-ModuleMember -Function Set-WindowsInstallerSessionProperty
