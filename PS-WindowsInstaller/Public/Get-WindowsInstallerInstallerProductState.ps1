<#
.SYNOPSIS
This function retrieves the installation state of the given product codes.

.DESCRIPTION
The Get-WindowsInstallerProductState function uses the Windows Installer COM object to get the installation state of all products
associated with the provided product codes.

.PARAMETER ProductCode
An array of product codes to check the state for.

.EXAMPLE
Get-WindowsInstallerProductState -ProductCode "GUID1","GUID2","GUID3"
#>
function Get-WindowsInstallerInstallerProductState {
	[CmdletBinding()]
	[OutputType([Int32])]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[ValidatePattern('^(\{[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\})$')]
		[string]				$ProductCode,

		[Parameter(Mandatory = $false, HelpMessage = 'WindowsInstaller.Installer ComObject')]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	process {
		$Installer.GetType().InvokeMember('ProductState', [System.Reflection.BindingFlags]::GetProperty, $null, $Installer, $ProductCode)
	}

	end {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Get-WindowsInstallerInstallerProductState
