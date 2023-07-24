Properties {
	# Find the build folder based on build system
	# $ProjectRoot = $ENV:BHProjectPath
	# If ($null -eq $ProjectRoot) {
	$ProjectRoot = Resolve-Path $PSScriptRoot
	$ModuleRoot = (Get-ChildItem -Recurse -Filter *.psm1 | Select-Object -First 1).DirectoryName

	# }
}

TaskSetup {
	Write-Output "".PadRight(70, '-')
}

Task Default -depends Test

Task Init {
	Set-Location $ProjectRoot
	"Build System Details:"
	Get-Item ENV:BH*
}

Task Test -depends Init {
	# Pester
	Import-Module Pester
	$PesterConf = [PesterConfiguration]@{
		Run        = @{
			Path     = "$ProjectRoot\Tests"
			PassThru = $true
		}
		TestResult = @{
			Enabled      = $true
			OutputPath   = ("{0}\Unit.Tests.xml" -f $ProjectRoot)
			OutputFormat = "NUnitXml"
		}
	}
	$TestResults = Invoke-Pester -Configuration $PesterConf
	If ($TestResults.FailedCount -gt 0) {
		Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed" -ErrorAction Stop
	}

	# PSScriptAnalyzer
	Invoke-ScriptAnalyzer -Path (Join-Path $ModuleRoot *.ps1) -Recurse -OutVariable issues
	$errors = $issues.Where({ $_.Severity -eq 'Error' })
	$warnings = $issues.Where({ $_.Severity -eq 'Warning' })
	if ($errors) {
		Write-Error "There were $($errors.Count) errors and $($warnings.Count) warnings total." -ErrorAction Stop
	} else {
		Write-Output "There were $($errors.Count) errors and $($warnings.Count) warnings total."
	}

}

Task Build -depends Test {
	Write-Output "Updating Module Manifest:"

	# FunctionsToExport, AliasesToExport; from BuildHelpers
	Write-Output "`Functions"
	Set-ModuleFunction
	Write-Output "`Aliases"
	Set-ModuleAlias

	# Prerelease
	Write-Output "`tPrerelease Metadata"
	If ($env:BHBranchName -eq 'release') {
		# Remove "Prerelease" from Manifest
		Set-Content -Path $env:BHPSModuleManifest -Value (Get-Content -Path $env:BHPSModuleManifest | Select-String -Pattern 'Prerelease' -NotMatch)
	} else {
		# Add/Update Prerelease Version
		Update-Metadata -Path $env:BHPSModuleManifest -PropertyName Prerelease -Value "PRE$(($env:BHCommitHash).Substring(0,7))"
	}

	# Build Number from CI
	Write-Output "`tVersion Build"
	[Version] $Ver = Get-Metadata -Path $env:BHPSModuleManifest -PropertyName 'ModuleVersion'
	Update-Metadata -Path $env:BHPSModuleManifest -PropertyName 'ModuleVersion' -Value (@($Ver.Major, $Ver.Minor, $Env:BHBuildNumber) -join '.')
}

Task Deploy -depends Build {
	$Params = @{
		Path    = "$ProjectRoot"
		Force   = $true
		Recurse = $false # We keep psdeploy artifacts, avoid deploying those : )
	}
	Write-Output "Invoking PSDeploy"
	Invoke-PSDeploy @Verbose @Params
}
