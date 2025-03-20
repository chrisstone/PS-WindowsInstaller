Add-Type -TypeDefinition @'
namespace MSI {

public
enum MsiUILevel {
  msiUILevelNoChange = 0,
  msiUILevelDefault = 1,
  msiUILevelNone = 2,
  msiUILevelBasic = 3,
  msiUILevelReduced = 4,
  msiUILevelFull = 5,
  msiUILevelHideCancel = 32,
  msiUILevelProgressOnly = 64,
  msiUILevelEndDialog = 128
};

public
enum MsiReadStream {
  msiReadStreamInteger = 0,
  msiReadStreamBytes = 1,
  msiReadStreamAnsi = 2,
  msiReadStreamDirect = 3
};

public
enum MsiRunMode {
  msiRunModeAdmin = 0,
  msiRunModeAdvertise = 1,
  msiRunModeMaintenance = 2,
  msiRunModeRollbackEnabled = 3,
  msiRunModeLogEnabled = 4,
  msiRunModeOperations = 5,
  msiRunModeRebootAtEnd = 6,
  msiRunModeRebootNow = 7,
  msiRunModeCabinet = 8,
  msiRunModeSourceShortNames = 9,
  msiRunModeTargetShortNames = 10,
  msiRunModeWindows9x = 12,
  msiRunModeZawEnabled = 13,
  msiRunModeScheduled = 16,
  msiRunModeRollback = 17,
  msiRunModeCommit = 18
};

public
enum MsiDatabaseState { msiDatabaseStateRead = 0, msiDatabaseStateWrite = 1 };

public
enum MsiViewModify {
  msiViewModifySeek = -1,
  msiViewModifyRefresh = 0,
  msiViewModifyInsert = 1,
  msiViewModifyUpdate = 2,
  msiViewModifyAssign = 3,
  msiViewModifyReplace = 4,
  msiViewModifyMerge = 5,
  msiViewModifyDelete = 6,
  msiViewModifyInsertTemporary = 7,
  msiViewModifyValidate = 8,
  msiViewModifyValidateNew = 9,
  msiViewModifyValidateField = 10,
  msiViewModifyValidateDelete = 11
};

public
enum MsiColumnInfo { msiColumnInfoNames = 0, msiColumnInfoTypes = 1 };

public
enum MsiTransformError {
  msiTransformErrorNone = 0,
  msiTransformErrorAddExistingRow = 1,
  msiTransformErrorDeleteNonExistingRow = 2,
  msiTransformErrorAddExistingTable = 4,
  msiTransformErrorDeleteNonExistingTable = 8,
  msiTransformErrorUpdateNonExistingRow = 16,
  msiTransformErrorChangeCodePage = 32,
  msiTransformErrorViewTransform = 256
};

public
enum MsiEvaluateCondition {
  msiEvaluateConditionFalse = 0,
  msiEvaluateConditionTrue = 1,
  msiEvaluateConditionNone = 2,
  msiEvaluateConditionError = 3
};

public
enum MsiTransformValidation {
  msiTransformValidationNone = 0,
  msiTransformValidationLanguage = 1,
  msiTransformValidationProduct = 2,
  msiTransformValidationPlatform = 4,
  msiTransformValidationMajorVer = 8,
  msiTransformValidationMinorVer = 16,
  msiTransformValidationUpdateVer = 32,
  msiTransformValidationLess = 64,
  msiTransformValidationLessOrEqual = 128,
  msiTransformValidationEqual = 256,
  msiTransformValidationGreaterOrEqual = 512,
  msiTransformValidationGreater = 1024,
  msiTransformValidationUpgradeCode = 2048
};

public
enum MsiDoActionStatus {
  msiDoActionStatusNoAction = 0,
  msiDoActionStatusSuccess = 1,
  msiDoActionStatusUserExit = 2,
  msiDoActionStatusFailure = 3,
  msiDoActionStatusSuspend = 4,
  msiDoActionStatusFinished = 5,
  msiDoActionStatusWrongState = 6,
  msiDoActionStatusBadActionData = 7
};

public
enum MsiMessageStatus {
  msiMessageStatusError = -1,
  msiMessageStatusNone = 0,
  msiMessageStatusOk = 1,
  msiMessageStatusCancel = 2,
  msiMessageStatusAbort = 3,
  msiMessageStatusRetry = 4,
  msiMessageStatusIgnore = 5,
  msiMessageStatusYes = 6,
  msiMessageStatusNo = 7
};

public
enum MsiMessageType {
  msiMessageTypeFatalExit = 0,
  msiMessageTypeError = 16777216,
  msiMessageTypeWarning = 33554432,
  msiMessageTypeUser = 50331648,
  msiMessageTypeInfo = 67108864,
  msiMessageTypeFilesInUse = 83886080,
  msiMessageTypeResolveSource = 100663296,
  msiMessageTypeOutOfDiskSpace = 117440512,
  msiMessageTypeActionStart = 134217728,
  msiMessageTypeActionData = 150994944,
  msiMessageTypeProgress = 167772160,
  msiMessageTypeCommonData = 184549376,
  msiMessageTypeOk = 0,
  msiMessageTypeOkCancel = 1,
  msiMessageTypeAbortRetryIgnore = 2,
  msiMessageTypeYesNoCancel = 3,
  msiMessageTypeYesNo = 4,
  msiMessageTypeRetryCancel = 5,
  msiMessageTypeDefault1 = 0,
  msiMessageTypeDefault2 = 256,
  msiMessageTypeDefault3 = 512
};

public
enum MsiInstallState {
  msiInstallStateNotUsed = -7,
  msiInstallStateBadConfig = -6,
  msiInstallStateIncomplete = -5,
  msiInstallStateSourceAbsent = -4,
  msiInstallStateInvalidArg = -2,
  msiInstallStateUnknown = -1,
  msiInstallStateBroken = 0,
  msiInstallStateAdvertised = 1,
  msiInstallStateRemoved = 1,
  msiInstallStateAbsent = 2,
  msiInstallStateLocal = 3,
  msiInstallStateSource = 4,
  msiInstallStateDefault = 5
};

public
enum MsiCostTree {
  msiCostTreeSelfOnly = 0,
  msiCostTreeChildren = 1,
  msiCostTreeParents = 2
};

public
enum MsiReinstallMode {
  msiReinstallModeFileMissing = 2,
  msiReinstallModeFileOlderVersion = 4,
  msiReinstallModeFileEqualVersion = 8,
  msiReinstallModeFileExact = 16,
  msiReinstallModeFileVerify = 32,
  msiReinstallModeFileReplace = 64,
  msiReinstallModeMachineData = 128,
  msiReinstallModeUserData = 256,
  msiReinstallModeShortcut = 512,
  msiReinstallModePackage = 1024
};

public
enum MsiInstallType {
  msiInstallTypeDefault = 0,
  msiInstallTypeNetworkImage = 1
};

public
enum MsiInstallMode {
  msiInstallModeNoSourceResolution = -3,
  msiInstallModeNoDetection = -2,
  msiInstallModeExisting = -1,
  msiInstallModeDefault = 0
};

public
enum MsiSignatureInfo {
  msiSignatureInfoCertificate = 0,
  msiSignatureInfoHash = 1
};

public
enum MsiOpenDatabaseMode {
  msiOpenDatabaseModeReadOnly = 0,
  msiOpenDatabaseModeTransact = 1,
  msiOpenDatabaseModeDirect = 2,
  msiOpenDatabaseModeCreate = 3,
  msiOpenDatabaseModeCreateDirect = 4,
  msiOpenDatabaseModePatchFile = 32
};

public
enum MsiSignatureOption { msiSignatureOptionInvalidHashFatal = 1 };

} // namespace MSI
'@