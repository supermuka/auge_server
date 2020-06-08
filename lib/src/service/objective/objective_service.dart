// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:auge_shared/src/util/common_utils.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:auge_server/src/util/mail.dart';
import 'package:auge_shared/message/messages.dart';
import 'package:auge_shared/message/domain_messages.dart';
import 'package:auge_shared/route/app_routes_definition.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/organization.pb.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pb.dart';
import 'package:auge_shared/protos/generated/general/group.pb.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/objective/objective.dart' as objective_m;

import 'package:auge_shared/message/rpc_error_message.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/objective/measure_service.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

class ObjectiveService extends ObjectiveServiceBase {

  // API
  @override
  Future<ObjectivesResponse> getObjectives(ServiceCall call,
      ObjectiveGetRequest request) async {
     ObjectivesResponse or = ObjectivesResponse()..objectives.addAll(await querySelectObjectives(request));
     return or;
  }

  @override
  Future<Objective> getObjective(ServiceCall call,
      ObjectiveGetRequest request) async {

    Objective objective = await querySelectObjective(request);
    if (objective == null) throw new GrpcError.notFound("Objective not found.");
    return objective;
  }

  @override
  Future<StringValue> createObjective(ServiceCall call,
      ObjectiveRequest request) async {
    return queryInsertObjective(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateObjective(ServiceCall call,
      ObjectiveRequest request) async {
    return queryUpdateObjective(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteObjective(ServiceCall call,
      ObjectiveDeleteRequest request) async {
    return queryDeleteObjective(request, call.clientMetadata['origin']);
  }

  // QUERY
  // *** OBJECTIVES ***
  // alignedToRecursiveDeep: 0 not call; 1 call once; 2 call two, etc...
  static Future<List<Objective>> querySelectObjectives(ObjectiveGetRequest objectiveGetRequest) async {

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
    if (objectiveGetRequest.hasId() && objectiveGetRequest.id.isNotEmpty) {
      queryStatementWhere = " objective.id = @id";
      substitutionValues = {"id": objectiveGetRequest.id};
    } else if (objectiveGetRequest.hasOrganizationId() && objectiveGetRequest.organizationId.isNotEmpty) {
      queryStatementWhere = " objective.organization_id = @organization_id";
      substitutionValues = {"organization_id": objectiveGetRequest.organizationId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.objectiveInvalidArgument );
    }

    if (!objectiveGetRequest.hasWithArchived() || !objectiveGetRequest.withArchived) {
      queryStatementWhere = queryStatementWhere + " AND objective.archived <> true";
    }

    //String ids;
    if (objectiveGetRequest.groupIds != null && objectiveGetRequest.groupIds.isNotEmpty) {
      queryStatementWhere = queryStatementWhere + " AND objective.group_id in ${objectiveGetRequest.groupIds.map((f) => "'${f}'")}";
      //ids = objectiveGetRequest.groupIds.toString();
      // queryStatementWhere = queryStatementWhere + " AND objective.group_id in (${ids.toString().substring(1, ids.length-1)})";
    }
    if (objectiveGetRequest.leaderUserIds != null && objectiveGetRequest.leaderUserIds.isNotEmpty) {
      queryStatementWhere = queryStatementWhere + " AND objective.leader_user_id in ${objectiveGetRequest.leaderUserIds.map((f) => "'${f}'")}";
      //ids = objectiveGetRequest.leaderUserIds.toString();
      // queryStatementWhere = queryStatementWhere + " AND objective.leader_user_id in (${ids.toString().substring(1, ids.length-1)})";
    }
    String queryStatement;
    if (objectiveGetRequest.hasTreeAlignedWithChildren() && objectiveGetRequest.treeAlignedWithChildren) {
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

    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      List<Objective> objectives = List();
      List<Objective> objectivesTree = List();
      Map<String, Objective> objectivesTreeMapAux = {};

      if (results != null && results.isNotEmpty) {

        Objective objective;

        if (!objectiveGetRequest.hasAlignedToRecursive()) {
          objectiveGetRequest.alignedToRecursive = 1;
        }

        Map<String, User> usersCache = {};
       // Map<String, Objective> objectivesCache = {};
        Map<String, Organization> organizationsCache = {};
        Map<String, Group> groupsCache = {};
        for (var row in results) {

          objective = Objective()
            ..id = row[0]
            ..version = row[1]
            ..name = row[2];

          if (row[3] != null) objective.description = row[3];

          if (row[4] != null)
            objective.startDate = CommonUtils.timestampFromDateTime(row[4].toUtc());

          if (row[5] != null)
            objective.endDate = CommonUtils.timestampFromDateTime(row[5].toUtc());

          if (row[6] != null) objective.archived = row[6];

          objective.measures.addAll(
          (objectiveGetRequest.withMeasures) ? await MeasureService
              .querySelectMeasures(MeasureGetRequest()
            ..objectiveId = row[0]) : []);

          if (row[7] != null) objective.leader = await UserService.querySelectUser(UserGetRequest()
              ..id = row[7]
              ..withUserProfile = objectiveGetRequest.withUserProfile, cache: usersCache);

          if (row[8] != null && objectiveGetRequest.alignedToRecursive > 0)
            //--objectiveSelectRequest.alignedToRecursive;
            objective.alignedTo =
            await ObjectiveService.querySelectObjective(ObjectiveGetRequest()
              ..id = row[8]
              /*..alignedToRecursive = (objectiveGetRequest.alignedToRecursive-1)
              ..withArchived = objectiveGetRequest.withArchived
              ..withMeasures = objectiveGetRequest.withMeasures
              ..withUserProfile = objectiveGetRequest.withUserProfile
              ..groupIds.addAll(objectiveGetRequest.groupIds), cache: objectivesCache */);

          // Organization
            if (row[9] != null)
              objective.organization = await OrganizationService.querySelectOrganization(
                  OrganizationGetRequest()
                    ..id = row[9], cache: organizationsCache);

            if (row[10] != null)
              objective.group = await GroupService.querySelectGroup(GroupGetRequest()
                ..id = row[10], cache: groupsCache);

            if (objectiveGetRequest.treeAlignedWithChildren) {
            objectivesTreeMapAux[objective.id] = objective;
            if (row[8] == null)
              // Parent must be present in the list (objectives);
              objectivesTree.add(objective);
            else {
              objectivesTreeMapAux[row[8]].alignedWithChildren
                  .add(objective);
            }
          } else {
            objectives.add(objective);
          }
        }
      }

      return (objectiveGetRequest.treeAlignedWithChildren)
          ? objectivesTree ?? []
          : objectives ?? [];

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  static Future<Objective> querySelectObjective(ObjectiveGetRequest request, {Map<String, Objective> cache}) async {
    if (cache != null && cache.containsKey(request.id)) {
      return cache[request.id];
    } else {
      List<Objective> objectives = await querySelectObjectives(request);

      if (objectives.isNotEmpty) {
        if (cache != null) cache[request.id] = objectives.first;
        return objectives.first;
      } else {
        return null;
      }
    }
  }

  /// Objective Notification User
  static void objectiveNotification(Objective objective, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    // Not send to your-self
    if (objective.leader.id == authUserId) return;

    // Leader  - Verify if send e-mail
    if (!objective.leader.userProfile.eMailNotification) return;

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];




    // Leader - eMail
    if (objective.leader.userProfile.eMail == null) throw Exception('e-mail of the Objective Leader is null.');

    await CommonUtils.setDefaultLocale(objective.leader.userProfile.idiomLocale);

    mailMessages.add(
        AugeMailMessageTo(
            [objective.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${ObjectiveDomainMsg.fieldLabel(objective_m.Objective.leaderField)}',
            '${ClassNameMsg.label(objective_m.Objective.className)} ${objective.name}',
            '${urlOrigin}/#/${AppRoutesPath.appLayoutRoutePath}/${AppRoutesPath.objectivesRoutePath}?${AppRoutesQueryParam.objectiveIdQueryParameter}=${objective.id}',
            ));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);
  }

  /// Create (insert) a new objective
  static Future<StringValue> queryInsertObjective(ObjectiveRequest request, String urlOrigin) async {
    if (!request.objective.hasId()) {
      request.objective.id = new Uuid().v4();
    }

    request.objective.version = 0;

    try {

      Map<String, dynamic> historyItemNotificationValues;

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
              "version": request.objective.version,
              "name": request.objective.name,
              "description": request.objective.hasDescription() ?  request.objective.description : null,
              "start_date": request.objective.hasStartDate() ? request.objective.startDate.toDateTime() /* CommonUtils.dateTimeFromTimestamp(request.objective.startDate) */ : null,
              "end_date": request.objective.hasEndDate() ? request.objective.endDate.toDateTime() /* CommonUtils.dateTimeFromTimestamp(request.objective.endDate) */ : null,
              "archived": request.objective.hasArchived() ? request.objective.archived : false,
              "aligned_to_objective_id": request.objective.hasAlignedTo() ? request.objective.alignedTo.id : null,
              "organization_id": request.objective.hasOrganization() ? request.objective.organization.id : null,
              "leader_user_id": request.objective.hasLeader() ? request.objective.leader.id : null,
              "group_id": request.objective.hasGroup() ? request.objective.group.id : null,

            });

        // Create a history item
        historyItemNotificationValues = {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.objective.id,
          "object_version": request.objective.version,
          "object_class_name": objective_m
              .Objective.className,
          "system_module_index": SystemModule.objectives.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.objective.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, objective_m.Objective.fromProtoBufToModelMap(request.objective, true))};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: historyItemNotificationValues);

      });

      objectiveNotification(request.objective, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return (StringValue()..value = request.objective.id);
  }


  /// Update an initiative passing an instance of [Objective]
  static Future<Empty> queryUpdateObjective(ObjectiveRequest request, String urlOrigin) async {

    // Recovery to log to history
    Objective previousObjective = await querySelectObjective(ObjectiveGetRequest()..id = request.objective.id..withUserProfile = true);
    Map<String, dynamic> historyItemNotificationValues;
    try {

      List<List<dynamic>> result;
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        result = await ctx.query(
            "UPDATE objective.objectives "
                " SET version = @version, "
                " name = @name,"
                " description = @description,"
                " start_date = @start_date,"
                " end_date = @end_date,"
                " archived = @archived,"
                " aligned_to_objective_id = @aligned_to_objective_id,"
                " organization_id = @organization_id,"
                " leader_user_id = @leader_user_id,"
                " group_id = @group_id"
                " WHERE id = @id AND version = @version - 1"
                " RETURNING true"
            , substitutionValues: {
          "id": request.objective.id,
          "version": ++request.objective.version,
          "name": request.objective.name,
          "description": request.objective.hasDescription() ? request.objective.description : null,
          "start_date": request.objective.hasStartDate() ? request.objective.startDate.toDateTime() /* CommonUtils.dateTimeFromTimestamp(request.objective.startDate) */ : null,
          "end_date": request.objective.hasEndDate() ? request.objective.endDate.toDateTime() /* CommonUtils.dateTimeFromTimestamp(request.objective.endDate) */ : null,
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

          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.objective.id,
            "object_version": request.objective.version,
            "object_class_name": objective_m
                .Objective.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.update.index,
            "date_time": DateTime.now().toUtc(),
            "description": request.objective.name,
            "changed_values": history_item_m.HistoryItem.changedValuesJson(objective_m.Objective.fromProtoBufToModelMap(previousObjective, true), objective_m.Objective.fromProtoBufToModelMap(request.objective, true))};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);

        }

      });

      objectiveNotification(request.objective, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete an objective by [id]
  static Future<Empty> queryDeleteObjective(ObjectiveDeleteRequest request, String urlOrigin) async {

    // Recovery to log to history
    Objective previousObjective = await querySelectObjective(ObjectiveGetRequest()..id = request.objectiveId..withUserProfile = true);

    try {
      Map<String, dynamic> historyItemNotificationValues;

      await (await AugeConnection.getConnection()).transaction((ctx) async {


        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM objective.objectives objective"
                " WHERE objective.id = @id"
                " AND objective.version = @version"
                " RETURNING true"
            , substitutionValues: {
          "id": request.objectiveId,
          "version": request.objectiveVersion});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.objectivePreconditionFailed );
        }
        else {

          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.objectiveId,
            "object_version": request.objectiveVersion,
            "object_class_name": objective_m.Objective.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.delete.index,
            "date_time": DateTime.now().toUtc(),
            "description": previousObjective.name,
            "changed_values":  history_item_m.HistoryItem.changedValuesJson(objective_m.Objective.fromProtoBufToModelMap(previousObjective, true), {})};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);

        }
      });

      objectiveNotification(previousObjective, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}