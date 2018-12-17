// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:async';
import 'dart:convert';

import 'package:rpc/rpc.dart';
import 'package:uuid/uuid.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/augeapi.dart';

import 'package:auge_server/model/authorization.dart';
import 'package:auge_server/model/history_item.dart';
import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/group.dart';

import 'package:auge_server/message/created_message.dart';

import 'package:auge_server/shared/rpc_error_message.dart';

/// Api for Objective Domain
@ApiClass(version: 'v1')
class ObjectiveAugeApi {

  ObjectiveAugeApi() {
    AugeConnection.createConnection();
  }

  // History to auge_objective schema
  String queryStatementCreateHistoryItem = "INSERT INTO auge_objective.history(id, object_id, object_version, object_class_name, system_function_index, date_time, user_id, description, changed_values) VALUES"
        "(@id,"
        "@object_id,"
        "@object_version,"
        "@object_class_name,"
        "@system_function_index,"
        "@date_time,"
        "@user_id,"
        "@description,"
        "@changed_values)";


  Map<String, dynamic> querySubstitutionValuesCreateHistoryItem(HistoryItem historyItem) {
      return {"id": historyItem.id,
              "date_time": historyItem.dateTime,
              "system_function_index": historyItem.systemFunctionIndex,
              "changed_values": historyItem.changedValues,
              "description": historyItem.description,
              "user_id": historyItem.user.id,
              "object_id": historyItem.objectId,
              "object_version": historyItem.objectVersion,
              "object_class_name": historyItem.objectClassName};
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
  static Future<List<Measure>> queryMeasures({String objectiveId, String id, bool isDeleted = false}) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id::VARCHAR," //0
    " version, " //1
    " name," //2
    " description," //3
    " metric," //4
    " decimals_number," //5
    " start_value::REAL," //6
    " end_value::REAL," //7
    " (select current_value from auge_objective.measure_progress where measure_progress.measure_id = measure.id order by date desc limit 1)::REAL as current_value," //8
    " measure_unit_id," //9
    " is_deleted" //10
    " FROM auge_objective.measures measure ";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE id = @id AND is_deleted = @is_deleted";
      substitutionValues = {"id": id, "is_deleted": isDeleted};
    } else {
      queryStatement += " WHERE objective_id = @objective_id AND is_deleted = @is_deleted";
      substitutionValues = {"objective_id": objectiveId, "is_deleted": isDeleted};
    }

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<Measure> mesuares = new List();
    List<MeasureUnit> measureUnits;

    if (results != null && results.isNotEmpty) {

      MeasureUnit measureUnit;

      for (var row in results) {

        if (row[9] != null)
         //  measureUnit = await getMeasureUnitById(row[8]);
          measureUnits = await queryMeasureUnits(id: row[9]);
          if (measureUnits != null && measureUnits.length != 0) {
            measureUnit = measureUnits.first;
          }
        else
          measureUnit = null;

        Measure measure = Measure();

        measure
          ..id = row[0]
          ..version = row[1]
          ..name = row[2]
          ..description = row[3]
          ..metric = row[4]
          ..decimalsNumber = row[5]
          ..startValue = row[6]
          ..endValue = row[7]
          ..currentValue = row[8]
          ..measureUnit = measureUnit
          ..isDeleted = row[10];
        mesuares.add(measure);
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
  Future<List<Measure>> getMeasures(String objectiveId, {bool isDeleted = false}) async {
    try {

      List<Measure> measures;
      measures = await queryMeasures(objectiveId: objectiveId, isDeleted: isDeleted);
      return measures;

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

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Create (insert) a new measures
  @ApiMethod( method: 'POST', path: 'objetives/{objectiveId}/measures')
  Future<IdMessage> createMeasure(String objectiveId, Measure measure) async {

    if (measure.id == null) {
      measure.id = new Uuid().v4();
    }

    try {
      await AugeConnection.getConnection().transaction((ctx) async {

        measure.version = 0;
        await ctx.query(
            "INSERT INTO auge_objective.measures(id, version, name, description, metric, decimals_number, start_value, end_value, measure_unit_id, objective_id, is_deleted) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@description,"
                "@metric,"
                "@decimals_number,"
                "@start_value,"
                "@end_value,"
                "@measure_unit_id,"
                "@objective_id,"
                "@is_deleted)"
            , substitutionValues: {
          "id": measure.id,
          "version": measure.version,
          "name": measure.name,
          "description": measure.description,
          "metric": measure.metric,
          "decimals_number": measure.decimalsNumber,
          "start_value": measure.startValue,
          "end_value": measure.endValue,
          "measure_unit_id": measure?.measureUnit?.id,
          "objective_id": objectiveId,
          "is_deleted": measure.isDeleted,
        });

        // HistoryItem - server-side generation
        measure.lastHistoryItem.setServerSideValues(id: new Uuid().v4(),
          objectId: measure.id,
          objectVersion: measure.version,
          objectClassName: measure.runtimeType.toString(),
          systemFunctionIndex: SystemFunction.create.index,
          dateTime: DateTime.now().toUtc());

        // Create a history item
        await ctx.query(queryStatementCreateHistoryItem, substitutionValues: querySubstitutionValuesCreateHistoryItem(measure.lastHistoryItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdMessage()..id = measure.id;
  }

  // *** MEASURES PROGRESS ***
  static Future<List<MeasureProgress>> queryMeasureProgress({String measureId, String id, bool isDeleted = false, bool withAuditUser = false}) async {


    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id::VARCHAR," // 0
    " version,"//1
    " date," //2
    " current_value," //3
    " comment," //4
    " measure_id" //5
    " FROM auge_objective.measure_progress ";

    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatement += " WHERE id = @id AND auge_objective.measure_progress.is_deleted = @is_deleted";
      substitutionValues = {"id": id, "is_deleted": isDeleted};
    } else {
      queryStatement += " WHERE measure_id = @measure_id AND auge_objective.measure_progress.is_deleted = @is_deleted";
      substitutionValues = {"measure_id": measureId, "is_deleted": isDeleted};
    }

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<MeasureProgress> mesuareProgresses = new List();

    if (results != null && results.isNotEmpty) {

      for (var row in results) {

        MeasureProgress measureProgress = MeasureProgress()..id = row[0]
          ..version = row[1]
          ..date = row[2]
          ..currentValue = row[3]
          ..comment = row[4];

        mesuareProgresses.add(measureProgress);
      }
    }
    return mesuareProgresses;
  }

  /// Create current value of the [MeasureProgress]
  @ApiMethod( method: 'POST', path: 'measures/{measureId}/progress')
  Future<IdMessage> createMeasureProgress(String measureId, MeasureProgress measureProgress) async {
    try {

      await AugeConnection.getConnection().transaction((ctx) async {

        if (measureProgress.id == null) {
          measureProgress.id = new Uuid().v4();
        }

        measureProgress.version = 0;

        await ctx.query(
            "INSERT INTO auge_objective.measure_progress(id, version, date, current_value, comment, measure_id, is_deleted) VALUES"
                "(@id,"
                "@version,"
                "@date,"
                "@current_value,"
                "@comment,"
                "@measure_id,"
                "@is_deleted)"
            , substitutionValues: {
          "id": measureProgress.id,
          "version": measureProgress.version,
          "date": measureProgress.date,
          "current_value": measureProgress.currentValue,
          "comment": measureProgress.comment,
          "measure_id": measureId,
          "is_deleted": false,
          });

        // HistoryItem - server-side generation
        measureProgress.lastHistoryItem.setServerSideValues(id: new Uuid().v4(),
            objectId: measureProgress.id,
            objectVersion: measureProgress.version,
            objectClassName: measureProgress.runtimeType.toString(),
            systemFunctionIndex: SystemFunction.create.index,
            dateTime: DateTime.now().toUtc());

        // Create a history item
        await ctx.query(queryStatementCreateHistoryItem, substitutionValues: querySubstitutionValuesCreateHistoryItem(measureProgress.lastHistoryItem));

      });

    } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
    }
    return IdMessage()..id = measureProgress.id;
  }

  /// Create current value of the [MeasureProgress]
  @ApiMethod( method: 'PUT', path: 'measures/{measureId}/progress')
  Future<VoidMessage> updateMeasureProgress(String measureId,  MeasureProgress measureProgress) async {
    try {

      DateTime dateTimeNow = DateTime.now().toUtc();

      await AugeConnection.getConnection().transaction((ctx) async {

        DateTime dateTimeNow = DateTime.now().toUtc();

        List<List<dynamic>> result;

        // Soft delete
        if (measureProgress.isDeleted) {

          result = await ctx.query(
              "UPDATE auge_objective.measure_progress "
                  "SET is_deleted = @is_deleted, "
                  "version = @version + 1"
                  "WHERE id = @id AND version = @version "
                  "RETURNING true"
              , substitutionValues: {
            "id": measureProgress.id,
            "version": measureProgress.version,
            "is_deleted": measureProgress.isDeleted,});

        } else {

          if (measureProgress.id == null) {
            measureProgress.id = new Uuid().v4();
          }

          if (measureProgress.date == null) {
            measureProgress.date = dateTimeNow;
          }

          result = await ctx.query(
              "UPDATE auge_objective.measure_progress "
                  "SET date = @date, "
                  "current_value = @current_value, "
                  "comment = @comment, "
                  "measure_id = @measure_id, "
                  "version = @version + 1"
                  "WHERE id = @id AND version = @version "
                  "RETURNING true"
              , substitutionValues: {
            "id": measureProgress.id,
            "version": measureProgress.version,
            "date": measureProgress.date,
            "current_value": measureProgress.currentValue,
            "comment": measureProgress.comment,
            "measure_id": measureId,

            });

          // Optimistic concurrency control
          if (result.isEmpty) {
            throw new RpcError(412, 'PreconditionFailed', 'Precondition Failed')
              ..errors.add(
                  new RpcErrorDetail(reason: RpcErrorDetailMessage
                      .measureProgressUpdatePreconditionFailed));
          }
        }

        measureProgress.lastHistoryItem.setServerSideValues(id: new Uuid().v4(),
            objectId: measureProgress.id,
            objectVersion: measureProgress.version,
            objectClassName: measureProgress.runtimeType.toString(),
            systemFunctionIndex: SystemFunction.update.index,
            dateTime: DateTime.now().toUtc());

        // Create a history item
        await ctx.query(queryStatementCreateHistoryItem, substitutionValues: querySubstitutionValuesCreateHistoryItem(measureProgress.lastHistoryItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return null;
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

  /// Return [MeasureProgress] list by ID [MeasureProgress.id]
  @ApiMethod( method: 'GET', path: 'progress/{measureProgressId}')
  Future<MeasureProgress> getMeasureProgressById(String measureProgressId) async {
    try {
      List<MeasureProgress> measureProgress;
      measureProgress = await queryMeasureProgress(id: measureProgressId);

      if (measureProgress != null && measureProgress.length != 0) {
        return measureProgress.first;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.measureDataNotFoundReason));
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Update [Measure]
  @ApiMethod( method: 'PUT', path: 'objetives/{objectiveId}/measures')
  Future<VoidMessage> updateMeasure(String objectiveId, Measure measure) async {
    try {
      await AugeConnection.getConnection().transaction((ctx) async {

        List<List<dynamic>> result;

        // Soft delete
        if (measure.isDeleted) {
          result = await ctx.query("UPDATE auge_objective.measures "
              " SET version = @version + 1,"
              " is_deleted = @is_deleted"
              " WHERE id = @id and version = @version"
              " RETURNING true"
              , substitutionValues: {
                "id": measure.id,
                "version": measure.version,
                "is_deleted": measure.isDeleted,
              });
        } else {
          result = await ctx.query("UPDATE auge_objective.measures "
              " version = @version + 1"
              " SET name = @name,"
              " description = @description,"
              " metric = @metric,"
              " decimals_number = @decimals_number,"
              " start_value = @start_value,"
              " end_value = @end_value,"
              " current_value = @current_value,"
              " objective_id = @objective_id,"
              " measure_unit_id = @measure_unit_id,"
              " is_deleted = @is_deleted"
              " WHERE id = @id and version = @version"
              " RETURNING true"
              , substitutionValues: {
                "id": measure.id,
                "version": measure.version,
                "name": measure.name,
                "description": measure.description,
                "metric": measure.metric,
                "decimals_number": measure.decimalsNumber,
                "start_value": measure.startValue,
                "end_value": measure.endValue,
                "current_value": measure.currentValue,
                "measure_unit_id": measure?.measureUnit?.id,
                "objective_id": objectiveId,
                "is_deleted": measure.isDeleted,
              });
        }

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new RpcError(412, 'PreconditionFailed', 'Precondition Failed')
            ..errors.add(
                new RpcErrorDetail(reason: 'MeasureUpdatePreconditionFailed'));
        } else {

          // Create a history item
          measure.lastHistoryItem.setServerSideValues(id: new Uuid().v4(),
              objectId: measure.id,
              objectVersion: measure.version,
              objectClassName: measure.runtimeType.toString(),
              systemFunctionIndex: measure.isDeleted ? SystemFunction.delete.index : SystemFunction.update.index,
              dateTime: DateTime.now().toUtc());

          await ctx.query(queryStatementCreateHistoryItem, substitutionValues: querySubstitutionValuesCreateHistoryItem(measure.lastHistoryItem));
        }
      });

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return null;
  }

  // *** OBJECTIVES ***
  // alignedToRecursiveDeep: 0 not call; 1 call once; 2 call tow, etc...
  static Future<List<Objective>> queryObjectives({String organizationId, String id, int alignedToRecursive = 1, bool withMeasures = true, bool treeAlignedWithChildren = false, bool withProfile = false, bool withHistory = false, bool withArchived = false}) async {
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
      List<HistoryItem> history;
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

        if (organization == null || organization.id != row[9]) {

          organizations = await AugeApi.queryOrganizations(id: row[9]);
          if (organizations != null && organizations.length != 0) {
            organization = organizations.first;
          }
        }

        measures = (withMeasures) ? await queryMeasures(objectiveId: row[0]) : [];
        history = (withHistory) ? await queryHistory(row[0]) : [];
        users = await AugeApi.queryUsers(id: row[7], withProfile: withProfile);

        if (users != null && users.length != 0) {
          leaderUser = users.first;
        }
        ///leaderUser = (await AugeApi.getUsers(id: row[5], withProfile: withProfile)).first;
        if (row[8] != null && alignedToRecursive > 0) {
          alignedToObjectives = await queryObjectives(id: row[8],
              alignedToRecursive: --alignedToRecursive);
          alignedToObjective = alignedToObjectives?.first;
        }
        //group = row[8] == null ? null : await _augeApi.getGroupById(row[8]);
        groups = await AugeApi.queryGroups(id: row[10]);
        if (groups != null && groups.length != 0) {
          group = groups.first;
        }

        objective = new Objective()
          ..id = row[0]
          ..version = row[1]
          ..name = row[2]
          ..description = row[3]
          ..startDate = row[4]
          ..endDate = row[5]
          ..archived =  row[6]
          ..organization = organization
          ..leader = leaderUser
          ..measures = measures
          ..alignedTo = alignedToObjective
          ..group = group
          ..history = history;

        objectives.add(objective);

        if (treeAlignedWithChildren) {
          // Parent must be present in the list (objectives);
          if (row[8] == null)
             objectivesTree.add(objective);
          else {
            objectives
                .singleWhere((o) => o.id == row[8])
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
  Future<List<Objective>> getObjectives(String organizationId, {bool withMeasures = false, bool treeAlignedWithChildren = false, bool withProfile = false, bool withHistory = false, bool withArchived = false}) async {
    try {
      // return queryGetObjectives(organizationId: organizationId, withMeasures: withMeasures, treeAlignedWithChildren: treeAlignedWithChildren, withProfile: withProfile);

      List<Objective> objectives;
      objectives = await queryObjectives(organizationId: organizationId, withMeasures: withMeasures, treeAlignedWithChildren: treeAlignedWithChildren, withProfile: withProfile, withHistory: withHistory, withArchived: withArchived);
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
  Future<Objective> getObjectiveById(String id, {bool withMeasures = false, bool withProfile = false, bool withHistory = false, bool withArchived = false}) async {
    try {
      List<Objective> objectives = await queryObjectives(id: id, withMeasures: withMeasures, withProfile: withProfile, withHistory: withHistory, withArchived: withArchived);

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
  Future<IdMessage> createObjective(Objective objective) async {
    if (objective.id == null) {
      objective.id = new Uuid().v4();
    }

    DateTime dateTimeNow = DateTime.now().toUtc();

    try {
      await AugeConnection.getConnection().transaction((ctx) async {
        await ctx.query("INSERT INTO auge_objective.objectives(id, version, name, description, start_date, end_date, archived, aligned_to_objective_id, organization_id, leader_user_id, group_id, is_deleted) VALUES"
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
            "@group_id,"
            "@is_deleted)"
        , substitutionValues: {
        "id": objective.id,
        "version": 0,
        "name": objective.name,
        "description": objective.description,
        "start_date": objective.startDate,
        "end_date": objective.endDate,
        "archived": objective.archived,
        "aligned_to_objective_id": objective.alignedTo == null ? null : objective.alignedTo.id ,
        "organization_id": objective.organization.id,
        "leader_user_id": objective.leader == null ? null : objective.leader.id,
        "group_id": objective.group == null ? null : objective.group.id,
        "is_deleted": objective.isDeleted,
        });

        // HistoryItem
        objective.lastHistoryItem.setServerSideValues(id: new Uuid().v4(),
            objectId: objective.id,
            objectVersion: objective.version,
            objectClassName: objective.runtimeType.toString(),
            systemFunctionIndex: SystemFunction.create.index,
            dateTime: DateTime.now().toUtc());
        // Create a history item
        await ctx.query(queryStatementCreateHistoryItem, substitutionValues: querySubstitutionValuesCreateHistoryItem(objective.lastHistoryItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return IdMessage()..id = objective.id;
  }

  /// Update an initiative passing an instance of [Objective]
  @ApiMethod( method: 'PUT', path: 'objectives')
  Future<IdMessage> updateObjective(Objective objective) async {

    try {


      List<List<dynamic>> result;
      await AugeConnection.getConnection().transaction((ctx) async {
        if (objective.isDeleted) {
          result = await ctx.query("UPDATE auge_objective.objectives "
              " SET version = @version + 1, "
              " is_deleted = @is_deleted "
              " WHERE id = @id and version = @version"
              " RETURNING true "
              , substitutionValues: {
                "id": objective.id,
                "version": objective.version,
                "is_deleted": objective.isDeleted,
              });
        } else {
          result = await ctx.query(
              "UPDATE auge_objective.objectives "
                  " SET version = @version + 1, "
                  " name = @name,"
                  " description = @description,"
                  " start_date = @start_date,"
                  " end_date = @end_date,"
                  " archived = @archived,"
                  " aligned_to_objective_id = @aligned_to_objective_id,"
                  " organization_id = @organization_id,"
                  " leader_user_id = @leader_user_id,"
                  " group_id = @group_id,"
                  " is_deleted = @is_deleted,"

                  " WHERE id = @id and version = @version"
                  " RETURNING true"
              , substitutionValues: {
            "id": objective.id,
            "version": objective.version,
            "name": objective.name,
            "description": objective.description,
            "start_date": objective.startDate,
            "end_date": objective.endDate,
            "archived": objective.archived,
            "aligned_to_objective_id": objective.alignedTo == null
                ? null
                : objective.alignedTo.id,
            "organization_id": objective.organization.id,
            "leader_user_id": objective.leader == null ? null : objective.leader
                .id,
            "group_id": objective.group == null ? null : objective.group.id,
            "is_deleted": objective.isDeleted,
            });
        }

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new RpcError(412, 'PreconditionFailed', 'Precondition Failed')
            ..errors.add(
                new RpcErrorDetail(reason: RpcErrorDetailMessage.measureUpdatePreconditionFailed));
        }
        else {
          // HistoryItem
          objective.lastHistoryItem.setServerSideValues(id: new Uuid().v4(),
              objectId: objective.id,
              objectVersion: objective.version,
              objectClassName: objective.runtimeType.toString(),
              systemFunctionIndex: objective.isDeleted ? SystemFunction.delete.index : SystemFunction.update.index,
              dateTime: DateTime.now().toUtc());

          await ctx.query(queryStatementCreateHistoryItem,
              substitutionValues: querySubstitutionValuesCreateHistoryItem(objective.lastHistoryItem));
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return new IdMessage()..id = objective.id;
  }

  // *** HISTORY TO OBJECTIVE SCHEMA ***
  static Future<List<HistoryItem>> queryHistory(String objectiveId, {withIdRemoved = false}) async {
    List<List> results;

    String queryStatementSelect = "SELECT history_item.id, " //0
        "history_item.object_id, " //1
        "history_item.object_version, " //2
        "history_item.object_class_name, " //3
        "history_item.system_function_index, " //4
        "history_item.date_time, " //5
        "history_item.user_id, " //6
        "history_item.description, " //7
        "history_item.changed_values "; //8

    String queryStatement;


    queryStatement = queryStatementSelect +
        "FROM auge_objective.history history_item "
        "WHERE object_class_name = 'Objective' "
        "AND object_id = @objective_id "
        "UNION "
         + queryStatementSelect +
        "FROM auge_objective.history history_item "
        "JOIN auge_objective.measures measure ON measure.id = history_item.object_id "
        "WHERE history_item.object_class_name = 'Measure' "
        "AND measure.objective_id = @objective_id "
        "UNION "
        + queryStatementSelect +
        "FROM auge_objective.history history_item "
        "JOIN auge_objective.measure_progress measure_progress ON measure_progress.id = history_item.object_id "
        "JOIN auge_objective.measures measure ON measure.id = measure_progress.measure_id "
        "WHERE history_item.object_class_name = 'MeasureProgress' "
        "AND measure.objective_id = @objective_id";

    Map<String, dynamic> substitutionValues;

    substitutionValues = {"objective_id": objectiveId};

    queryStatement += " ORDER BY 6 DESC ";

    results = await AugeConnection.getConnection().query(
        queryStatement, substitutionValues: substitutionValues);

    List<HistoryItem> history = new List();
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

        Map changedDataMap = json.decode(row[8]);
        if (withIdRemoved)
        changedDataMap.keys.where((k) =>  (k == 'id' || changedDataMap[k] is Map && changedDataMap[k].keys.where((kk) => (kk == 'id') ))
        ).toList().forEach(changedDataMap.remove);


        history.add(new HistoryItem()
          ..id = row[0]
          ..objectId = row[1]
          ..objectVersion = row[2]
          ..objectClassName = row[3]
          ..systemFunctionIndex = row[4]
          ..dateTime = row[5]
          ..user = user
          ..description = row[7]
          ..changedValues = json.encode(changedDataMap)
          );
      }
    }
    return history;

  }

  /// Return objective history
  @ApiMethod( method: 'GET', path: 'objective/{objectiveId}/history')
  Future<List<HistoryItem>> getHistory(String objectiveId) async {
    try {
      // return queryGetObjectives(organizationId: organizationId, withMeasures: withMeasures, treeAlignedWithChildren: treeAlignedWithChildren, withProfile: withProfile);

      List<HistoryItem> history;
      history = await queryHistory(objectiveId);
      return history;

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
}