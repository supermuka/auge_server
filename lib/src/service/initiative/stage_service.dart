// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/state.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/stage.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/initiative/state_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/model/initiative/stage.dart' as stage_m;

import 'package:uuid/uuid.dart';

class StageService extends StageServiceBase {

  // API
  @override
  Future<StagesResponse> getStages(ServiceCall call,
      StageGetRequest stageRequest) async {
    StagesResponse statesResponse;
    statesResponse = StagesResponse()/*..webWorkAround = true*/
      ..stages.addAll(
          await querySelectStages(stageRequest));
    return statesResponse;
  }

  @override
  Future<Stage> getStage(ServiceCall call,
      StageGetRequest stageRequest) async {
    Stage stage = await querySelectStage(stageRequest);
    if (stage == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.stageDataNotFoundReason);
    return stage;
  }

  @override
  Future<StringValue> createStage(ServiceCall call,
      StageRequest request) async {
    return queryInsertStage(request);
  }

  @override
  Future<Empty> updateStage(ServiceCall call,
      StageRequest request) async {
    return queryUpdateStage(request);
  }

  @override
  Future<Empty> deleteStage(ServiceCall call,
      StageDeleteRequest request) async {
    return queryDeleteStage(request);
  }


  // QUERY
  // *** INITIATIVE STAGES ***
  static Future<List<Stage>> querySelectStages(StageGetRequest stageGetRequest /* {String initiativeId, String id} */) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT stage.id,"
        " stage.version,"
        " stage.name,"
        " stage.index,"
        " stage.initiative_id,"
        " stage.state_id"
        " FROM initiative.stages stage"
        " JOIN initiative.states state ON state.id = stage.state_id";

    Map<String, dynamic> substitutionValues;

    if (stageGetRequest != null && stageGetRequest.hasId()) {
      queryStatement += " WHERE stage.id = @id";
      substitutionValues = {"id": stageGetRequest.id};
    } else if (stageGetRequest != null && stageGetRequest.hasInitiativeId() ) {
      queryStatement += " WHERE stage.initiative_id = @initiative_id";
      substitutionValues = {"initiative_id": stageGetRequest.initiativeId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.stageInvalidArgument );
    }

    queryStatement += " ORDER BY state.index, stage.index";

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<Stage> stages = new List();
    Stage stage;
    for (var row in results) {

      List<State> states = await StateService.querySelectStates(StateGetRequest()..id = row[5]);

      stage = Stage()
        ..id = row[0]
        ..version = row[1]
        ..name = row[2]
        ..index = row[3];

      if (states.isNotEmpty) {
        stage.state = states?.first;
      }

      stages.add(stage);
    }

    return stages;
  }

  static Future<Stage> querySelectStage(StageGetRequest stageGetRequest) async {
    List<Stage> stages = await querySelectStages(stageGetRequest);
    if (stages.isNotEmpty) {
      return stages.first;
    } else {
      return null;
    }
  }

  /// Create (insert) a new stage
  static Future<StringValue> queryInsertStage(StageRequest request) async {

    if (!request.stage.hasId()) {
      request.stage.id = Uuid().v4();
    }

    request.stage.version = 0;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO initiative.stages(id, version, name, index, state_id, initiative_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@index,"
                "@state_id,"
                "@initiative_id)"
            , substitutionValues: {
          "id": request.stage.id,
          "version": request.stage.version,
          "name": request.stage.name,
          "index": request.stage.index,
          "state_id": request.stage.hasState() ? request.stage.state.id : null,
          "initiative_id": request.initiativeId});


        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.stage.id,
          "object_version": request.stage.version,
          "object_class_name": stage_m.Stage.className,
          "system_module_index": SystemModule.initiatives.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.stage.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, stage_m.Stage.fromProtoBufToModelMap(request.stage))});
      });

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.stage.id;
  }

  /// Update a Stage
  Future<Empty> queryUpdateStage(StageRequest request) async {

    // Recovery to log to history
    Stage previousStage = await querySelectStage(StageGetRequest()
      ..id = request.stage.id);

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result;

        result =  await ctx.query("UPDATE initiative.stages SET"
            " version = @version,"
            " name = @name,"
            " index = @index,"
            " state_id = @state_id,"
            " initiative_id = @initiative_id"
            " WHERE id = @id AND version = @version - 1"
            " RETURNING true "
            , substitutionValues: {
              "id": request.stage.id,
              "version": ++request.stage.version,
              "name": request.stage.name,
              "index": request.stage.index,
              "state_id": request.stage.state.id,
              "initiative_id": request.initiativeId});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.initiativePreconditionFailed );
        } else {
          // Create a history item
          await ctx.query(
              HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.stage.id,
                "object_version": request.stage.version,
                "object_class_name": stage_m
                    .Stage.className,
                "system_module_index": SystemModule.initiatives.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": request.stage.name,
                "changed_values": history_item_m.HistoryItem
                    .changedValuesJson(
                    stage_m.Stage
                        .fromProtoBufToModelMap(
                        previousStage),
                    stage_m.Stage
                        .fromProtoBufToModelMap(
                        request.stage)
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
  static Future<Empty> queryDeleteStage(StageDeleteRequest request) async {

    Stage previousStage = await querySelectStage(StageGetRequest()..id = request.stageId);

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM initiative.stages stage"
                " WHERE stage.id = @id"
                " AND stage.version = @version"
                " RETURNING true "
            , substitutionValues: {
          "id": request.stageId,
          "version": request.stageVersion});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.initiativePreconditionFailed );
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.stageId,
                "object_version": request.stageVersion,
                "object_class_name": stage_m.Stage.className,
                "system_module_index": SystemModule.initiatives.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousStage.name,
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    stage_m.Stage.fromProtoBufToModelMap(
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