Add-Type -TypeDefinition @'
public enum MsiInstallState {
	msiInstallStateNotUsed = -7,
	msiInstallStateBadConfig = -6,
	msiInstallStateIncomplete = -5,
	msiInstallStateSourceAbsent = -4,
	msiInstallStateMoreData = -3,
	msiInstallStateInvalidArg = -2,
	msiInstallStateUnknown = -1,
	msiInstallStateBroken = 0,
	msiInstallStateAdvertised = 1,
	msiInstallStateRemoved = 1,
	msiInstallStateAbsent = 2,
	msiInstallStateLocal = 3,
	msiInstallStateSource = 4,
	msiInstallStateDefault = 5
}
'@