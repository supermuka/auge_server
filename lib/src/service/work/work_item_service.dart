// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/util/mail.dart';
import 'package:auge_shared/route/app_routes_definition.dart';

import 'package:auge_shared/message/messages.dart';
import 'package:auge_shared/message/domain_messages.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/unit_of_measurement.pb.dart';
import 'package:auge_shared/protos/generated/work/work_work_item.pbgrpc.dart';

import 'package:auge_shared/message/rpc_error_message.dart';
import 'package:auge_shared/src/util/common_utils.dart';

import 'package:auge_server/src/service/general/unit_of_measurement_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/work/work_stage_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/work/work_service.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/work/work.dart' as work_m;
import 'package:auge_shared/domain/work/work_item.dart' as work_item_m;

import 'package:auge_server/src/util/db_connection.dart';

import 'package:uuid/uuid.dart';

class WorkItemService extends WorkItemServiceBase {

  // API
  @override
  Future<WorkItemsResponse> getWorkItems(ServiceCall call,
      WorkItemGetRequest workItemGetRequest) async {
    WorkItemsResponse workItemsResponse;
    workItemsResponse = WorkItemsResponse()/*..webWorkAround = true*/
      ..workItems.addAll(
          await querySelectWorkItems(workItemGetRequest));
    return workItemsResponse;
  }

  @override
  Future<WorkItem> getWorkItem(ServiceCall call,
      WorkItemGetRequest workItemGetRequest) async {
    WorkItem workItem = await querySelectWorkItem(workItemGetRequest);
    if (workItem == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workItemDataNotFoundReason);
    return workItem;
  }

  @override
  Future<StringValue> createWorkItem(ServiceCall call,
      WorkItemRequest request) async {
    return queryInsertWorkItem(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateWorkItem(ServiceCall call,
      WorkItemRequest request) async {
    return queryUpdateWorkItem(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteWorkItem(ServiceCall call,
      WorkItemDeleteRequest request) async {
    return queryDeleteWorkItem(request, call.clientMetadata['origin']);
  }

  @override
  Future<WorkItemCheckItemsResponse> getWorkItemCheckItems(ServiceCall call,
      WorkItemCheckItemGetRequest workItemCheckItemGetRequest) async {
    WorkItemCheckItemsResponse workItemCheckItemsResponse;
    workItemCheckItemsResponse = WorkItemCheckItemsResponse()
      ..workItemCheckItems.addAll(
          await querySelectWorkItemCheckItems(workItemCheckItemGetRequest));
    return workItemCheckItemsResponse;
  }

  @override
  Future<WorkItemAttachment> getWorkItemAttachment(ServiceCall call,
      WorkItemAttachmentGetRequest workItemAttachmentGetRequest) async {
    WorkItemAttachment workItemAttachment = await querySelectWorkItemAttachment(workItemAttachmentGetRequest);
    if (workItemAttachment == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workItemAttachmentDataNotFoundReason);
    return workItemAttachment;
  }

  @override
  Future<WorkItemValuesResponse> getWorkItemValues(ServiceCall call,
      WorkItemValueGetRequest request) async {
    return
      WorkItemValuesResponse()/*..webWorkAround = true*/..workItemValues.addAll(await querySelectWorkItemValues(request));
  }

  @override
  Future<WorkItemValue> getWorkItemValue(ServiceCall call,
      WorkItemValueGetRequest request) async {
    WorkItemValue workItemValue = await querySelectWorkItemValue(
        request);
    if (workItemValue == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workItemValueDataNotFoundReason);
    return workItemValue;
  }

  @override
  Future<StringValue> createWorkItemValue(ServiceCall call,
      WorkItemValueRequest request) async {
    return queryInsertWorkItemValue(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateWorkItemValue(ServiceCall call,
      WorkItemValueRequest request) async {
    return queryUpdateWorkItemValue(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteWorkItemValue(ServiceCall call,
      WorkItemValueDeleteRequest request) async {
    return queryDeleteWorkItemValue(request, call.clientMetadata['origin']);
  }


  // QUERY
  // *** INITIATIVE WORK ITEMS ***
  static Future<List<WorkItem>> querySelectWorkItems(WorkItemGetRequest workItemGetRequest) async {

    List<List<dynamic>> results;

    String queryStatement;
    queryStatement = "SELECT work_item.id," //0
        " work_item.version," //1
        " work_item.name," //2
        " work_item.description," //3
        " work_item.due_date," //4
        " work_item.planned_value," //5
        " (SELECT sum(actual_value) FROM work.work_item_values work_item_value WHERE work_item_value.work_item_id = work_item.id)::REAL AS actual_value," //6 +
        " work_item.stage_id," // 7
        " work_item.work_id, " // 8
        " work_item.unit_of_measurement_id, " // 9
        " work_item.archived " // 10
        " FROM work.work_items work_item";
      //  " JOIN work.work_stages work_stage ON stage.id = work_item.stage_id";

    Map<String, dynamic> substitutionValues;
    if (workItemGetRequest.hasId()) {
      queryStatement += " WHERE work_item.id = @id";
      substitutionValues = {"id": workItemGetRequest.id};
    } else if (workItemGetRequest.hasWorkId() ) {
      queryStatement += " WHERE work_item.work_id = @work_id";
      substitutionValues = {"work_id": workItemGetRequest.workId};
    } else if (workItemGetRequest.hasOrganizationId() ) {
      queryStatement += " WHERE work_item.work_id IN (SELECT work.id FROM work.works work WHERE work.organization_id = @organization_id)";
      substitutionValues = {"organization_id": workItemGetRequest.organizationId};
    } else {
      throw GrpcError.invalidArgument( RpcErrorDetailMessage.workItemInvalidArgument );
    }
    if (!workItemGetRequest.hasWithArchived() || !workItemGetRequest.withArchived) {
      queryStatement = queryStatement + " AND work_item.archived <> true";
    }

    //String ids;
    if (workItemGetRequest.assignedToIds != null && workItemGetRequest.assignedToIds.isNotEmpty) {
      queryStatement = queryStatement + " AND exists(SELECT null FROM work.work_item_assigned_users work_item_assigned_user WHERE work_item_assigned_user.work_item_id = work_item.id AND work_item_assigned_user.user_id in ${workItemGetRequest.assignedToIds.map((f) => "'${f}'")})";
      //ids = objectiveGetRequest.groupIds.toString();
      // queryStatementWhere = queryStatementWhere + " AND objective.group_id in (${ids.toString().substring(1, ids.length-1)})";
    }
    List<WorkItem> workItems = List();
    List<UnitOfMeasurement> unitsOfMeasurement;

    try {
      results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

      WorkStage workStage;
      List<User> assignedToUsers;
      List<WorkItemAttachment> attachments;
      List<WorkItemCheckItem> checkItems;
      WorkItem workItem;
      for (var row in results) {
        workStage = await WorkStageService.querySelectWorkStage(WorkStageGetRequest()..id = row[7]);

        assignedToUsers = await querySelectWorkItemAssignedToUsers(row[0]);

        attachments = await querySelectWorkItemAttachments(WorkItemAttachmentGetRequest()..workItemId = row[0]..withContent = false);

        checkItems = await querySelectWorkItemCheckItems(WorkItemCheckItemGetRequest()..workItemId = row[0]);

        workItem = WorkItem()..id = row[0]..version = row[1]..name = row[2];
        if (row[3] != null) workItem.description = row[3];
        if (row[4] != null) workItem.dueDate = CommonUtils.timestampFromDateTime(row[4]);

        if (row[5] != null) workItem.plannedValue = row[5];
        if (row[6] != null) workItem.actualValue = row[6];
        if (workStage != null) workItem.workStage = workStage; //await WorkStageService.querySelectWorkStage(WorkStageGetRequest()..id = row[7]);
        if (assignedToUsers.isNotEmpty) workItem.assignedTo.addAll(assignedToUsers);
        if (attachments.isNotEmpty) workItem.attachments.addAll(attachments);
        if (checkItems.isNotEmpty) workItem.checkItems.addAll(checkItems);

        if (workItemGetRequest.hasWithWork() && workItemGetRequest.withWork == true && row[8] != null) {
          workItem.work = await WorkService.querySelectWork(WorkGetRequest()..id = row[8]..withUserProfile = workItemGetRequest.withUserProfile);
        }

        if (row[9] != null)
          //  measureUnit = await getMeasureUnitById(row[8]);
          unitsOfMeasurement = await UnitOfMeasurementService.querySelectUnitsOfMeasurement(id: row[9]);
        if (unitsOfMeasurement != null && unitsOfMeasurement.length != 0) {
          workItem.unitOfMeasurement = unitsOfMeasurement.first;
        }

        workItem.archived = row[10];
        workItems.add(workItem);

      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return workItems;
  }

  // *** WORK ITEMS CHECKED ITEMS ***
  static Future<List<WorkItemCheckItem>> querySelectWorkItemCheckItems(WorkItemCheckItemGetRequest workItemCheckItemGetRequest) async {

    List<List> results;

    String queryStatement;

    queryStatement = "SELECT check_item.id, check_item.name, check_item.finished"
        " FROM work.work_item_check_items check_item";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE check_item.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemCheckItemGetRequest.workItemId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItemCheckItem> checkItems = new List();
    for (var row in results) {

      checkItems.add(new WorkItemCheckItem()..id = row[0]..name = row[1]..finished = row[2]);
    }

    return checkItems;
  }

  // *** ATTACHMENT ***
  static Future<List<WorkItemAttachment>> querySelectWorkItemAttachments(WorkItemAttachmentGetRequest workItemAttachmentGetRequest) async {

    List<List> results;

    String queryStatement;

    queryStatement = "SELECT attachment.id, attachment.name, attachment.type";
    if (workItemAttachmentGetRequest.hasWithContent() && workItemAttachmentGetRequest.withContent)  queryStatement += ", attachment.content";
    queryStatement += " FROM work.work_item_attachments attachment";

    Map<String, dynamic> substitutionValues;


    substitutionValues = {"work_item_id": workItemAttachmentGetRequest.workItemId};

    if (workItemAttachmentGetRequest.hasId()) {
      queryStatement += " WHERE attachment.id = @id";
      substitutionValues = {"id": workItemAttachmentGetRequest.id};
    } else if (workItemAttachmentGetRequest.hasWorkItemId() ) {
      queryStatement += " WHERE attachment.work_item_id = @work_item_id";
      substitutionValues = {"work_item_id": workItemAttachmentGetRequest.workItemId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.workItemAttachmentInvalidArgument );
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItemAttachment> attachments =  List();
    for (var row in results) {
      WorkItemAttachment workItemAttachment = WorkItemAttachment()..id = row[0]..name = row[1]..type = row[2];
      if (workItemAttachmentGetRequest.hasWithContent() && workItemAttachmentGetRequest.withContent) {
        workItemAttachment.content = row[3];
      }

      attachments.add(workItemAttachment);
    }

    return attachments;
  }

  static Future<WorkItemAttachment> querySelectWorkItemAttachment(WorkItemAttachmentGetRequest workItemAttachmentGetRequest /* String id */) async {

    List<WorkItemAttachment> workItemAttachments = await querySelectWorkItemAttachments(workItemAttachmentGetRequest);

    if (workItemAttachments == null || workItemAttachments.isEmpty) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workItemAttachmentDataNotFoundReason);
    else
      return workItemAttachments.first;
  }

  static Future<WorkItem> querySelectWorkItem(WorkItemGetRequest workItemGetRequest /* String id */) async {

    List<WorkItem> workItems = await querySelectWorkItems(workItemGetRequest);

    if (workItems == null || workItems.isEmpty) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workItemDataNotFoundReason);
    else
      return workItems.first;
  }

  // *** INITIATIVE WORK ITEMS ASSIGNED ***
  static Future<List<User>> querySelectWorkItemAssignedToUsers(String workItemId) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_item_assigned_user.user_id"
        " FROM work.work_item_assigned_users work_item_assigned_user";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE work_item_assigned_user.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<User> assignedToUsers = List();

    User user;

    for (var row in results) {

      user = await UserService.querySelectUser(UserGetRequest()..id = row[0]..onlyIdAndName = true..withUserProfile = true);

      assignedToUsers.add(user);
    }

    return assignedToUsers;
  }

  /// Workitem Notification User
  static void workItemNotification(Work relatedWork, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    // Not send to your-self
    if (relatedWork.leader.id == authUserId) return;

    // Leader  - Verify if send e-mail
    if (!relatedWork.leader.userProfile.eMailNotification) return;

    // Leader - eMail
    if (relatedWork.leader.userProfile.eMail == null) throw Exception('e-mail of the Work Leader is null.');

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];


    await CommonUtils.setDefaultLocale(relatedWork.leader.userProfile.idiomLocale);

    mailMessages.add(
        AugeMailMessageTo(
            [relatedWork.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${ObjectiveDomainMsg.fieldLabel(work_m.Work.leaderField)}',
            '${ClassNameMsg.label(work_m.Work.className)} ${relatedWork.name}',
            '${urlOrigin}/#/${AppRoutesPath.appLayoutRoutePath}/${AppRoutesPath.worksRoutePath}?${AppRoutesQueryParam.workIdQueryParameter}=${relatedWork.id}'));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);

  }

  /// Create (insert) a new instance of [WorkItem]
  static Future<StringValue> queryInsertWorkItem(WorkItemRequest request, String urlOrigin) async {

    if (!request.workItem.hasId()) {
      request.workItem.id = Uuid().v4();
    }
    request.workItem.version = 0;

    Map<String, dynamic> historyItemNotificationValues;

    try {

      // TODO (this is made just to get a work leader email, found a way to improve the performance)
      Work work = await WorkService.querySelectWork(WorkGetRequest()..id = request.workId..withUserProfile = true);

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query("INSERT INTO work.work_items"
            "(id,"
            "version,"
            "name,"
            "description,"
            "due_date,"
            "planned_value,"
        //    "actual_value,"
            "work_id,"
            "unit_of_measurement_id,"
            "stage_id,"
            "archived) "
            "VALUES"
            "(@id,"
            "@version,"
            "@name,"
            "@description,"
            "@due_date,"
            "@planned_value,"
           // "@actual_value,"
            "@work_id,"
            "@unit_of_measurement_id,"
            "@stage_id,"
            "@archived)"
            , substitutionValues: {
              "id": request.workItem.id,
              "version": request.workItem.version,
              "name": request.workItem.name,
              "description": request.workItem.hasDescription() ? request.workItem.description : null,
              "due_date": request.workItem.hasDueDate() ? /* CommonUtils.dateTimeFromTimestamp(request.workItem.dueDate) */ request.workItem.dueDate.toDateTime() : null,
              "planned_value": request.workItem.hasPlannedValue() ? request.workItem.plannedValue : null,
            //  "actual_value": request.workItem.hasActualValue() ? request.workItem.actualValue : null,
              "archived": request.workItem.hasArchived() ? request.workItem.archived : false,
              "work_id": request.hasWorkId() ? request.workId : null,
              "unit_of_measurement_id": request.workItem.hasUnitOfMeasurement() ? request.workItem.unitOfMeasurement.id : null,
              "stage_id": request.workItem.hasWorkStage() ? request.workItem.workStage.id : null,
              });

        // Assigned Members Users
        for (User user in request.workItem.assignedTo) {
          await ctx.query("INSERT INTO work.work_item_assigned_users"
              " (work_item_id,"
              " user_id)"
              " VALUES"
              " (@id,"
              " @user_id)"
              , substitutionValues: {
                "id": request.workItem.id,
                "user_id": user.id});
        }

        // Attachment list
        for (WorkItemAttachment attachment in request.workItem.attachments) {
          attachment.id = Uuid().v4();

          await ctx.query("INSERT INTO work.work_item_attachments"
              " (id,"
              " name,"
              " type,"
              " content,"
              " work_item_id)"
              " VALUES"
              " (@id,"
              " @name,"
              " @type,"
              " @content,"
              " @work_item_id)"
              , substitutionValues: {
                "id": attachment.id,
                "name": attachment.name,
                "type": attachment.type,
                "content": attachment.hasContent() ? attachment.content : false,
                "work_item_id": request.workItem.id});
        }

        // Check item list
        for (WorkItemCheckItem checkItem in request.workItem.checkItems) {
          checkItem.id = Uuid().v4();

          await ctx.query("INSERT INTO work.work_item_check_items"
              " (id,"
              " name,"
              " finished,"
              " work_item_id)"
              " VALUES"
              " (@id,"
              " @name,"
              " @finished,"
              " @work_item_id)"
              , substitutionValues: {
                "id": checkItem.id,
                "name": checkItem.name,
                "finished": checkItem.hasFinished() ? checkItem.finished : false,
                "work_item_id": request.workItem.id});
        }

        // Create a history item
        historyItemNotificationValues = {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.workItem.id,
          "object_version": request.workItem.version,
          "object_class_name": work_item_m
              .WorkItem.className,
          "system_module_index": SystemModule.works.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now(),
          "description": request.workItem.name,
          "changed_values": history_item_m.HistoryItemHelper
              .changedValuesJson({},
                  request.workItem.toProto3Json() )};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: historyItemNotificationValues);

      });

      // Notification
      workItemNotification(work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.workItem.id;
  }

  /// Update an work passing an instance of [WorkItem]
  static Future<Empty> queryUpdateWorkItem(WorkItemRequest request, String urlOrigin) async {

    // Recovery to log to history
    WorkItem previousWorkItem = await querySelectWorkItem(WorkItemGetRequest()..id = request.workItem.id..withWork = true);

    // TODO (this is made just to get a user profile email, it needs to find to a way to improve the performance)
    Work work = await WorkService.querySelectWork(WorkGetRequest()..id = request.workId..withUserProfile = true);

    Map<String, dynamic> historyItemNotificationValues;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result;
        result = await ctx.query("UPDATE work.work_items"
            " SET version = @version, "
            " name = @name,"
            " description = @description,"
            " due_date = @due_date,"
            " planned_value = @planned_value,"
          //  " actual_value = @actual_value,"
            " work_id = @work_id,"
            " stage_id = @stage_id,"
            " unit_of_measurement_id = @unit_of_measurement_id, "
            " archived = @archived"
            " WHERE id = @id AND version = @version - 1"
            " RETURNING true"
            , substitutionValues: {
              "id": request.workItem.id,
              "version": ++request.workItem.version,
              "name": request.workItem.name,
              "description": request.workItem.hasDescription()
                  ? request.workItem.description
                  : null,
              "due_date": request.workItem.hasDueDate() ? /* CommonUtils.dateTimeFromTimestamp(request.workItem.dueDate) */ request.workItem.dueDate.toDateTime() : null,
              "planned_value": request.workItem.hasPlannedValue()
                  ? request.workItem.plannedValue
                  : null,
          //    "actual_value": request.workItem.hasActualValue()
          //        ? request.workItem.actualValue
           //       : null,
              "work_id": request.workId,
              "stage_id": request.workItem.hasWorkStage() ? request.workItem.workStage.id : null,
              "unit_of_measurement_id": request.workItem.hasUnitOfMeasurement () ? request.workItem.unitOfMeasurement.id : null,
              "archived": request.workItem.archived});

        // Assigned Members Users
        StringBuffer assignedToUsersId = new StringBuffer();
        for (User user in request.workItem.assignedTo) {
          await ctx.query(
              "INSERT INTO work.work_item_assigned_users"
                  " (work_item_id,"
                  " user_id)"
                  " VALUES"
                  " (@id,"
                  " @user_id)"
                  " ON CONFLICT (work_item_id, user_id) DO NOTHING"
              , substitutionValues: {
            "id": request.workItem.id,
            "user_id": user.id});

          if (assignedToUsersId.isNotEmpty)
            assignedToUsersId.write(',');
          assignedToUsersId.write("'");
          assignedToUsersId.write(user.id);
          assignedToUsersId.write("'");
        }

        if (assignedToUsersId.isNotEmpty) {
          await ctx.query(
              "DELETE FROM work.work_item_assigned_users"
                  " WHERE work_item_id = @id"
                  " AND user_id NOT IN (${assignedToUsersId.toString()})"
              , substitutionValues: {
            "id": request.workItem.id});
        }

        // WorkItemAttachment list
        StringBuffer workItemsId = new StringBuffer();
        for (WorkItemAttachment workItemAttachment in request.workItem.attachments) {
          if (!workItemAttachment.hasId()) {
            workItemAttachment.id = new Uuid().v4();

            await ctx.query(
                "INSERT INTO work.work_item_attachments"
                    " (id,"
                    " name,"
                    " type,"
                    " content,"
                    " work_item_id)"
                    " VALUES"
                    " (@id,"
                    " @name,"
                    " @type,"
                    " @content,"
                    " @work_item_id)"
                , substitutionValues: {
              "id": workItemAttachment.id,
              "name": workItemAttachment.name,
              "type": workItemAttachment.type,
              "content": workItemAttachment.content,
              "work_item_id": request.workItem.id});
          } /* else {
            checkItem.version++;
            await ctx.query("UPDATE work.work_item_check_items SET"
                " name = @name,"
                " version = @version,"
                " finished = @finished,"
                " work_item_id = @work_item_id"
                " WHERE id = @id AND version = @version - 1"
                , substitutionValues: {
                  "id": checkItem.id,
                  "version": checkItem.version,
                  "name": checkItem.name,
                  "finished": checkItem.finished,
                  "work_item_id": request.workItem.id});

          }*/

          if (workItemsId.isNotEmpty)
            workItemsId.write(',');
          workItemsId.write("'");
          workItemsId.write(workItemAttachment.id);
          workItemsId.write("'");
        }

        String queryDelete;
        queryDelete = "DELETE FROM work.work_item_attachments work_item_attachment WHERE work_item_attachment.work_item_id = @work_item_id";
        if (workItemsId.isNotEmpty) {
          queryDelete =
              queryDelete + " AND work_item_attachment.id NOT IN (${workItemsId.toString()})";
        }

        await ctx.query(queryDelete, substitutionValues: {"work_item_id": request.workItem.id});


        // Check item list
        StringBuffer checkItemsId = new StringBuffer();
        for (WorkItemCheckItem checkItem in request.workItem.checkItems) {
          if (!checkItem.hasId()) {
            checkItem.id = new Uuid().v4();

            await ctx.query(
                "INSERT INTO work.work_item_check_items"
                    " (id,"
                    " name,"
                    " finished,"
                    " work_item_id)"
                    " VALUES"
                    " (@id,"
                    " @name,"
                    " @finished,"
                    " @work_item_id)"
                , substitutionValues: {
              "id": checkItem.id,
              "name": checkItem.name,
              "finished": checkItem.finished,
              "work_item_id": request.workItem.id});
          } else {
            await ctx.query("UPDATE work.work_item_check_items SET"
                " name = @name,"
                " finished = @finished,"
                " work_item_id = @work_item_id"
                " WHERE id = @id"
                , substitutionValues: {
                  "id": checkItem.id,
                  "name": checkItem.name,
                  "finished": checkItem.finished,
                  "work_item_id": request.workItem.id});
          }

          if (checkItemsId.isNotEmpty)
            checkItemsId.write(',');
          checkItemsId.write("'");
          checkItemsId.write(checkItem.id);
          checkItemsId.write("'");
        }

        String queryDeleteCheckItems;
        queryDeleteCheckItems = "DELETE FROM work.work_item_check_items work_item_check_item WHERE work_item_check_item.work_item_id = @work_item_id";
        if (checkItemsId.isNotEmpty) {
          queryDeleteCheckItems =
              queryDeleteCheckItems + " AND work_item_check_item.id NOT IN (${checkItemsId.toString()})";
        }

        await ctx.query(queryDeleteCheckItems, substitutionValues: {"work_item_id": request.workItem.id});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workItemPreconditionFailed );
        }
        else {

          // Create a history item
          historyItemNotificationValues =  {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.workItem.id,
            "object_version": request.workItem.version,
            "object_class_name": work_item_m
                .WorkItem.className,
            "system_module_index": SystemModule.works.index,
            "system_function_index": SystemFunction.update.index,
            "date_time": DateTime.now(),
            "description": request.workItem.name,
            "changed_values": history_item_m.HistoryItemHelper
                .changedValuesJson(
                    previousWorkItem.toProto3Json(),
                    request.workItem.toProto3Json() )};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }

      });

      // Notification
      workItemNotification(work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a WorkItem by [id]
  static Future<Empty> queryDeleteWorkItem(WorkItemDeleteRequest request, String urlOrigin) async {

    WorkItem previousWorkItem = await querySelectWorkItem(WorkItemGetRequest()..id = request.workItemId..withWork = true..withUserProfile = true);

    Map<String, dynamic> historyItemNotificationValues;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query("DELETE FROM work.work_item_check_items work_item_check_item WHERE work_item_check_item.work_item_id = @work_item_id",
            substitutionValues: {"work_item_id": request.workItemId});

        await ctx.query(
            "DELETE FROM work.work_item_assigned_users"
                " WHERE work_item_id = @work_item_id"
            , substitutionValues: {
          "work_item_id": request.workItemId});


        List<List<dynamic>> result = await ctx.query(
              "DELETE FROM work.work_items work_item"
                  " WHERE work_item.id = @id and work_item.version = @version"
                  " RETURNING true"
              , substitutionValues: {
            "id": request.workItemId,
            "version": request.workItemVersion});

          // Optimistic concurrency control
          if (result.isEmpty) {
            throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
          } else {
            // Create a history item
            historyItemNotificationValues = {"id": Uuid().v4(),
              "user_id": request.authUserId,
              "organization_id": request.authOrganizationId,
              "object_id": request.workItemId,
              "object_version": request.workItemVersion,
              "object_class_name": work_item_m.WorkItem.className,
              "system_module_index": SystemModule.works.index,
              "system_function_index": SystemFunction.delete.index,
              "date_time": DateTime.now(),
              "description": previousWorkItem.name,
              "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                      previousWorkItem.toProto3Json(), {})};

            await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
                substitutionValues: historyItemNotificationValues);
          }
      });

      // Notification
      workItemNotification(previousWorkItem.work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  // *** WORK ITEM VALUE  ***
  static Future<List<WorkItemValue>> querySelectWorkItemValues(WorkItemValueGetRequest request) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id," // 0
        " version," //1
        " date," //2
        " actual_value," //3
        " comment," //4
        " work_item_id" //5
        " FROM work.work_item_values ";

    Map<String, dynamic> substitutionValues = {};

    if (request.hasId()) {
      queryStatement +=
      " WHERE id = @id";
      substitutionValues['id'] = request.id;
    } else if (request.hasWorkItemId()) {
      queryStatement +=
      " WHERE work_item_id = @work_item_id";
      substitutionValues['work_item_id'] = request.workItemId;
    }

    queryStatement += " ORDER BY date DESC";

    List<WorkItemValue> workItemValues = List();
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      if (results != null && results.isNotEmpty) {
        for (var row in results) {
          WorkItemValue workItemValue = WorkItemValue()
            ..id = row[0]
            ..version = row[1];

          //  measureProgress.date = row[3]
          if (row[2] != null) workItemValue.date = CommonUtils.timestampFromDateTime(row[2]); /*{
              Timestamp t = Timestamp();
              int microsecondsSinceEpoch = row[2].toUtc().microsecondsSinceEpoch;
              t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
              t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
              measureProgress.date = t;
            }*/

          if (row[3] != null) {
            workItemValue.actualValue = row[3];
          }
          if (row[4] != null) {
            workItemValue.comment = row[4];
          }

          if (request.withWorkItem && request.withWorkItem == true && row[5] != null) {
            workItemValue.workItem = await WorkItemService.querySelectWorkItem(WorkItemGetRequest()..id = row[5]..withWork = request.withWork..withUserProfile = request.withUserProfile);
          }

          workItemValues.add(workItemValue);
        }
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return workItemValues;
  }

  static Future<WorkItemValue> querySelectWorkItemValue(WorkItemValueGetRequest request) async {
    List<WorkItemValue> workItemValues = await querySelectWorkItemValues(request);

    if (workItemValues.isNotEmpty) {
      return workItemValues.first;
    } else {
      return null;
    }
  }


  /// Objective Work Item Value Notification User
  static void workItemValueNotification(WorkItemValue workItemValue, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    // Not send to your-self
    if (workItemValue.workItem.work.leader.id == authUserId) return;

    // Leader  - Verify if send e-mail
    if (!workItemValue.workItem.work.leader.userProfile.eMailNotification) return;

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    // Leader - eMail
    if (workItemValue.workItem.work.leader.userProfile.eMail == null) throw Exception('e-mail of the Work Leader is null.');

    await CommonUtils.setDefaultLocale(workItemValue.workItem.work.leader.userProfile.idiomLocale);

    mailMessages.add(
        AugeMailMessageTo(
            [workItemValue.workItem.work.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${ObjectiveDomainMsg.fieldLabel(work_m.Work.leaderField)}',
            '${ClassNameMsg.label(work_m.Work.className)} ${workItemValue.workItem.work.name}',
            urlOrigin));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);

  }

  /// Create value of the [WorkItemValue]
  static Future<StringValue> queryInsertWorkItemValue(
      WorkItemValueRequest request, String urlOrigin) async {
    Map<String, dynamic> historyItemNotificationValues;
    try {

      // This is made just to recovery email leader from objective, used to notification
      request.workItemValue.workItem = await querySelectWorkItem(WorkItemGetRequest()..id = request.workItemId..withWork = true..withUserProfile = true);

      request.workItemValue.version = 0;

      await (await AugeConnection.getConnection()).transaction((ctx) async {
        if (!request.workItemValue.hasId()) {
          request.workItemValue.id = Uuid().v4();
        }

        await ctx.query(
            "INSERT INTO work.work_item_values(id, version, date, actual_value, comment, work_item_id) VALUES"
                "(@id,"
                "@version,"
                "@date,"
                "@actual_value,"
                "@comment,"
                "@work_item_id)"
            , substitutionValues: {
          "id": request.workItemValue.id,
          "version": request.workItemValue.version,
          "date": request.workItemValue.hasDate() ? /* CommonUtils.dateTimeFromTimestamp(request.measureProgress.date) */ request.workItemValue.date.toDateTime() : DateTime.now().toUtc(),
          "actual_value": request.workItemValue.hasActualValue() ? request.workItemValue.actualValue : null,
          "comment": request.workItemValue.hasComment() ? request.workItemValue.comment : null,
          "work_item_id": request.hasWorkItemId() ? request.workItemId : null,
        });

        // Create a history item
        historyItemNotificationValues =  {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.workItemValue.id,
          "object_version": request.workItemValue.version,
          "object_class_name": work_item_m
              .WorkItemValue.className,
          "system_module_index": SystemModule.objectives.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": '${request.workItemValue.actualValue} @ ${request.workItemValue.workItem.name}',
          "changed_values": history_item_m.HistoryItemHelper
              .changedValuesJson({},
                  request.workItemValue.toProto3Json())};


        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: historyItemNotificationValues);

      });

      // Notification
      workItemValueNotification(request.workItemValue, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return StringValue()..value = request.workItemValue.id;
  }

  /// Create value of the [WorkItemValue]
  Future<Empty> queryUpdateWorkItemValue(
      WorkItemValueRequest request, String urlOrigin) async {

    // Recovery to log to history
    WorkItemValue previousWorkItemValue = await querySelectWorkItemValue(WorkItemValueGetRequest()..id = request.workItemValue.id..withWorkItem = true..withWork = true..withUserProfile = true);

    request.workItemValue.workItem = previousWorkItemValue.workItem;
    // This is made just to recovery email leader from objective, used to notification
    //request.measureProgress.measure = await querySelectMeasure(MeasureGetRequest()..id = request.measureId..withObjective = true..withUserProfile = true);

    Map<String, dynamic> historyItemNotificationValues;
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        DateTime dateTimeNow = DateTime.now().toUtc();

        List<List<dynamic>> result;

        if (!request.workItemValue.hasId()) {
          request.workItemValue.id = Uuid().v4();
        }

        result = await ctx.query(
            "UPDATE work.work_item_values "
                "SET date = @date, "
                "actual_value = @actual_value, "
                "comment = @comment, "
                "work_item_id = @work_item_id, "
                "version = @version "
                "WHERE id = @id AND version = @version - 1 "
                "RETURNING true"
            , substitutionValues: {
          "id": request.workItemValue.id,
          "version": ++request.workItemValue.version,
          "date": request.workItemValue.date == null
              ? dateTimeNow
              : request.workItemValue.date.toDateTime(),
          "actual_value": request.workItemValue.hasActualValue() ? request.workItemValue.actualValue : null,
          "comment": request.workItemValue.hasComment() ? request.workItemValue.comment : null,
          "work_item_id": request.hasWorkItemId() ? request.workItemId : null,

        });

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.workItemPreconditionFailed);
        } else {
          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.workItemValue.id,
            "object_version": request.workItemValue.version,
            "object_class_name": work_item_m
                .WorkItemValue.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.update.index,
            "date_time": DateTime.now().toUtc(),
            "description": '${request.workItemValue.actualValue} @ ${request.workItemValue.workItem.name}',
            "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(previousWorkItemValue.toProto3Json(), request.workItemValue.toProto3Json())};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }

      });

      // Notification
      workItemValueNotification(request.workItemValue, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a [WorkItemValue] by id
  Future<Empty> queryDeleteWorkItemValue(WorkItemValueDeleteRequest request, String urlOrigin) async {

    WorkItemValue previousWorkItemValue = await querySelectWorkItemValue(WorkItemValueGetRequest()..id = request.workItemValueId..withWorkItem = true..withWork = true..withUserProfile = true);

    try {

      Map<String, dynamic> historyItemNotificationValues;

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM work.work_item_values work_item_value"
                " WHERE work_item_value.id = @id AND work_item_value.version = @version"
                " RETURNING true"
            , substitutionValues: {
          "id": request.workItemValueId,
          "version": request.workItemValueVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.workItemPreconditionFailed);
        } else {
          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.workItemValueId,
            "object_version": request.workItemValueVersion,
            "object_class_name": work_item_m.WorkItemValue.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.delete.index,
            "date_time": DateTime.now().toUtc(),
            "description": '${previousWorkItemValue.actualValue} @ ${previousWorkItemValue.workItem.name}',
            "changed_values": history_item_m.HistoryItemHelper
                .changedValuesJson(previousWorkItemValue.toProto3Json(), {})};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }
      });

      // Notification
      workItemValueNotification(previousWorkItemValue, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}