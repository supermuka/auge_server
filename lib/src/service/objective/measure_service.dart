// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'dart:convert';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/objective/measure.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';
import 'package:auge_server/model/general/authorization.dart';
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/shared/rpc_error_message.dart';

import 'package:auge_server/src/service/general/history_item_service.dart';


import 'package:uuid/uuid.dart';

class MeasureService extends MeasureServiceBase {

  // API
  @override
  Future<MeasureUnitsResponse> getMeasureUnits(ServiceCall call,
      Empty) async {
    MeasureUnitsResponse measureUnitsResponse;
    measureUnitsResponse = MeasureUnitsResponse()..webWorkAround = true
      ..measureUnits.addAll(
          await querySelectMeasureUnits());
    return measureUnitsResponse;
  }

  @override
  Future<MeasuresResponse> getMeasures(ServiceCall call,
      MeasureGetRequest request) async {
    MeasuresResponse measuresResponse;
    measuresResponse = MeasuresResponse()..webWorkAround = true
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
      MeasureRequest request) async {
    return queryInsertMeasure(request);
  }

  @override
  Future<Empty> updateMeasure(ServiceCall call,
      MeasureRequest request) async {
    return queryUpdateMeasure(request);
  }

  @override
  Future<Empty> deleteMeasure(ServiceCall call,
      MeasureRequest request) async {
    return queryDeleteMeasure(request);
  }


  @override
  Future<MeasureProgressesResponse> getMeasureProgresses(ServiceCall call,
      MeasureProgressGetRequest request) async {
    return
    MeasureProgressesResponse()..webWorkAround = true..measureProgresses.addAll(await querySelectMeasureProgresses(request));
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
      MeasureProgressRequest request) async {
    return queryInsertMeasureProgress(request);
  }

  @override
  Future<Empty> updateMeasureProgress(ServiceCall call,
      MeasureProgressRequest request) async {
    return queryUpdateMeasureProgress(request);
  }

  @override
  Future<Empty> deleteMeasureProgress(ServiceCall call,
      MeasureProgressRequest request) async {
    return queryDeleteMeasureProgress(request);
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

    queryStatement = "SELECT id," //0
        " version, " //1
        " name," //2
        " description," //3
        " metric," //4
        " decimals_number," //5
        " start_value::REAL," //6
        " end_value::REAL," //7
        " (select current_value from objective.measure_progress where measure_progress.measure_id = measure.id order by date desc limit 1)::REAL as current_value," //8
        " measure_unit_id " //9
        " FROM objective.measures measure ";

    Map<String, dynamic> substitutionValues;

    if (request.id != null && request.id.isNotEmpty) {
      queryStatement += " WHERE id = @id";
      substitutionValues = {"id": request.id};
    } else if (request.objectiveId != null && request.objectiveId.isNotEmpty) {
      queryStatement +=
      " WHERE objective_id = @objective_id";
      substitutionValues =
      {"objective_id": request.objectiveId};
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
        if (row[10] != null)
          //  measureUnit = await getMeasureUnitById(row[8]);
          measureUnits = await querySelectMeasureUnits(id: row[10]);
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
      MeasureRequest request) async {
    if (!request.measure.hasId()) {
      request.measure.id = new Uuid().v4();
    }

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO objective.measures(id, version, name, description, metric, decimals_number, start_value, end_value, measure_unit_id, objective_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@description,"
                "@metric,"
                "@decimals_number,"
                "@start_value,"
                "@end_value,"
                "@measure_unit_id,"
                "@objective_id)"
            , substitutionValues: {
          "id": request.measure.id,
          "version": 0,
          "name": request.measure.name,
          "description": request.measure.hasDescription() ? request.measure.description : null,
          "metric": request.measure.hasMetric() ? request.measure.metric : null,
          "decimals_number": request.measure.hasDecimalsNumber() ? request.measure.decimalsNumber : null,
          "start_value": request.measure.hasStartValue() ? request.measure.startValue : null,
          "end_value": request.measure.hasEndValue() ? request.measure.endValue : null,
          "measure_unit_id": request.measure.hasMeasureUnit() ? request.measure.measureUnit.id : null,
          "objective_id": request.hasObjectiveId() ? request.objectiveId : null,
        });


        // HistoryItem
        HistoryItem historyItem;

        Map<String, dynamic> valuesCurrent = request.measure.writeToJsonMap();

        historyItem
          ..id = new Uuid().v4()
          ..objectId = request.measure.id
          ..objectVersion = request.measure.version
          ..objectClassName = 'Measure' // objectiveRequest.runtimeType.toString(),
          ..systemFunctionIndex = SystemFunction.create.index
          ..description = request.measure.name
        // ..dateTime
          ..description = ''
         // ..changedValuesPrevious.addAll(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
          ..changedValuesCurrentJson = json.encode(history_item_m.HistoryItem.changedValues(valuesCurrent, {}));

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: HistoryItemService
                .querySubstitutionValuesCreateHistoryItem(
                historyItem));
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdResponse()..id = request.measure.id;
  }

  /// Update [Measure]
  Future<Empty> queryUpdateMeasure(MeasureRequest request) async {
    try {

      // Recovery to log to history
      Measure previousMeasure = await querySelectMeasure(MeasureGetRequest()..id = request.measure.id);

      await (await AugeConnection.getConnection()).transaction((ctx) async {
        List<List<dynamic>> result;

          result = await ctx.query("UPDATE objective.measures "
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
              " WHERE id = @id AND version = @version"
              " RETURNING true"
              , substitutionValues: {
                "id": request.measure.id,
                "version": request.measure.version,
                "name": request.measure.name,
                "description": request.measure.hasDescription() ? request.measure.description : null,
                "metric": request.measure.hasMetric() ? request.measure.metric : null,
                "decimals_number": request.measure.hasDecimalsNumber() ? request.measure.decimalsNumber : null,
                "start_value": request.measure.hasStartValue() ? request.measure.startValue : null,
                "end_value": request.measure.hasEndValue() ? request.measure.endValue : null,
                //"current_value": measureRequest.currentValue,
                "measure_unit_id": request.measure.hasMeasureUnit() ? request.measure.measureUnit.id : null,
                "objective_id": request.hasObjectiveId() ? request.objectiveId : null,
              });

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.measurePreconditionFailed);
        } else {

          // HistoryItem
          HistoryItem historyItem;

          Map<String, dynamic> valuesPrevious = previousMeasure.writeToJsonMap();
          Map<String, dynamic> valuesCurrent = request.measure.writeToJsonMap();

          historyItem
            ..id = new Uuid().v4()
            ..objectId = request.measure.id
            ..objectVersion = request.measure.version
            ..objectClassName = 'Measure' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.update.index
            ..description = request.measure.name
          // ..dateTime
            ..description = ''
            ..changedValuesPreviousJson = json.encode(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
            ..changedValuesCurrentJson = json.encode(history_item_m.HistoryItem.changedValues(valuesCurrent, valuesPrevious));

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: HistoryItemService
                  .querySubstitutionValuesCreateHistoryItem(
                  historyItem));

        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()..webWorkAround = true;
  }

  /// Delete a [Measure] by id
  Future<Empty> queryDeleteMeasure(MeasureRequest request) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM objective.measures measure"
                " WHERE measure.id = @id"
            , substitutionValues: {
          "id": request.measure.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }

  // *** MEASURES PROGRESS ***
  static Future<List<MeasureProgress>> querySelectMeasureProgresses(MeasureProgressGetRequest request /*
      {String measureId, String id, bool isDeleted = false, bool withAuditUser = false}*/) async {
    List<List> results;

    String queryStatement;

    queryStatement = "SELECT id," // 0
        " version," //1
        " date," //2
        " current_value," //3
        " comment," //4
        " measure_id" //5
        " FROM objective.measure_progress ";

    Map<String, dynamic> substitutionValues;

    if (request.hasId()) {
      queryStatement +=
      " WHERE id = @id";
    } else if (request.hasMeasureId()) {
      queryStatement +=
      " WHERE measure_id = @measure_id";
    }

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<MeasureProgress> mesuareProgresses = new List();

    if (results != null && results.isNotEmpty) {
      for (var row in results) {
        MeasureProgress measureProgress = MeasureProgress()
          ..id = row[0]
          ..version = row[1];

        //  measureProgress.date = row[3]
          if (row[2] != null) {
            Timestamp t = Timestamp();
            int microsecondsSinceEpoch = row[2].toUtc().microsecondsSinceEpoch;
            t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
            t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
            measureProgress.date = t;
          }

          if (row[3] != null) {
            measureProgress.currentValue = row[3];
          }
          if (row[4] != null) {
            measureProgress.comment = row[4];
          }

        mesuareProgresses.add(measureProgress);
      }
    }
    return mesuareProgresses;
  }

  static Future<MeasureProgress> querySelectMeasureProgress(MeasureProgressGetRequest request) async {
    List<MeasureProgress> measureProgresses = await querySelectMeasureProgresses(request);

    if (measureProgresses.isNotEmpty) {
      return measureProgresses.first;
    } else {
      return null;
    }
  }

  /// Create current value of the [MeasureProgress]
  static Future<IdResponse> queryInsertMeasureProgress(
      MeasureProgressRequest request) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        if (!request.measureProgress.hasId()) {
          request.measureProgress.id = new Uuid().v4();
        }

        request.measureProgress.version = 0;

        await ctx.query(
            "INSERT INTO objective.measure_progress(id, version, date, current_value, comment, measure_id) VALUES"
                "(@id,"
                "@version,"
                "@date,"
                "@current_value,"
                "@comment,"
                "@measure_id)"
            , substitutionValues: {
          "id": request.measureProgress.id,
          "version": request.measureProgress.version,
          "date": request.measureProgress.hasDate() ?  DateTime.fromMicrosecondsSinceEpoch(request.measureProgress.date.seconds.toInt() * 1000000 + request.measureProgress.date.nanos ~/ 1000 )  : DateTime.now().toUtc(),
          "current_value": request.measureProgress.hasCurrentValue() ? request.measureProgress.currentValue : null,
          "comment": request.measureProgress.hasComment() ? request.measureProgress.comment : null,
          "measure_id": request.hasMeasureId() ? request.measureId : null,
        });

        // HistoryItem
        HistoryItem historyItem;

      //  Map<String, dynamic> valuesPrevious = previousMeasureProgress.writeToJsonMap();
        Map<String, dynamic> valuesCurrent = request.measureProgress.writeToJsonMap();

        historyItem
          ..id = new Uuid().v4()
          ..objectId = request.measureProgress.id
          ..objectVersion = request.measureProgress.version
          ..objectClassName = 'MeasureProgress' // objectiveRequest.runtimeType.toString(),
          ..systemFunctionIndex = SystemFunction.create.index
        // ..dateTime
          ..description = ''
         // ..changedValuesPrevious.addAll(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
          ..changedValuesCurrentJson = json.encode(history_item_m.HistoryItem.changedValues(valuesCurrent, {}));

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: HistoryItemService
                .querySubstitutionValuesCreateHistoryItem(
                historyItem));

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: HistoryItemService
                .querySubstitutionValuesCreateHistoryItem(
                historyItem));

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return IdResponse()..id = request.measureProgress.id;
  }

  /// Create current value of the [MeasureProgress]
  Future<Empty> queryUpdateMeasureProgress(
      MeasureProgressRequest request) async {
    // Recovery to log to history
    MeasureProgress previousMeasureProgress = await querySelectMeasureProgress(MeasureProgressGetRequest()..id = request.measureProgress.id);

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        DateTime dateTimeNow = DateTime.now().toUtc();

        List<List<dynamic>> result;

        if (request.measureProgress.id == null) {
          request.measureProgress.id = new Uuid().v4();
        }

        result = await ctx.query(
            "UPDATE objective.measure_progress "
                "SET date = @date, "
                "current_value = @current_value, "
                "comment = @comment, "
                "measure_id = @measure_id, "
                "version = @version + 1"
                "WHERE id = @id AND version = @version "
                "RETURNING true"
            , substitutionValues: {
          "id": request.measureProgress.id,
          "version": request.measureProgress.version,
          "date": request.measureProgress.date == null
              ? dateTimeNow
              : request.measureProgress.date,
          "current_value": request.measureProgress.hasCurrentValue() ? request.measureProgress.currentValue : null,
          "comment": request.measureProgress.hasComment() ? request.measureProgress.comment : null,
          "measure_id": request.hasMeasureId() ? request.measureId : null,

        });

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.measurePreconditionFailed);
        } else {

          // HistoryItem
          HistoryItem historyItem;

          Map<String, dynamic> valuesPrevious = previousMeasureProgress.writeToJsonMap();
          Map<String, dynamic> valuesCurrent = request.measureProgress.writeToJsonMap();

          historyItem
            ..id = new Uuid().v4()
            ..objectId = request.measureProgress.id
            ..objectVersion = request.measureProgress.version
            ..objectClassName = 'MeasureProgress' // objectiveRequest.runtimeType.toString(),
            ..systemFunctionIndex = SystemFunction.update.index
          // ..dateTime
            ..description = ''
            ..changedValuesPreviousJson = json.encode(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
            ..changedValuesCurrentJson = json.encode(history_item_m.HistoryItem.changedValues(valuesCurrent, valuesPrevious));

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: HistoryItemService
                  .querySubstitutionValuesCreateHistoryItem(
                  historyItem));
        }

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()..webWorkAround = true;
  }

  /// Delete a [MeasureProgress] by id
  Future<Empty> queryDeleteMeasureProgress(MeasureProgressRequest request) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM objective.measure_progress measure_progress"
                " WHERE measure_progress.id = @id"
            , substitutionValues: {
          "id": request.measureProgress.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }
}