<#
.SYNOPSIS
Closes a Windows Installer Sessopm.

.DESCRIPTION
The Close-WindowsInstallerSession function releases a COM object for a Windows Installer Database.
This is necessary to free up system resources. The function currently does not handle committing changes to the database.

.PARAMETER Database
Specifies the Windows Installer Database COM object to release. This parameter is mandatory.

.EXAMPLE
$Session = Open-WindowsInstallerPackage -DatabasePath "C:\Path\To\Database.msi"
Close-WindowsInstallerSession $Session

This example opens a Windows Installer Session and then immediately closes it.

#>
function Close-WindowsInstallerSession {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.__ComObject]	$Session
	)

	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Session) | Out-Null
}
Export-ModuleMember -Function Close-WindowsInstallerSession
