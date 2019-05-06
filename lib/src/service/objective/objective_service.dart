// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/objective/objective.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/objective/measure.pb.dart';
import 'package:auge_server/src/protos/generated/general/group.pb.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';


import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' show HistoryItemUtils;
import 'package:auge_server/model/objective/objective.dart' show ObjectiveUtils;
import 'package:auge_server/shared/rpc_error_message.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';
import 'package:auge_server/src/service/objective/measure_service.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:uuid/uuid.dart';

class ObjectiveService extends ObjectiveServiceBase {

  // API
  @override
  Future<ObjectivesResponse> getObjectives(ServiceCall call,
      ObjectiveGetRequest request) async {

    return ObjectivesResponse()..webWorkAround = true..objectives.addAll(await querySelectObjectives(request));
  }

  @override
  Future<Objective> getObjective(ServiceCall call,
      ObjectiveGetRequest request) async {
    Objective objective = await querySelectObjective(request);
    if (objective == null) throw new GrpcError.notFound("Objective not found.");
    return objective;
  }

  @override
  Future<IdResponse> createObjective(ServiceCall call,
      ObjectiveRequest request) async {
    return queryInsertObjective(request);
  }

  @override
  Future<Empty> updateObjective(ServiceCall call,
      ObjectiveRequest request) async {
    return queryUpdateObjective(request);
  }

  @override
  Future<Empty> deleteObjective(ServiceCall call,
      ObjectiveRequest request) async {
    return queryDeleteObjective(request);
  }

  // QUERY
  // *** OBJECTIVES ***
  // alignedToRecursiveDeep: 0 not call; 1 call once; 2 call tow, etc...
  static Future<List<Objective>> querySelectObjectives(ObjectiveGetRequest objectiveSelectRequest) async {
    List<List> results;
    // String queryStatementColumns = "objective.id::VARCHAR, objective.name, objective.description, objective.start_date, objective.end_date, objective.leader_user_id, objective.aligned_to_objective_id";
    String queryStatementColumns = "objective.id," //0
        " objective.version, " //1
        " objective.name," //2
        " objective.description," //3
        " objective.start_date," //4
        " objective.end_date," //5
        " objective.archived," //6
        " objective.leader_user_id," //7
        " objective.aligned_to_objective_id," //8
        " objective.organization_id," //9
        " objective.group_id"; //10

    String queryStatementWhere = "";
    Map<String, dynamic> substitutionValues;

    if (objectiveSelectRequest.id != null && objectiveSelectRequest.id.isNotEmpty) {
      queryStatementWhere = " objective.id = @id";
      substitutionValues = {"id": objectiveSelectRequest.id};

    } else if (objectiveSelectRequest.organizationId != null && objectiveSelectRequest.organizationId.isNotEmpty) {
      queryStatementWhere = " objective.organization_id = @organization_id";
      substitutionValues = {"organization_id": objectiveSelectRequest.organizationId};

    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.objectiveInvalidArgument );
    }

    if (!objectiveSelectRequest.withArchived) {
      queryStatementWhere = queryStatementWhere + " AND objective.archived <> true";
    }

    String queryStatement;
    if (objectiveSelectRequest.treeAlignedWithChildren) {
      queryStatement =
          "WITH RECURSIVE nodes(" + queryStatementColumns.replaceAll("objective.", "") + ") AS ("
              " SELECT " + queryStatementColumns +
              " FROM objective.objectives objective WHERE " +
              queryStatementWhere + " AND objective.aligned_to_objective_id is null"
              " UNION"
              " SELECT " + queryStatementColumns +
              " FROM objective.objectives objective, nodes node WHERE " +
              queryStatementWhere + " AND objective.aligned_to_objective_id = node.id"
              " )"
              " SELECT " + queryStatementColumns.replaceAll("objective.", "") + " FROM nodes";
    }
    else {
      queryStatement = "SELECT " + queryStatementColumns +
          " FROM objective.objectives objective"
              " WHERE " + queryStatementWhere;
    }


    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<Objective> objectives = new List();
    List<Objective> objectivesTree = new List();

    if (results != null && results.isNotEmpty) {

      Organization organization; // = await _augeApi.getOrganizationById(organizationId);

      List<Measure> measures;
      List<HistoryItem> history;
      User leaderUser;
      Objective alignedToObjective;

      Objective objective;
      Group group;

      for (var row in results) {
        // Measures

        if (row[10] != null) {
          organization = await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = row[10]);
        }

        if (row[0] != null) {
          measures =
          (objectiveSelectRequest.withMeasures) ? await MeasureService
              .querySelectMeasures(MeasureGetRequest()
            ..objectiveId = row[0]) : [];
          history =
          (objectiveSelectRequest.withHistory) ? await HistoryItemService
              .querySelectHistory(HistoryItemGetRequest()..id = row[0]) : [];
        }
        if (row[8] != null) {
          leaderUser = await UserService.querySelectUser(UserGetRequest()..id = row[8]..withProfile = objectiveSelectRequest.withProfile);
        }

        if (row[9] != null && objectiveSelectRequest.alignedToRecursive > 0) {
          --objectiveSelectRequest.alignedToRecursive;
          alignedToObjective = await ObjectiveService.querySelectObjective(objectiveSelectRequest);
        }

        if (row[11] != null) {
          group = await GroupService.querySelectGroup(GroupGetRequest()..id = row[11]);
        }

        objective = new Objective()
          ..id = row[0]
          ..version = row[1]
           ..name = row[2];

        if (row[3] != null) objective.description = row[3];
        //if (row[4] != null) objective.startDate = row[4];

        if (row[4] != null) {
          Timestamp t = Timestamp();
          int microsecondsSinceEpoch = row[4].toUtc().microsecondsSinceEpoch;
          t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
          t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
          objective.startDate = t;
        }

        //  if (row[5] != null) objective.endDate = row[5];
        if (row[5] != null) {
          Timestamp t = Timestamp();
          int microsecondsSinceEpoch = row[5].toUtc().microsecondsSinceEpoch;
          t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
          t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
          objective.endDate = t;
        }


        if (row[6] != null) objective.archived =  row[6];
        if (organization != null) objective.organization = organization;
        if (leaderUser != null) objective.leader = leaderUser;
        if (measures.isNotEmpty) objective.measures.addAll(measures);
        if (alignedToObjective != null) objective.alignedTo = alignedToObjective;
        if (group != null) objective.group = group;
        if (history.isNotEmpty) objective.history.addAll(history);

        objectives.add(objective);

        if (!objectiveSelectRequest.treeAlignedWithChildren) {
          // Parent must be present in the list (objectives);
          if (row[8] == null)
            objectivesTree.add(objective);
          else {
            objectives
                .singleWhere((o) => o.id == row[8])
                ?.alignedWithChildren
                ?.add(objective);
          }
          // objectives.singleWhere((o) => o.id == objective.alignedTo, orElse: )?.alignedWithChildren?.add(objective);
        }
      }
    }
    //print('DEBUG 1 ${(objectiveSelectRequest.treeAlignedWithChildren) ? objectivesTree ?? [] : objectives ?? []}');

   // ObjectivesResponse o = ObjectivesResponse()..objectives.addAll((objectiveSelectRequest.treeAlignedWithChildren) ? objectivesTree ?? [] : objectives ?? []);
    //print('DEBUG 2 ${o.objectives.length}');

    return (objectiveSelectRequest.treeAlignedWithChildren) ? objectivesTree ?? [] : objectives ?? [];
  }

  static Future<Objective> querySelectObjective(ObjectiveGetRequest request) async {

    List<Objective> objectives = await querySelectObjectives(request);

    if (objectives.isNotEmpty) {
      return objectives.first;
    } else {
      return null;
    }
  }

  /// Create (insert) a new objective
  static Future<IdResponse> queryInsertObjective(ObjectiveRequest request) async {
    if (!request.objective.hasId()) {
      request.objective.id = new Uuid().v4();
    }

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query("INSERT INTO objective.objectives(id, version, name, description, start_date, end_date, archived, aligned_to_objective_id, organization_id, leader_user_id, group_id) VALUES"
            "(@id,"
            "@version,"
            "@name,"
            "@description,"
            "@start_date,"
            "@end_date,"
            "@archived,"
            "@aligned_to_objective_id, "
            "@organization_id,"
            "@leader_user_id,"
            "@group_id)"
            , substitutionValues: {
              "id": request.objective.id,
              "version": 0,
              "name": request.objective.name,
              "description": request.objective.hasDescription() ?  request.objective.description : null,
              "start_date": request.objective.hasStartDate() ? request.objective.startDate : null,
              "end_date": request.objective.hasEndDate() ? request.objective.endDate : null,
              "archived": request.objective.hasArchived() ? request.objective.archived : false,
              "aligned_to_objective_id": request.objective.hasAlignedTo() ? request.objective.alignedTo.id : null,
              "organization_id": request.objective.hasOrganization() ? request.objective.organization.id : null,
              "leader_user_id": request.objective.hasLeader() ? request.objective.leader.id : null,
              "group_id": request.objective.hasGroup() ? request.objective.group.id : null,

            });


        // HistoryItem
        HistoryItem historyItem;

        historyItem
          ..id = new Uuid().v4()
          ..objectId = request.objective.id
          ..objectVersion = request.objective.version
          ..objectClassName = 'Objective' // objectiveRequest.runtimeType.toString(),
          ..systemFunctionIndex = SystemFunction.create.index
        // ..dateTime
          ..description = ''
        //  ..changedValuesPrevious.addAll(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
          ..changedValuesJson = HistoryItemUtils.changedValuesJson({}, ObjectiveUtils.fromProtoBufToModelMap(request.objective));

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(historyItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return (IdResponse()..id = request.objective.id);
  }

  /// Update an initiative passing an instance of [Objective]
  static Future<Empty> queryUpdateObjective(ObjectiveRequest request) async {

    // Recovery to log to history
    Objective previousObjective = await querySelectObjective(ObjectiveGetRequest()..id = request.objective.id);

    try {

      List<List<dynamic>> result;
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        result = await ctx.query(
            "UPDATE objective.objectives "
                " SET version = @version + 1, "
                " name = @name,"
                " description = @description,"
                " start_date = @start_date,"
                " end_date = @end_date,"
                " archived = @archived,"
                " aligned_to_objective_id = @aligned_to_objective_id,"
                " organization_id = @organization_id,"
                " leader_user_id = @leader_user_id,"
                " group_id = @group_id,"
                " WHERE id = @id and version = @version"
                " RETURNING true"
            , substitutionValues: {
          "id": request.objective.id,
          "version": request.objective.version,
          "name": request.objective.name,
          "description": request.objective.hasDescription() ? request.objective.description : null,
          "start_date": request.objective.hasStartDate() ? request.objective.startDate : null,
          "end_date": request.objective.hasEndDate() ? request.objective.endDate : null,
          "archived": request.objective.hasArchived() ? request.objective.archived : null,
          "aligned_to_objective_id": request.objective.hasAlignedTo() ? request.objective.alignedTo.id : null,
          "organization_id": request.objective.hasOrganization() ? request.objective.organization.id : null,
          "leader_user_id": request.objective.hasLeader() ? request.objective.leader.id : null,
          "group_id": request.objective.hasGroup() ? request.objective.group.id : null,

        });


        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.objectivePreconditionFailed );
        }
        else {
          // HistoryItem
          HistoryItem historyItem;

          historyItem
            ..id = new Uuid().v4()
            ..objectId = request.objective.id
            ..objectVersion = request.objective.version
            ..objectClassName = 'Objective' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.update.index
          // ..dateTime
            ..description = ''
            ..changedValuesJson = HistoryItemUtils.changedValuesJson(ObjectiveUtils.fromProtoBufToModelMap(previousObjective), ObjectiveUtils.fromProtoBufToModelMap(request.objective));

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(historyItem));
        }

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return Empty()..webWorkAround = true;
  }

  /// Delete an objective by [id]
  static Future<Empty> queryDeleteObjective(ObjectiveRequest objectiveRequest) async {

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM objective.objectives objective"
                " WHERE objective.id = @id"
            , substitutionValues: {
          "id": objectiveRequest.objective.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }
}