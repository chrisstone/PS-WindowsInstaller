Add-Type -TypeDefinition @'
public enum msiUILevel {
	msiUILevelNoChange = 0,
	msiUILevelDefault = 1,
	msiUILevelNone = 2,
	msiUILevelBasic = 3,
	msiUILevelReduced = 4,
	msiUILevelFull = 5,
	msiUILevelHideCancel = 32,
	msiUILevelProgressOnly = 64,
	msiUILevelEndDialog = 128
}
'@