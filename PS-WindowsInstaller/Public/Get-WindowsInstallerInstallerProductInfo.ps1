<#
.SYNOPSIS
This function retrieves information for a given product installed by the Windows Installer.

.PARAMETER ProductCode
The ProductCode of the product to get information for.

.PARAMETER Properties
The properties of the product to retrieve. Defaults to a predefined list of common properties.

.PARAMETER Installer
An optional WindowsInstaller.Installer COM object. If not provided, the function creates a new one.

.EXAMPLE
PS C:\> Get-WindowsInstallerInstallerProductInfo -ProductCode '{ABCDEFGHIJK-1234-5678-90AB-CDEF12345678}'

.EXAMPLE
PS C:\> '{ABCDEFGHIJK-1234-5678-90AB-CDEF12345678}', '{BCDEFGHIJKL-2345-6789-01BC-DEF23456789A}' | Get-WindowsInstallerInstallerProductInfo

#>
function Get-WindowsInstallerInstallerProductInfo {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[String[]]				$ProductCodes,

		[Parameter(Mandatory = $false)]
		[String[]]				$Properties = @('Language', 'ProductName', 'PackageCode', 'Transforms', 'AssignmentType',
			'PackageName', 'InstalledProductName', 'VersionString', 'RegCompany', 'RegOwner', 'ProductID',
			'ProductIcon', 'InstallLocation', 'InstallSource', 'InstallDate', 'Publisher', 'LocalPackage',
			'HelpLink', 'HelpTelephone', 'URLInfoAbout', 'URLUpdateInfo'),

		[Parameter(Mandatory = $false, HelpMessage = 'WindowsInstaller.Installer COM object')]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	process {
		foreach ($Code in $ProductCodes) {
			$Product = @{
				ProductCode = $Code
			}

			foreach ($Property in $Properties) {
				$Product[$Property] = $Installer.GetType().InvokeMember('ProductInfo', [System.Reflection.BindingFlags]::GetProperty, $null, $Installer, @($Code, $Property))
			}

			$Product
		}
	}

	end {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
