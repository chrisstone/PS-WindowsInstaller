Describe 'Get-WindowsInstallerInstallerProduct' {
	BeforeAll {
		. .\PS-WindowsInstaller\Public\Get-WindowsInstallerInstallerProduct.ps1
	}

	Context 'When no parameters are given' {
		It 'Should not throw' {
			{ Get-WindowsInstallerInstallerProduct } | Should -Not -Throw
		}
	}

	Context 'When the Installer parameter is given' {
		It 'Should not throw' {
			$Installer = New-Object -ComObject WindowsInstaller.Installer
			{ Get-WindowsInstallerInstallerProduct -Installer $Installer } | Should -Not -Throw
		}
	}

	Context 'When an invalid Installer is given' {
		It 'Should throw' {
			{ Get-WindowsInstallerInstallerProduct -Installer "Invalid" } | Should -Throw
		}
	}

	Context 'When function is called' {
		It 'Should return an array of strings' {
			$result = Get-WindowsInstallerInstallerProduct
			$result -is [System.Array] | Should -Be $true
			$result[0] -is [System.String] | Should -Be $true
		}
	}
}
