enum MsiInstallState {
	msiInstallStateNotUsed = -7
	msiInstallStateBadConfig = -6
	msiInstallStateIncomplete = -5
	msiInstallStateSourceAbsent = -4
	msiInstallStateMoreData = -3
	msiInstallStateInvalidArg = -2
	msiInstallStateUnknown = -1
	msiInstallStateBroken = 0
	msiInstallStateAdvertised = 1
	msiInstallStateRemoved = 1
	msiInstallStateAbsent = 2
	msiInstallStateLocal = 3
	msiInstallStateSource = 4
	msiInstallStateDefault = 5
}

<#
.SYNOPSIS
   Configures a Windows Installer Product

.DESCRIPTION
   The function Invoke-ProductConfiguration configures a Windows Installer product using a given product code, install level and install state.
   It utilizes a Windows Installer COM object for this purpose.

.PARAMETER Installer
   A Windows Installer COM object. If not provided, the function will create a new one.

.PARAMETER ProductCode
   The product code of the Windows Installer Product.

.PARAMETER InstallLevel
   The install level of the Windows Installer Product. Default value is 0.

.PARAMETER InstallState
   The install state of the Windows Installer Product.

.EXAMPLE
   Invoke-ProductConfiguration -ProductCode "{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}" -InstallState 2

.EXAMPLE
   "{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}", 2 | Invoke-ProductConfiguration

#>
function Set-WindowsInstallerInstallerProduct {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[string]				$ProductCode,

		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 5)]
		[MsiInstallState]		$InstallState,

		[Parameter(Mandatory = $false)]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer),

		[Parameter(Mandatory = $false)]
		[ValidateRange(0, 65535)]
		[int]					$InstallLevel = 0
	)

	Process {
		if ($PSCmdlet.ShouldProcess("Product Code: $ProductCode", 'Configure product')) {
			return $Installer.GetType().InvokeMember("ConfigureProduct", [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, @($ProductCode, $InstallLevel, $InstallState))
		}
	}

	End {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Set-WindowsInstallerInstallerProduct
