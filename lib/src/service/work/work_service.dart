// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/util/mail.dart';

import 'package:auge_shared/message/messages.dart';
import 'package:auge_shared/message/domain_messages.dart';
import 'package:auge_shared/route/app_routes_definition.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/general/organization.pb.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/group.pb.dart';
import 'package:auge_shared/protos/generated/work/work_work_item.pbgrpc.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pb.dart';

import 'package:auge_shared/src/util/common_utils.dart';
import 'package:auge_shared/message/rpc_error_message.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/work/work_stage_service.dart';
import 'package:auge_server/src/service/work/work_item_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/work/work.dart' as work_m;

import 'package:auge_server/src/util/db_connection.dart';

import 'package:uuid/uuid.dart';

class WorkService extends WorkServiceBase {

  // API
  @override
  Future<WorksResponse> getWorks(ServiceCall call,
      WorkGetRequest workGetRequest) async {
    WorksResponse worksResponse;
    worksResponse = WorksResponse()/*..webWorkAround = true*/
      ..works.addAll(
          await querySelectWorks(workGetRequest));
    return worksResponse;
  }
/*
  @override
  Future<Work> getWork(ServiceCall call,
      WorkGetRequest workGetRequest) async {
    Work work = await querySelectWork(workGetRequest);
    if (work == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workDataNotFoundReason);
    return work;
  }
*/
  @override
  Future<StringValue> createWork(ServiceCall call,
      WorkRequest request) async {
    return queryInsertWork(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateWork(ServiceCall call,
      WorkRequest request) async {
    return queryUpdateWork(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteWork(ServiceCall call,
      WorkDeleteRequest request) async {
    return queryDeleteWork(request, call.clientMetadata['origin']);
  }

  // QUERY
  // *** WORKS ***
  static Future<List<Work>> querySelectWorks(WorkGetRequest workGetRequest) async {

    List<List<dynamic>> results;
    List<Work> works = List<Work>();

    String queryStatement;

    queryStatement = "SELECT ";

    if (workGetRequest.hasRestrictWork()) {
      if (workGetRequest.restrictWork == RestrictWork.workSpecification) {
        queryStatement = queryStatement + "work.id, " //0
            "work.name, " //1
            "null," //2
            "null, " //3
            "null, " //4 +
            "null, " //5
            "null, " //6
            "null, " //7
            "null " //8
            "FROM work.works work";

      } else { // none
         return null;
      }

    } else {
      queryStatement = queryStatement + "work.id, " //0
          "work.name, " //1
          "work.version," //2
          "work.description, " //3
          "work.archived, " //4 +
          "work.organization_id, " //5
          "work.leader_user_id, " //6
          "work.objective_id, " //7
          "work.group_id " //8
          "FROM work.works work";
    }

    Map<String, dynamic> substitutionValues;

    if (workGetRequest.hasId()) {
      queryStatement += " WHERE work.id = @id";
      substitutionValues = {"id": workGetRequest.id};
    } else if (workGetRequest.hasOrganizationId()){
      queryStatement += " WHERE work.organization_id = @organization_id";
      substitutionValues = {"organization_id": workGetRequest.organizationId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.workInvalidArgument );
    }

    if (workGetRequest.hasObjectiveId()) {
      queryStatement += " AND work.objective_id = @objective_id";
      substitutionValues.putIfAbsent("objective_id", () => workGetRequest.objectiveId);
    }

    if (!workGetRequest.hasWithArchived() || !workGetRequest.withArchived) {
      queryStatement = queryStatement + " AND work.archived <> true";
    }

    //String ids;
    if (workGetRequest.groupIds != null && workGetRequest.groupIds.isNotEmpty) {
      queryStatement = queryStatement + " AND work.group_id in ${workGetRequest.groupIds.map((f) => "'${f}'")}";
      //ids = objectiveGetRequest.groupIds.toString();
      // queryStatementWhere = queryStatementWhere + " AND objective.group_id in (${ids.toString().substring(1, ids.length-1)})";
    }
    if (workGetRequest.leaderUserIds != null && workGetRequest.leaderUserIds.isNotEmpty) {
      queryStatement = queryStatement + " AND work.leader_user_id in ${workGetRequest.leaderUserIds.map((f) => "'${f}'")}";
      //ids = objectiveGetRequest.leaderUserIds.toString();
      // queryStatementWhere = queryStatementWhere + " AND objective.leader_user_id in (${ids.toString().substring(1, ids.length-1)})";
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItem> workItems;

    Objective objective;
    Organization organization;
    User user;
    Group group;
    List<WorkStage> workStages;


    for (var row in results) {
      // Work Items

      if (!workGetRequest.hasRestrictWorkItem() || workGetRequest.restrictWorkItem != RestrictWorkItem.workItemNone) {
        WorkItemGetRequest workItemGetRequest = WorkItemGetRequest();
        workItemGetRequest.workId = row[0];
        workItemGetRequest.restrictWork = (workGetRequest.hasRestrictWork()) ? workGetRequest.restrictWork : workItemGetRequest.restrictWork = RestrictWork.workSpecification;
        if (workGetRequest.hasWorkItemWithArchived()) workItemGetRequest.withArchived = workGetRequest.workItemWithArchived;
        if (workGetRequest.workItemAssignedToIds != null && workGetRequest.workItemAssignedToIds.isNotEmpty) {
          workItemGetRequest.assignedToIds.addAll(workGetRequest.workItemAssignedToIds);
        }
        workItems = await WorkItemService.querySelectWorkItems(workItemGetRequest);
      } else {
        workItems = [];
      }

      if (row[5] != null &&
          (organization == null || organization.id != row[5])) {
      if (!workGetRequest.hasRestrictOrganization() || workGetRequest.restrictOrganization != RestrictOrganization.organizationNone) {
          // organization = await _augeApi.getOrganizationById(row[3]);
          organization = await OrganizationService.querySelectOrganization(
              OrganizationGetRequest()
                ..id = row[5]
                ..restrictOrganization = workGetRequest.hasRestrictOrganization() ? workGetRequest.restrictOrganization : RestrictOrganization.organizationSpecification);
        } else {
          organization = null;
        }
      }

      // user = (await _augeApi.getUsers(id: row[4])).first;
      if (row[6] != null) {
        UserGetRequest userGetRequest = UserGetRequest();
        userGetRequest.id = row[6];
        userGetRequest.restrictUser = RestrictUser.userSpecification;
        userGetRequest.restrictUserProfile = workGetRequest.hasRestrictUserProfile() ? workGetRequest.restrictUserProfile : RestrictUserProfile.userProfileImage;

        user = await UserService.querySelectUser(userGetRequest);
      } else {
        user = null;
      }

      //stages = await getStages(row[0]);
      workStages = await WorkStageService.querySelectWorkStages(WorkStageGetRequest()
        ..workId = row[0]
        ..restrictWork = RestrictWork.workNone);

      // objective = row[5] == null ? null : await _objectiveAugeApi.getObjectiveById(row[5]);
      if (row[7] != null) {
        objective =
        row[7] == null ? null : await ObjectiveService.querySelectObjective(
            ObjectiveGetRequest()
              ..id = row[7]
              ..restrictObjective = RestrictObjective.objectiveIdName);
      } else {
        objective = null;
      }

      // group =  row[6] == null ? null : await _augeApi.getGroupById(row[6]);
      if (row[8] != null) {
        group = row[8] == null ? null : await GroupService.querySelectGroup(
            GroupGetRequest()
              ..id = row[8]..restrictGroup = RestrictGroup.groupSpecification);
      } else {
        group = null;
      }

      Work work =
      Work()..id = row[0]..name = row[1];

      if (row[2] != null) work.version = row[2];
      if (row[3] != null) work.description = row[3];

      if (row[4] != null) work.archived = row[4];
      if (workItems.isNotEmpty) {
        work.workItems.addAll(workItems);
      }
      if (organization != null) {
        work.organization = organization;
      }
      if (user != null) {
        work.leader = user;
      }
      if (workStages.isNotEmpty) {
        work.workStages.addAll(workStages);
      }
      if (objective != null) {
        work.objective = objective;
      }
      if (group != null) {
        work.group = group;
      }

      works.add(work);
    }

    return works;
  }

  static Future<Work> querySelectWork(WorkGetRequest workGetRequest) async {

    List<Work> works = await querySelectWorks(workGetRequest);

    if (works.isNotEmpty) {
      return works.first;
    } else {
      return null;
    }
  }


  static Future<User> querySelectWorkUserLeader(WorkGetRequest workGetRequest) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work.leader_user_id " //0
        "FROM work.works work";

    Map<String, dynamic> substitutionValues;

    if (workGetRequest.hasId()) {
      queryStatement += " WHERE work.id = @id";
      substitutionValues = {"id": workGetRequest.id};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.workInvalidArgument );
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    User user;

    if (results.length != 0) {
      // Work Items

      var row = results.first;

      // user = (await _augeApi.getUsers(id: row[4])).first;
      if (row[0] != null) {
        UserGetRequest userGetRequest = UserGetRequest();
        userGetRequest.id = row[6];
        userGetRequest.restrictUser = RestrictUser.userSpecification;
        if (workGetRequest.hasRestrictUserProfile()) {
          userGetRequest.restrictUserProfile = workGetRequest.restrictUserProfile;
        } else {
          userGetRequest.restrictUserProfile = RestrictUserProfile.userProfileImage;
        }
        user = await UserService.querySelectUser(userGetRequest);
      } else {
        user = null;
      }
    }

    return user;
  }


  /// Work Notification User
  static void workNotification(Work work, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    // Not send to your-self
    if (work.leader.id == authUserId) return;

    // Leader - Verify if send e-mail
    if (!work.leader.userProfile.eMailNotification) return;

    // Leader - eMail
    if (work.leader.userProfile.eMail == null) throw Exception('e-mail of the Work Leader is null.');

    await CommonUtils.setDefaultLocale(work.leader.userProfile.idiomLocale);

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    mailMessages.add(
        AugeMailMessageTo(
            [work.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${WorkDomainMsg.fieldLabel(work_m.Work.leaderField)}',
            '${ClassNameMsg.label(work_m.Work.className)} ${work.name}',
            '${urlOrigin}/#/${AppRoutesPath.appLayoutRoutePath}/${AppRoutesPath.worksRoutePath}?${AppRoutesQueryParam.workIdQueryParameter}=${work.id}'));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);

  }

  /// Create (insert) a new work
  static Future<StringValue> queryInsertWork(WorkRequest request, String urlOrigin) async {

    if (!request.work.hasId()) {
      request.work.id = new Uuid().v4();
    }

    request.work.version = 0;

    Map<String, dynamic> historyItemNotificationValues;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query(
            "INSERT INTO work.works(id, version, name, description, archived, organization_id, leader_user_id, objective_id, group_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@description,"
                "@archived,"
                "@organization_id,"
                "@leader_user_id,"
                "@objective_id,"
                "@group_id)"
            , substitutionValues: {
          "id": request.work.id,
          "version": request.work.version,
          "name": request.work.name,
          "description": request.work.description,
          "archived": request.work.hasArchived() ? request.work.archived : false,
          "organization_id": request.authOrganizationId,
          "leader_user_id": request.work.hasLeader() ? request.work.leader.id : null,
          "objective_id": request.work.hasObjective() ? request.work.objective.id : null,
          "group_id": request.work.hasGroup() ? request.work.group.id : null });


        // Create a history item
        historyItemNotificationValues = {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.work.id,
          "object_version": request.work.version,
          "object_class_name": work_m.Work.className,
          "system_module_index": SystemModule.works.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.work.name,
          "changed_values": history_item_m.HistoryItemHelper.changedValuesJson({}, request.work.toProto3Json() )};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: historyItemNotificationValues);
      });

      workNotification(request.work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.work.id;
  }

  /// Update an work passing an instance of [Work]
  Future<Empty> queryUpdateWork(WorkRequest request, String urlOrigin) async {

    // Recovery to log to history
    Work previousWork = await querySelectWork(WorkGetRequest()
      ..id = request.work.id
    );

    Map<String, dynamic> historyItemNotificationValues;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

          List<List<dynamic>> result;

          result = await ctx.query("UPDATE work.works "
            " SET version = @version,"
            " name = @name,"
            " description = @description,"
            " archived = @archived,"
            " organization_id = @organization_id,"
            " leader_user_id = @leader_user_id,"
            " objective_id = @objective_id,"
            " group_id = @group_id"
            " WHERE id = @id AND version = @version - 1"
            " RETURNING true "
            , substitutionValues: {
              "id": request.work.id,
              "version": ++request.work.version,
              "name": request.work.name,
              "description": request.work.description,
              "archived": request.work.hasArchived() ? request.work.archived : false,
              "organization_id": request.authOrganizationId,
              "leader_user_id": request.work.hasLeader() ? request.work.leader.id : null,
              "objective_id": request.work.hasObjective() ? request.work.objective.id : null,
              "group_id": request.work.hasGroup() ? request.work.group.id : null });

          // Optimistic concurrency control
          if (result.isEmpty) {
            throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
          }

          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.work.id,
            "object_version": request.work.version,
            "object_class_name": work_m
                .Work.className,
            "system_module_index": SystemModule.works.index,
            "system_function_index": SystemFunction.update.index,
            "date_time": DateTime.now().toUtc(),
            "description": request.work.name,
            "changed_values": history_item_m.HistoryItemHelper
                .changedValuesJson(
                    previousWork.toProto3Json(),
                    request.work.toProto3Json()
            )};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);

      });

      workNotification(request.work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete an work by [id]
  static Future<Empty> queryDeleteWork(WorkDeleteRequest request, String urlOrigin) async {

    Work previousWork = await querySelectWork(WorkGetRequest()..id = request.workId);

    try {

      Map<String, dynamic> historyItemNotificationValues;

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM work.works work"
                " WHERE work.id = @id AND work.version = @version"
                " RETURNING true "
            , substitutionValues: {
          "id": request.workId,
          "version": request.workVersion});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
        } else {
          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.workId,
            "object_version": request.workVersion,
            "object_class_name": work_m.Work.className,
            "system_module_index": SystemModule.works.index,
            "system_function_index": SystemFunction.delete.index,
            "date_time": DateTime.now().toUtc(),
            "description": previousWork.name,
            "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                    previousWork.toProto3Json(), {})};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }
      });

      workNotification(previousWork, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}