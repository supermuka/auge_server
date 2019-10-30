// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/util/mail.dart';

import 'package:auge_server/shared/message/messages.dart';
import 'package:auge_server/shared/message/model_messages.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/group.pb.dart';
import 'package:auge_server/src/protos/generated/work/work_stage.pb.dart';
import 'package:auge_server/src/protos/generated/work/work_work_item.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/objective/objective_measure.pb.dart';

import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/work/work_stage_service.dart';
import 'package:auge_server/src/service/work/work_item_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/model/work/work.dart' as work_m;

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

  @override
  Future<Work> getWork(ServiceCall call,
      WorkGetRequest workGetRequest) async {
    Work work = await querySelectWork(workGetRequest);
    if (work == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workDataNotFoundReason);
    return work;
  }

  @override
  Future<StringValue> createWork(ServiceCall call,
      WorkRequest request) async {
    return queryInsertWork(request);
  }

  @override
  Future<Empty> updateWork(ServiceCall call,
      WorkRequest request) async {
    return queryUpdateWork(request);
  }

  @override
  Future<Empty> deleteWork(ServiceCall call,
      WorkDeleteRequest request) async {
    return queryDeleteWork(request);
  }

  // QUERY
  // *** WORKS ***
  static Future<List<Work>> querySelectWorks(WorkGetRequest workGetRequest/* {String organizationId, String id, String objectiveId, bool withWorkItems = false, bool withProfile = false} */ ) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work.id, " //0
        "work.version," //1
        "work.name, " //2
        "work.description, " //3
        "work.organization_id, " //4
        "work.leader_user_id, " //5
        "work.objective_id, " //6
        "work.group_id " //7
        "FROM work.works work";

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

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<Work> works = List<Work>();
    List<WorkItem> workItems;

    Objective objective;
    Organization organization;
    User user;
    Group group;
    List<WorkStage> workStages;

    for (var row in results) {
      // Work Items
      workItems = (workGetRequest.withWorkItems) ? await WorkItemService.querySelectWorkItems(WorkItemGetRequest()..workId = row[0]) : [];

      if (row[4] != null && (organization == null || organization.id != row[4])) {

        // organization = await _augeApi.getOrganizationById(row[3]);

        organization = await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = row[4]);

      } else {
        organization = null;
      }

      // user = (await _augeApi.getUsers(id: row[4])).first;
      if (row[5] != null) {
        user = await UserService.querySelectUser(UserGetRequest()..id = row[5]..withUserProfile = workGetRequest.withUserProfile);
      } else {
        user = null;
      }

      //stages = await getStages(row[0]);
      workStages = await WorkStageService.querySelectWorkStages(WorkStageGetRequest()..workId = row[0]);

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

      Work work =
      Work()..id = row[0]..version = row[1]..name = row[2]..description = row[3];
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

  /// Work Notification User
  static void workNotification(Work work, String className, int systemFunctionIndex, String description) {

    // Leader - Verify if send e-mail
    if (!work.leader.userProfile.eMailNotification) return;

    // Leader - eMail
    if (work.leader.userProfile.eMail == null) throw Exception('e-mail of the Work Leader is null.');

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    mailMessages.add(
        AugeMailMessageTo(
            [work.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString())}',
            '${ClassNameMsg.label(className)}',
            description,
            '${FieldMsg.label('${work_m.Work.className}.${work_m.Work.leaderField}')}'));

    // SEND E-MAIL
    AugeMail().send(mailMessages);

  }

  /// Create (insert) a new work
  static Future<StringValue> queryInsertWork(WorkRequest request) async {

    if (!request.work.hasId()) {
      request.work.id = new Uuid().v4();
    }

    request.work.version = 0;

    Map<String, dynamic> historyItemNotificationValues;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query(
            "INSERT INTO work.works(id, version, name, description, organization_id, leader_user_id, objective_id, group_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@description,"
                "@organization_id,"
                "@leader_user_id,"
                "@objective_id,"
                "@group_id)"
            , substitutionValues: {
          "id": request.work.id,
          "version": request.work.version,
          "name": request.work.name,
          "description": request.work.description,
          "organization_id": request.work.organization.id,
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
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, work_m.Work.fromProtoBufToModelMap(request.work))};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: historyItemNotificationValues);
      });

      workNotification(request.work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description']);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.work.id;
  }

  /// Update an work passing an instance of [Work]
  Future<Empty> queryUpdateWork(WorkRequest request) async {

    // Recovery to log to history
    Work previousWork = await querySelectWork(WorkGetRequest()
      ..id = request.work.id
      ..withUserProfile = true
    );

    Map<String, dynamic> historyItemNotificationValues;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

          List<List<dynamic>> result;

          result = await ctx.query("UPDATE work.works "
            " SET version = @version,"
            " name = @name,"
            " description = @description,"
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
              "organization_id": request.work.hasOrganization() ? request.work.organization.id : null,
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
            "changed_values": history_item_m.HistoryItem
                .changedValuesJson(
                work_m.Work
                    .fromProtoBufToModelMap(
                    previousWork),
                work_m.Work
                    .fromProtoBufToModelMap(
                    request.work)
            )};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);

      });

      workNotification(request.work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description']);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete an work by [id]
  static Future<Empty> queryDeleteWork(WorkDeleteRequest request) async {

    Work previousWork = await querySelectWork(WorkGetRequest()..id = request.workId..withUserProfile = true);

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
            "changed_values": history_item_m.HistoryItem.changedValuesJson(
                work_m.Work.fromProtoBufToModelMap(
                    previousWork, true), {})};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }
      });

      workNotification(previousWork, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description']);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}