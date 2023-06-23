<#
.SYNOPSIS
This function retrieves all products installed by the Windows Installer.

.PARAMETER Installer
An optional WindowsInstaller.Installer COM object. If not provided, the function creates a new one.

.EXAMPLE
PS C:\> Get-WindowsInstallerInstallerProduct

.EXAMPLE
PS C:\> $installer = New-Object -ComObject WindowsInstaller.Installer
PS C:\> Get-WindowsInstallerInstallerProduct -Installer $installer
#>
function Get-WindowsInstallerInstallerProduct {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $false, HelpMessage = 'WindowsInstaller.Installer ComObject')]
		[System.__ComObject]	$Installer = (New-Object -ComObject WindowsInstaller.Installer)
	)

	process {
		$Installer.GetType().InvokeMember('Products', [System.Reflection.BindingFlags]::GetProperty, $null, $Installer, $null)
	}

	end {
		if (-not $PSBoundParameters.ContainsKey('Installer')) {
			[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Installer) | Out-Null
		}
	}
}
Export-ModuleMember -Function Get-WindowsInstallerInstallerProduct
