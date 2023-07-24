<#
.SYNOPSIS
Checks if Windows Installer is currently executing an installation sequence.

.DESCRIPTION
The Test-WindowsInstallerExecuteSequence function uses .NET's Mutex object to
check if the Windows Installer is currently in use. It does this by attempting to
open the "Global\_MSIExecute" Mutex, which is held by the Windows Installer when
it's running an installation sequence.

.PARAMETER Verbose
Specifies whether to show verbose messages.
This is a switch parameter and does not require a value.
Verbose messages are shown if -Verbose is included in the function call, and not shown otherwise.

.EXAMPLE
Test-WindowsInstallerExecuteSequence -Verbose

In this example, the function will output verbose messages showing whether the Windows Installer is in use.

.OUTPUTS
System.Boolean
This function returns $true if the Windows Installer is in use, and $false otherwise.
#>
function Test-WindowsInstallerExecuteSequence {
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param()

	try {
		$mutex = [System.Threading.Mutex]::OpenExisting("Global\_MSIExecute")
		if ($null -ne $mutex) {
			Write-Verbose "MSI Installer is currently in use."
			return $true
		}
	} catch [System.Threading.WaitHandleCannotBeOpenedException] {
		Write-Verbose "MSI Installer is not in use."
	} catch {
		Write-Verbose "An unexpected error occurred: $_"
	}
	return $false
}
