// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'package:auge_shared/src/util/common_utils.dart';

import 'package:grpc/grpc.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/history_item.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/general/user_service.dart';

class HistoryItemService extends HistoryItemServiceBase {

  // API
  @override
  Future<HistoryResponse> getHistory(ServiceCall call,
      HistoryItemGetRequest historyItemGetRequest) async {

    HistoryResponse historyResponse = HistoryResponse()..history.addAll(await querySelectHistory(historyItemGetRequest))/*..webListWorkAround = true*/;
    return historyResponse;
  }

  // QUERY
  // History to auge_objective schema
  static String queryStatementCreateHistoryItem = "INSERT INTO general.history(id, organization_id, user_id, object_id, object_version, object_class_name, system_module_index, system_function_index, date_time, description, changed_values) VALUES"
      "(@id,"
      "@organization_id,"
      "@user_id,"
      "@object_id,"
      "@object_version,"
      "@object_class_name,"
      "@system_module_index,"
      "@system_function_index,"
      "@date_time,"
      "@description,"
      "@changed_values)";

  // *** HISTORY TO OBJECTIVE SCHEMA ***
  static Future<List<HistoryItem>> querySelectHistory(HistoryItemGetRequest historyItemGetRequest  /* {String id, int systemModuleIndex} */) async {
    Map<String, User> userCache;
    List<List> results;
    List<HistoryItem> history = new List();


    String queryStatement = "SELECT history_item.id, " //0
        "history_item.user_id, " //1
        "history_item.object_id, " //2
        "history_item.object_version, " //3
        "history_item.object_class_name, " //4
        "history_item.system_module_index, " //5
        "history_item.system_function_index, " //6
        "history_item.date_time, " //7
        "history_item.description, " //8
        "history_item.changed_values " //9
        "FROM general.history history_item "
        "WHERE history_item.organization_id = @organization_id ";

    Map<String, dynamic> substitutionValues;

    substitutionValues = {"organization_id": historyItemGetRequest.organizationId};

    if (historyItemGetRequest.hasSystemModuleIndex() && historyItemGetRequest.systemModuleIndex != null) {
      substitutionValues["system_module_index"] = historyItemGetRequest.systemModuleIndex;
      queryStatement = queryStatement + "AND history_item.system_module_index = @system_module_index ";
    }

    if (historyItemGetRequest.hasSystemModuleIndex() && historyItemGetRequest.systemModuleIndex != null) {
      substitutionValues["system_module_index"] = historyItemGetRequest.systemModuleIndex;
      queryStatement = queryStatement + "AND history_item.system_module_index = @system_module_index ";
    }

    if (historyItemGetRequest.hasFromDateTime() && historyItemGetRequest.fromDateTime != null) {
      substitutionValues["from_date_time"] = historyItemGetRequest.fromDateTime.toDateTime();
      queryStatement = queryStatement + "AND history_item.date_time >= @from_date_time ";
    }

    queryStatement = queryStatement + "ORDER BY history_item.date_time DESC ";

    if (historyItemGetRequest.hasRowsLimit() && historyItemGetRequest.rowsLimit > 0) {
      queryStatement = queryStatement + "LIMIT ${historyItemGetRequest.rowsLimit} ";
    }

    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      User user;

      if (results != null && results.isNotEmpty) {
        for (var row in results) {
          user = await UserService.querySelectUser(UserGetRequest()
            ..id = row[1]
            ..withUserProfile = true, cache: userCache);

          HistoryItem historyItem = HistoryItem()..id = row[0]
            ..user = user
            ..objectId = row[2]
            ..objectVersion = row[3]
            ..objectClassName = row[4]
            ..systemModuleIndex = row[5]
            ..systemFunctionIndex = row[6];

          if (row[7] != null) historyItem.dateTime = CommonUtils.timestampFromDateTime(row[7]);
          if (row[8] != null) historyItem.description = row[8];
          if (row[9] != null) historyItem.changedValuesJson = row[9];

          history.add(historyItem);
        }
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return history;
  }

  static Future<HistoryItem> querySelectHistoryItem(HistoryItemGetRequest request, {Map<String, HistoryItem> cache}) async {
    if (cache != null && cache.containsKey(request.id)) {
      return cache[request.id];
    } else {
      List<HistoryItem> history = await querySelectHistory(request);

      if (history.isNotEmpty) {
        if (cache != null) cache[request.id] = history.first;
        return history.first;
      } else {
        return null;
      }
    }
  }
}