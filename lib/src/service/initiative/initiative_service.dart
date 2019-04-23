// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/group.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/stage.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/work_item.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/initiative.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/objective/objective.pb.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';

import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/initiative/stage_service.dart';
import 'package:auge_server/src/service/initiative/work_item_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';

import 'package:auge_server/model/general/authorization.dart';
import 'package:auge_server/model/general/history_item.dart' as history_item_m;


import 'package:auge_server/augeconnection.dart';

import 'package:uuid/uuid.dart';

class InitiativeService extends InitiativeServiceBase {

  // API
  @override
  Future<InitiativesResponse> getInitiatives(ServiceCall call,
      InitiativeGetRequest initiativeGetRequest) async {
    InitiativesResponse initiativesResponse;
    initiativesResponse = InitiativesResponse()..webWorkAround = true
      ..initiatives.addAll(
          await querySelectInitiatives(initiativeGetRequest));
    return initiativesResponse;
  }

  @override
  Future<Initiative> getInitiative(ServiceCall call,
      InitiativeGetRequest initiativeGetRequest) async {
    Initiative initiative = await querySelectInitiative(initiativeGetRequest);
    if (initiative == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.initiativeDataNotFoundReason);
    return initiative;
  }

  @override
  Future<IdResponse> createInitiative(ServiceCall call,
      InitiativeRequest request) async {
    return queryInsertInitiative(request);
  }

  @override
  Future<Empty> updateInitiative(ServiceCall call,
      InitiativeRequest request) async {
    return queryUpdateInitiative(request);
  }

  @override
  Future<Empty> deleteInitiative(ServiceCall call,
      InitiativeRequest request) async {
    return queryDeleteInitiative(request);
  }

  // QUERY
  // *** INITIATIVES ***
  static Future<List<Initiative>> querySelectInitiatives(InitiativeGetRequest initiativeGetRequest/* {String organizationId, String id, String objectiveId, bool withWorkItems = false, bool withProfile = false} */ ) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT initiative.id, " //0
        "initiative.version," //1
        "initiative.name, " //2
        "initiative.description, " //3
        "initiative.organization_id, " //4
        "initiative.leader_user_id, " //5
        "initiative.objective_id, " //6
        "initiative.group_id " //7
        "FROM initiative.initiatives initiative";

    Map<String, dynamic> substitutionValues;

    if (initiativeGetRequest.hasId()) {
      queryStatement += " WHERE initiative.id = @id";
      substitutionValues = {"id": initiativeGetRequest.id};
    } else if (initiativeGetRequest.hasOrganizationId()){
      queryStatement += " WHERE initiative.organization_id = @organization_id";
      substitutionValues = {"organization_id": initiativeGetRequest.organizationId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.initiativeInvalidArgument );
    }

    if (initiativeGetRequest.hasObjectiveId()) {
      queryStatement += " AND initiative.objective_id = @objective_id";
      substitutionValues.putIfAbsent("objective_id", () => initiativeGetRequest.objectiveId);
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<Initiative> initiatives = List<Initiative>();
    List<WorkItem> workItems;

    Objective objective;
    Organization organization;
    User user;
    Group group;
    List<Stage> stages;

    for (var row in results) {
      // Work Items
      workItems = (initiativeGetRequest.withWorkItems) ? await WorkItemService.querySelectWorkItems(WorkItemGetRequest()..initiativeId = row[0]) : [];

      if (row[4] != null && (organization == null || organization.id != row[4])) {

        // organization = await _augeApi.getOrganizationById(row[3]);

        organization = await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = row[4]);

      } else {
        organization = null;
      }

      // user = (await _augeApi.getUsers(id: row[4])).first;
      if (row[5] != null) {
        user = await UserService.querySelectUser(UserGetRequest()..id = row[5]..withProfile = initiativeGetRequest.withProfile);
      } else {
        user = null;
      }

      //stages = await getStages(row[0]);
      stages = await StageService.querySelectStages(StageGetRequest()..initiativeId = row[0]);

      // objective = row[5] == null ? null : await _objectiveAugeApi.getObjectiveById(row[5]);
      if (row[6] != null) {
        objective =
        row[6] == null ? null : await ObjectiveService.querySelectObjective(
            ObjectiveGetRequest()
              ..id = row[6]);
      } else {
        objective = null;
      }

      // group =  row[6] == null ? null : await _augeApi.getGroupById(row[6]);
      if (row[7] != null) {
        group = row[7] == null ? null : await GroupService.querySelectGroup(
            GroupGetRequest()
              ..id = row[7]);
      } else {
        group = null;
      }

      Initiative initiative =
      Initiative()..id = row[0]..version = row[1]..name = row[2]..description = row[3];
      if (workItems.isNotEmpty) {
        initiative.workItems.addAll(workItems);
      }
      if (organization != null) {
        initiative.organization = organization;
      }
      if (user != null) {
        initiative.leader = user;
      }
      if (stages.isNotEmpty) {
        initiative.stages.addAll(stages);
      }
      if (objective != null) {
        initiative.objective = objective;
      }
      if (group != null) {
        initiative.group = group;
      }

      initiatives.add(initiative);
    }

    return initiatives;
  }

  static Future<Initiative> querySelectInitiative(InitiativeGetRequest initiativeGetRequest) async {

    List<Initiative> initiatives = await querySelectInitiatives(initiativeGetRequest);

    if (initiatives.isNotEmpty) {
      return initiatives.first;
    } else {
      return null;
    }
  }

  /// Create (insert) a new initiative
  static Future<IdResponse> queryInsertInitiative(InitiativeRequest request) async {

    if (!request.initiative.hasId()) {
      request.initiative.id = new Uuid().v4();
    }

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query(
            "INSERT INTO initiative.initiatives(id, version, name, description, organization_id, leader_user_id, objective_id, group_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@description,"
                "@organization_id,"
                "@leader_user_id,"
                "@objective_id,"
                "@group_id)"
            , substitutionValues: {
          "id": request.initiative.id,
          "version": 0,
          "name": request.initiative.name,
          "description": request.initiative.description,
          "organization_id": request.initiative.organization.id,
          "leader_user_id": request.initiative.hasLeader() ? request.initiative.leader.id : null,
          "objective_id": request.initiative.hasObjective() ? request.initiative.objective.id : null,
          "group_id": request.initiative.hasGroup() ? request.initiative.group.id : null });

        for (Stage stage in request.initiative.stages) {
          stage.id = new Uuid().v4();

          await ctx.query(
              "INSERT INTO initiative.stages(id, name, index, state_id, initiative_id) VALUES"
                  "(@id,"
                  "@name,"
                  "@index,"
                  "@state_id,"
                  "@initiative_id)"
              , substitutionValues: {
            "id": stage.id,
            "name": stage.name,
            "index": stage.index,
            "state_id": stage.hasState() ? stage.state.id : null,
            "initiative_id": request.initiative.id});
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdResponse()..id = request.initiative.id;
  }

  /// Update an initiative passing an instance of [Initiative]
  Future<Empty> queryUpdateInitiative(InitiativeRequest request) async {

    // Recovery to log to history
    Initiative previousInitiative = await querySelectInitiative(InitiativeGetRequest()..id = request.initiative.id);

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result;

        result = await ctx.query("UPDATE initiative.initiatives "
          " SET version = @version + 1,"
          " name = @name,"
          " description = @description,"
          " organization_id = @organization_id,"
          " leader_user_id = @leader_user_id,"
          " objective_id = @objective_id,"
          " group_id = @group_id"
          " WHERE id = @id AND version = @version"
          " RETURNING true "
          , substitutionValues: {
            "id": request.initiative.id,
            "version": request.initiative.version,
            "name": request.initiative.name,
            "description": request.initiative.description,
            "organization_id": request.initiative.hasOrganization() ? request.initiative.organization.id : null,
            "leader_user_id": request.initiative.hasLeader() ? request.initiative.leader.id : null,
            "objective_id": request.initiative.hasObjective() ? request.initiative.objective.id : null,
            "group_id": request.initiative.hasGroup() ? request.initiative.group.id : null });

        // Stages
        StringBuffer stagesId = new StringBuffer();
        for (Stage stage in request.initiative.stages) {
          if (stage.id == null) {
            stage.id = new Uuid().v4();

            await ctx.query(
                "INSERT INTO initiative.stages(id, name, index, state_id, initiative_id) VALUES"
                    "(@id,"
                    "@name,"
                    "@index,"
                    "@state_id,"
                    "@initiative_id)"
                , substitutionValues: {
              "id": stage.id,
              "name": stage.name,
              "index": stage.index,
              "state_id": stage.state.id,
              "initiative_id": request.initiative.id});
          } else {
            await ctx.query("UPDATE initiative.stages SET"
                " name = @name,"
                " index = @index,"
                " state_id = @state_id,"
                " initiative_id = @initiative_id"
                " WHERE id = @id"
                , substitutionValues: {
                  "id": stage.id,
                  "name": stage.name,
                  "index": stage.index,
                  "state_id": stage.state.id,
                  "initiative_id": request.initiative.id});
          }

          if (stagesId.isNotEmpty)
            stagesId.write(',');
          stagesId.write("'");
          stagesId.write(stage.id);
          stagesId.write("'");
        }

        if (stagesId.isNotEmpty) {
          await ctx.query("DELETE FROM initiative.stages "
              " WHERE id NOT IN (${stagesId.toString()}) "
              " AND initiative_id  = @initiative_id "
              , substitutionValues: {
                "initiative_id": request.initiative.id});
        }

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.initiativePreconditionFailed );
        }
        else {
          // HistoryItem
          HistoryItem historyItem;

          Map<String, dynamic> valuesPrevious = previousInitiative.writeToJsonMap();
          Map<String, dynamic> valuesCurrent = request.initiative.writeToJsonMap();

          historyItem
            ..id = new Uuid().v4()
            ..objectId = request.initiative.id
            ..objectVersion = request.initiative.version
            ..objectClassName = 'Initiative' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.create.index
            // ..dateTime
            ..description = request.initiative.name
            ..changedValuesPreviousJson = json.encode(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
            ..changedValuesCurrentJson = json.encode(history_item_m.HistoryItem.changedValues(valuesCurrent, valuesPrevious));

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(historyItem));
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }

  /// Delete an initiative by [id]
  static Future<Empty> queryDeleteInitiative(InitiativeRequest request) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "DELETE FROM initiative.stages stage"
                " WHERE stage.initiative_id = @id"
            , substitutionValues: {
          "id": request.initiative.id});

        await ctx.query(
            "DELETE FROM initiative.initiatives initiative"
                " WHERE initiative.id = @id"
            , substitutionValues: {
          "id": request.initiative.id});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return null;
  }
}