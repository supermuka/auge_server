/// HistoryItem is just created (inserted) like a log.
/// It does not have version field, necessary to concurrency control

import 'dart:convert';
import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/user.dart';

class HistoryItem {
  String id;
  String objectId;
  int objectVersion;
  String objectClassName;
  /// This field values it's generated on server side
  int systemFunctionIndex;
  DateTime dateTime;
  User user;
  String description;

  // Ideal would be a Map, but the rpc package doesn't permit to use dynamic type, like Map<String, dynamic>
  String changedValues;

  setClientSideValues({User user, String description, String changedValues}) {
    this.user = user;
    this.description = description;
    this.changedValues = changedValues;
  }

  setServerSideValues({String id, String objectId, int objectVersion, String objectClassName, int systemFunctionIndex, DateTime dateTime}) {
    this.id = id;
    this.objectId = objectId;
    this.objectVersion = objectVersion;
    this.objectClassName = objectClassName;
    this.systemFunctionIndex = systemFunctionIndex;
    this.dateTime = dateTime;
  }

  Map<String, dynamic> get changedValuesToMap  {
    if (objectClassName == 'Objective') {
      return ObjectiveFacilities.differenceToMap(changedValues);
    } else {
      return json.decode(changedValues);
    }
  }

}