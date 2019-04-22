// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';
//import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/src/service/general/user_service.dart';

class HistoryItemService extends HistoryItemServiceBase {

  // API
  @override
  Future<HistoryResponse> getHistory(ServiceCall call,
      HistoryItemGetRequest historyItemGetRequest) async {
    HistoryResponse historyResponse;
    historyResponse.webListWorkAround = true;
    historyResponse = HistoryResponse()..history.addAll(await querySelectHistory(historyItemGetRequest));
    return historyResponse;
  }

  // QUERY
  // History to auge_objective schema
  static String queryStatementCreateHistoryItem = "INSERT INTO auge_objective.history(id, object_id, object_version, object_class_name, system_function_index, date_time, user_id, description, changed_values) VALUES"
      "(@id,"
      "@user_id,"
      "@object_id,"
      "@object_version,"
      "@object_class_name,"
      "@system_function_index,"
      "@date_time,"
      "@description,"
      "@changed_values_previous,"
      "@changed_values_current)";

  static Map<String, dynamic> querySubstitutionValuesCreateHistoryItem(HistoryItem request) {

    return {"id": request.id,
      "user_id": request.hasUser() ? request.user.id : null,

      "object_id": request.hasObjectId() ? request.objectId : null,
      "object_version": request.hasObjectVersion() ? request.objectVersion : null,
      "object_class_name": request.hasObjectClassName() ? request.objectClassName : null,
      "system_function_index": request.systemFunctionIndex,
      "date_time": DateTime.now().toUtc(),
      "changed_values_previous": request.changedValuesPrevious.isNotEmpty ? request.changedValuesPrevious.toString() : null,
      "changed_values_current": request.changedValuesCurrent.isNotEmpty ? request.changedValuesCurrent.toString() : null,
      "description": request.hasDescription() ? request.description : null};
  }

  // *** HISTORY TO OBJECTIVE SCHEMA ***
  static Future<List<HistoryItem>> querySelectHistory(HistoryItemGetRequest historyItemGetRequest  /* {String id, int systemModuleIndex} */) async {
    Map<String, User> userCache;
    List<List> results;

    String queryStatementSelect = "SELECT history_item.id, " //0
        "history_item.user_id, " //1
        "history_item.object_id, " //2
        "history_item.object_version, " //3
        "history_item.object_class_name, " //4
        "history_item.system_function_index, " //5
        "history_item.date_time, " //6
        "history_item.description, " //7
        "history_item.changed_values_previous, " //8
        "history_item.changed_values_current"; //9

    String queryStatement;

/*
    queryStatement = queryStatementSelect +
        "FROM auge_objective.history history_item "
            "WHERE object_class_name = 'Objective' "
            "AND object_id = @objective_id "
            "UNION "
        + queryStatementSelect +
        "FROM auge_objective.history history_item "
            "JOIN auge_objective.measures measure ON measure.id = history_item.object_id "
            "WHERE history_item.object_class_name = 'Measure' "
            "AND measure.objective_id = @objective_id "
            "UNION "
        + queryStatementSelect +
        "FROM auge_objective.history history_item "
            "JOIN auge_objective.measure_progress measure_progress ON measure_progress.id = history_item.object_id "
            "JOIN auge_objective.measures measure ON measure.id = measure_progress.measure_id "
            "WHERE history_item.object_class_name = 'MeasureProgress' "
            "AND measure.objective_id = @objective_id";

 */
    queryStatement = queryStatementSelect +
        "FROM auge_objective.history history_item "
            "WHERE object_class_name = 'Objective' "
            "AND system_module_index = @system_module_index ";

    Map<String, dynamic> substitutionValues;

    substitutionValues = {"system_module_index": historyItemGetRequest.systemModuleIndex};

    queryStatement += " ORDER BY 6 DESC ";

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<HistoryItem> history = new List();

    User user;

    if (results != null && results.isNotEmpty) {

      for (var row in results) {

        user = await UserService.querySelectUser(UserGetRequest()..id = row[1]..withProfile = true, cache: userCache);
/*
        Map changedDataMap = json.decode(row[8]);

        if (historyItemGetRequest.withIdRemoved)
          changedDataMap.keys.where((k) =>  (k == 'id' || changedDataMap[k] is Map && changedDataMap[k].keys.where((kk) => (kk == 'id') ))
          ).toList().forEach(changedDataMap.remove);
*/
        history.add(new HistoryItem()
          ..id = row[0]
          ..user = user
          ..objectId = row[2]
          ..objectVersion = row[3]
          ..objectClassName = row[4]
          ..systemFunctionIndex = row[5]
          ..dateTime = row[6]
          ..description = row[7]
          ..changedValuesPrevious.addAll(json.decode(row[8]))
          ..changedValuesCurrent.addAll(json.decode(row[9]))
        );
      }
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