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
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/group.pb.dart';
import 'package:auge_shared/protos/generated/work/work_work_item.pbgrpc.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pb.dart';

import 'package:auge_shared/src/util/common_utils.dart';
import 'package:auge_shared/message/rpc_error_message.dart';
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

    if (workGetRequest.hasCustomWork()) {
      if (workGetRequest.customWork == CustomWork.workOnlySpecification) {
        queryStatement = queryStatement + "work.id, " //0
            "null," //1
            "work.name, " //2
            "null, " //3
            "null, " //4 +
            //"null, " //5
            "null, " //5
            "null, " //6
            "null " //7
            "FROM work.works work";
      } else if (workGetRequest.customWork == CustomWork.workOnlyWithWorkItems) {
        queryStatement = queryStatement + "work.id, " //0
            "null, " //1
            "null," //2
            "null, " //3
            "null, " //4 +
           // "null, " //5
            "null, " //5
            "null, " //6
            "null " //7
            "FROM work.works work";
      } else if (workGetRequest.customWork == CustomWork.workWithWorkItemsAndStages) {
        queryStatement = queryStatement + "work.id, " //0
            "work.version," //1
            "work.name, " //2
            "work.description, " //3
            "work.archived, " //4 +
        //   "work.organization_id, " //5
            "work.leader_user_id, " //5
            "work.objective_id, " //6
            "work.group_id " //7
            "FROM work.works work";

      } else if (workGetRequest.customWork == CustomWork.workWithWorkItems) {
        queryStatement = queryStatement + "work.id, " //0
            "work.version," //1
            "work.name, " //2
            "work.description, " //3
            "work.archived, " //4 +
        //   "work.organization_id, " //5
            "work.leader_user_id, " //5
            "work.objective_id, " //6
            "work.group_id " //7
            "FROM work.works work";
      } else { // none
         return null;
      }
    } else {
      queryStatement = queryStatement + "work.id, " //0
          "work.version," //1
          "work.name, " //2
          "work.description, " //3
          "work.archived, " //4 +
       //   "work.organization_id, " //5
          "work.leader_user_id, " //5
          "work.objective_id, " //6
          "work.group_id " //7
          "FROM work.works work";
    }

    Map<String, dynamic> substitutionValues;

    if (workGetRequest.hasId()) {
      queryStatement += " WHERE work.id = @id";
      substitutionValues = {"id": workGetRequest.id};
    } else if (workGetRequest.hasOrganizationId()) {
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

    try {

      results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

      Objective objective;
      User user;
      Group group;
     // List<WorkStage> workStages;

      fillFields(Work work, var row) async {

        // user = (await _augeApi.getUsers(id: row[4])).first;
        if (row[5] != null) {
          UserGetRequest userGetRequest = UserGetRequest();
          userGetRequest.id = row[5];
          userGetRequest.customUser = CustomUser.userOnlySpecificationProfileImage;

          user = await UserService.querySelectUser(userGetRequest);
        } else {
          user = null;
        }

        // objective = row[5] == null ? null : await _objectiveAugeApi.getObjectiveById(row[5]);
        if (row[6] != null) {
          objective = await ObjectiveService.querySelectObjective(
              ObjectiveGetRequest()
                ..id = row[6]
                ..customObjective = CustomObjective.objectiveOnlySpecification);
        } else {
          objective = null;
        }

        // group =  row[6] == null ? null : await _augeApi.getGroupById(row[6]);
        if (row[7] != null) {
          group = row[7] == null ? null : await GroupService.querySelectGroup(
              GroupGetRequest()
                ..id = row[7]
                ..customGroup = CustomGroup.groupOnlySpecification);
        } else {
          group = null;
        }

        work.id = row[0];
        work.name = row[2];

        if (row[1] != null) work.version = row[1];
        if (row[3] != null) work.description = row[3];

        if (row[4] != null) work.archived = row[4];

        if (user != null) {
          work.leader = user;
        }
        if (objective != null) {
          work.objective = objective;
        }
        if (group != null) {
          work.group = group;
        }
      }

      WorkItemGetRequest workItemGetRequest;
      fillWorkItems(Work work, var row) async {
        workItemGetRequest.workId = row[0];
        //workItemGetRequest.customWorkItem = CustomWorkItem.workItemWithoutWork;
        if (workGetRequest.hasWorkItemWithArchived()) workItemGetRequest.withArchived = workGetRequest.workItemWithArchived;
        if (workGetRequest.workItemAssignedToIds != null && workGetRequest.workItemAssignedToIds.isNotEmpty) {
          workItemGetRequest.assignedToIds.addAll(workGetRequest.workItemAssignedToIds);
        }
        work.workItems.addAll(await WorkItemService.querySelectWorkItems(workItemGetRequest));
      }

      WorkStageGetRequest workStageGetRequest;
      fillStages(Work work, var row) async {

        workStageGetRequest..workId = row[0];
         // ..customWorkStage = CustomWorkStage.workStageOnlySpecification;

        work.workStages.addAll(await WorkStageService.querySelectWorkStages(workStageGetRequest));
      }

      if (workGetRequest.hasCustomWork()) {
        if (workGetRequest.customWork == CustomWork.workOnlySpecification) {
          for (var row in results) {
            Work work =
            Work()..id = row[0]..name = row[2];
            works.add(work);
          }
        } else if (workGetRequest.customWork == CustomWork.workOnlyWithWorkItems) {
          workItemGetRequest = WorkItemGetRequest();
          for (var row in results) {
            Work work = Work();
            await fillWorkItems(work, row);
            works.add(work);
          }
        } else if (workGetRequest.customWork == CustomWork.workWithWorkItemsAndStages) {
          workItemGetRequest = WorkItemGetRequest();
          workStageGetRequest = WorkStageGetRequest();
          for (var row in results) {
            Work work = Work();
            await fillFields(work, row);
            await fillWorkItems(work, row);
            await fillStages(work, row);
            works.add(work);
          }
        } else if (workGetRequest.customWork == CustomWork.workWithWorkItems) {
          workItemGetRequest = WorkItemGetRequest();
          for (var row in results) {
            Work work = Work();
            await fillFields(work, row);
            await fillWorkItems(work, row);
            works.add(work);
          }
        }
      } else {

        for (var row in results) {
          Work work = Work();
          await fillFields(work, row);
          works.add(work);
        }
      }
      return works;
    } catch (e) {
      print('querySelectWorks - ${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  static Future<Work> querySelectWork(WorkGetRequest workGetRequest) async {

    List<Work> works = await querySelectWorks(workGetRequest);

    if (works.isNotEmpty) {
      return works.first;
    } else {
      return null;
    }
  }

  // Inner query, not expost to grpc. Because this, the param is nativa dart type, not protobuf.
  static Future<User> querySelectWorkLeaderUser({String workId, String workItemId, CustomUser customUser}) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work.leader_user_id " //0
        "FROM work.works work ";

    if (workItemId != null) {
      queryStatement = queryStatement + "JOIN work.work_items work_item ON work_item.work_id = work.id ";
    }


    Map<String, dynamic> substitutionValues;

    if (workItemId != null) {
      queryStatement += " WHERE work_item.id = @work_item_id";
      substitutionValues = {"work_item_id": workItemId};
    } else if (workId != null) {
      queryStatement += " WHERE work.id = @id";
      substitutionValues = {"id": workId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.workInvalidArgument );
    }

    try {
      results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

      User user;

      if (results.length != 0) {
        // Work Items

        var row = results.first;

        // user = (await _augeApi.getUsers(id: row[4])).first;
        if (row[0] != null) {
          UserGetRequest userGetRequest = UserGetRequest();
          userGetRequest.id = row[0];
          userGetRequest.customUser = customUser;
          user = await UserService.querySelectUser(userGetRequest);
        } else {
          user = null;
        }
      }

      return user;
    } catch (e) {
      print('querySelectWorkLeaderUser - ${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Work Notification User
  static void workNotification(Work work, User leaderNotification, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    if (leaderNotification == null) return;

    // Not send to your-self
    if (leaderNotification.id == authUserId) return;

    // Leader - Verify if send e-mail
    if (leaderNotification.userProfile.eMailNotification == false) return;

    // Leader - eMail
    if (leaderNotification.userProfile.eMail == null) throw Exception('e-mail of the Work Leader is null.');

    await CommonUtils.setDefaultLocale(leaderNotification.userProfile.idiomLocale);

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    mailMessages.add(
        AugeMailMessageTo(
            [leaderNotification.userProfile.eMail],
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
          "changed_values": history_item_m.HistoryItemHelper.changedValuesJson({}, request.work.toProto3Json(), removeUserProfileImageField: true )};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: historyItemNotificationValues);
      });

      // Recovery eMail and notification from User Id.
      User leaderNotification = await WorkService.querySelectWorkLeaderUser(workId: request.work.id, customUser: CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

      workNotification(request.work, leaderNotification, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

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
                    request.work.toProto3Json(), removeUserProfileImageField: true
            )};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);

      });

      // Recovery eMail and notification from User Id.
      User leaderNotification = await WorkService.querySelectWorkLeaderUser(workId: request.work.id, customUser: CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

      workNotification(request.work, leaderNotification, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete an work by [id]
  static Future<Empty> queryDeleteWork(WorkDeleteRequest request, String urlOrigin) async {

    Work previousWork = await querySelectWork(WorkGetRequest()..id = request.workId);

    // Recovery eMail and notification from User Id.
    User leaderNotification = await WorkService.querySelectWorkLeaderUser(workId: request.workId, customUser: CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

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
                    previousWork.toProto3Json(), {}, removeUserProfileImageField: true)};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }
      });

      workNotification(previousWork, leaderNotification, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}