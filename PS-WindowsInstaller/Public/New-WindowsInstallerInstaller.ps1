<#
.SYNOPSIS
   Creates a new Windows Installer COM object.

.DESCRIPTION
   The function New-WindowsInstallerObject creates a new Windows Installer COM object.

.EXAMPLE
   New-WindowsInstallerObject
#>
function New-WindowsInstallerInstaller {
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param()

	Process {
		if ($PSCmdlet.ShouldProcess("WindowsInstaller.Installer", "Create new COM object")) {
			return (New-Object -ComObject WindowsInstaller.Installer)
		}
	}

}
Export-ModuleMember -Function New-WindowsInstallerInstaller
