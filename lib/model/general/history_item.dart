/// HistoryItem is just created (inserted) like a log.
/// It does not have version field, necessary to concurrency control

import 'dart:convert';
import 'package:fixnum/fixnum.dart';
import 'package:auge_server/model/general/user.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pb.dart' as history_item_pb;

class HistoryItem {
  static final String idField = 'id';
  String id;
  static final String userField = 'user';
  User user;
  static final String objectClassNameField = 'objectClassName';
  String objectClassName;
  static final String objectIdField = 'objectId';
  String objectId;
  static final String objectVersionField = 'objectVersion';
  int objectVersion;
  static final String systemModuleIndexField = 'systemModuleIndex';
  int systemModuleIndex;
  static final String systemFunctionIndexField = 'systemFunctionIndex';
  int systemFunctionIndex;
  static final String dateTimeField = 'dateTime';
  DateTime dateTime;

  // This fields are setting on client
  static final String descriptionField = 'description';
  String description;

  // values are dynamic, contents json
  static final String changedValuesPreviousField = 'changedValuesPrevious';
  Map<String, dynamic> changedValuesPrevious;  // previousValuesChanged;
  static final String changedValuesCurrentField = 'changedValuesCurrent';
  Map<String, dynamic> changedValuesCurrent; // currentChangedValues;

  // Used to create a Map to differences
  static Map<String, dynamic> changedValues(Map<String, dynamic> baseline, Map<String, dynamic> comparedTo) {
    Map<String, dynamic> changedValues = {};
    baseline.forEach((k, v) {
      if (baseline[k] != comparedTo[k]) {
        changedValues[k] = baseline[k];
      }
    });
    return changedValues;
  }

  history_item_pb.HistoryItem writeToProtoBuf() {
    history_item_pb.HistoryItem historyItemPb = history_item_pb.HistoryItem();

    if (this.id != null) historyItemPb.id = this.id;
    if (this.objectClassName != null) historyItemPb.objectClassName = this.objectClassName;
    if (this.objectId != null) historyItemPb.objectId = this.objectId;
    if (this.objectVersion != null) historyItemPb.objectVersion = this.objectVersion;
    if (this.systemModuleIndex != null) historyItemPb.systemModuleIndex = this.systemModuleIndex;
    if (this.systemFunctionIndex != null) historyItemPb.systemFunctionIndex = this.systemFunctionIndex;

    if (this.dateTime != null) {
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.dateTime.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      historyItemPb.dateTime = t;
    }

    if (this.user != null) historyItemPb.user = this.user.writeToProtoBuf();
    if (this.description != null) historyItemPb.description = this.description;

    if (this.changedValuesPrevious != null) {

      // Convert value from dart json to protobuf string
      historyItemPb.changedValuesPreviousJson = json.encode(this.changedValuesPrevious);
    }

    if (this.changedValuesCurrent != null) {

      historyItemPb.changedValuesCurrentJson = json.encode(this.changedValuesCurrent);

      // Convert value from dart json to protobuf string
     // historyItemPb.changedValuesCurrent.addAll(this.changedValuesCurrent.map((key, value) => Map().putIfAbsent(key, () => json.encode(value))));
    }

    return historyItemPb;
  }

  readFromProtoBuf(history_item_pb.HistoryItem historyItemPb) {
    if (historyItemPb.hasId()) this.id = historyItemPb.id;
    if (historyItemPb.hasObjectClassName()) this.objectClassName = historyItemPb.objectClassName;
    if (historyItemPb.hasObjectId()) this.objectId = historyItemPb.objectId;
    if (historyItemPb.hasObjectVersion()) this.objectVersion = historyItemPb.objectVersion;
    if (historyItemPb.hasSystemModuleIndex()) this.systemModuleIndex = historyItemPb.systemModuleIndex;
    if (historyItemPb.hasSystemFunctionIndex()) this.systemFunctionIndex = historyItemPb.systemFunctionIndex;

    if (historyItemPb.hasDateTime()) {
      this.dateTime = DateTime.fromMicrosecondsSinceEpoch(historyItemPb.dateTime.seconds.toInt() * 1000000 + historyItemPb.dateTime.nanos ~/ 1000 );
    }

    if (historyItemPb.hasUser()) this.user = User()..readFromProtoBuf(historyItemPb.user);
    if (historyItemPb.hasDescription()) this.description = historyItemPb.description;
    //if (historyItemPb.changedValues.isNotEmpty) this.changedValues = historyItemPb.changedValues;
    // Convert value from protobuf string to dart json
    if (historyItemPb.hasChangedValuesPreviousJson()) this.changedValuesPrevious = json.decode(historyItemPb.changedValuesPreviousJson);
    if (historyItemPb.hasChangedValuesCurrentJson()) this.changedValuesCurrent  = json.decode(historyItemPb.changedValuesCurrentJson);

  }
}