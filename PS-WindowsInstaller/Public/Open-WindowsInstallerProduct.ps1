<#
.SYNOPSIS
   Opens a Windows Installer product

.DESCRIPTION
   The function Open-WindowsInstallerProduct opens a Windows Installer product.

.PARAMETER ProductCode
   The Product Code of the Windows Installer product.

.OUTPUTS
	WindowsInstaller.Session object

.EXAMPLE
   $Session = Open-WindowsInstallerProduct -ProductCode "Product Code Here"
#>
function Open-WindowsInstallerProduct {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidatePattern('^(\{[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\})$')]
		[string] $ProductCode,

		[Parameter(Mandatory = $false)]
		[System.__ComObject] $Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	Process {
		return $Installer.GetType().InvokeMember('OpenProduct', [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, $ProductCode)
	}

	End {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Open-WindowsInstallerProduct
