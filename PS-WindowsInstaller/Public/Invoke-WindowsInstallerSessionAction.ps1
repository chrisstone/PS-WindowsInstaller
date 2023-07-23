# enum MsiMessageStatus {
# 	msiMessageStatusError = -1
# 	msiMessageStatusNone = 0
# 	msiMessageStatusOk = 1
# 	msiMessageStatusCancel = 2
# 	msiMessageStatusAbort = 3
# 	msiMessageStatusRetry = 4
# 	msiMessageStatusIgnore = 5
# 	msiMessageStatusYes = 6
# 	msiMessageStatusNo = 7
# }
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
	[Int32] MsiMessageStatus

.NOTES
	1 = Success, 3 = Failure
#>
function Invoke-WindowsInstallerSessionAction {
	[CmdletBinding()]
	[OutputType([Int32])]
	param (
		[Parameter(Mandatory = $true)]
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
