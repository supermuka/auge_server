// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/stage.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/work_item.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';

import 'package:auge_server/shared/rpc_error_message.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/initiative/stage_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';

import 'package:auge_server/model/general/authorization.dart';
import 'package:auge_server/model/general/history_item.dart' as history_item_m;

import 'package:auge_server/augeconnection.dart';

import 'package:uuid/uuid.dart';

class WorkItemService extends WorkItemServiceBase {

  // API
  @override
  Future<WorkItemsResponse> getWorkItems(ServiceCall call,
      WorkItemGetRequest workItemGetRequest) async {
    WorkItemsResponse workItemsResponse;
    workItemsResponse = WorkItemsResponse()..webWorkAround = true
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
      WorkItemRequest request) async {
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

  // QUERY

  // *** INITIATIVE WORK ITEMS ***
  static Future<List<WorkItem>> querySelectWorkItems(WorkItemGetRequest workItemGetRequest /* {String initiativeId, String id} */) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_item.id,"
        " work_item.version,"
        " work_item.name,"
        " work_item.description,"
        " work_item.due_date,"
        " work_item.completed,"
        " work_item.stage_id"
        " FROM initiative.work_items work_item"
        " JOIN initiative.stages stage ON stage.id = work_item.stage_id";

    Map<String, dynamic> substitutionValues;

    if (workItemGetRequest.hasId()) {
      queryStatement += " WHERE work_item.id = @id";
      substitutionValues = {"id": workItemGetRequest.id};
    } else if (workItemGetRequest.hasInitiativeId() ) {
      queryStatement += " WHERE work_item.initiative_id = @initiative_id";
      substitutionValues = {"initiative_id": workItemGetRequest.initiativeId};
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

      stages = await StageService.querySelectStages(StageGetRequest()..initiativeId = row[0]..id = row[6]);

      assignedToUsers = await querySelectWorkItemAssignedToUsers(row[0]);

      checkItems = await querySelectWorkItemCheckItems(WorkItemCheckItemGetRequest()..workItemId = row[0]);

      workItem = WorkItem()..id = row[0]..version = row[1]..name = row[2];
      if (row[3] != null) workItem.description = row[3];
      if (row[4] != null) workItem.dueDate = row[4];
      if (row[5] != null) workItem.completed = row[5];
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

    queryStatement = "SELECT check_item.id, check_item.version, check_item.name, check_item.finished"
        " FROM initiative.work_item_check_items check_item";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE check_item.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemCheckItemGetRequest.workItemId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItemCheckItem> checkItems = new List();
    for (var row in results) {

      checkItems.add(new WorkItemCheckItem()..id = row[0]..version = row[1]..name = row[2]..finished = row[3]);
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
  static Future<IdResponse> queryInsertWorkItem(WorkItemRequest request) async {

    if (!request.workItem.hasId()) {
      request.workItem.id = new Uuid().v4();
    }

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query("INSERT INTO initiative.work_items"
            "(id,"
            "version,"
            "name,"
            "description,"
            "due_date,"
            "completed,"
            "initiative_id,"
            "stage_id)"
            "VALUES"
            "(@id,"
            "@version,"
            "@name,"
            "@description,"
            "@due_date,"
            "@completed,"
            "@initiative_id,"
            "@stage_id)"
            , substitutionValues: {
              "id": request.workItem.id,
              "version": 0,
              "name": request.workItem.name,
              "description": request.workItem.hasDescription() ? request.workItem.description : null,
              "due_date": request.workItem.hasDueDate() ? request.workItem.dueDate : null,
              "completed": request.workItem.hasCompleted() ? request.workItem.completed : null,
              "initiative_id": request.hasInitiativeId() ? request.initiativeId : null,
              "stage_id": request.workItem.hasStage() ? request.workItem.stage.id : null});

        // Assigned Members Users
        for (User user in request.workItem.assignedTo) {
          await ctx.query("INSERT INTO initiative.work_item_assigned_users"
              " (work_item_id,"
              " user_id)"
              " VALUES"
              " (@id,"
              " @user_id)"
              , substitutionValues: {
                "id": request.workItem.id,
                "user_id": user.id});
        }

        // Check item list
        for (WorkItemCheckItem checkItem in request.workItem.checkItems) {
          checkItem.id = new Uuid().v4();

          await ctx.query("INSERT INTO initiative.work_item_check_items"
              " (id,"
              " version,"
              " name,"
              " finished,"
              " work_item_id)"
              " VALUES"
              " (@id,"
              " @version,"
              " @name,"
              " @finished,"
              " @work_item_id)"
              , substitutionValues: {
                "id": checkItem.id,
                "version": 0,
                "name": checkItem.name,
                "finished": checkItem.hasFinished() ? checkItem.finished : false,
                "work_item_id": request.workItem.id});
        }

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return IdResponse()..id = request.workItem.id;
  }

  /// Update an initiative passing an instance of [WorkItem]
  static Future<Empty> queryUpdateWorkItem(WorkItemRequest request) async {

    // Recovery to log to history
    WorkItem previousWorkItem = await querySelectWorkItem(WorkItemGetRequest()..id = request.workItem.id);

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result;

        result = await ctx.query("UPDATE initiative.work_items"
            " SET version = @version + 1, "
            " name = @name,"
            " description = @description,"
            " due_date = @due_date,"
            " completed = @completed,"
            " initiative_id = @initiative_id,"
            " stage_id = @stage_id"
            " WHERE id = @id AND version = @version"
            " RETURNING true"
            , substitutionValues: {
              "id": request.workItem.id,
              "version": request.workItem.version,
              "name": request.workItem.name,
              "description": request.workItem.hasDescription()
                  ? request.workItem.description
                  : null,
              "due_date": request.workItem.hasDueDate() ? request.workItem.dueDate : null,
              "completed": request.workItem.hasCompleted()
                  ? request.workItem.completed
                  : null,
              "initiative_id": request.initiativeId,
              "stage_id": request.workItem.hasStage() ? request.workItem.stage.id : null});

        // Assigned Members Users
        StringBuffer assignedToUsersId = new StringBuffer();
        for (User user in request.workItem.assignedTo) {
          await ctx.query(
              "INSERT INTO initiative.work_item_assigned_users"
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
              "DELETE FROM initiative.work_item_assigned_users"
                  " WHERE work_item_id = @id"
                  " AND user_id NOT IN (${assignedToUsersId.toString()})"
              , substitutionValues: {
            "id": request.workItem.id});
        }

        // Check item list
        StringBuffer checkItemsId = new StringBuffer();
        for (WorkItemCheckItem checkItem in request.workItem.checkItems) {
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
              "work_item_id": request.workItem.id});
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
                  "work_item_id": request.workItem.id});
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

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workItemPreconditionFailed );
        }
        else {

          // HistoryItem
          HistoryItem historyItem;

          Map<String, dynamic> valuesPrevious = previousWorkItem.writeToJsonMap();
          Map<String, dynamic> valuesCurrent = request.workItem.writeToJsonMap();

          historyItem
            ..id = new Uuid().v4()
            ..objectId = request.workItem.id
            ..objectVersion = request.workItem.version
            ..objectClassName = 'WorkItem' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.create.index
          // ..dateTime
            ..description = request.workItem.name
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

  /// Delete a WorkItem by [id]
  static Future<Empty> queryDeleteWorkItem(WorkItemRequest request) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM initiative.work_items work_item"
                " WHERE work_item.id = @id"
            , substitutionValues: {
          "id": request.workItem.id});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }
}