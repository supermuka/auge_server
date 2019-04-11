// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/stage.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/work_item.pbgrpc.dart';

import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/initiative/stage_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';

import 'package:auge_server/model/general/authorization.dart';

import 'package:auge_server/augeconnection.dart';

import 'package:uuid/uuid.dart';

class WorkItemService extends WorkItemServiceBase {

  // API
  @override
  Future<WorkItemsResponse> getWorkItems(ServiceCall call,
      WorkItemGetRequest workItemGetRequest) async {
    WorkItemsResponse workItemsResponse;
    workItemsResponse = WorkItemsResponse()
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
  Future<IdResponse> createWorkItem(ServiceCall call,
      WorkItem workItem) async {
    return queryInsertWorkItem(workItem);
  }

  @override
  Future<Empty> updateWorkItem(ServiceCall call,
      WorkItem workItem) async {
    return queryUpdateWorkItem(workItem);
  }

  @override
  Future<Empty> deleteWorkItem(ServiceCall call,
      WorkItem workItem) async {
    return queryDeleteWorkItem(workItem);
  }

  @override
  Future<Empty> softDeleteWorkItem(ServiceCall call,
      WorkItem workItem) async {
    workItem.isDeleted = true;
    return queryUpdateWorkItem(workItem);
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

  // QUERY

  // *** INITIATIVE WORK ITEMS ***
  static Future<List<WorkItem>> querySelectWorkItems(WorkItemGetRequest workItemGetRequest /* {String initiativeId, String id} */) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_item.id,"
        " work_item.version,"
        " work_item.is_deleted,"
        " work_item.name,"
        " work_item.description,"
        " work_item.due_date,"
        " work_item.completed,"
        " work_item.stage_id"
        " FROM initiative.work_items work_item"
        " JOIN initiative.stages stage ON stage.id = work_item.stage_id";

    Map<String, dynamic> substitutionValues;

    if (workItemGetRequest.hasId()) {
      queryStatement += " WHERE work_item.id = @id AND work_item.is_deleted = @is_deleted";
      substitutionValues = {"id": workItemGetRequest.id, "is_deleted": workItemGetRequest.isDeleted};
    } else if (workItemGetRequest.hasInitiativeId() ) {
      queryStatement += " WHERE work_item.initiative_id = @initiative_id AND work_item.is_deleted = @is_deleted";
      substitutionValues = {"initiative_id": workItemGetRequest.initiativeId, "is_deleted": workItemGetRequest.isDeleted};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.workItemInvalidArgument );
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItem> workItems = new List();
    List<Stage> stages;
    List<User> assignedToUsers;
    List<WorkItemCheckItem> checkItems;
    WorkItem workItem;
    for (var row in results) {

      stages = await StageService.querySelectStages(StageGetRequest()..initiativeId = row[0]..id = row[7]);

      assignedToUsers = await querySelectWorkItemAssignedToUsers(row[0]);

      checkItems = await querySelectWorkItemCheckItems(WorkItemCheckItemGetRequest()..workItemId = row[0]);

      workItem = WorkItem()..id = row[0]..version = row[1]..isDeleted = row[2]..name = row[3];
      if (row[4] != null) workItem.description = row[4];
      if (row[5] != null) workItem.dueDate = row[5];
      if (row[6] != null) workItem.completed = row[6];
      if ( stages.isNotEmpty) workItem.stage = stages?.first;
      if (assignedToUsers.isNotEmpty) workItem.assignedTo.addAll(assignedToUsers);
      if (checkItems.isNotEmpty) workItem.checkItems.addAll(checkItems);

      workItems.add(workItem);

    }
    return workItems;
  }


  // *** INITIATIVE WORK ITEMS CHECKED ITEMS ***
  static Future<List<WorkItemCheckItem>> querySelectWorkItemCheckItems(WorkItemCheckItemGetRequest workItemCheckItemGetRequest) async {

    List<List> results;

    String queryStatement;

    queryStatement = "SELECT check_item.id, check_item.version, check_item.is_deleted, check_item.name, check_item.finished"
        " FROM initiative.work_item_check_items check_item";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE check_item.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemCheckItemGetRequest.workItemId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItemCheckItem> checkItems = new List();
    for (var row in results) {

      checkItems.add(new WorkItemCheckItem()..id = row[0]..version = row[1]..isDeleted = row[2]..name = row[3]..finished = row[4]);
    }

    return checkItems;
  }

  static Future<WorkItem> querySelectWorkItem(WorkItemGetRequest workItemGetRequest /* String id */) async {

    List<WorkItem> workItem = await querySelectWorkItems(workItemGetRequest);

    if (workItem == null || workItem.isEmpty) throw new GrpcError.notFound(
        RpcErrorDetailMessage.workItemDataNotFoundReason);
    else
      return workItem.first;
  }

  // *** INITIATIVE WORK ITEMS ASSIGNED ***
  static Future<List<User>> querySelectWorkItemAssignedToUsers(String workItemId) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_item_assigned_user.user_id"
        " FROM initiative.work_item_assigned_users work_item_assigned_user";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE work_item_assigned_user.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<User> assignedToUsers = new List();

    User user;

    for (var row in results) {

      user = await UserService.querySelectUser(row[0]);

      assignedToUsers.add(user);
    }

    return assignedToUsers;
  }

  /// Create (insert) a new instance of [WorkItem]
  static Future<IdResponse> queryInsertWorkItem(WorkItem workItem) async {

    if (!workItem.hasId()) {
      workItem.id = new Uuid().v4();
    }

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query("INSERT INTO initiative.work_items"
            "(id,"
            "version,"
            "is_deleted,"
            "name,"
            "description,"
            "due_date,"
            "completed,"
            "initiative_id,"
            "stage_id)"
            "VALUES"
            "(@id,"
            "@version,"
            "@is_deleted,"
            "@name,"
            "@description,"
            "@due_date,"
            "@completed,"
            "@initiative_id,"
            "@stage_id)"
            , substitutionValues: {
              "id": workItem.id,
              "version": 0,
              "is_deleted": false,
              "name": workItem.name,
              "description": workItem.hasDescription() ? workItem.description : null,
              "due_date": workItem.hasDueDate() ? workItem.dueDate : null,
              "completed": workItem.hasCompleted() ? workItem.completed : null,
              "initiative_id": workItem.hasInitiativeId() ? workItem.initiativeId : null,
              "stage_id": workItem.hasStage() ? workItem.stage.id : null});

        // Assigned Members Users
        for (User user in workItem.assignedTo) {
          await ctx.query("INSERT INTO initiative.work_item_assigned_users"
              " (work_item_id,"
              " user_id)"
              " VALUES"
              " (@id,"
              " @user_id)"
              , substitutionValues: {
                "id": workItem.id,
                "user_id": user.id});
        }

        // Check item list

        for (WorkItemCheckItem checkItem in workItem.checkItems) {
          checkItem.id = new Uuid().v4();

          await ctx.query("INSERT INTO initiative.work_item_check_items"
              " (id,"
              " version,"
              " is_deleted,"
              " name,"
              " finished,"
              " work_item_id)"
              " VALUES"
              " (@id,"
              " @version,"
              " @is_deleted,"
              " @name,"
              " @finished,"
              " @work_item_id)"
              , substitutionValues: {
                "id": checkItem.id,
                "version": 0,
                "is_deleted": checkItem.isDeleted ?? false,
                "name": checkItem.name,
                "finished": checkItem.hasFinished() ? checkItem.finished : false,
                "work_item_id": workItem.id});
        }

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return IdResponse()..id = workItem.id;
  }

  /// Update an initiative passing an instance of [WorkItem]
  static Future<Empty> queryUpdateWorkItem(WorkItem workItem) async {

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result;
        if (workItem.isDeleted) {
          result = await ctx.query("UPDATE initiative.work_items "
              " SET version = @version + 1, "
              " is_deleted = @is_deleted "
              " WHERE id = @id AND version = @version"
              " RETURNING true "
              , substitutionValues: {
                "id": workItem.id,
                "version": workItem.version,
                "is_deleted": workItem.isDeleted,
              });
        } else {
          result = await ctx.query("UPDATE initiative.work_items"
              " SET version = @version + 1, "
              " is_deleted = @is_deleted, "
              " name = @name,"
              " description = @description,"
              " due_date = @due_date,"
              " completed = @completed,"
              " initiative_id = @initiative_id,"
              " stage_id = @stage_id"
              " WHERE id = @id AND version = @version"
              " RETURNING true"
              , substitutionValues: {
                "id": workItem.id,
                "version": workItem.version,
                "is_deleted": workItem.isDeleted,
                "name": workItem.name,
                "description": workItem.hasDescription()
                    ? workItem.description
                    : null,
                "due_date": workItem.hasDueDate() ? workItem.dueDate : null,
                "completed": workItem.hasCompleted()
                    ? workItem.completed
                    : null,
                "initiative_id": workItem.initiativeId,
                "stage_id": workItem.hasStage() ? workItem.stage.id : null});

          // Assigned Members Users
          StringBuffer assignedToUsersId = new StringBuffer();
          for (User user in workItem.assignedTo) {
            await ctx.query(
                "INSERT INTO initiative.work_item_assigned_users"
                    " (work_item_id,"
                    " user_id)"
                    " VALUES"
                    " (@id,"
                    " @user_id)"
                    " ON CONFLICT (work_item_id, user_id) DO NOTHING"
                , substitutionValues: {
              "id": workItem.id,
              "user_id": user.id});


            if (assignedToUsersId.isNotEmpty)
              assignedToUsersId.write(',');
            assignedToUsersId.write("'");
            assignedToUsersId.write(user.id);
            assignedToUsersId.write("'");
          }

          if (assignedToUsersId.isNotEmpty) {
            await ctx.query(
                "DELETE FROM initiative.work_item_assigned_users"
                    " WHERE work_item_id = @id"
                    " AND user_id NOT IN (${assignedToUsersId.toString()})"
                , substitutionValues: {
              "id": workItem.id});
          }

          // Check item list
          StringBuffer checkItemsId = new StringBuffer();
          for (WorkItemCheckItem checkItem in workItem.checkItems) {
            if (checkItem.id == null) {
              checkItem.id = new Uuid().v4();

              await ctx.query(
                  "INSERT INTO initiative.work_item_check_items"
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
                "work_item_id": workItem.id});
            } else {
              await ctx.query("UPDATE initiative.work_item_check_items SET"
                  " name = @name,"
                  " finished = @finished,"
                  " work_item_id = @work_item_id"
                  " WHERE id = @id"
                  , substitutionValues: {
                    "id": checkItem.id,
                    "name": checkItem.name,
                    "finished": checkItem.finished,
                    "work_item_id": workItem.id});
            }

            if (checkItemsId.isNotEmpty)
              checkItemsId.write(',');
            checkItemsId.write("'");
            checkItemsId.write(checkItem.id);
            checkItemsId.write("'");
          }

          String queryDelete;
          queryDelete = "DELETE FROM initiative.work_item_check_items";
          if (checkItemsId.isNotEmpty) {
            queryDelete =
                queryDelete + " WHERE id NOT IN (${checkItemsId.toString()})";
          }

          await ctx.query(queryDelete);
        }

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workItemPreconditionFailed );
        }
        else {
          // HistoryItem
          workItem.historyItemLog
            ..id = new Uuid().v4()
            ..objectId = workItem.id
            ..objectVersion = workItem.version
            ..objectClassName = 'WorkItem' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.create.index;
          // ..dateTime = DateTime.now().toUtc();

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(workItem.historyItemLog));
        }

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  /// Delete a WorkItem by [id]
  static Future<Empty> queryDeleteWorkItem(WorkItem workItem) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM initiative.work_items work_item"
                " WHERE work_item.id = @id"
            , substitutionValues: {
          "id": workItem.id});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }
}