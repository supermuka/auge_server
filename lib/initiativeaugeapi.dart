// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:async';
import 'dart:convert';

import 'package:rpc/rpc.dart';
import 'package:uuid/uuid.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/augeapi.dart';
import 'package:auge_server/objectiveaugeapi.dart';

import 'package:auge_server/model/initiative/initiative.dart';
import 'package:auge_server/model/initiative/state.dart';
import 'package:auge_server/model/initiative/work_item.dart';
import 'package:auge_server/model/initiative/stage.dart';
import 'package:auge_server/model/initiative/work_item_check_item.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/group.dart';

import 'package:auge_server/message_type/id_message.dart';

import 'package:auge_server/shared/rpc_error_message.dart';

/// Api for Initiative Domain
@ApiClass(version: 'v1')
class InitiativeAugeApi {

  InitiativeAugeApi() {
    AugeConnection.createConnection();
  }

  // *** INITIATIVES ***
  static Future<List<Initiative>> queryInitiatives({String organizationId, String id, String objectiveId, bool withWorkItems = false}) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT initiative.id::VARCHAR, " //0
    "initiative.name, " //1
    "initiative.description, " //2
    "initiative.organization_id, " //3
    "initiative.leader_user_id, " //4
    "initiative.objective_id, " //5
    "initiative.group_id" //6
    " FROM auge_initiative.initiatives initiative";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE initiative.id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatement += " WHERE initiative.organization_id = @organization_id";
      substitutionValues = {"organization_id": organizationId};
    }

    if (objectiveId != null) {
      queryStatement += " AND initiative.objective_id = @objective_id";
      substitutionValues.putIfAbsent("objective_id", () => objectiveId);

    }

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: substitutionValues);

    List<Initiative> initiatives = List<Initiative>();
    List<WorkItem> workItems;

    Objective objective;
    Organization organization;
    User user;
    List<User> users;
    List<Stage> stages;
    Group group;
    List<Organization> organizations;
    List<Objective> objectives;
    List<Group> groups;

    for (var row in results) {
      // Work Items
      workItems = (withWorkItems) ? await queryWorkItems(initiativeId: row[0]) : [];
      if (organization == null || organization.id != row[3]) {

        // organization = await _augeApi.getOrganizationById(row[3]);

        organizations = await AugeApi.queryOrganizations(id: row[3]);

        if (organizations.isNotEmpty) {
          organization = organizations.first;
        }
      }

     // user = (await _augeApi.getUsers(id: row[4])).first;
      users = await AugeApi.queryUsers(id: row[4]);

      if (users != null && users.length != 0) {
        user = users.first;
      }

      //stages = await getStages(row[0]);
      stages = await queryStages(initiativeId: row[0]);

      // objective = row[5] == null ? null : await _objectiveAugeApi.getObjectiveById(row[5]);
      objectives = row[5] == null ? null : await ObjectiveAugeApi.queryObjectives(id: row[5]);
      if (objectives != null && objectives.length != 0) {
        objective = objectives.first;
      }

      // group =  row[6] == null ? null : await _augeApi.getGroupById(row[6]);
      groups = row[6] == null ? null : await AugeApi.queryGroups(id: row[6]);
      if (groups != null && groups.length != 0) {
        group = groups.first;
      }

      initiatives.add(new Initiative()..id = row[0]..name = row[1]..description = row[2]..workItems = workItems..organization = organization..leader = user..stages = stages..objective = objective..group = group);
    }
    return initiatives;
  }

  // *** INITIATIVE STATES ***
  static Future<List<State>> queryStates({String id}) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT state.id::VARCHAR, state.name, state.color"
        " FROM auge_initiative.states state";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE state.id = @id";
      substitutionValues = {"id": id};
    }

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: substitutionValues);
    List<State> states = new List();
    for (var row in results) {
      states.add(new State()..id = row[0]..name = row[1]..color = (json.decode(row[2]) as Map).cast<String, int>());
    }

    return states;
  }

  // *** INITIATIVE STAGES ***
  static Future<List<Stage>> queryStages({String initiativeId, String id}) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT stage.id::VARCHAR,"
        " stage.name,"
        " stage.index,"
        " stage.initiative_id,"
        " stage.state_id"
        " FROM auge_initiative.stages stage";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE stage.id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatement += " WHERE stage.initiative_id = @initiative_id";
      substitutionValues = {"initiative_id": initiativeId};
    }

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<Stage> stages = new List();
    for (var row in results) {
      List<State> states = await queryStates(
          id: row[4]);

      stages.add(new Stage()
        ..id = row[0]
        ..name = row[1]
        ..index = row[2]
        ..state = states?.first);
    }
    return stages;
  }

  // *** INITIATIVE WORK ITEMS ***
  static Future<List<WorkItem>> queryWorkItems({String initiativeId, String id}) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_item.id::VARCHAR,"
        " work_item.name,"
        " work_item.description,"
        " work_item.due_date,"
        " work_item.completed,"
        " work_item.stage_id"
        " FROM auge_initiative.work_items work_item"
        " JOIN auge_initiative.stages stage ON stage.id = work_item.stage_id";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE work_item.id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatement += " WHERE work_item.initiative_id = @initiative_id";
      substitutionValues = {"initiative_id": initiativeId};
    }

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItem> workItems = new List();
    List<Stage> stages;
    List<User> assignedToUsers;
    List<WorkItemCheckItem> checkItems;

    for (var row in results) {

      stages = await queryStages(initiativeId: row[0], id: row[5]);

      assignedToUsers = await queryWorkItemAssignedToUsers(row[0]);

      checkItems = await queryWorkItemCheckItems(row[0]);

      workItems.add(new WorkItem()..id = row[0]..name = row[1]..description = row[2]..dueDate = row[3]..completed = row[4]..stage = stages?.first..assignedTo = assignedToUsers..checkItems = checkItems);


    }
    return workItems;
  }

  // *** INITIATIVE WORK ITEMS ASSIGNED ***
  static Future<List<User>> queryWorkItemAssignedToUsers(String workItemId) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_item_assigned_user.user_id::VARCHAR"
        " FROM auge_initiative.work_item_assigned_users work_item_assigned_user";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE work_item_assigned_user.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemId};

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: substitutionValues);

    List<User> assignedToUsers = new List();
    List<User> users;
    User user;

    for (var row in results) {

      users = await AugeApi.queryUsers(id: row[0], withProfile: true);

      if (users != null && users.length != 0) {
        user = users.first;
      }

      assignedToUsers.add(user);
    }

    return assignedToUsers;
  }

  // *** INITIATIVE WORK ITEMS CHECKED ITEMS ***
  static Future<List<WorkItemCheckItem>> queryWorkItemCheckItems(String workItemId) async {

    List<List> results;

    String queryStatement;

    queryStatement = "SELECT check_item.id::VARCHAR, check_item.name, check_item.finished"
        " FROM auge_initiative.work_item_check_items check_item";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE check_item.work_item_id = @work_item_id";
    substitutionValues = {"work_item_id": workItemId};

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: substitutionValues);

    List<WorkItemCheckItem> checkItems = new List();
    for (var row in results) {

      checkItems.add(new WorkItemCheckItem()..id = row[0]..name = row[1]..finished = row[2]);
    }

    return checkItems;
  }

  /// Return all initiatives from an organization
  /// Its possible to filter as a [id] key, [organizationId], [objectiveId] and [withWorkItems]
  @ApiMethod( method: 'GET', path: 'organizations/{organizationId}/initiatives')
  Future<List<Initiative>> getInitiatives(String organizationId, {String objectiveId, bool withWorkItems = false}) async {
    try {
      List<Initiative> initiatives;
      initiatives = await queryInitiatives(organizationId: organizationId, objectiveId: objectiveId, withWorkItems: withWorkItems);
      return initiatives;

      /*
      if (initiatives != null && initiatives.length != 0) {
        return initiatives;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.initiativesDataNotFoundReason));
      }
      */

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
/*
  /// Return an initiative from by Id
  @ApiMethod( method: 'GET', path: 'initiatives/{id}')
  Future<Initiative> getInitiativeById(String id, {bool withWorkItems = false}) async {
    try {
      List<Initiative> initiatives = await queryGetInitiatives(
          id: id, withWorkItems: withWorkItems);
      return initiatives?.first;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
  */

  /// Delete an initiative by [id]
  @ApiMethod( method: 'DELETE', path: 'initiatives/{id}')
  Future<VoidMessage> deleteInitiative(String id) async {
    try {
      await AugeConnection.getConnection().transaction((ctx) async {

        await ctx.query(
            "DELETE FROM auge_initiative.stages stage"
                " WHERE stage.initiative_id = @id"
            , substitutionValues: {
          "id": id});

        await ctx.query(
            "DELETE FROM auge_initiative.initiatives initiative"
                " WHERE initiative.id = @id"
            , substitutionValues: {
          "id": id});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

  }

  /// Return all initiatives states
  @ApiMethod( method: 'GET', path: 'states')
  Future<List<State>> getStates() async {
    try {
      // return queryGetStates();

      List<State> states;
      states = await queryStates();
      return states;

      /*
      if (states != null && states.length != 0) {
        return states;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.statesDataNotFoundReason));
      }
*/
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Return all initiatives states
  @ApiMethod( method: 'GET', path: 'initiatives/{initiativeid}/stages')
  Future<List<Stage>> getStages(String initiativeid) async {
    try {
      //return queryGetStages(initiativeId: initiativeid);

      List<Stage> stages;
      stages = await queryStages(initiativeId: initiativeid);
      return stages;
      /*
      if (stages != null && stages.length != 0) {
        return stages;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.userDataNotFoundReason));
      }
      */

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Create (insert) a new initiative
  @ApiMethod( method: 'POST', path: 'initiatives')
  Future<IdMessage> createInitiative(Initiative initiative) async {

    if (initiative.id == null) {
      initiative.id = new Uuid().v4();
    }

    try {
      await AugeConnection.getConnection().transaction((ctx) async {
        await ctx.query(
            "INSERT INTO auge_initiative.initiatives(id, name, description, organization_id, leader_user_id,  objective_id) VALUES"
                "(@id,"
                "@name,"
                "@description,"
                "@organization_id,"
                "@leader_user_id,"
                "@objective_id,"
                "group_id)"
            , substitutionValues: {
          "id": initiative.id,
          "name": initiative.name,
          "description": initiative.description,
          "organization_id": initiative.organization.id,
          "leader_user_id": initiative.leader.id,
          "objective_id": initiative?.objective,
          "group_id": initiative?.group});

        for (Stage stage in initiative.stages) {
          stage.id = new Uuid().v4();
          await ctx.query(
              "INSERT INTO auge_initiative.stages(id, name, index, state_id, initiative_id) VALUES"
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
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return new IdMessage()..id = initiative.id;
  }

  /// Update an initiative passing an instance of [Initiative]
  @ApiMethod( method: 'PUT', path: 'initiatives')
  Future<VoidMessage> updateInitiative(Initiative initiative) async {


    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query("UPDATE auge_initiative.initiatives "
            " SET name = @name,"
            " description = @description,"
            " organization_id = @organization_id,"
            " leader_user_id = @leader_user_id,"
            " objective_id = @objective_id,"
            " group_id = @group_id"
            " WHERE id = @id"
            , substitutionValues: {
              "id": initiative.id,
              "name": initiative.name,
              "description": initiative.description,
              "organization_id": initiative.organization.id,
              "leader_user_id": initiative.leader.id,
              "objective_id": initiative?.objective.id,
              "group_id": initiative?.group.id});

        // Stages
        StringBuffer stagesId = new StringBuffer();
        for (Stage stage in initiative.stages) {
          if (stage.id == null) {
            stage.id = new Uuid().v4();

            await ctx.query(
                "INSERT INTO auge_initiative.stages(id, name, index, state_id, initiative_id) VALUES"
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
            await ctx.query("UPDATE auge_initiative.stages SET"
                " name = @name,"
                " index = @index,"
                " state_id = @state_id,"
                " work_item_id = @work_item_id,"
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
          await ctx.query("DELETE FROM auge_initiative.stages "
              " WHERE id NOT IN (${stagesId.toString()}) "
              " AND initiative_id  = @initiative_id "
              , substitutionValues: {
                "initiative_id": initiative.id});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  // *** INITIATIVE WORK ITEM ***
/*
  /// Return an initiative from by Id
  @ApiMethod( method: 'GET', path: 'workitems/{id}')
  Future<WorkItem> getWorkItemById(String id) async {
    try {
      List<WorkItem> workItems = await queryGetWorkItems(id: id);
      return workItems?.first;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
  */

  /// Delete an initiative by [id]
  @ApiMethod(method: 'DELETE', path: 'workitems/{id}')
  Future<VoidMessage> deleteWorkItem(String id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge_initiative.work_items work_item"
                " WHERE work_item.id = @id"
            , substitutionValues: {
          "id": id});

      } catch (e) {
          print('${e.runtimeType}, ${e}');
          rethrow;
      }
    });
  }

  /// Create (insert) a new instance of [WorkItem]
  @ApiMethod(method: 'POST', path: 'initiatives/{initiativeId}/workitems')
  Future<IdMessage> createWorkItem(String initiativeId, WorkItem workItem) async {

    if (workItem.id == null) {
      workItem.id = new Uuid().v4();
    }

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query("INSERT INTO auge_initiative.work_items"
            "(id,"
            "name,"
            "description,"
            "due_date,"
            "completed,"
            "initiative_id,"
            "stage_id)"
            "VALUES"
            "(@id,"
            "@name,"
            "@description,"
            "@due_date,"
            "@completed,"
            "@initiative_id,"
            "@stage_id)"
            , substitutionValues: {
              "id": workItem.id,
              "name": workItem.name,
              "description": workItem.description,
              "due_date": workItem.dueDate,
              "completed": workItem.completed,
              "initiative_id": initiativeId,
              "stage_id": workItem.stage.id});

        // Assigned Members Users
        for (User user in workItem.assignedTo) {
          await ctx.query("INSERT INTO auge_initiative.work_item_assigned_users"
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

          await ctx.query("INSERT INTO auge_initiative.work_item_check_items"
              " (id,"
              " name,"
              " finished"
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
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });

    return new IdMessage()..id = workItem.id;
  }

  /// Update an initiative passing an instance of [WorkItem]
  @ApiMethod(method: 'PUT', path: 'initiatives/{initiativeId}/workitems')
  Future<VoidMessage> updateWorkItem(String initiativeId, WorkItem workItem) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query("UPDATE auge_initiative.work_items"
            " SET name = @name,"
            " description = @description,"
            " due_date = @due_date,"
            " completed = @completed,"
            " initiative_id = @initiative_id,"
            " stage_id = @stage_id"
            " WHERE id = @id"
            , substitutionValues: {
              "id": workItem.id,
              "name": workItem.name,
              "description": workItem.description,
              "due_date": workItem.dueDate,
              "completed": workItem.completed,
              "initiative_id": initiativeId,
              "stage_id": workItem.stage.id});

        // Assigned Members Users
        StringBuffer assignedToUsersId = new StringBuffer();
        for (User user in workItem.assignedTo) {
          await ctx.query("INSERT INTO auge_initiative.work_item_assigned_users"
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
          await ctx.query("DELETE FROM auge_initiative.work_item_assigned_users"
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

            await ctx.query("INSERT INTO auge_initiative.work_item_check_items"
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

            await ctx.query("UPDATE auge_initiative.work_item_check_items SET"
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

        if (checkItemsId.isNotEmpty) {
          await ctx.query("DELETE FROM auge_initiative.work_item_check_items"
              " WHERE id NOT IN (${checkItemsId.toString()})");
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }
}
