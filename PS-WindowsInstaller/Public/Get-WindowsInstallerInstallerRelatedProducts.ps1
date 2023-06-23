<#
.SYNOPSIS
This function retrieves the product codes of installed products related to the given upgrade codes.

.DESCRIPTION
The Get-WindowsInstallerInstallerRelatedProduct function uses the Windows Installer COM object to get the product codes of all products
that derive from a product associated with one of the given upgrade codes.

.PARAMETER UpgradeCodes
An array of upgrade codes to look for.

.EXAMPLE
Get-WindowsInstallerInstallerRelatedProduct -UpgradeCodes "GUID1","GUID2","GUID3"
#>
function Get-WindowsInstallerInstallerRelatedProduct {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[ValidatePattern('^(\{[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\})$')]
		[string[]]				$UpgradeCodes,

		[Parameter(Mandatory = $false, HelpMessage = 'WindowsInstaller.Installer ComObject')]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	begin {
		$Products = @()
	}

	process {
		foreach ($UpgradeCode in $UpgradeCodes) {
			$Products += $Installer.GetType().InvokeMember('RelatedProducts', [System.Reflection.BindingFlags]::GetProperty, $null, $Installer, $UpgradeCode)
		}

		return $Products
	}

	end {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Get-WindowsInstallerInstallerRelatedProduct
