// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:async';

import 'package:rpc/rpc.dart';
import 'package:uuid/uuid.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/augeapi.dart';

import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/objective/timeline_item.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/group.dart';

import 'package:auge_server/message/created_message.dart';

import 'package:auge_server/shared/rpc_error_message.dart';

//import 'package:auge_shared/message/messages.dart';

/// Api for Objective Domain
@ApiClass(version: 'v1')
class ObjectiveAugeApi {

 // AugeApi _augeApi;

  ObjectiveAugeApi() {
  //  _augeApi = new AugeApi();
    AugeConnection.createConnection();
  }

  String queryStatementCreateTimelineItem =
  "INSERT INTO auge_objective.objective_timeline(id, date_time, system_function_index, class_name, changed_data, comment, user_id, objective_id) VALUES"
  "(@id,"
  "@date_time,"
  "@system_function_index,"
  "@class_name,"
  "@changed_data,"
  "@comment,"
  "@user_id,"
  "@objective_id)";

  Map<String, dynamic> querySubstitutionValuesCreateTimelineItem(String objectiveId, TimelineItem timelineItem) {
      return {"id": timelineItem.id,
              "date_time": timelineItem.dateTime,
              "system_function_index": timelineItem.systemFunctionIndex,
              "class_name": timelineItem.className,
              "changed_data": timelineItem.changedData,
              "comment": timelineItem.comment,
              "user_id": timelineItem.user.id,
              "objective_id": objectiveId};
  }


  // *** MEASURE UNITS ***
  static Future<List<MeasureUnit>> queryMeasureUnits({String id}) async {
    List<MeasureUnit> mesuareUnits = new List();

    mesuareUnits.add(new MeasureUnit()
      ..id = 'f748d3ad-b533-4a2d-b4ae-0ae1e255cf81'
      ..symbol = '%'
      ..name = 'Percent' // MeasureMessage.measureUnitLabel('Percent')
    );
    mesuareUnits.add(new MeasureUnit()
      ..id = 'fad0dc86-0124-4caa-9954-7526814efc3a'
      ..symbol = '\$'
      ..name = 'Money' // MeasureMessage.measureUnitLabel('Money')
    );

    mesuareUnits.add(new MeasureUnit()
      ..id = 'fad0dc86-0124-4caa-9954-7526814efc3a'
      ..symbol = ''
      ..name = 'Index' // MeasureMessage.measureUnitLabel('Index')
    );

    mesuareUnits.add(new MeasureUnit()
      ..id = '723f1387-d5da-44f7-8373-17de31921cae'
      ..symbol = ''
      ..name = 'Unitary' // MeasureMessage.measureUnitLabel('Unitary')
    );

    return mesuareUnits;
  }

  // *** MEASURES ***
  static Future<List<Measure>> queryMeasures({String objectiveId, String id}) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id::VARCHAR, name, description, metric, decimals_number, start_value::REAL, end_value::REAL, current_value::REAL, measure_unit_id"
        " FROM auge_objective.measures ";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatement += " WHERE objective_id = @objective_id";
      substitutionValues = {"objective_id": objectiveId};
    }

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<Measure> mesuares = new List();
    List<MeasureUnit> measureUnits;

    if (results != null && results.isNotEmpty) {

      MeasureUnit measureUnit;

      for (var row in results) {

        if (row[8] != null)
         //  measureUnit = await getMeasureUnitById(row[8]);
          measureUnits = await queryMeasureUnits(id: row[8]);
          if (measureUnits != null && measureUnits.length != 0) {
            measureUnit = measureUnits.first;
          }
        else
          measureUnit = null;

        mesuares.add(new Measure()
          ..id = row[0]
          ..name = row[1]
          ..description = row[2]
          ..metric = row[3]
          ..decimalsNumber = row[4]
          ..startValue = row[5]
          ..endValue = row[6]
          ..currentValue = row[7]
          ..measureUnit = measureUnit);
      }
    }
    return mesuares;
  }

  /// Delete a [Measure] by id
  @ApiMethod( method: 'DELETE', path: 'measures/{id}')
  Future<VoidMessage> deleteMeasure(String id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge_objective.measures measure"
                " WHERE measure.id = @id"
            , substitutionValues: {
          "id": id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return null;
  }


  /// Return a [Measure] by Id
  @ApiMethod( method: 'GET', path: 'measures/{id}')
  Future<Measure> getMeasureById(String id) async {
    try {
      List<Measure> measures = await queryMeasures(id: id);
      if (measures == null || measures.length == 0) {
        throw new RpcError(204,  'DataNotFound', 'Data not Found')
          ..errors.add(new RpcErrorDetail(reason: 'MeasuereDataNotFound'));
      }
      return measures?.first;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }



  /// Return [Measure] list
  @ApiMethod( method: 'GET', path: 'objetives/{objectiveId}/measures')
  Future<List<Measure>> getMeasures(String objectiveId) async {
    try {

      List<Measure> measures;
      measures = await queryMeasures(objectiveId: objectiveId);
      return measures;
      /*
      if (measures != null && measures.length != 0) {
        return measures;
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

  /// Return all [MeasureUnit]
  @ApiMethod( method: 'GET', path: 'measure_units')
  Future<List<MeasureUnit>> getMeasureUnits() async {
    try {
     // return  await queryGetMeasureUnits();

      List<MeasureUnit> measureUnits;
      measureUnits = await queryMeasureUnits();
      return measureUnits;
      /*
      if (measureUnits != null && measureUnits.length != 0) {
        return measureUnits;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.measureUnitsDataNotFoundReason));
      }
      */


    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
/*
  /// Return a [MeasureUnit] by Id
  @ApiMethod( method: 'GET', path: 'measure_units/{id}')
  Future<MeasureUnit> getMeasureUnitById(String id) async {
    try {
      List<MeasureUnit> measureUnits = await queryGetMeasureUnits(id: id);
      return measureUnits?.first;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
  */

  /// Create (insert) a new measures
  @ApiMethod( method: 'POST', path: 'objetives/{objectiveid}/measures')
  Future<IdMessage> createMeasure(String objectiveid, Measure measure) async {

    if (measure.id == null) {
      measure.id = new Uuid().v4();
    }

    try {

      await AugeConnection.getConnection().transaction((ctx) async {
        await ctx.query(
            "INSERT INTO auge_objective.measures(id, name, description, metric, decimals_number, start_value, end_value, current_value, measure_unit_id, objective_id) VALUES"
                "(@id,"
                "@name,"
                "@description,"
                "@metric,"
                "@decimals_number,"
                "@start_value,"
                "@end_value,"
                "@current_value,"
                "@measure_unit_id,"
                "@objective_id)"
            , substitutionValues: {
          "id": measure.id,
          "name": measure.name,
          "description": measure.description,
          "metric": measure.metric,
          "decimals_number": measure.decimalsNumber,
          "start_value": measure.startValue,
          "end_value": measure.endValue,
          "current_value": measure.currentValue,
          "measure_unit_id": measure?.measureUnit?.id,
          "objective_id": objectiveid
        });
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdMessage()..id = measure.id;
  }

  // *** MEASURES PROGRESS ***
  static Future<List<MeasureProgress>> queryMeasureProgress({String measureId, String id}) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id::VARCHAR, date_time, current_value, comment, measure_id"
        " FROM auge_objective.measure_progress ";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatement += " WHERE measure_id = @measure_id";
      substitutionValues = {"measure_id": measureId};
    }

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<MeasureProgress> mesuareProgress = new List();

    if (results != null && results.isNotEmpty) {

      for (var row in results) {

        mesuareProgress.add( MeasureProgress()
          ..id = row[0]
          ..dateTime = row[1]
          ..currentValue = row[2]
          ..comment = row[3]);
      }
    }
    return mesuareProgress;
  }

  /// Update current value of the [MeasureProgress]
  @ApiMethod( method: 'POST', path: 'measures/{measureId}/progress')
  Future<IdMessage> createMeasureProgress(String measureId, MeasureProgress measureProgress) async {
    try {
      await AugeConnection.getConnection().transaction((ctx) async {

        await ctx.query(
            "UPDATE auge_objective.measures SET current_value = @current_value WHERE id = @measure_id", substitutionValues: {
          "current_value": measureProgress.currentValue,
          "measure_id": measureId});

        if (measureProgress.id == null) {
          measureProgress.id = new Uuid().v4();
        }

        if (measureProgress.dateTime == null) {
          measureProgress.dateTime = DateTime.now().toUtc();
        }

        await ctx.query(
            "INSERT INTO auge_objective.measure_progress(id, date_time, current_value, comment, measure_id) VALUES"
                "(@id,"
                "@date_time,"
                "@current_value,"
                "@comment,"
                "@measure_id)"
            , substitutionValues: {
          "id": measureProgress.id,
          "date_time": measureProgress.dateTime,
          "current_value": measureProgress.currentValue,
          "comment": measureProgress.comment,
          "measure_id": measureId});

      });
    } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
    }
    return IdMessage()..id = measureProgress.id;
  }


  /// Return [MeasureProgress] list by [Measure.id]
  @ApiMethod( method: 'GET', path: 'measures/{measureId}/progress')
  Future<List<MeasureProgress>> getMeasureProgress(String measureId) async {
    try {

      List<MeasureProgress> measureProgress;
      measureProgress = await queryMeasureProgress(measureId: measureId);
      return measureProgress;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }


  /// Update [Measure]
  @ApiMethod( method: 'PUT', path: 'objetives/{objectiveid}/measures')
  Future<VoidMessage> updateMeasure(String objectiveid, Measure measure) async {
    try {
      await  AugeConnection.getConnection().query("UPDATE auge_objective.measures "
          " SET name = @name,"
          " description = @description,"
          " metric = @metric,"
          " decimals_number = @decimals_number,"
          " start_value = @start_value,"
          " end_value = @end_value,"
          " current_value = @current_value,"
          " objective_id = @objective_id,"
          " measure_unit_id = @measure_unit_id"
          " WHERE id = @id"
          , substitutionValues: {
            "id": measure.id,
            "name": measure.name,
            "description": measure.description,
            "metric": measure.metric,
            "decimals_number": measure.decimalsNumber,
            "start_value": measure.startValue,
            "end_value": measure.endValue,
            "current_value": measure.currentValue,
            "measure_unit_id": measure?.measureUnit?.id,
            "objective_id": objectiveid
          });

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return null;
  }

  // *** OBJECTIVES ***
  // alignedToRecursiveDeep: 0 not call; 1 call once; 2 call tow, etc...
  static Future<List<Objective>> queryObjectives({String organizationId, String id, int alignedToRecursive = 1, bool withMeasures = true, bool treeAlignedWithChildren = false, bool withProfile = false, bool withTimeline = false, bool withArchived = false}) async {
    List<List> results;

   // String queryStatementColumns = "objective.id::VARCHAR, objective.name, objective.description, objective.start_date, objective.end_date, objective.leader_user_id, objective.aligned_to_objective_id";
    String queryStatementColumns = "objective.id," //0
    " objective.name," //1
    " objective.description," //2
    " objective.start_date," //3
    " objective.end_date," //4
    " objective.archived," //5
    " objective.leader_user_id," //6
    " objective.aligned_to_objective_id," //7
    " objective.organization_id," //8
    " objective.group_id"; //9

    String queryStatementWhere = "";
    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatementWhere = " objective.id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatementWhere = " objective.organization_id = @organization_id";
      substitutionValues = {"organization_id": organizationId};
    }

    if (!withArchived) {
      queryStatementWhere = queryStatementWhere + " AND objective.archived <> true";
    }

    String queryStatement;
    if (treeAlignedWithChildren) {
      queryStatement =
          "WITH RECURSIVE nodes(" + queryStatementColumns.replaceAll("objective.", "") + ") AS ("
              " SELECT " + queryStatementColumns +
              " FROM auge_objective.objectives objective WHERE " +
              queryStatementWhere + " AND objective.aligned_to_objective_id is null"
              " UNION"
              " SELECT " + queryStatementColumns +
              " FROM auge_objective.objectives objective, nodes node WHERE " +
              queryStatementWhere + " AND objective.aligned_to_objective_id = node.id"
              " )"
              " SELECT " + queryStatementColumns.replaceAll("objective.", "") + " FROM nodes";
    }
    else {
        queryStatement = "SELECT " + queryStatementColumns +
            " FROM auge_objective.objectives objective"
                " WHERE " + queryStatementWhere;
    }

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<Objective> objectives = new List();
    List<Objective> objectivesTree = new List();

    if (results != null && results.isNotEmpty) {

      Organization organization; // = await _augeApi.getOrganizationById(organizationId);

      List<Measure> measures;
      List<TimelineItem> timeline;
      User leaderUser;
      Objective alignedToObjective;
      List<Objective> alignedToObjectives;

      Objective objective;
      Group group;

      List<Organization> organizations;
      List<User> users;
      List<Group> groups;

      for (var row in results) {
        // Measures

        if (organization == null || organization.id != row[8]) {

          organizations = await AugeApi.queryOrganizations(id: row[8]);
          if (organizations != null && organizations.length != 0) {
            organization = organizations.first;
          }
        }

        measures = (withMeasures) ? await queryMeasures(objectiveId: row[0]) : [];
        timeline = (withTimeline) ? await queryTimeline(objectiveId: row[0]) : [];

        users = await AugeApi.queryUsers(id: row[6], withProfile: withProfile);

        if (users != null && users.length != 0) {
          leaderUser = users.first;
        }
        ///leaderUser = (await AugeApi.getUsers(id: row[5], withProfile: withProfile)).first;

        if (row[7] != null && alignedToRecursive > 0) {
          alignedToObjectives = await queryObjectives(id: row[7],
              alignedToRecursive: --alignedToRecursive);
          alignedToObjective = alignedToObjectives?.first;
        }

        //group = row[8] == null ? null : await _augeApi.getGroupById(row[8]);
        groups = await AugeApi.queryGroups(id: row[9]);
        if (groups != null && groups.length != 0) {
          group = groups.first;
        }

        objective = new Objective()
          ..id = row[0]
          ..name = row[1]
          ..description = row[2]
          ..startDate = row[3]
          ..endDate = row[4]
          ..archived = row[5]
          ..organization = organization
          ..leader = leaderUser
          ..measures = measures
          ..alignedTo = alignedToObjective
          ..group = group
          ..timeline = timeline
          ..lastTimelineItem = timeline.length == 0 ? null : timeline.first;
        objectives.add(objective);

        if (treeAlignedWithChildren) {
          // Parent must be present in the list (objectives);
          if (row[7] == null)
             objectivesTree.add(objective);
          else {
            objectives
                .singleWhere((o) => o.id == row[7])
                ?.alignedWithChildren
                ?.add(objective);
          }
         // objectives.singleWhere((o) => o.id == objective.alignedTo, orElse: )?.alignedWithChildren?.add(objective);
        } else {

        }
      }
    }
    return (treeAlignedWithChildren) ? objectivesTree ?? [] : objectives ?? [];
  }

  /// Return all objectives from an organization
  @ApiMethod( method: 'GET', path: 'organization/{organizationId}/objetives')
  Future<List<Objective>> getObjectives(String organizationId, {String id, bool withMeasures = false, bool treeAlignedWithChildren = false, bool withProfile = false, bool withTimeline = false, bool withArchived = false}) async {
    try {
      // return queryGetObjectives(organizationId: organizationId, withMeasures: withMeasures, treeAlignedWithChildren: treeAlignedWithChildren, withProfile: withProfile);

      List<Objective> objectives;
      objectives = await queryObjectives(organizationId: organizationId, withMeasures: withMeasures, treeAlignedWithChildren: treeAlignedWithChildren, withProfile: withProfile, withTimeline: withTimeline, withArchived: withArchived);
      return objectives;
      /*
      if (objectives != null && objectives.length != 0) {
        return objectives;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.objectivesDataNotFoundReason));
      }
      */
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }


  /// Return an [Objective] from an organization by Id
  @ApiMethod( method: 'GET', path: 'objectives/{id}')
  Future<Objective> getObjectiveById(String id, {bool withMeasures = false}) async {
    try {
      List<Objective> objectives = await queryObjectives(id: id, withMeasures: withMeasures);

      if (objectives != null && objectives.length != 0) {
        return objectives.first;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.objectiveDataNotFoundReason));
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Delete an objective by [id]
  @ApiMethod( method: 'DELETE', path: 'objectives/{id}')
  Future<VoidMessage> deleteObjective(String id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge_objective.objective_timeline objective_timeline"
                " WHERE objective_timeline.objective_id = @id"
            , substitutionValues: {
          "id": id});

        await ctx.query(
            "DELETE FROM auge_objective.objectives objective"
                " WHERE objective.id = @id"
            , substitutionValues: {
          "id": id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return null;
  }

    /// Create (insert) a new objective
  @ApiMethod( method: 'POST', path: 'objectives')
  Future<Objective> createObjective(Objective objective) async {

    if (objective.id == null) {
      objective.id = new Uuid().v4();
    }

    try {

      await AugeConnection.getConnection().transaction((ctx) async {

        await ctx.query("INSERT INTO auge_objective.objectives(id, name, description, start_date, end_date, archived, aligned_to_objective_id, organization_id, leader_user_id, group_id) VALUES"
            "(@id,"
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
        "id": objective.id,
        "name": objective.name,
        "description": objective.description,
        "start_date": objective.startDate,
        "end_date": objective.endDate,
        "archived": objective.archived,
        "aligned_to_objective_id": objective.alignedTo == null ? null : objective.alignedTo.id ,
        "organization_id": objective.organization.id,
        "leader_user_id": objective.leader == null ? null : objective.leader.id,
        "group_id": objective.group == null ? null : objective.group.id });

        // TimelineItem
        if (objective.lastTimelineItem.id == null) {
          objective.lastTimelineItem.id = new Uuid().v4();
        }
        if (objective.lastTimelineItem.dateTime == null) {
          objective.lastTimelineItem.dateTime = DateTime.now().toUtc();
        }

        await ctx.query(queryStatementCreateTimelineItem, substitutionValues: querySubstitutionValuesCreateTimelineItem(objective.id, objective.lastTimelineItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return (await queryObjectives(id: objective.id, withTimeline: true, withMeasures: true, withProfile: true, withArchived: true))?.first;
  }

  /// Update an initiative passing an instance of [Objective]
  @ApiMethod( method: 'PUT', path: 'objectives')
  Future<Objective> updateObjective(Objective objective) async {

    try {

      await AugeConnection.getConnection().transaction((ctx) async {
        await ctx.query(
            "UPDATE auge_objective.objectives "
                " SET name = @name,"
                " description = @description,"
                " start_date = @start_date,"
                " end_date = @end_date,"
                " archived = @archived,"
                " aligned_to_objective_id = @aligned_to_objective_id,"
                " organization_id = @organization_id,"
                " leader_user_id = @leader_user_id,"
                " group_id = @group_id"
                " WHERE id = @id"
            , substitutionValues: {
          "id": objective.id,
          "name": objective.name,
          "description": objective.description,
          "start_date": objective.startDate,
          "end_date": objective.endDate,
          "archived": objective.archived,
          "aligned_to_objective_id": objective.alignedTo == null ? null : objective.alignedTo.id,
          "organization_id": objective.organization.id,
          "leader_user_id": objective.leader == null ? null : objective.leader.id,
          "group_id": objective.group == null ? null : objective.group.id});

        // TimelineItem
        if (objective.lastTimelineItem.id == null) {
          objective.lastTimelineItem.id = new Uuid().v4();
        }
        if (objective.lastTimelineItem.dateTime == null) {
          objective.lastTimelineItem.dateTime = DateTime.now().toUtc();
        }

        await ctx.query(queryStatementCreateTimelineItem, substitutionValues: querySubstitutionValuesCreateTimelineItem(objective.id, objective.lastTimelineItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return (await queryObjectives(id: objective.id, withTimeline: true, withMeasures: true, withProfile: true, withArchived: true))?.first;
  }

  // *** OBJECTIVE TIMELINE ***
  static Future<List<TimelineItem>> queryTimeline({String objectiveId, String id}) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id::VARCHAR," //0
        " date_time," //1
        " system_function_index," //2
        " class_name," //3
        " changed_data,"  //4
        " comment,"  //5
        " user_id," //6
        " objective_id" //7
        " FROM auge_objective.objective_timeline ";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatement += " WHERE objective_id = @objective_id";
      substitutionValues = {"objective_id": objectiveId};
    }

    queryStatement += " ORDER BY date_time DESC ";

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<TimelineItem> objectiveTimeline = new List();
    List<User> users;

    User user;

    if (results != null && results.isNotEmpty) {

      for (var row in results) {

        users = await AugeApi.queryUsers(id: row[6], withProfile: true);

        if (users != null && users.length != 0) {
          user = users.first;
        } else {
          user = null;
        }

        objectiveTimeline.add(new TimelineItem()
          ..id = row[0]
          ..dateTime = row[1]
          ..systemFunctionIndex = row[2]
          ..className = row[3]
          ..changedData = row[4]
          ..comment = row[5]
          ..user = user);
      }
    }
    return objectiveTimeline;
  }
}