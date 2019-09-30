// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/work/state.pb.dart';
import 'package:auge_server/src/protos/generated/work/work_stage.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/work/state_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/model/work/work_stage.dart' as work_stage_m;

import 'package:uuid/uuid.dart';

class WorkStageService extends WorkStageServiceBase {

  // API
  @override
  Future<WorkStagesResponse> getWorkStages(ServiceCall call,
      WorkStageGetRequest stageRequest) async {
    WorkStagesResponse workStatesResponse;
    workStatesResponse = WorkStagesResponse()/*..webWorkAround = true*/
      ..workStages.addAll(
          await querySelectWorkStages(stageRequest));
    return workStatesResponse;
  }

  @override
  Future<WorkStage> getWorkStage(ServiceCall call,
      WorkStageGetRequest workStageRequest) async {
    WorkStage workStage = await querySelectWorkStage(workStageRequest);
    if (workStage == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.stageDataNotFoundReason);
    return workStage;
  }

  @override
  Future<StringValue> createWorkStage(ServiceCall call,
      WorkStageRequest request) async {
    return queryInsertWorkStage(request);
  }

  @override
  Future<Empty> updateWorkStage(ServiceCall call,
      WorkStageRequest request) async {
    return queryUpdateWorkStage(request);
  }

  @override
  Future<Empty> deleteWorkStage(ServiceCall call,
      WorkStageDeleteRequest request) async {
    return queryDeleteWorkStage(request);
  }


  // QUERY
  // *** WORK STAGES ***
  static Future<List<WorkStage>> querySelectWorkStages(WorkStageGetRequest workStageGetRequest /* {String workId, String id} */) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_stage.id,"
        " work_stage.version,"
        " work_stage.name,"
        " work_stage.index,"
        " work_stage.work_id,"
        " work_stage.state_id"
        " FROM work.work_stages work_stage"
        " JOIN work.states state ON state.id = work_stage.state_id";

    Map<String, dynamic> substitutionValues;

    if (workStageGetRequest != null && workStageGetRequest.hasId()) {
      queryStatement += " WHERE work_stage.id = @id";
      substitutionValues = {"id": workStageGetRequest.id};
    } else if (workStageGetRequest != null && workStageGetRequest.hasWorkId() ) {
      queryStatement += " WHERE work_stage.work_id = @work_id";
      substitutionValues = {"work_id": workStageGetRequest.workId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.stageInvalidArgument );
    }

    queryStatement += " ORDER BY state.index, work_stage.index";

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<WorkStage> workStages = new List();
    WorkStage workStage;
    for (var row in results) {

      List<State> states = await StateService.querySelectStates(StateGetRequest()..id = row[5]);

      workStage = WorkStage()
        ..id = row[0]
        ..version = row[1]
        ..name = row[2]
        ..index = row[3];

      if (states.isNotEmpty) {
        workStage.state = states?.first;
      }

      workStages.add(workStage);
    }

    return workStages;
  }

  static Future<WorkStage> querySelectWorkStage(WorkStageGetRequest workStageGetRequest) async {
    List<WorkStage> workStages = await querySelectWorkStages(workStageGetRequest);
    if (workStages.isNotEmpty) {
      return workStages.first;
    } else {
      return null;
    }
  }

  /// Create (insert) a new stage
  static Future<StringValue> queryInsertWorkStage(WorkStageRequest request) async {

    if (!request.workStage.hasId()) {
      request.workStage.id = Uuid().v4();
    }

    request.workStage.version = 0;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO work.work_stages(id, version, name, index, state_id, work_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@index,"
                "@state_id,"
                "@work_id)"
            , substitutionValues: {
          "id": request.workStage.id,
          "version": request.workStage.version,
          "name": request.workStage.name,
          "index": request.workStage.index,
          "state_id": request.workStage.hasState() ? request.workStage.state.id : null,
          "work_id": request.workId});


        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.workStage.id,
          "object_version": request.workStage.version,
          "object_class_name": work_stage_m.WorkStage.className,
          "system_module_index": SystemModule.works.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.workStage.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, work_stage_m.WorkStage.fromProtoBufToModelMap(request.workStage))});
      });

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.workStage.id;
  }

  /// Update a Stage
  Future<Empty> queryUpdateWorkStage(WorkStageRequest request) async {

    // Recovery to log to history
    WorkStage previousStage = await querySelectWorkStage(WorkStageGetRequest()
      ..id = request.workStage.id);

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result;

        result =  await ctx.query("UPDATE work.work_stages SET"
            " version = @version,"
            " name = @name,"
            " index = @index,"
            " state_id = @state_id,"
            " work_id = @work_id"
            " WHERE id = @id AND version = @version - 1"
            " RETURNING true "
            , substitutionValues: {
              "id": request.workStage.id,
              "version": ++request.workStage.version,
              "name": request.workStage.name,
              "index": request.workStage.index,
              "state_id": request.workStage.state.id,
              "work_id": request.workId});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
        } else {
          // Create a history item
          await ctx.query(
              HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.workStage.id,
                "object_version": request.workStage.version,
                "object_class_name": work_stage_m
                    .WorkStage.className,
                "system_module_index": SystemModule.works.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": request.workStage.name,
                "changed_values": history_item_m.HistoryItem
                    .changedValuesJson(
                    work_stage_m.WorkStage
                        .fromProtoBufToModelMap(
                        previousStage),
                    work_stage_m.WorkStage
                        .fromProtoBufToModelMap(
                        request.workStage)
                )
              });
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a stage by [id]
  static Future<Empty> queryDeleteWorkStage(WorkStageDeleteRequest request) async {

    WorkStage previousStage = await querySelectWorkStage(WorkStageGetRequest()..id = request.workStageId);

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM work.work_stages work_stage"
                " WHERE work_stage.id = @id"
                " AND work_stage.version = @version"
                " RETURNING true "
            , substitutionValues: {
          "id": request.workStageId,
          "version": request.workStageVersion});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.workStageId,
                "object_version": request.workStageVersion,
                "object_class_name": work_stage_m.WorkStage.className,
                "system_module_index": SystemModule.works.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousStage.name,
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    work_stage_m.WorkStage.fromProtoBufToModelMap(
                        previousStage, true), {})});
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}