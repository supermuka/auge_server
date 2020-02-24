// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:auge_server/src/service/work/work_service.dart';
import 'package:grpc/grpc.dart';
import 'package:auge_server/src/util/mail.dart';
import 'package:auge_shared/route/app_routes_definition.dart';
import 'package:auge_shared/message/messages.dart';
import 'package:auge_shared/message/domain_messages.dart';
import 'package:auge_shared/src/util/common_utils.dart';
import 'package:auge_shared/domain/work/work.dart' as work_m;

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/work/work_work_item.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_shared/message/rpc_error_message.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/work/work_stage.dart' as work_stage_m;

import 'package:uuid/uuid.dart';

class WorkStageService extends WorkStageServiceBase {

  // API
  @override
  Future<WorkStagesResponse> getWorkStages(ServiceCall call,
      WorkStageGetRequest stageRequest) async {
    WorkStagesResponse workStatesResponse;
    workStatesResponse = WorkStagesResponse()/*..webWorkAround = true*/
      ..workStages.addAll(
          await querySelectWorkStages(stageRequest));
    return workStatesResponse;
  }

  @override
  Future<WorkStage> getWorkStage(ServiceCall call,
      WorkStageGetRequest workStageRequest) async {
    WorkStage workStage = await querySelectWorkStage(workStageRequest);
    if (workStage == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.stageDataNotFoundReason);
    return workStage;
  }

  @override
  Future<StringValue> createWorkStage(ServiceCall call,
      WorkStageRequest request) async {
    return queryInsertWorkStage(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> updateWorkStage(ServiceCall call,
      WorkStageRequest request) async {
    return queryUpdateWorkStage(request, call.clientMetadata['origin']);
  }

  @override
  Future<Empty> deleteWorkStage(ServiceCall call,
      WorkStageDeleteRequest request) async {
    return queryDeleteWorkStage(request, call.clientMetadata['origin']);
  }


  // QUERY
  // *** WORK STAGES ***
  static Future<List<WorkStage>> querySelectWorkStages(WorkStageGetRequest workStageGetRequest /* {String workId, String id} */) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT work_stage.id," //0
        " work_stage.version," //1
        " work_stage.name," //2
        " work_stage.index," //3
        " work_stage.work_id," //4
        " work_stage.state_index" //5
        " FROM work.work_stages work_stage";

    Map<String, dynamic> substitutionValues;

    if (workStageGetRequest != null && workStageGetRequest.hasId()) {
      queryStatement += " WHERE work_stage.id = @id";
      substitutionValues = {"id": workStageGetRequest.id};
    } else if (workStageGetRequest != null && workStageGetRequest.hasWorkId() ) {
      queryStatement += " WHERE work_stage.work_id = @work_id";
      substitutionValues = {"work_id": workStageGetRequest.workId};
    } else {
      throw new GrpcError.invalidArgument( RpcErrorDetailMessage.stageInvalidArgument );
    }

    queryStatement += " ORDER BY work_stage.state_index, work_stage.index";

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: substitutionValues);

    List<WorkStage> workStages = new List();
    WorkStage workStage;
    for (var row in results) {

     // List<State> states = await StateService.querySelectStates(StateGetRequest()..id = row[5]);

      workStage = WorkStage()
        ..id = row[0]
        ..version = row[1]
        ..name = row[2]
        ..index = row[3]
        ..stateIndex = row[5];

      if (workStageGetRequest.hasWithWork() && workStageGetRequest.withWork) {
        workStage.work = await WorkService.querySelectWork(WorkGetRequest()..id = row[4]..withUserProfile = workStageGetRequest.withUserProfile);
      }

/*
      if (states.isNotEmpty) {
        workStage.state = states?.first;
      }
*/
      workStages.add(workStage);
    }

    return workStages;
  }

  static Future<WorkStage> querySelectWorkStage(WorkStageGetRequest workStageGetRequest) async {
    List<WorkStage> workStages = await querySelectWorkStages(workStageGetRequest);
    if (workStages.isNotEmpty) {
      return workStages.first;
    } else {
      return null;
    }
  }

  /// Work Stage Notification User
  static void workStageNotification(Work relatedWork, String className, int systemFunctionIndex, String description, String urlOrigin) async {

    // MODEL
    List<AugeMailMessageTo> mailMessages = [];

    // Leader  - Verify if send e-mail
    if (!relatedWork.leader.userProfile.eMailNotification) return;

    // Leader - eMail
    if (relatedWork.leader.userProfile.eMail == null) throw Exception('e-mail of the Work Stage Leader is null.');

    await CommonUtils.setDefaultLocale(relatedWork.leader.userProfile.idiomLocale);

    mailMessages.add(
        AugeMailMessageTo(
            [relatedWork.leader.userProfile.eMail],
            '${SystemFunctionMsg.inPastLabel(SystemFunction.values[systemFunctionIndex].toString().split('.').last)}',
            '${ClassNameMsg.label(className)}',
            description,
            '${ObjectiveDomainMsg.fieldLabel(work_m.Work.leaderField)}',
            '${ClassNameMsg.label(work_m.Work.className)} ${relatedWork.name}',
            '${urlOrigin}/#/${AppRoutesPath.appLayoutRoutePath}/${AppRoutesPath.worksRoutePath}?${AppRoutesQueryParam.workIdQueryParameter}=${relatedWork.id}'));

    // SEND E-MAIL
    AugeMail().sendNotification(mailMessages);

  }

  /// Create (insert) a new stage
  static Future<StringValue> queryInsertWorkStage(WorkStageRequest request, String urlOrigin) async {

    if (!request.workStage.hasId()) {
      request.workStage.id = Uuid().v4();
    }

    request.workStage.version = 0;

    try {

      // TODO (this is made just to get a user profile email, it needs to find to a way to improve the performance)
      Work work = await WorkService.querySelectWork(WorkGetRequest()..id = request.workId..withUserProfile = true);

      Map<String, dynamic> historyItemNotificationValues;

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO work.work_stages(id, version, name, index, state_index, work_id) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@index,"
                "@state_index,"
                "@work_id)"
            , substitutionValues: {
          "id": request.workStage.id,
          "version": request.workStage.version,
          "name": request.workStage.name,
          "index": request.workStage.index,
          "state_index": request.workStage.hasStateIndex() ? request.workStage.stateIndex : null,
          "work_id": request.workId});

        // Create a history item
        historyItemNotificationValues = {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.workStage.id,
          "object_version": request.workStage.version,
          "object_class_name": work_stage_m.WorkStage.className,
          "system_module_index": SystemModule.works.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.workStage.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, work_stage_m.WorkStage.fromProtoBufToModelMap(request.workStage))};

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: historyItemNotificationValues);
      });

      // Notification
      workStageNotification(work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin);


    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.workStage.id;
  }

  /// Update a Stage
  Future<Empty> queryUpdateWorkStage(WorkStageRequest request, String urlOrigin) async {

    // Recovery to log to history
    WorkStage previousStage = await querySelectWorkStage(WorkStageGetRequest()
      ..id = request.workStage.id);

    // TODO (this is made just to get a user profile email, it needs to find to a way to improve the performance)
    Work work = await WorkService.querySelectWork(WorkGetRequest()..id = request.workId..withUserProfile = true);

    Map<String, dynamic> historyItemNotificationValues;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result;

        result =  await ctx.query("UPDATE work.work_stages SET"
            " version = @version,"
            " name = @name,"
            " index = @index,"
            " state_index = @state_index,"
            " work_id = @work_id"
            " WHERE id = @id AND version = @version - 1"
            " RETURNING true "
            , substitutionValues: {
              "id": request.workStage.id,
              "version": ++request.workStage.version,
              "name": request.workStage.name,
              "index": request.workStage.index,
              "state_index": request.workStage.stateIndex,
              "work_id": request.workId});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
        } else {
          // Create a history item
          historyItemNotificationValues =  {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.workStage.id,
                "object_version": request.workStage.version,
                "object_class_name": work_stage_m
                    .WorkStage.className,
                "system_module_index": SystemModule.works.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": request.workStage.name,
                "changed_values": history_item_m.HistoryItem
                    .changedValuesJson(
                    work_stage_m.WorkStage
                        .fromProtoBufToModelMap(
                        previousStage),
                    work_stage_m.WorkStage
                        .fromProtoBufToModelMap(
                        request.workStage)
                )
              };

          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: historyItemNotificationValues);
        }
      });

      // Notification
      workStageNotification(work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin);


    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  /// Delete a stage by [id]
  static Future<Empty> queryDeleteWorkStage(WorkStageDeleteRequest request, String urlOrigin) async {

    WorkStage previousStage = await querySelectWorkStage(WorkStageGetRequest()..id = request.workStageId..withWork = true..withUserProfile = true);

    Map<String, dynamic> historyItemNotificationValues;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM work.work_stages work_stage"
                " WHERE work_stage.id = @id"
                " AND work_stage.version = @version"
                " RETURNING true "
            , substitutionValues: {
          "id": request.workStageId,
          "version": request.workStageVersion});

        // Optimistic concurrency control
        if (result.isEmpty) {
          throw new GrpcError.failedPrecondition( RpcErrorDetailMessage.workPreconditionFailed );
        } else {
          // Create a history item
          historyItemNotificationValues = {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.workStageId,
                "object_version": request.workStageVersion,
                "object_class_name": work_stage_m.WorkStage.className,
                "system_module_index": SystemModule.works.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousStage.name,
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    work_stage_m.WorkStage.fromProtoBufToModelMap(
                        previousStage, true), {})};
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: historyItemNotificationValues);
        }
      });

      // Notification
      workStageNotification(previousStage.work, historyItemNotificationValues['object_class_name'], historyItemNotificationValues['system_function_index'], historyItemNotificationValues['description'], urlOrigin);

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}