// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/initiative/state.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/stage.pbgrpc.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';
import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/initiative/state_service.dart';

class StageService extends StageServiceBase {

  // API
  @override
  Future<StagesResponse> getStages(ServiceCall call,
      StageGetRequest stageRequest) async {
    StagesResponse statesResponse;
    statesResponse = StagesResponse()..webWorkAround = true
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
        " FROM initiative.stages stage";

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
}