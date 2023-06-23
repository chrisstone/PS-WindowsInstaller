<#
.SYNOPSIS
Closes a Windows Installer Database.

.DESCRIPTION
The Close-WindowsInstallerDatabase function releases a COM object for a Windows Installer Database.
This is necessary to free up system resources. The function currently does not handle committing changes to the database.

.PARAMETER Database
Specifies the Windows Installer Database COM object to release. This parameter is mandatory.

.EXAMPLE
$Database = Open-WindowsInstallerDatabase -DatabasePath "C:\Path\To\Database.msi"
Close-WindowsInstallerDatabase -Database $Database

This example opens a Windows Installer Database and then immediately closes it.

#>
function Close-WindowsInstallerDatabase {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.__ComObject] $Database
	)

	# TODO Commit should only be called if the DB has been modified, try TablePersistent to check?
	# $Database.GetType().InvokeMember("Commit", [System.Reflection.BindingFlags]::InvokeMethod, $null, $Database, $null)

	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Database) | Out-Null
}
Export-ModuleMember -Function Close-WindowsInstallerDatabase
