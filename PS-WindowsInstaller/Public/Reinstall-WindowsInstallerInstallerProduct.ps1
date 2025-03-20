<#
.SYNOPSIS
    Reinstalls (repairs) a Windows Installer product.

.DESCRIPTION
    This function uses the Windows Installer object to reinstall (repair) a product based on its product code.
    It allows for specifying the reinstall mode to control the scope and behavior of the reinstallation.

.PARAMETER Installer
    Specifies an existing Windows Installer object. If not provided, a new instance is created.

.PARAMETER ProductCode
    Specifies the product code of the application to reinstall (repair). This is a mandatory parameter and must be a valid GUID.

.PARAMETER ReinstallMode
    Specifies the reinstall mode. This parameter allows you to control which components of the product are reinstalled.
    Valid values are defined by the [MSI.MsiReinstallMode] enum. If not provided, the default reinstall mode is used.
    See the Microsoft documentation for details on available reinstall modes.

.EXAMPLE
    Reinstall-WindowsInstallerInstallerProduct -ProductCode '{YOUR-PRODUCT-CODE-GUID}' -ReinstallMode omus

    Reinstalls (repairs) the product with the specified product code using the 'omus' reinstall mode.

.EXAMPLE
    $installer = New-Object -ComObject WindowsInstaller.Installer
    Reinstall-WindowsInstallerInstallerProduct -Installer $installer -ProductCode '{YOUR-PRODUCT-CODE-GUID}'

    Reinstalls (repairs) the product using an existing Windows Installer object.

.NOTES
    For more information on Windows Installer actions and reinstall modes, see:
    https://learn.microsoft.com/en-us/windows/win32/msi/action
    https://learn.microsoft.com/en-us/windows/win32/msi/remove
    https://learn.microsoft.com/en-us/windows/win32/msi/reinstallmode
#>
function Reinstall-WindowsInstallerInstallerProduct {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer),

		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[ValidatePattern('^(\{[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\})$')]
		[string]				$ProductCode,

		[Parameter(Mandatory = $false)]
		[ValidateSetAttribute()]
		[MSI.MsiReinstallMode]				$ReinstallMode = $null
	)

	Process {
		$Installer.GetType().InvokeMember('ReinstallProduct', [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, @($ProductCode, $ReinstallMode))
	}

	End {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Reinstall-WindowsInstallerInstallerProduct
