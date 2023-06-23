<#
.SYNOPSIS
   Opens a Windows Installer Database

.DESCRIPTION
   The function Open-WindowsInstallerDatabase creates a Windows Installer database object from a given database path.
   It utilizes a Windows Installer COM object for this purpose.

.PARAMETER Installer
   A Windows Installer COM object. If not provided, the function will create a new one.

.PARAMETER DatabasePath
   The path to the Windows Installer Database (.msi) file. This can be passed by value or from pipeline input.

.OUTPUTS
	WindowsInstaller.Database object

.EXAMPLE
   Open-WindowsInstallerDatabase -DatabasePath "C:\Path\To\YourDatabase.msi"

.EXAMPLE
   "C:\Path\To\YourDatabase.msi" | Open-WindowsInstallerDatabase

#>
function Open-WindowsInstallerDatabase {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[string]				$DatabasePath,

		[Parameter(Mandatory = $false)]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	Process {
		return $Installer.GetType().InvokeMember("OpenDatabase", [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, @($DatabasePath, 0))
	}

	End {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Open-WindowsInstallerDatabase
