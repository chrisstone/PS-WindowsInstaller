
$ModuleHome = Split-Path -Path $MyInvocation.MyCommand.Path -Parent

Foreach ($ModFile in (Get-ChildItem -Filter '*.ps1' -Path "$ModuleHome" -Recurse)) {
	. $($ModFile.FullName)
}
