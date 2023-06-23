# Describe 'Get-WindowsInstallerProductState' {
# 	# Let's assume that your MSI Product Codes are 'ProductCode1', 'ProductCode2' and 'ProductCode3'
# 	$ProductCodes = @('ProductCode1', 'ProductCode2', 'ProductCode3')

# 	# Import your module before executing tests
# 	BeforeAll {
# 		. .\PS-WindowsInstaller\Public\Get-WindowsInstallerInstallerProductState.ps1	}

# 	It 'Gets the product states' {
# 		# Call the function with the parameters
# 		$productStates = Get-WindowsInstallerProductState -ProductCodes $ProductCodes
# 		# Validate that the result is a Hashtable
# 		$productStates | Should -BeOfType Hashtable
# 		# Validate that the Hashtable contains the keys (product codes)
# 		$productStates.Keys | Should -Contain $ProductCodes[0]
# 		$productStates.Keys | Should -Contain $ProductCodes[1]
# 		$productStates.Keys | Should -Contain $ProductCodes[2]
# 		# Validate that the Hashtable values (product states) are within the expected range (-7 to 5 for MsiInstallState enum)
# 		$productStates.Values | Should -BeGreaterOrEqual -7
# 		$productStates.Values | Should -BeLessOrEqual 5
# 	}
# }
