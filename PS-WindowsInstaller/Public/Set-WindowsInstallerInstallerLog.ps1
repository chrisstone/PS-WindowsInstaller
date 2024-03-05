<#
.SYNOPSIS
   Sets the log file attributes for the Windows Installer

.DESCRIPTION
   The function Set-WindowsInstallerInstallerLog sets the log file attributes for the Windows Installer.
   See https://learn.microsoft.com/en-us/windows/win32/msi/installer-enablelog for details.

.PARAMETER LogMode
   The logging attributes.

.PARAMETER LogFile
   The full path to the log file.

.EXAMPLE
   Set-WindowsInstallerInstallerLog -LogMode "voicewarmup" -LogFile "C:\Path\To\YourLogFile.log"

.EXAMPLE
	Set-WindowsInstallerInstallerLog -LogFile ""  # Disables logging
#>
function Set-WindowsInstallerInstallerLog {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateScript({ $_ -match '^(?![+!]$)[lwefarucmvp+!xo]+$' })]
		[string] $LogMode,

		[Parameter(Mandatory = $true)]
		[ValidateScript({ Test-Path $_ -IsValid })]
		[string] $LogFile,

		[Parameter(Mandatory = $true)]
		[System.__ComObject] $Installer
	)

	Process {
		if ($PSCmdlet.ShouldProcess("WindowsInstaller.Installer", "Enable log")) {
			$Installer.GetType().InvokeMember('EnableLog', [System.Reflection.BindingFlags]::InvokeMethod, $null, $Installer, @($LogMode, $LogFile))
		}
	}

}
Export-ModuleMember -Function Set-WindowsInstallerInstallerLog
