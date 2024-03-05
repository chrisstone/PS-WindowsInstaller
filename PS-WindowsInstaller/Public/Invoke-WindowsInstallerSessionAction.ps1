<#
.SYNOPSIS
   Invokes an action on a Windows Installer Session.

.DESCRIPTION
   The function Invoke-WindowsInstallerSessionAction calls the DoAction method on a given Windows Installer Session.

.PARAMETER Session
   The Windows Installer Session COM object.

.PARAMETER Action
   The action to invoke. Must be one of 'INSTALL', 'ADVERTISE', or 'ADMIN'.

.EXAMPLE
   Invoke-WindowsInstallerSessionAction -Session $Session -Action "INSTALL"

.OUTPUTS
	[MsiMessageStatus] MsiMessageStatus

.NOTES
	1 = Success, 3 = Failure typically
#>
function Invoke-WindowsInstallerSessionAction {
	[CmdletBinding()]
	[OutputType([MsiMessageStatus])]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.__ComObject] $Session,

		[Parameter(Mandatory = $true)]
		[ValidateSet('INSTALL', 'ADVERTISE', 'ADMIN')]
		[string] $Action
	)

	Process {
		return $Session.GetType().InvokeMember('DoAction', [System.Reflection.BindingFlags]::InvokeMethod, $null, $Session, $Action)
	}

	End {
		[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Session) | Out-Null
	}
}
Export-ModuleMember -Function Invoke-WindowsInstallerSessionAction
