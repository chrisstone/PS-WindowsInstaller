Describe "Get-WindowsInstallerDatabaseTable" {
	BeforeAll {
		. .\PS-WindowsInstaller\Public\Get-WindowsInstallerDatabaseTable.ps1
	}

	# TODO Need to open a DB first
	# It "Calls Open-WindowsInstallerDatabaseView with correct parameters" {
	# 	Get-WindowsInstallerDatabaseTable -Database $Database -TableName "Property"
	# 	Assert-MockCalled Open-WindowsInstallerDatabaseView -Exactly 1 -ParameterFilter { $Database -eq $Database -and $Query -eq "SELECT * FROM Property" }
	# }

	# It "Returns array by default" {
	# 	$result = Get-WindowsInstallerDatabaseTable -Database $Database -TableName "Property"
	# 	$result | Should -BeOfType [Array]
	# }

	# It "Returns hashtable when AsHashtable parameter is set" {
	# 	$result = Get-WindowsInstallerDatabaseTable -Database $Database -TableName "Property" -AsHashtable
	# 	$result | Should -BeOfType [Hashtable]
	# }
}
