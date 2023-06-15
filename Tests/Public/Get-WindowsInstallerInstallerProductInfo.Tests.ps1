Describe 'Get-WindowsInstallerInstallerProductInfo' {
	BeforeAll {
		. .\PS-WindowsInstaller\Public\Get-WindowsInstallerInstallerProductInfo.ps1

		. .\PS-WindowsInstaller\Public\Get-WindowsInstallerInstallerProduct.ps1
		$AProductCode = (Get-WindowsInstallerInstallerProduct)[0]
	}

	Context 'When no parameters are given' {
		It 'Should throw' {
			{ Get-WindowsInstallerInstallerProductInfo $null } | Should -Throw
		}
	}

	Context 'When the ProductCode parameter is given' {
		It 'Should not throw' {
			{ Get-WindowsInstallerInstallerProductInfo -ProductCode $AProductCode } | Should -Not -Throw
		}
	}

	Context 'When the Installer parameter is given' {
		It 'Should not throw' {
			$Installer = New-Object -ComObject WindowsInstaller.Installer
			{ Get-WindowsInstallerInstallerProductInfo -ProductCode $AProductCode -Installer $Installer } | Should -Not -Throw
		}
	}

	Context 'When an invalid Installer is given' {
		It 'Should throw' {
			{ Get-WindowsInstallerInstallerProductInfo -ProductCode $AProductCode -Installer "Invalid" } | Should -Throw
		}
	}

	Context 'When function is called' {
		It 'Should return an hashtable' {
			$result = Get-WindowsInstallerInstallerProductInfo -ProductCode $AProductCode
			$result | Should -BeOfType [System.Collections.Hashtable]
		}
	}
}
