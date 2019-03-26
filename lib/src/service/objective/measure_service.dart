// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/objective/measure.pbgrpc.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/model/general/authorization.dart';
import 'package:auge_server/shared/rpc_error_message.dart';

import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:uuid/uuid.dart';

class MeasureService extends MeasureServiceBase {

  // API
  @override
  Future<MeasureUnitsResponse> getMeasureUnits(ServiceCall call,
      Empty) async {
    MeasureUnitsResponse measureUnitsResponse;
    measureUnitsResponse = MeasureUnitsResponse()
      ..measureUnits.addAll(
          await querySelectMeasureUnits());
    return measureUnitsResponse;
  }

  @override
  Future<MeasuresResponse> getMeasures(ServiceCall call,
      MeasureGetRequest request) async {
    MeasuresResponse measuresResponse;
    measuresResponse = MeasuresResponse()
      ..measures.addAll(
          await querySelectMeasures(request));
    return measuresResponse;
  }

  @override
  Future<Measure> getMeasure(ServiceCall call,
      MeasureGetRequest request) async {
    Measure measure = await querySelectMeasure(request);
    if (measure == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.measureDataNotFoundReason);
    return measure;
  }

  @override
  Future<IdResponse> createMeasure(ServiceCall call,
      Measure measure) async {
    return queryInsertMeasure(measure);
  }

  @override
  Future<Empty> updateMeasure(ServiceCall call,
      Measure measure) async {
    return queryUpdateMeasure(measure);
  }

  @override
  Future<Empty> deleteMeasure(ServiceCall call,
      Measure measure) async {
    return queryDeleteMeasure(measure);
  }

  @override
  Future<Empty> softDeleteMeasure(ServiceCall call,
      Measure measure) async {
    measure.isDeleted = true;
    return queryUpdateMeasure(measure);
  }

  @override
  Future<MeasureProgressesResponse> getMeasureProgresses(ServiceCall call,
      MeasureProgressGetRequest request) async {
    return querySelectMeasureProgresses(
        request);
  }

  @override
  Future<MeasureProgress> getMeasureProgress(ServiceCall call,
      MeasureProgressGetRequest request) async {
    MeasureProgress measureProgress = await querySelectMeasureProgress(
        request);
    if (measureProgress == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.measureProgressDataNotFoundReason);
    return measureProgress;
  }

  @override
  Future<IdResponse> createMeasureProgress(ServiceCall call,
      MeasureProgress measureProgress) async {
    return queryInsertMeasureProgress(measureProgress);
  }

  @override
  Future<Empty> updateMeasureProgress(ServiceCall call,
      MeasureProgress measureProgress) async {
    return queryUpdateMeasureProgress(measureProgress);
  }

  @override
  Future<Empty> deleteMeasureProgress(ServiceCall call,
      MeasureProgress measureProgress) async {
    return queryDeleteMeasureProgress(measureProgress);
  }

  @override
  Future<Empty> softDeleteMeasureProgress(ServiceCall call,
      MeasureProgress measureProgress) async {
    measureProgress.isDeleted = true;
    return queryUpdateMeasureProgress(measureProgress);
  }


  // QUERY
  // *** MEASURE UNITS ***
  static Future<List<MeasureUnit>> querySelectMeasureUnits({String id}) async {
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
  static Future<List<Measure>> querySelectMeasures(MeasureGetRequest request /*
      {String objectiveId, String id, bool isDeleted = false} */) async {
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

    if (request.id != null && request.id.isNotEmpty) {
      queryStatement += " WHERE id = @id AND is_deleted = @is_deleted";
      substitutionValues = {"id": request.id, "is_deleted": request.isDeleted};
    } else if (request.objectiveId != null && request.objectiveId.isNotEmpty) {
      queryStatement +=
      " WHERE objective_id = @objective_id AND is_deleted = @is_deleted";
      substitutionValues =
      {"objective_id": request.objectiveId, "is_deleted": request.isDeleted};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.measureInvalidArgument );
    }

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<Measure> measures = new List();
    List<MeasureUnit> measureUnits;

    if (results != null && results.isNotEmpty) {
      MeasureUnit measureUnit;

      for (var row in results) {
        if (row[9] != null)
          //  measureUnit = await getMeasureUnitById(row[8]);
          measureUnits = await querySelectMeasureUnits(id: row[9]);
        if (measureUnits != null && measureUnits.length != 0) {
          measureUnit = measureUnits.first;
        }
        else
          measureUnit = null;

        Measure measure = Measure();

        measure
          ..id = row[0]
          ..version = row[1]
          ..name = row[2];

        if (row[3] != null)  measure.description = row[3];
        if (row[4] != null) measure.metric = row[4];
        if (row[5] != null) measure.decimalsNumber = row[5];
        if (row[6] != null) measure.startValue = row[6];
        if (row[7] != null) measure.endValue = row[7];
        if (row[8] != null) measure.currentValue = row[8];
        if (measureUnit != null) measure.measureUnit = measureUnit;
        if (row[10] != null) measure.isDeleted = row[10];

        measures.add(measure);
      }
    }
    return measures;
  }

  static Future<Measure> querySelectMeasure(MeasureGetRequest request) async {
    List<Measure> measures = await querySelectMeasures(request);
    if (measures.isNotEmpty) {
      return measures.first;
    } else {
      return null;
    }
  }

  /// Create (insert) a new measures
  static Future<IdResponse> queryInsertMeasure(
      Measure measure) async {
    if (!measure.hasId()) {
      measure.id = new Uuid().v4();
    }

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

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
          "description": measure.hasDescription() ? measure.description : null,
          "metric": measure.hasMetric() ? measure.metric : null,
          "decimals_number": measure.hasDecimalsNumber() ? measure.decimalsNumber : null,
          "start_value": measure.hasStartValue() ? measure.startValue : null,
          "end_value": measure.hasEndValue() ? measure.endValue : null,
          "measure_unit_id": measure.hasMeasureUnit() ? measure.measureUnit.id : null,
          "objective_id": measure.hasObjectiveId() ? measure.objectiveId : null,
          "is_deleted": measure.hasIsDeleted() ? measure.isDeleted : false,
        });

        // HistoryItem - server-side generation
        measure.historyItemLog
          ..id = new Uuid().v4()
          ..objectId = measure.id
          ..objectVersion = measure.version
          ..objectClassName = 'Measure' // objectiveRequest.runtimeType.toString(),
          ..systemFunctionIndex = SystemFunction.create.index;
        // ..dateTime = DateTime.now().toUtc();


        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: HistoryItemService
                .querySubstitutionValuesCreateHistoryItem(
                measure.historyItemLog));
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdResponse()..id = measure.id;
  }

  /// Update [Measure]
  Future<Empty> queryUpdateMeasure(Measure measure) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        List<List<dynamic>> result;

        // Soft delete
        if (measure.isDeleted) {
          result = await ctx.query("UPDATE auge_objective.measures "
              " SET version = @version + 1,"
              " is_deleted = @is_deleted"
              " WHERE id = @id AND version = @version"
              " RETURNING true"
              , substitutionValues: {
                "id": measure.id,
                "version": measure.version,
                "is_deleted": measure.isDeleted,
              });
        } else {
          result = await ctx.query("UPDATE auge_objective.measures "
              " SET version = @version + 1,"
              " name = @name,"
              " description = @description,"
              " metric = @metric,"
              " decimals_number = @decimals_number,"
              " start_value = @start_value,"
              " end_value = @end_value,"
             // " current_value = @current_value,"
              " objective_id = @objective_id,"
              " measure_unit_id = @measure_unit_id,"
              " is_deleted = @is_deleted"
              " WHERE id = @id AND version = @version"
              " RETURNING true"
              , substitutionValues: {
                "id": measure.id,
                "version": measure.version,
                "name": measure.name,
                "description": measure.hasDescription() ? measure.description : null,
                "metric": measure.hasMetric() ? measure.metric : null,
                "decimals_number": measure.hasDecimalsNumber() ? measure.decimalsNumber : null,
                "start_value": measure.hasStartValue() ? measure.startValue : null,
                "end_value": measure.hasEndValue() ? measure.endValue : null,
                //"current_value": measureRequest.currentValue,
                "measure_unit_id": measure.hasMeasureUnit() ? measure.measureUnit.id : null,
                "objective_id": measure.hasObjectiveId() ? measure.objectiveId : null,
                "is_deleted": measure.hasIsDeleted() ? measure.isDeleted : null,
              });
        }

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.measurePreconditionFailed);
        } else {
          // HistoryItem - server-side generation
          measure.historyItemLog
            ..id = new Uuid().v4()
            ..objectId = measure.id
            ..objectVersion = measure.version
            ..objectClassName = 'Measure' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.update.index;
          // ..dateTime = DateTime.now().toUtc();

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: HistoryItemService
                  .querySubstitutionValuesCreateHistoryItem(
                  measure.historyItemLog));
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty();
  }

  /// Delete a [Measure] by id
  Future<Empty> queryDeleteMeasure(Measure measure) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge_objective.measures measure"
                " WHERE measure.id = @id"
            , substitutionValues: {
          "id": measure.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  // *** MEASURES PROGRESS ***
  static Future<MeasureProgressesResponse> querySelectMeasureProgresses(MeasureProgressGetRequest request /*
      {String measureId, String id, bool isDeleted = false, bool withAuditUser = false}*/) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id," // 0
        " version," //1
        " is_deleted," //2
        " date," //3
        " current_value," //4
        " comment," //5
        " measure_id" //6
        " FROM auge_objective.measure_progress ";

    Map<String, dynamic> substitutionValues;

    if (request.hasId()) {
      queryStatement +=
      " WHERE id = @id AND auge_objective.measure_progress.is_deleted = @is_deleted";
      substitutionValues = {"id": request.id, "is_deleted": request.isDeleted};
    } else if (request.hasMeasureId()) {
      queryStatement +=
      " WHERE measure_id = @measure_id AND auge_objective.measure_progress.is_deleted = @is_deleted";
      substitutionValues = {"measure_id": request.measureId, "is_deleted": request.isDeleted};
    }

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<MeasureProgress> mesuareProgresses = new List();

    if (results != null && results.isNotEmpty) {
      for (var row in results) {
        MeasureProgress measureProgress = MeasureProgress()
          ..id = row[0]
          ..version = row[1]
          ..isDeleted = row[2];

        //  measureProgress.date = row[3]
          if (row[3] != null) {
            Timestamp t = Timestamp();
            int microsecondsSinceEpoch = row[3].toUtc().microsecondsSinceEpoch;
            t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
            t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
            measureProgress.date = t;
          }

          if (row[4] != null) {
            measureProgress.currentValue = row[4];
          }
          if (row[5] != null) {
            measureProgress.comment = row[5];
          }

        mesuareProgresses.add(measureProgress);
      }
    }
    return MeasureProgressesResponse()..measureProgresses.addAll(mesuareProgresses);
  }

  static Future<MeasureProgress> querySelectMeasureProgress(MeasureProgressGetRequest request) async {
    MeasureProgressesResponse measureProgressesResponse = await querySelectMeasureProgresses(request);

    if (measureProgressesResponse.measureProgresses.isNotEmpty) {
      return measureProgressesResponse.measureProgresses.first;
    } else {
      return null;
    }
  }

  /// Create current value of the [MeasureProgress]
  static Future<IdResponse> queryInsertMeasureProgress(
      MeasureProgress measureProgress) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        if (!measureProgress.hasId()) {
          measureProgress.id = new Uuid().v4();
        }

        measureProgress.version = 0;

        await ctx.query(
            "INSERT INTO auge_objective.measure_progress(id, version, is_deleted, date, current_value, comment, measure_id) VALUES"
                "(@id,"
                "@version,"
                "@is_deleted,"
                "@date,"
                "@current_value,"
                "@comment,"
                "@measure_id)"
            , substitutionValues: {
          "id": measureProgress.id,
          "version": measureProgress.version,
          "date": measureProgress.hasDate() ?  DateTime.fromMicrosecondsSinceEpoch(measureProgress.date.seconds.toInt() * 1000000 + measureProgress.date.nanos ~/ 1000 )  : DateTime.now().toUtc(),
          "current_value": measureProgress.hasCurrentValue() ? measureProgress.currentValue : null,
          "comment": measureProgress.hasComment() ? measureProgress.comment : null,
          "measure_id": measureProgress.hasMeasureId() ? measureProgress.measureId : null,
          "is_deleted": false,
        });

        // HistoryItem - server-side generation
        measureProgress.historyItemLog
          ..id = new Uuid().v4()
          ..objectId = measureProgress.id
          ..objectVersion = measureProgress.version
          ..objectClassName = 'MeasureProgress' // objectiveRequest.runtimeType.toString(),
          ..systemFunctionIndex = SystemFunction.create.index;
        // ..dateTime = DateTime.now().toUtc();
        // Create a history item

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: HistoryItemService
                .querySubstitutionValuesCreateHistoryItem(
                measureProgress.historyItemLog));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return IdResponse()..id = measureProgress.id;
  }

  /// Create current value of the [MeasureProgress]
  Future<Empty> queryUpdateMeasureProgress(
      MeasureProgress measureProgress) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
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
            "date": measureProgress.date == null
                ? dateTimeNow
                : measureProgress.date,
            "current_value": measureProgress.hasCurrentValue() ? measureProgress.currentValue : null,
            "comment": measureProgress.hasComment() ? measureProgress.comment : null,
            "measure_id": measureProgress.hasMeasureId() ? measureProgress.measureId : null,

          });

          // Optimistic concurrency control
          if (result.length == 0) {
            throw new GrpcError.failedPrecondition(
                RpcErrorDetailMessage.measurePreconditionFailed);
          } else {
            // HistoryItem - server-side generation
            measureProgress.historyItemLog
              ..id = new Uuid().v4()
              ..objectId = measureProgress.id
              ..objectVersion = measureProgress.version
              ..objectClassName = 'MeasureProgress' // objectiveRequest.runtimeType.toString(),
              ..systemFunctionIndex = SystemFunction.update.index;
            // ..dateTime = DateTime.now().toUtc();

            // Create a history item
            await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
                substitutionValues: HistoryItemService
                    .querySubstitutionValuesCreateHistoryItem(
                    measureProgress.historyItemLog));
          }
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty();
  }

  /// Delete a [MeasureProgress] by id
  Future<Empty> queryDeleteMeasureProgress(MeasureProgress measureProgress) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge_objective.measure_progress measure_progress"
                " WHERE measure_progress.id = @id"
            , substitutionValues: {
          "id": measureProgress.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }
}