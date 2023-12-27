<#
.SYNOPSIS
  Sets one or more properties of a Windows Installer Session.

.DESCRIPTION
  The function Set-WindowsInstallerSessionProperty sets the value of a specified property in a Windows Installer Session. It can either set a single property using the PropertyName and PropertyValue parameters, or it can set multiple properties at once using a hashtable.

.PARAMETER Session
  The Windows Installer Session COM object.

.PARAMETER PropertyName
  The name of the property to set. This parameter is optional when using the Properties parameter.

.PARAMETER PropertyValue
  The value to set the property to. This parameter is optional when using the Properties parameter.

.PARAMETER Properties
  A hashtable of properties to set. The keys of the hashtable represent the property names, and the values represent the property values.

.EXAMPLE
  Set-WindowsInstallerSessionProperty -Session $Session -PropertyName "ProductName" -PropertyValue "NewProductName"

.EXAMPLE
  $properties = @{
      "INSTALLDIR" = "C:\Program Files"
      "ALLUSERS" = "1"
  }
  Set-WindowsInstallerSessionProperty -Session $session -Properties $properties
#>
function Set-WindowsInstallerSessionProperty {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.__ComObject]    $Session,

		[Parameter(Mandatory = $false)]
		[Alias("Name")]
		[string]                $PropertyName,

		[Parameter(Mandatory = $false)]
		[Alias("Value")]
		[string]                $PropertyValue,

		[Parameter(Mandatory = $false)]
		[hashtable]             $Properties
	)

	Process {
		if ($Properties) {
			foreach ($key in $Properties.Keys) {
				if ($PSCmdlet.ShouldProcess("Setting property $key to $($Properties[$key])", "")) {
					$Session.GetType().InvokeMember('Property', [System.Reflection.BindingFlags]::SetProperty, $null, $Session, @($key, $Properties[$key]))
				}
			}
		} else {
			if ($PSCmdlet.ShouldProcess("Setting property $PropertyName to $PropertyValue", "")) {
				$Session.GetType().InvokeMember('Property', [System.Reflection.BindingFlags]::SetProperty, $null, $Session, @($PropertyName, $PropertyValue))
			}
		}
	}
}
Export-ModuleMember -Function Set-WindowsInstallerSessionProperty
