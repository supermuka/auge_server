const int httpCodeNotFound = 404;

class RpcErrorMessage {
  static const String dataNotFoundName = 'DataNotFound';
  static const String dataNotFoundMessage = 'Data Not Found.';
}

class RpcErrorDetailMessage {

  static const String groupUpdatePreconditionFailed = 'GroupUpdatePreconditionFailed';
  static const String measureUpdatePreconditionFailed = 'MeasureUpdatePreconditionFailed';
  static const String measureProgressUpdatePreconditionFailed = 'MeasureProgressUpdatePreconditionFailed';
  static const String measureUnitsDataNotFoundReason = 'MeasureUnitsDataNotFound';
  static const String measureDataNotFoundReason = 'MeasureDataNotFound';
  static const String objectiveDataNotFoundReason = 'ObjectiveDataNotFound';
  static const String organizationDataNotFoundReason = 'OrganizationDataNotFound';
  static const String userDataNotFoundReason = 'UserDataNotFound';
}

