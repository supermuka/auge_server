// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:async';

import 'package:rpc/rpc.dart';
import 'package:postgres/postgres.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/augeapi.dart';

import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/group.dart';

//import 'package:auge_shared/message/messages.dart';

/// Api for Objective Domain
@ApiClass(version: 'v1')
class ObjectiveAugeApi {

  AugeApi _augeApi;

  ObjectiveAugeApi() {
    _augeApi = new AugeApi();
    AugeConnection.createConnection();
  }

  // *** MEASURES ***
  Future<List<MeasureUnit>> _queryGetMeasureUnits({String id}) async {
    List<List> results;

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

  Future<List<Measure>> _queryGetMeasures({String objectiveId, String id}) async {
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

    if (results != null && results.isNotEmpty) {

      MeasureUnit measureUnit;

      for (var row in results) {

        if (row[8] != null)
          measureUnit = await getMeasureUnitById(row[8]);
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
      } on PostgreSQLException catch (e) {
        throw new ApplicationError(e);
      }
    });

  }

  /// Return a [Measure] by Id
  @ApiMethod( method: 'GET', path: 'measures/{id}')
  Future<Measure> getMeasureById(String id) async {
    try {
      List<Measure> measures = await _queryGetMeasures(id: id);
      return measures.first;
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }

  /// Return all [MeasureUnit]
  @ApiMethod( method: 'GET', path: 'measure_units')
  Future<List<MeasureUnit>> getMeasureUnits() async {
    try {
       return  await _queryGetMeasureUnits();
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }

  /// Return a [MeasureUnit] by Id
  @ApiMethod( method: 'GET', path: 'measure_units/{id}')
  Future<MeasureUnit> getMeasureUnitById(String id) async {
    try {
      List<MeasureUnit> measureUnits = await _queryGetMeasureUnits(id: id);
      return measureUnits.first;
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }

  /// Create (insert) a new measures
  @ApiMethod( method: 'POST', path: 'objetives/{objectiveid}/measures')
  Future<VoidMessage> createMeasure(String objectiveid, Measure measure) async {

  //  measure.id = new Uuid().v4();
    try {
      await  AugeConnection.getConnection().query("INSERT INTO auge_objective.measures(id, name, description, metric, decimals_number, start_value, end_value, current_value, measure_unit_id, objective_id) VALUES"
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
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }

  /// Update an initiative passing an instance of [Measure]
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
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }

  }

  // *** OBJECTIVES ***
  // alignedToRecursiveDeep: 0 not call; 1 call once; 2 call tow, etc...
  Future<List<Objective>> _queryGetObjectives({String organizationId, String id, int alignedToRecursive = 1, bool withMeasures = true, bool treeAlignedWithChildren = false, bool withProfile = false}) async {
    List<List> results;

   // String queryStatementColumns = "objective.id::VARCHAR, objective.name, objective.description, objective.start_date, objective.end_date, objective.leader_user_id, objective.aligned_to_objective_id";
    String queryStatementColumns = "objective.id," //0
    " objective.name," //1
    " objective.description," //2
    " objective.start_date," //3
    " objective.end_date," //4
    " objective.leader_user_id," //5
    " objective.aligned_to_objective_id," //6
    " objective.organization_id," //7
    " objective.group_id"; //8

    String queryStatementWhere = "";
    Map<String, dynamic> substitutionValues;

    if (id != null) {
      queryStatementWhere = " objective.id = @id";
      substitutionValues = {"id": id};
    } else {
      queryStatementWhere = " objective.organization_id = @organization_id";
      substitutionValues = {"organization_id": organizationId};
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
      User leaderUser;
      Objective alignedToObjective;
      List<Objective> alignedToObjectives;

      Objective objective;
      Group group;

      for (var row in results) {
        // Measures

        if (organization == null || organization.id != row[7]) {
          organization = await _augeApi.getOrganizationById(row[7]);
        }

        measures = (withMeasures) ? await _queryGetMeasures(objectiveId: row[0]) : [];

        leaderUser = await _augeApi.getUserById(row[5], withProfile: withProfile);

        if (row[6] != null && alignedToRecursive > 0) {
          alignedToObjectives = await _queryGetObjectives(id: row[6],
              alignedToRecursive: --alignedToRecursive);
          alignedToObjective = alignedToObjectives.first;
        }

        group = row[8] == null ? null : await _augeApi.getGroupById(row[8]);

        objective = new Objective()
          ..id = row[0]
          ..name = row[1]
          ..description = row[2]
          ..startDate = row[3]
          ..endDate = row[4]
          ..organization = organization
          ..leader = leaderUser
          ..measures = measures
          ..alignedTo = alignedToObjective
          ..group = group;

        objectives.add(objective);

        if (treeAlignedWithChildren) {
          // Parent must be present in the list (objectives);
          if (row[6] == null)
             objectivesTree.add(objective);
          else {
            objectives
                .singleWhere((o) => o.id == row[6])
                ?.alignedWithChildren
                ?.add(objective);
          }

         // objectives.singleWhere((o) => o.id == objective.alignedTo, orElse: )?.alignedWithChildren?.add(objective);
        } else {

        }
      }
    }

    return (treeAlignedWithChildren) ? objectivesTree : objectives;
  }

  /// Return all objectives from an organization
  @ApiMethod( method: 'GET', path: 'organization/{organizationId}/objetives')
  Future<List<Objective>> getObjectives(String organizationId, {bool withMeasures, bool treeAlignedWithChildren, bool withProfile}) async {
    try {
      return _queryGetObjectives(organizationId: organizationId, withMeasures: withMeasures, treeAlignedWithChildren: treeAlignedWithChildren, withProfile: withProfile);
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }

  /// Return an [Objective] from an organization by Id
  @ApiMethod( method: 'GET', path: 'objectives/{id}')
  Future<Objective> getObjectiveById(String id, {bool withMeasures}) async {
    try {
      List<Objective> objectives = await _queryGetObjectives(id: id, withMeasures: withMeasures);
      return objectives.first;
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
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
      } on PostgreSQLException catch (e) {
        throw new ApplicationError(e);
      }
    });
  }

    /// Create (insert) a new objective
  @ApiMethod( method: 'POST', path: 'objectives')
  Future<VoidMessage> createObjective(Objective objective) async {
    print('createObjective');
    print(objective.id);

   // objective.id = new Uuid().v4();
    try {
      await  AugeConnection.getConnection().query("INSERT INTO auge_objective.objectives(id, name, description, start_date, end_date, aligned_to_objective_id, organization_id, leader_user_id, group_id) VALUES"
            "(@id,"
            "@name,"
            "@description,"
            "@start_date,"
            "@end_date,"
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
              "aligned_to_objective_id": objective.alignedTo?.id,
              "organization_id": objective.organization?.id,
              "leader_user_id": objective.leader?.id,
              "group_id": objective.group?.id});
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }

  /// Update an initiative passing an instance of [Objective]
  @ApiMethod( method: 'PUT', path: 'objectives')
  Future<VoidMessage> updateObjective(Objective objective) async {
    try {
      await AugeConnection.getConnection().query(
          "UPDATE auge_objective.objectives "
              " SET name = @name,"
              " description = @description,"
              " start_date = @start_date,"
              " end_date = @end_date,"
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
        "aligned_to_objective_id": objective?.alignedTo?.id,
        "organization_id": objective.organization.id,
        "leader_user_id": objective.leader.id,
        "group_id": objective?.group?.id});
    } on PostgreSQLException catch (e) {
      throw new ApplicationError(e);
    }
  }
}