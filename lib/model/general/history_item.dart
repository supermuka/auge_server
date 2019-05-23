/// HistoryItem is just created (inserted) like a log.
/// It does not have version field, necessary to concurrency control

import 'dart:convert';
import 'package:auge_server/shared/common_utils.dart';
import 'package:collection/collection.dart';

import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/history_item.pb.dart' as history_item_pb;

class HistoryItem {
  static final String idField = 'id';
  String id;
  static final String organizationField = 'organization';
  Organization organization;
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
  static final String changedValuesField = 'changedValues';
  Map<String, dynamic> changedValues;  // previousValuesChanged;


  history_item_pb.HistoryItem writeToProtoBuf() {
    history_item_pb.HistoryItem historyItemPb = history_item_pb.HistoryItem();

    if (this.id != null) historyItemPb.id = this.id;
    if (this.objectClassName != null) historyItemPb.objectClassName = this.objectClassName;
    if (this.objectId != null) historyItemPb.objectId = this.objectId;
    if (this.objectVersion != null) historyItemPb.objectVersion = this.objectVersion;
    if (this.systemModuleIndex != null) historyItemPb.systemModuleIndex = this.systemModuleIndex;
    if (this.systemFunctionIndex != null) historyItemPb.systemFunctionIndex = this.systemFunctionIndex;

    if (this.dateTime != null) historyItemPb.dateTime = CommonUtils.timestampFromDateTime(this.dateTime);/*{
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.dateTime.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      historyItemPb.dateTime = t;
    }*/
    if (this.organization != null) historyItemPb.organization = this.organization.writeToProtoBuf();
    if (this.user != null) historyItemPb.user = this.user.writeToProtoBuf();
    if (this.description != null) historyItemPb.description = this.description;

    if (this.changedValues != null) {

      // Convert value from dart json to protobuf string
      historyItemPb.changedValuesJson = json.encode(this.changedValues);
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
      this.dateTime = CommonUtils.dateTimeFromTimestamp(historyItemPb.dateTime);
    }
    if (historyItemPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(historyItemPb.organization);
    if (historyItemPb.hasUser()) this.user = User()..readFromProtoBuf(historyItemPb.user);
    if (historyItemPb.hasDescription()) this.description = historyItemPb.description;
    //if (historyItemPb.changedValues.isNotEmpty) this.changedValues = historyItemPb.changedValues;
    // Convert value from protobuf string to dart json
    if (historyItemPb.hasChangedValuesJson()) this.changedValues = json.decode(historyItemPb.changedValuesJson);
  }

  static const previousKey = 'p', currentKey = 'c';

  static Map<dynamic, dynamic> changedValuesMap(Map<dynamic, dynamic> previous, Map<dynamic, dynamic> current, [bool onlyDiff = true]) {

    Map<dynamic, dynamic> processPrevious(Map<dynamic, dynamic> previous) {
      //   Map<String, dynamic> mP = Map.from(map);
      Map<dynamic, dynamic> mP = {};
      previous.forEach((k, v) {
        if (v is Map) {
          mP[k] = processPrevious(v);
        } else {
          mP.putIfAbsent(k, () => {});
          mP[k][previousKey] = v;
        }
      });
      return mP;
    }

    Map<dynamic, dynamic> processCurrent(Map<dynamic, dynamic> current) {
      Map<dynamic, dynamic> mC = {};
      current.forEach((k, v) {
        if (v is Map) {
          mC[k] = processCurrent(v);
        } else {
          mC.putIfAbsent(k, () => {});
          mC[k][currentKey] = v;
        }
      });
      return mC;
    }

    Map<dynamic, dynamic> processMerge(Map<dynamic, dynamic> mapWithP, Map<dynamic, dynamic> mapWithC) {
      Map<dynamic, dynamic> mergeMap = Map.from(mapWithP ?? {});

      mapWithC.forEach((k, v) {
        if (v is Map) {
          mergeMap[k] = processMerge(mapWithP[k] ?? {}, mapWithC[k]);
        }
        mergeMap.putIfAbsent(k, () => mapWithC[k]);
      });
      return mergeMap;
    }

    Map<dynamic, dynamic> processOnlyDiffPreviousCurrent(Map<dynamic, dynamic> merge) {

      Map<dynamic, dynamic> diff = Map.from(merge);

      Map<dynamic, dynamic> diffSub;
      merge.forEach((k,v) {
        if (v is Map) {
          if (v.isEmpty) {
            diff.remove(k);
          } else if (v.containsKey(previousKey) || v.containsKey(currentKey)) {
            if (v[previousKey] is List && v[currentKey] is List) {
              if (DeepCollectionEquality().equals(
                  v[previousKey], v[currentKey]))
                diff.remove(k);
            } else if (v[previousKey] == v[currentKey]) {
              diff.remove(k);
            }
          } else {
            diffSub = processOnlyDiffPreviousCurrent(v);

            if (diffSub.isEmpty) {
              diff.remove(k);
            } else {
              diff[k] = diffSub;
            }
            //diff[k] = processOnlyDiffPreviousCurrent(v);
          }
        }
      });

      return diff;

    }

    Map<dynamic, dynamic> withP = processPrevious(previous);
    Map<dynamic, dynamic> withC = processCurrent(current);
    Map<dynamic, dynamic> merge = processMerge(withP, withC);
    if (onlyDiff) {

      return processOnlyDiffPreviousCurrent(merge);
    }
    else
      return merge;
  }

  static changedValuesJson(Map<dynamic, dynamic> previous, Map<dynamic, dynamic> current, [bool onlyDiff = true]) {
    return json.encode(changedValuesMap(previous, current, onlyDiff), toEncodable: changedValuesEncode);
  }

  static dynamic changedValuesEncode(dynamic item) {
    if(item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}