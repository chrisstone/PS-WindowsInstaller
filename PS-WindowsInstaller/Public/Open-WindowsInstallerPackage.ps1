<#
.SYNOPSIS
   Opens a Windows Installer package

.DESCRIPTION
   The function Open-WindowsInstallerPackage opens a Windows Installer package.

.PARAMETER PackagePath
   The path to the Windows Installer package (.msi) file.

.OUTPUTS
	WindowsInstaller.Session object

.EXAMPLE
   $Session = Open-WindowsInstallerPackage -PackagePath "C:\Path\To\YourPackage.msi"
#>
function Open-WindowsInstallerPackage {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateScript({ Test-Path $_ -IsValid })]
		[string] $PackagePath,

		[Parameter(Mandatory = $false)]
		[System.__ComObject] $Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	Process {
		return $Installer.GetType().InvokeMember('OpenPackage', [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, $PackagePath)
	}

	End {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Open-WindowsInstallerPackage
