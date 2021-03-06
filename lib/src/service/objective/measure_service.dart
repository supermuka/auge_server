// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:auge_shared/src/util/common_utils.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pb.dart';
import 'package:auge_shared/message/messages.dart';
import 'package:auge_shared/message/domain_messages.dart';
import 'package:grpc/grpc.dart';

import 'package:auge_server/src/util/mail.dart';
import 'package:auge_shared/route/app_routes_definition.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/unit_of_measurement.pb.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_shared/domain/general/authorization.dart';
import 'package:auge_shared/message/rpc_error_message.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/objective/objective.dart' as objective_m;
import 'package:auge_shared/domain/objective/measure.dart' as measure_m;

import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/unit_of_measurement_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';


import 'package:uuid/uuid.dart';

class MeasureService extends MeasureServiceBase {

  // API
  @override
  Future<MeasuresResponse> getMeasures(ServiceCall call,
      MeasureGetRequest request) async {
    MeasuresResponse measuresResponse;
    measuresResponse = MeasuresResponse()/*..webWorkAround = true*/
      ..measures.addAll(
          await querySelectMeasures(request));
    return measuresResponse;
  }
/*
  @override
  Future<Measure> getMeasure(ServiceCall call,
      MeasureGetRequest request) async {
    Measure measure = await querySelectMeasure(request);
    if (measure == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.measureDataNotFoundReason);
    return measure;
  }
*/
  @override
  Future<StringValue> createMeasure(ServiceCall call,
      MeasureRequest request) async {
    return queryInsertMeasure(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateMeasure(ServiceCall call,
      MeasureRequest request) async {
    return queryUpdateMeasure(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteMeasure(ServiceCall call,
      MeasureDeleteRequest request) async {
    return queryDeleteMeasure(request, call.clientMetadata['origin']);
  }


  @override
  Future<MeasureProgressesResponse> getMeasureProgresses(ServiceCall call,
      MeasureProgressGetRequest request) async {
    return
    MeasureProgressesResponse()/*..webWorkAround = true*/..measureProgresses.addAll(await querySelectMeasureProgresses(request));
  }
/*
  @override
  Future<MeasureProgress> getMeasureProgress(ServiceCall call,
      MeasureProgressGetRequest request) async {
    MeasureProgress measureProgress = await querySelectMeasureProgress(
        request);
    if (measureProgress == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.measureProgressDataNotFoundReason);
    return measureProgress;
  }
*/
  @override
  Future<StringValue> createMeasureProgress(ServiceCall call,
      MeasureProgressRequest request) async {
    return queryInsertMeasureProgress(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateMeasureProgress(ServiceCall call,
      MeasureProgressRequest request) async {
    return queryUpdateMeasureProgress(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteMeasureProgress(ServiceCall call,
      MeasureProgressDeleteRequest request) async {
    return queryDeleteMeasureProgress(request, call.clientMetadata['origin']);
  }

  // QUERY

  // *** MEASURE UNITS ***
  /*
  static Future<List<MeasureUnit>> querySelectMeasureUnits({String id}) async {
    List<MeasureUnit> mesuareUnits = List();

    mesuareUnits.add(MeasureUnit()
      ..id = '819692ec-3640-4209-915a-4f3aee6d798e'
      ..symbol = 'd'
      ..name = 'day' // MeasureMessage.measureUnitLabel('Unitary')
    );
    mesuareUnits.add(MeasureUnit()
      ..id = '3ad31a95-bd08-48e0-80ab-0a9ee3c5e912'
      ..symbol = 'h'
      ..name = 'hour' // MeasureMessage.measureUnitLabel('Unitary')
    );
    mesuareUnits.add(MeasureUnit()
      ..id = 'fad0dc86-0124-4caa-9954-7526814efc3a'
      ..symbol = ''
      ..name = 'index' // MeasureMessage.measureUnitLabel('Index')
    );
    mesuareUnits.add(MeasureUnit()
      ..id = 'fad0dc86-0124-4caa-9954-7526814efc3a'
      ..symbol = '\$'
      ..name = 'money' // MeasureMessage.measureUnitLabel('Money')
    );
    mesuareUnits.add(MeasureUnit()
      ..id = 'f748d3ad-b533-4a2d-b4ae-0ae1e255cf81'
      ..symbol = '%'
      ..name = 'percent' // MeasureMessage.measureUnitLabel('Percent')
    );
    mesuareUnits.add(MeasureUnit()
      ..id = '723f1387-d5da-44f7-8373-17de31921cae'
      ..symbol = ''
      ..name = 'unitary' // MeasureMessage.measureUnitLabel('Unitary')
    );

    mesuareUnits.add(MeasureUnit()
      ..id = '723f1387-d5da-44f7-8373-17de31921cae'
      ..symbol = 'h'
      ..name = 'hour' // MeasureMessage.measureUnitLabel('Unitary')
    );

    return mesuareUnits;
  }
   */

  // *** MEASURES ***
  static Future<List<Measure>> querySelectMeasures(MeasureGetRequest request) async {
    List<List> results;

    String queryStatement;

    if (request.hasCustomMeasure()) {
      if (request.customMeasure == CustomMeasure.measureOnlySpecification) {
        queryStatement = "SELECT id," //0
            " null, " //1
            " name," //2
            " null," //3
            " null," //4
            " null," //5
            " null," //6
            " null," //7
            " null," //8
            " null, " //9
            " null" //10
            " FROM objective.measures measure ";
      } else if (request.customMeasure == CustomMeasure.measureWithoutObjective) {
        queryStatement = "SELECT id," //0
            " version, " //1
            " name," //2
            " description," //3
            " metric," //4
            " decimals_number," //5
            " start_value::REAL," //6
            " end_value::REAL," //7
            " (SELECT current_value FROM objective.measure_progress WHERE measure_progress.measure_id = measure.id ORDER BY date desc limit 1)::REAL as current_value," //8
            " unit_of_measurement_id, " //9
            " null" //10
            " FROM objective.measures measure ";
      }
      else {
        return null;
      }
    } else {
      queryStatement = "SELECT id," //0
          " version, " //1
          " name," //2
          " description," //3
          " metric," //4
          " decimals_number," //5
          " start_value::REAL," //6
          " end_value::REAL," //7
          " (SELECT current_value FROM objective.measure_progress WHERE measure_progress.measure_id = measure.id ORDER BY date desc limit 1)::REAL as current_value," //8
          " unit_of_measurement_id, " //9
          " objective_id" //10
          " FROM objective.measures measure ";
    }

    Map<String, dynamic> substitutionValues;

    if (request.hasId()) {
      queryStatement += " WHERE id = @id";
      substitutionValues = {"id": request.id};
    } else if (request.hasObjectiveId()) {
      queryStatement +=
      " WHERE objective_id = @objective_id";
      substitutionValues =
      {"objective_id": request.objectiveId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.measureInvalidArgument );
    }

    List<UnitOfMeasurement> unitsOfMeasurement;
    List<Measure> measures = List();

    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      if (results != null && results.isNotEmpty) {

        fillFields(Measure measure, var row) async {
          measure
            ..id = row[0]

            ..name = row[2];

          if (row[1] != null) measure.version = row[1];
          if (row[3] != null) measure.description = row[3];
          if (row[4] != null) measure.metric = row[4];
          if (row[5] != null) measure.decimalsNumber = row[5];
          if (row[6] != null) measure.startValue = row[6];
          if (row[7] != null) measure.endValue = row[7];
          if (row[8] != null) measure.currentValue = row[8];
          if (row[9] != null)
            //  measureUnit = await getMeasureUnitById(row[8]);
            unitsOfMeasurement =
            await UnitOfMeasurementService.querySelectUnitsOfMeasurement(
                id: row[9]);
          if (unitsOfMeasurement != null && unitsOfMeasurement.length != 0) {
            measure.unitOfMeasurement = unitsOfMeasurement.first;
          }
        }
        if (request.hasCustomMeasure()) {
          if (request.customMeasure == CustomMeasure.measureOnlySpecification) {

            for (var row in results) {
              Measure measure = Measure();
              measure.id = row[0];
              measure.name = row[2];
              measures.add(measure);
            }
          } else if (request.customMeasure == CustomMeasure.measureWithoutObjective) {

            for (var row in results) {
              Measure measure = Measure();
              await fillFields(measure, row);
              measures.add(measure);
            }
          }
        } else  {
          ObjectiveGetRequest objectiveGetRequest = ObjectiveGetRequest();
          fillObjectiveField(Measure measure, var row, [Objective objectiveCache]) async {

            if (objectiveCache != null && objectiveCache.id == row[10]) {
              measure.objective = objectiveCache;
            } else {
              objectiveGetRequest.id = row[10];
              objectiveGetRequest.customObjective =
                  CustomObjective.objectiveOnlySpecificationStartDateEndDate;

              measure.objective =
              await ObjectiveService.querySelectObjective(objectiveGetRequest);

              objectiveCache = measure.objective;
            }
          }

          Objective objectiveCache;
          for (var row in results) {
            Measure measure = Measure();
            await fillFields(measure, row);
            await fillObjectiveField(measure, row, objectiveCache);
            measures.add(measure);
          }
        }
      }
    } catch (e) {
      print('querySelectMeasures - ${e.runtimeType}, ${e}');
      rethrow;
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

  /// Objective Measure Notification User
  static void measureNotification(Objective objective, User leaderNotification, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    if (leaderNotification == null) return;

    // Not send to your-self
    if (leaderNotification.id == authUserId) return;

    // Leader
    if (leaderNotification.userProfile.eMailNotification == false) return;

    // Leader - eMail
    if (leaderNotification.userProfile.eMail == null) throw Exception('e-mail of the Objective Leader is null.');

    await CommonUtils.setDefaultLocale(leaderNotification.userProfile.idiomLocale);

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    mailMessages.add(
        AugeMailMessageTo(
            [leaderNotification.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${ObjectiveDomainMsg.fieldLabel(objective_m.Objective.leaderField)}',
            '${ClassNameMsg.label(objective_m.Objective.className)} ${objective.name}',
            '${urlOrigin}/#/${AppRoutesPath.appLayoutRoutePath}/${AppRoutesPath.objectivesRoutePath}?${AppRoutesQueryParam.objectiveIdQueryParameter}=${objective.id}',));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);

  }

  /// Create (insert) a new measures
  static Future<StringValue> queryInsertMeasure(
      MeasureRequest request, String urlOrigin) async {
    if (!request.measure.hasId()) {
      request.measure.id = new Uuid().v4();
    }

    request.measure.version = 0;

    Map<String, dynamic> historyItemNotificationValues;

    try {
/*
      // TODO (this is made just to get a objective name and email, found a way to improve the performance)
      Objective objective = await ObjectiveService.querySelectObjective(ObjectiveGetRequest()
        ..id = request.objectiveId);
*/

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO objective.measures(id, version, name, description, metric, decimals_number, start_value, end_value, unit_of_measurement_id, objective_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@description,"
                "@metric,"
                "@decimals_number,"
                "@start_value,"
                "@end_value,"
                "@unit_of_measurement_id,"
                "@objective_id)"
            , substitutionValues: {
          "id": request.measure.id,
          "version": request.measure.version,
          "name": request.measure.name,
          "description": request.measure.hasDescription() ? request.measure.description : null,
          "metric": request.measure.hasMetric() ? request.measure.metric : null,
          "decimals_number": request.measure.hasDecimalsNumber() ? request.measure.decimalsNumber : null,
          "start_value": request.measure.hasStartValue() ? request.measure.startValue : null,
          "end_value": request.measure.hasEndValue() ? request.measure.endValue : null,
          "unit_of_measurement_id": request.measure.hasUnitOfMeasurement() ? request.measure.unitOfMeasurement.id : null,
          "objective_id": request.measure.objective.id,
        });

        historyItemNotificationValues =  {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.measure.id,
          "object_version": request.measure.version,
          "object_class_name": measure_m
              .Measure.className,
          "system_module_index": SystemModule.objectives.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": '${request.measure.name} @ ${request.measure.objective.name}',
          "changed_values": history_item_m.HistoryItemHelper
              .changedValuesJson({},
                  request.measure.toProto3Json(), removeUserProfileImageField: true)};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: historyItemNotificationValues);

      });


      // Recovery eMail and notification from User Id.
      User leaderNotification = await ObjectiveService.querySelectObjectiveLeaderUser(request.measure.objective.id, customUser: CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

      // Notification
      measureNotification(request.measure.objective, leaderNotification, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.measure.id;
  }

  /// Update [Measure]
  Future<Empty> queryUpdateMeasure(MeasureRequest request, String urlOrigin) async {

    Map<String, dynamic> historyItemNotificationValues;

    try {

      // Recovery to log to history
      Measure previousMeasure = await querySelectMeasure(MeasureGetRequest()..id = request.measure.id);

      // TODO (this is made just to get a objective name, found a way to improve the performance)
    //  Objective objective = await ObjectiveService.querySelectObjective(ObjectiveGetRequest()..id = request.objectiveId..restrictObjective = RestrictObjective.objectiveIdName);

      await (await AugeConnection.getConnection()).transaction((ctx) async {
        List<List<dynamic>> result;

          result = await ctx.query("UPDATE objective.measures "
              " SET version = @version,"
              " name = @name,"
              " description = @description,"
              " metric = @metric,"
              " decimals_number = @decimals_number,"
              " start_value = @start_value,"
              " end_value = @end_value,"
             // " current_value = @current_value,"
              " objective_id = @objective_id,"
              " unit_of_measurement_id = @unit_of_measurement_id"
              " WHERE id = @id AND version = @version - 1"
              " RETURNING true"
              , substitutionValues: {
                "id": request.measure.id,
                "version": ++request.measure.version,
                "name": request.measure.name,
                "description": request.measure.hasDescription() ? request.measure.description : null,
                "metric": request.measure.hasMetric() ? request.measure.metric : null,
                "decimals_number": request.measure.hasDecimalsNumber() ? request.measure.decimalsNumber : null,
                "start_value": request.measure.hasStartValue() ? request.measure.startValue : null,
                "end_value": request.measure.hasEndValue() ? request.measure.endValue : null,
                //"current_value": measureRequest.currentValue,
                "unit_of_measurement_id": request.measure.hasUnitOfMeasurement() ? request.measure.unitOfMeasurement.id : null,
                "objective_id": request.measure.objective.id,
              });

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.measurePreconditionFailed);
        } else {

          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.measure.id,
            "object_version": request.measure.version,
            "object_class_name": measure_m
                .Measure.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.update.index,
            "date_time": DateTime.now().toUtc(),
            "description": '${request.measure.name} @ ${request.measure.objective.name}',
            "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(previousMeasure.toProto3Json(), request.measure.toProto3Json(), removeUserProfileImageField: true)};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }
      });

      // Recovery eMail and notification from User Id.
      User leaderNotification = await ObjectiveService.querySelectObjectiveLeaderUser(request.measure.objective.id, customUser: CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

      // Notification
      measureNotification(previousMeasure.objective, leaderNotification, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a [Measure] by id
  Future<Empty> queryDeleteMeasure(MeasureDeleteRequest request, String urlOrigin) async {

    Measure previousMeasure = await querySelectMeasure(MeasureGetRequest()..id = request.measureId);
    Map<String, dynamic> historyItemNotificationValues;


    // Recovery eMail and notification from User Id.
    User leaderNotification = await ObjectiveService.querySelectObjectiveLeaderUser(previousMeasure.objective.id, customUser: CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result =  await ctx.query(
            "DELETE FROM objective.measures measure"
                " WHERE measure.id = @id and measure.version = @version "
            "RETURNING true"
            , substitutionValues: {
          "id": request.measureId,
          "version": request.measureVersion});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
        } else {

          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.measureId,
            "object_version": request.measureVersion,
            "object_class_name": measure_m. Measure.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.delete.index,
            "date_time": DateTime.now().toUtc(),
            "description": '${previousMeasure.name} @ ${previousMeasure.objective.name}', // previousMeasure.name,
            "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                    previousMeasure.toProto3Json(), {}, removeUserProfileImageField: true)};

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }

      });

      // Notification
      measureNotification(previousMeasure.objective, leaderNotification, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  // *** MEASURES PROGRESS ***
  static Future<List<MeasureProgress>> querySelectMeasureProgresses(MeasureProgressGetRequest request) async {
    List<List> results;

    String queryStatement;

    if (request.hasCustomMeasureProgress()) {
      if (request.customMeasureProgress == CustomMeasureProgress.measureProgressWithoutMeasure) {
        queryStatement = "SELECT id," // 0
            " version," //1
            " date," //2
            " current_value," //3
            " comment," //4
            " null" //5
            " FROM objective.measure_progress ";
      }
    } else {
      queryStatement = "SELECT id," // 0
          " version," //1
          " date," //2
          " current_value," //3
          " comment," //4
          " measure_id" //5
          " FROM objective.measure_progress ";
    }
    Map<String, dynamic> substitutionValues = {};

    if (request.hasId()) {
      queryStatement +=
      " WHERE id = @id";
      substitutionValues['id'] = request.id;
    } else if (request.hasMeasureId()) {
      queryStatement +=
      " WHERE measure_id = @measure_id";
      substitutionValues['measure_id'] = request.measureId;
    }

    queryStatement += " ORDER BY date DESC";

    List<MeasureProgress> measureProgresses = List();
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      if (results != null && results.isNotEmpty) {
        fillFields(MeasureProgress measureProgress, var row) async {
          measureProgress
            ..id = row[0];

          if (row[1] != null) measureProgress.version = row[1];

          //  measureProgress.date = row[3]
          if (row[2] != null)
            measureProgress.date = CommonUtils.timestampFromDateTime(row[2].toUtc());

          if (row[3] != null) {
            measureProgress.currentValue = row[3];
          }
          if (row[4] != null) {
            measureProgress.comment = row[4];
          }
        }

        if (request.hasCustomMeasureProgress() && request.customMeasureProgress == CustomMeasureProgress.measureProgressWithoutMeasure) {

          for (var row in results) {
            MeasureProgress measureProgress = MeasureProgress();
            await fillFields(measureProgress, row);
            measureProgresses.add(measureProgress);
          }

        } else {
          MeasureGetRequest measureGetRequest = MeasureGetRequest();
          fillMeasureField(MeasureProgress measureProgress, var row) async {
            if (row[5] != null) {

              measureGetRequest.id = row[5];
              measureProgress.measure =
              await MeasureService.querySelectMeasure(measureGetRequest);
            }
          }
          for (var row in results) {
            MeasureProgress measureProgress = MeasureProgress();
            await fillFields(measureProgress, row);
            await fillMeasureField(measureProgress, row);
            measureProgresses.add(measureProgress);
          }
        }
      }
    } catch (e) {
      print('querySelectMeasureProgresses - ${e.runtimeType}, ${e}');
      rethrow;
    }
    return measureProgresses;
  }

  static Future<MeasureProgress> querySelectMeasureProgress(MeasureProgressGetRequest request) async {
    List<MeasureProgress> measureProgresses = await querySelectMeasureProgresses(request);

    if (measureProgresses.isNotEmpty) {
      return measureProgresses.first;
    } else {
      return null;
    }
  }

  /// Objective Measure Progress Notification User
  static void measureProgressNotification(MeasureProgress measureProgress, String className, int systemFunctionIndex, String description, String urlOrigin, String authUserId) async {

    if (!measureProgress.measure.objective.hasLeader()) return;

    // Not send to your-self
    if (measureProgress.measure.objective.leader.id == authUserId) return;

    // Recovery eMail and notification from User Id.
    User leaderNotification = await UserService.querySelectUser(UserGetRequest()..id = measureProgress.measure.objective.leader.id..customUser = CustomUser.userOnlySpecificationProfileNotificationEmailIdiom);

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    // Not send to your-self
    if (!leaderNotification.userProfile.eMailNotification) return;

    // Leader - eMail
    if (leaderNotification.userProfile.eMail == null) throw Exception('e-mail of the Objective Leader is null.');

    await CommonUtils.setDefaultLocale(leaderNotification.userProfile.idiomLocale);

    mailMessages.add(
        AugeMailMessageTo(
            [leaderNotification.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${ObjectiveDomainMsg.fieldLabel(objective_m.Objective.leaderField)}',
            '${ClassNameMsg.label(objective_m.Objective.className)} ${measureProgress.measure.objective.name}',
            urlOrigin));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);

  }

  /// Create current value of the [MeasureProgress]
  static Future<StringValue> queryInsertMeasureProgress(
      MeasureProgressRequest request, String urlOrigin) async {
    Map<String, dynamic> historyItemNotificationValues;
    try {

      /*
      // This is made just to recovery email leader from objective, used to notification
      request.measureProgress.measure = await querySelectMeasure(MeasureGetRequest()..id = request.measureId);
*/
      request.measureProgress.version = 0;

      await (await AugeConnection.getConnection()).transaction((ctx) async {
        if (!request.measureProgress.hasId()) {
          request.measureProgress.id = new Uuid().v4();
        }

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
          "date": request.measureProgress.hasDate() ? /* CommonUtils.dateTimeFromTimestamp(request.measureProgress.date) */ request.measureProgress.date.toDateTime() : DateTime.now().toUtc(),
          "current_value": request.measureProgress.hasCurrentValue() ? request.measureProgress.currentValue : null,
          "comment": request.measureProgress.hasComment() ? request.measureProgress.comment : null,
          "measure_id": request.measureProgress.measure.id,
        });

        // Create a history item
        historyItemNotificationValues =  {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.measureProgress.id,
          "object_version": request.measureProgress.version,
          "object_class_name": measure_m
              .MeasureProgress.className,
          "system_module_index": SystemModule.objectives.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": '${request.measureProgress.currentValue} @ ${request.measureProgress.measure.name}',
          "changed_values": history_item_m.HistoryItemHelper
              .changedValuesJson({},
                  request.measureProgress.toProto3Json(), removeUserProfileImageField: true)};


        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: historyItemNotificationValues);

      });

      // Notification
      measureProgressNotification(request.measureProgress, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return StringValue()..value = request.measureProgress.id;
  }

  /// Create current value of the [MeasureProgress]
  Future<Empty> queryUpdateMeasureProgress(
      MeasureProgressRequest request, String urlOrigin) async {

    // Recovery to log to history
    MeasureProgress previousMeasureProgress = await querySelectMeasureProgress(MeasureProgressGetRequest()..id = request.measureProgress.id);

    request.measureProgress.measure = previousMeasureProgress.measure;
    // This is made just to recovery email leader from objective, used to notification
    //request.measureProgress.measure = await querySelectMeasure(MeasureGetRequest()..id = request.measureId..withObjective = true..withUserProfile = true);

    Map<String, dynamic> historyItemNotificationValues;
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        DateTime dateTimeNow = DateTime.now().toUtc();

        List<List<dynamic>> result;

        if (!request.measureProgress.hasId()) {
          request.measureProgress.id = new Uuid().v4();
        }

        result = await ctx.query(
            "UPDATE objective.measure_progress "
                "SET date = @date, "
                "current_value = @current_value, "
                "comment = @comment, "
                "measure_id = @measure_id, "
                "version = @version "
                "WHERE id = @id AND version = @version - 1 "
                "RETURNING true"
            , substitutionValues: {
          "id": request.measureProgress.id,
          "version": ++request.measureProgress.version,
          "date": request.measureProgress.date == null
              ? dateTimeNow
              : /* CommonUtils.dateTimeFromTimestamp(request.measureProgress.date) */ request.measureProgress.date.toDateTime(),
          "current_value": request.measureProgress.hasCurrentValue() ? request.measureProgress.currentValue : null,
          "comment": request.measureProgress.hasComment() ? request.measureProgress.comment : null,
          "measure_id": request.measureProgress.measure.id,

        });

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition(
              RpcErrorDetailMessage.measurePreconditionFailed);
        } else {
          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
            "user_id": request.authUserId,
            "organization_id": request.authOrganizationId,
            "object_id": request.measureProgress.id,
            "object_version": request.measureProgress.version,
            "object_class_name": measure_m
                .MeasureProgress.className,
            "system_module_index": SystemModule.objectives.index,
            "system_function_index": SystemFunction.update.index,
            "date_time": DateTime.now().toUtc(),
            "description": '${request.measureProgress.currentValue} @ ${request.measureProgress.measure.name}',
            "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(previousMeasureProgress.toProto3Json(), request.measureProgress.toProto3Json(), removeUserProfileImageField: true)};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: historyItemNotificationValues);
        }

      });

      // Notification
      measureProgressNotification(request.measureProgress, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a [MeasureProgress] by id
  Future<Empty> queryDeleteMeasureProgress(MeasureProgressDeleteRequest request, String urlOrigin) async {

    MeasureProgress previousMeasureProgress = await querySelectMeasureProgress(MeasureProgressGetRequest()
      ..id = request.measureProgressId);

    try {

      Map<String, dynamic> historyItemNotificationValues;

      await (await AugeConnection.getConnection()).transaction((ctx) async {

          List<List<dynamic>> result = await ctx.query(
              "DELETE FROM objective.measure_progress measure_progress"
                  " WHERE measure_progress.id = @id AND measure_progress.version = @version"
                  " RETURNING true"
              , substitutionValues: {
            "id": request.measureProgressId,
            "version": request.measureProgressVersion});

          // Optimistic concurrency control
          if (result.length == 0) {
            throw new GrpcError.failedPrecondition(
                RpcErrorDetailMessage.measurePreconditionFailed);
          } else {
            // Create a history item
            historyItemNotificationValues = {"id": Uuid().v4(),
              "user_id": request.authUserId,
              "organization_id": request.authOrganizationId,
              "object_id": request.measureProgressId,
              "object_version": request.measureProgressVersion,
              "object_class_name": measure_m.MeasureProgress.className,
              "system_module_index": SystemModule.objectives.index,
              "system_function_index": SystemFunction.delete.index,
              "date_time": DateTime.now().toUtc(),
              "description": '${previousMeasureProgress.currentValue} @ ${previousMeasureProgress.measure.name}',
              "changed_values": history_item_m.HistoryItemHelper
                  .changedValuesJson(
                      previousMeasureProgress.toProto3Json(), {}, removeUserProfileImageField: true)};

            await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
                substitutionValues: historyItemNotificationValues);
          }
      });

      // Notification
      measureProgressNotification(previousMeasureProgress, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin, request.authUserId);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}