<#
.SYNOPSIS
Releases a COM object associated with the Windows Installer.

.DESCRIPTION
The Remove-WindowsInstallerObject function uses the .NET [System.Runtime.Interopservices.Marshal]::ReleaseComObject method
to release a COM object associated with the Windows Installer. If no specific Installer object is provided, it creates a new
COM object for WindowsInstaller.Installer and releases it.

.PARAMETER Installer
An optional parameter, which is a COM object of Windows Installer. If no object is passed, a new object is created and
released.

.EXAMPLE
Remove-WindowsInstallerObject -InputObject $myInstaller

Releases the COM object referenced by $myInstaller.

.INPUTS
[System.__ComObject]
You can pipe a COM object to Remove-WindowsInstallerObject.

.OUTPUTS
None. This function does not produce any output.

.NOTES
If the 'ShouldProcess' confirmation is denied, the COM object will not be released.
#>
function Remove-WindowsInstallerObject {
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.__ComObject]		$InputObject
	)

	Process {
		try {
			if ($PSCmdlet.ShouldProcess("WindowsInstaller", "Remove COM object")) {
				[System.Runtime.Interopservices.Marshal]::ReleaseComObject($InputObject) | Out-Null
			}
		} catch {
			Write-Verbose $_
		}
	}
}
Export-ModuleMember -Function Remove-WindowsInstallerObject
