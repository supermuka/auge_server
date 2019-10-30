// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/util/mail.dart';

import 'package:auge_server/shared/message/messages.dart';
import 'package:auge_server/shared/message/model_messages.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/work/work_stage.pb.dart';
import 'package:auge_server/src/protos/generated/work/work_work_item.pbgrpc.dart';

import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/shared/common_utils.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/work/work_stage_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/work/work_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/model/work/work.dart' as work_m;
import 'package:auge_server/model/work/work_item.dart' as work_item_m;

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
    return queryInsertWorkItem(request);
  }

  @override
  Future<Empty> updateWorkItem(ServiceCall call,
      WorkItemRequest request) async {
    return queryUpdateWorkItem(request);
  }

  @override
  Future<Empty> deleteWorkItem(ServiceCall call,
      WorkItemDeleteRequest request) async {
    return queryDeleteWorkItem(request);
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
        " work_item.completed," //5
        " work_item.stage_id," //6
        " work_item.work_id" //7
        " FROM work.work_items work_item";
      //  " JOIN work.work_stages work_stage ON stage.id = work_item.stage_id";

    Map<String, dynamic> substitutionValues;

    if (workItemGetRequest.hasId()) {
      queryStatement += " WHERE work_item.id = @id";
      substitutionValues = {"id": workItemGetRequest.id};
    } else if (workItemGetRequest.hasWorkId() ) {
      queryStatement += " WHERE work_item.work_id = @work_id";
      substitutionValues = {"work_id": workItemGetRequest.workId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.workItemInvalidArgument );
    }


    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItem> workItems = new List();
    WorkStage workStage;
    List<User> assignedToUsers;
    List<WorkItemAttachment> attachments;
    List<WorkItemCheckItem> checkItems;
    WorkItem workItem;
    for (var row in results) {

      workStage = await WorkStageService.querySelectWorkStage(WorkStageGetRequest()..id = row[6]);

      assignedToUsers = await querySelectWorkItemAssignedToUsers(row[0]);

      attachments = await querySelectWorkItemAttachments(WorkItemAttachmentGetRequest()..workItemId = row[0]..withContent = false);

      checkItems = await querySelectWorkItemCheckItems(WorkItemCheckItemGetRequest()..workItemId = row[0]);

      workItem = WorkItem()..id = row[0]..version = row[1]..name = row[2];
      if (row[3] != null) workItem.description = row[3];
      if (row[4] != null) workItem.dueDate = CommonUtils.timestampFromDateTime(row[4]);

      if (row[5] != null) workItem.completed = row[5];
      if (workStage != null) workItem.workStage = workStage;
      if (assignedToUsers.isNotEmpty) workItem.assignedTo.addAll(assignedToUsers);
      if (attachments.isNotEmpty) workItem.attachments.addAll(attachments);
      if (checkItems.isNotEmpty) workItem.checkItems.addAll(checkItems);

      if (workItemGetRequest.hasWithWork() && workItemGetRequest.withWork == true && row[7] != null) {

        workItem.work = await WorkService.querySelectWork(WorkGetRequest()..id = row[7]);
      }

      workItems.add(workItem);

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

      user = await UserService.querySelectUser(UserGetRequest()..id = row[0]..withUserProfile = true);

      assignedToUsers.add(user);
    }

    return assignedToUsers;
  }

  /// Workitem Notification User
  static void workItemNotification(WorkItem workItem, String className, int systemFunctionIndex, String description) {

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    // Leader  - Verify if send e-mail
    if (!workItem.work.leader.userProfile.eMailNotification) return;

    // Leader - eMail
    if (workItem.work.leader.userProfile.eMail == null) throw Exception('e-mail of the Work Leader is null.');

    mailMessages.add(
        AugeMailMessageTo(
            [workItem.work.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString())}',
            '${ClassNameMsg.label(className)}',
            description,
            '${FieldMsg.label('${work_m.Work.className}.${work_m.Work.leaderField}')}'));

    // SEND E-MAIL
    AugeMail().send(mailMessages);

  }

  /// Create (insert) a new instance of [WorkItem]
  static Future<StringValue> queryInsertWorkItem(WorkItemRequest request) async {

    if (!request.workItem.hasId()) {
      request.workItem.id = Uuid().v4();
    }
    request.workItem.version = 0;

    Map<String, dynamic> historyItemNotificationValues;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query("INSERT INTO work.work_items"
            "(id,"
            "version,"
            "name,"
            "description,"
            "due_date,"
            "completed,"
            "work_id,"
            "stage_id)"
            "VALUES"
            "(@id,"
            "@version,"
            "@name,"
            "@description,"
            "@due_date,"
            "@completed,"
            "@work_id,"
            "@stage_id)"
            , substitutionValues: {
              "id": request.workItem.id,
              "version": request.workItem.version,
              "name": request.workItem.name,
              "description": request.workItem.hasDescription() ? request.workItem.description : null,
              "due_date": request.workItem.hasDueDate() ? /* CommonUtils.dateTimeFromTimestamp(request.workItem.dueDate) */ request.workItem.dueDate.toDateTime() : null,
              "completed": request.workItem.hasCompleted() ? request.workItem.completed : null,
              "work_id": request.hasWorkId() ? request.workId : null,
              "stage_id": request.workItem.hasWorkStage() ? request.workItem.workStage.id : null});

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
          attachment.id = new Uuid().v4();

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
          checkItem.id = new Uuid().v4();

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
          "changed_values": history_item_m.HistoryItem
              .changedValuesJson({},
              work_item_m.WorkItem
                  .fromProtoBufToModelMap(
                  request.workItem))};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: historyItemNotificationValues);

      });

      // Notification
      workItemNotification(request.workItem, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description']);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.workItem.id;
  }

  /// Update an work passing an instance of [WorkItem]
  static Future<Empty> queryUpdateWorkItem(WorkItemRequest request) async {

    // Recovery to log to history
    WorkItem previousWorkItem = await querySelectWorkItem(WorkItemGetRequest()..id = request.workItem.id);

    Map<String, dynamic> historyItemNotificationValues;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result;

        result = await ctx.query("UPDATE work.work_items"
            " SET version = @version, "
            " name = @name,"
            " description = @description,"
            " due_date = @due_date,"
            " completed = @completed,"
            " work_id = @work_id,"
            " stage_id = @stage_id"
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
              "completed": request.workItem.hasCompleted()
                  ? request.workItem.completed
                  : null,
              "work_id": request.workId,
              "stage_id": request.workItem.hasWorkStage() ? request.workItem.workStage.id : null});

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
            "changed_values": history_item_m.HistoryItem
                .changedValuesJson(
                work_item_m.WorkItem
                    .fromProtoBufToModelMap(
                    previousWorkItem),
                work_item_m.WorkItem
                    .fromProtoBufToModelMap(
                    request.workItem))};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }

      });

      // Notification
      workItemNotification(request.workItem, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description']);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a WorkItem by [id]
  static Future<Empty> queryDeleteWorkItem(WorkItemDeleteRequest request) async {

    WorkItem previousWorkItem = await querySelectWorkItem(WorkItemGetRequest()..id = request.workItemId..withWork = true);

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
              "changed_values": history_item_m.HistoryItem.changedValuesJson(
                  work_item_m.WorkItem.fromProtoBufToModelMap(
                      previousWorkItem, true), {})};

            await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
                substitutionValues: historyItemNotificationValues);
          }
      });

      // Notification
      workItemNotification(previousWorkItem, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description']);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}