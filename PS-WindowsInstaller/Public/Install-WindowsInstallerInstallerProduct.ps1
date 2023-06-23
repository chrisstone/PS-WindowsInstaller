<#
.SYNOPSIS
   Installs a product using the Windows Installer.

.DESCRIPTION
   The function Install-WindowsInstallerInstallerProduct calls the InstallProduct method on a given Windows Installer object.

.PARAMETER Installer
   The Windows Installer COM object.

.PARAMETER PackagePath
   The full path to the package to be installed.

.PARAMETER CommandLineOptions
   Options for the command line for the installation.

.EXAMPLE
   Install-WindowsInstallerInstallerProduct -Installer $Installer -PackagePath "C:\Path\To\YourProduct.msi" -CommandLineOptions "OPTION1=VALUE1 OPTION2=VALUE2"
#>
function Install-WindowsInstallerInstallerProduct {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer),

		[Parameter(Mandatory = $true)]
		[ValidateScript({
				(Test-Path $_ -IsValid) -and ((Get-Item $_).Extension -eq ".msi")
			})]
		[string]				$PackagePath,

		[Parameter(Mandatory = $false)]
		[string]				$CommandLineOptions = ""
	)

	Process {
		$Installer.GetType().InvokeMember('InstallProduct', [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, @($PackagePath, $CommandLineOptions))
	}

	End {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Install-WindowsInstallerInstallerProduct
