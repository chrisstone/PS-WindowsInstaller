<#
.SYNOPSIS
This function retrieves the installation state of the given product codes.

.DESCRIPTION
The Get-WindowsInstallerProductState function uses the Windows Installer COM object to get the installation state of all products
associated with the provided product codes.

.PARAMETER ProductCodes
An array of product codes to check the state for.

.EXAMPLE
Get-WindowsInstallerProductState -ProductCodes "GUID1","GUID2","GUID3"
#>
function Get-WindowsInstallerInstallerProductState {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[ValidatePattern('^(\{[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\})$')]
		[string[]]				$ProductCodes,

		[Parameter(Mandatory = $false, HelpMessage = 'WindowsInstaller.Installer ComObject')]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	begin {
		$ProductStates = @{}
	}

	process {
		foreach ($ProductCode in $ProductCodes) {
			$ProductStates[$ProductCode] = $Installer.GetType().InvokeMember('ProductState', [System.Reflection.BindingFlags]::GetProperty, $null, $Installer, $ProductCode)
		}

		return $ProductStates
	}

	end {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Get-WindowsInstallerInstallerProductState
