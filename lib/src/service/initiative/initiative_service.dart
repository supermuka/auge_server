// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

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

import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/initiative/stage_service.dart';
import 'package:auge_server/src/service/initiative/work_item_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';

import 'package:auge_server/model/general/authorization.dart';


import 'package:auge_server/augeconnection.dart';

import 'package:uuid/uuid.dart';

class InitiativeService extends InitiativeServiceBase {

  // API
  @override
  Future<InitiativesResponse> getInitiatives(ServiceCall call,
      InitiativeGetRequest initiativeGetRequest) async {
    InitiativesResponse initiativesResponse;
    initiativesResponse = InitiativesResponse()..webListWorkAround = true
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
      Initiative initiative) async {
    return queryInsertInitiative(initiative);
  }

  @override
  Future<Empty> updateInitiative(ServiceCall call,
      Initiative initiative) async {
    return queryUpdateInitiative(initiative);
  }

  @override
  Future<Empty> deleteInitiative(ServiceCall call,
      Initiative initiative) async {
    return queryDeleteInitiative(initiative);
  }

  @override
  Future<Empty> softDeleteInitiative(ServiceCall call,
      Initiative initiative) async {
    initiative.isDeleted = true;
    return queryUpdateInitiative(initiative);
  }

  // QUERY
  // *** INITIATIVES ***
  static Future<List<Initiative>> querySelectInitiatives(InitiativeGetRequest initiativeGetRequest/* {String organizationId, String id, String objectiveId, bool withWorkItems = false, bool withProfile = false} */ ) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT initiative.id, " //0
        "initiative.version," //1
        "initiative.is_deleted," //2
        "initiative.name, " //3
        "initiative.description, " //4
        "initiative.organization_id, " //5
        "initiative.leader_user_id, " //6
        "initiative.objective_id, " //7
        "initiative.group_id " //8
        "FROM initiative.initiatives initiative";

    Map<String, dynamic> substitutionValues;

    if (initiativeGetRequest.hasId()) {
      queryStatement += " WHERE initiative.id = @id AND is_deleted = @is_deleted";
      substitutionValues = {"id": initiativeGetRequest.id, "is_deleted": initiativeGetRequest.isDeleted};
    } else if (initiativeGetRequest.hasOrganizationId()){
      queryStatement += " WHERE initiative.organization_id = @organization_id AND is_deleted = @is_deleted";
      substitutionValues = {"organization_id": initiativeGetRequest.organizationId, "is_deleted": initiativeGetRequest.isDeleted};
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

      if (row[5] != null && (organization == null || organization.id != row[5])) {

        // organization = await _augeApi.getOrganizationById(row[3]);

        organization = await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = row[5]);

      } else {
        organization = null;
      }

      // user = (await _augeApi.getUsers(id: row[4])).first;
      if (row[6] != null) {
        user = await UserService.querySelectUser(UserGetRequest()..id = row[6]..withProfile = initiativeGetRequest.withProfile);
      } else {
        user = null;
      }

      //stages = await getStages(row[0]);
      stages = await StageService.querySelectStages(StageGetRequest()..initiativeId = row[0]);

      // objective = row[5] == null ? null : await _objectiveAugeApi.getObjectiveById(row[5]);
      if (row[7] != null) {
        objective =
        row[7] == null ? null : await ObjectiveService.querySelectObjective(
            ObjectiveGetRequest()
              ..id = row[7]);
      } else {
        objective = null;
      }

      // group =  row[6] == null ? null : await _augeApi.getGroupById(row[6]);
      if (row[8] != null) {
        group = row[8] == null ? null : await GroupService.querySelectGroup(
            GroupGetRequest()
              ..id = row[8]);
      } else {
        group = null;
      }

      Initiative initiative =
      Initiative()..id = row[0]..version = row[1]..isDeleted = row[2]..name = row[3]..description = row[4];
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
  static Future<IdResponse> queryInsertInitiative(Initiative initiative) async {

    if (!initiative.hasId()) {
      initiative.id = new Uuid().v4();
    }

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query(
            "INSERT INTO initiative.initiatives(id, version, is_deleted, name, description, organization_id, leader_user_id, objective_id, group_id) VALUES"
                "(@id,"
                "@version,"
                "@is_deleted,"
                "@name,"
                "@description,"
                "@organization_id,"
                "@leader_user_id,"
                "@objective_id,"
                "@group_id)"
            , substitutionValues: {
          "id": initiative.id,
          "version": 0,
          "is_deleted": false,
          "name": initiative.name,
          "description": initiative.description,
          "organization_id": initiative.organization.id,
          "leader_user_id": initiative.hasLeader() ? initiative.leader.id : null,
          "objective_id": initiative.hasObjective() ? initiative.objective.id : null,
          "group_id": initiative.hasGroup() ? initiative.group.id : null });

        for (Stage stage in initiative.stages) {
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
            "initiative_id": initiative.id});
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdResponse()..id = initiative.id;
  }

  /// Update an initiative passing an instance of [Initiative]
  Future<Empty> queryUpdateInitiative(Initiative initiative) async {

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        List<List<dynamic>> result;
        if (initiative.isDeleted) {
          result = await ctx.query("UPDATE initiative.initiatives "
              " SET version = @version + 1, "
              " is_deleted = @is_deleted "
              " WHERE id = @id AND version = @version"
              " RETURNING true "
              , substitutionValues: {
                "id": initiative.id,
                "version": initiative.version,
                "is_deleted": initiative.isDeleted,
              });
        } else {
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
              "id": initiative.id,
              "version": initiative.version,
              "name": initiative.name,
              "description": initiative.description,
              "organization_id": initiative.hasOrganization() ? initiative.organization.id : null,
              "leader_user_id": initiative.hasLeader() ? initiative.leader.id : null,
              "objective_id": initiative.hasObjective() ? initiative.objective.id : null,
              "group_id": initiative.hasGroup() ? initiative.group.id : null });

          // Stages
          StringBuffer stagesId = new StringBuffer();
          for (Stage stage in initiative.stages) {
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
                "initiative_id": initiative.id});
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
                    "initiative_id": initiative.id});
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
                  "initiative_id": initiative.id});
          }
        }

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.initiativePreconditionFailed );
        }
        else {
          // HistoryItem
          initiative.historyItemLog
            ..id = new Uuid().v4()
            ..objectId = initiative.id
            ..objectVersion = initiative.version
            ..objectClassName = 'Initiative' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.create.index;
          // ..dateTime = DateTime.now().toUtc();

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(initiative.historyItemLog));
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  /// Delete an initiative by [id]
  static Future<Empty> queryDeleteInitiative(Initiative initiative) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "DELETE FROM initiative.stages stage"
                " WHERE stage.initiative_id = @id"
            , substitutionValues: {
          "id": initiative.id});

        await ctx.query(
            "DELETE FROM initiative.initiatives initiative"
                " WHERE initiative.id = @id"
            , substitutionValues: {
          "id": initiative.id});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return null;
  }


}