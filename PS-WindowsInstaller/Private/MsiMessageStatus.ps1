Add-Type -TypeDefinition @'
public enum MsiMessageStatus {
	msiMessageStatusError = -1,
	msiMessageStatusNone = 0,
	msiMessageStatusOk = 1,
	msiMessageStatusCancel = 2,
	msiMessageStatusAbort = 3,
	msiMessageStatusRetry = 4,
	msiMessageStatusIgnore = 5,
	msiMessageStatusYes = 6,
	msiMessageStatusNo = 7
}
'@