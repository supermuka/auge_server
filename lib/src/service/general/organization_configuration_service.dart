// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

// import 'package:auge_shared/protos/generated/general/organization.pb.dart';
import 'package:grpc/grpc.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';

import 'package:auge_shared/protos/generated/general/organization_configuration.pbgrpc.dart';

import 'package:auge_shared/domain/general/organization_configuration.dart' as organization_configuration_m;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:uuid/uuid.dart';

class OrganizationConfigurationService extends OrganizationConfigurationServiceBase {

  // API
  @override
  Future<OrganizationConfiguration> getOrganizationConfiguration(
      ServiceCall call,
      OrganizationConfigurationGetRequest request) async {
    OrganizationConfiguration organizationConfiguration = await querySelectOrganizationConfiguration(
        request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
    if (organizationConfiguration == null) throw new GrpcError.notFound(
        "Configuration not found.");
    return organizationConfiguration;
  }

  @override
  Future<StringValue> createOrganizationConfiguration(ServiceCall call,
      OrganizationConfigurationRequest request) async {
    return queryInsertOrganizationConfiguration(request);
  }

  @override
  Future<Empty> updateOrganizationConfiguration(ServiceCall call,
      OrganizationConfigurationRequest request) async {
    return queryUpdateOrganizationConfiguration(request);
  }


  // Query
  static Future<
      List<OrganizationConfiguration>> querySelectOrganizationConfigurations(
      OrganizationConfigurationGetRequest request) async {
    var results;

    String queryStatement;

    queryStatement = "SELECT organization_configuration.id," //0
        " organization_configuration.version," //1
        " organization_configuration.domain" //2
        " FROM general.organization_configurations organization_configuration";

    Map<String, dynamic> substitutionValues;

    if (request.hasId()) {
      queryStatement +=
      " WHERE organization_configuration.id = @id";
      substitutionValues = {
        "id": request.id,
      };
    } else if (request.hasOrganizationId()) {
      queryStatement +=
      " WHERE organization_configuration.organization_id = @organization_id";
      substitutionValues = {
        "organization_id": request.organizationId,
      };
    } else {
      throw Exception('Organization id or id does not informed.');
    }

    List<OrganizationConfiguration> configurations = [];
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);
      for (var row in results) {
        OrganizationConfiguration configuration = OrganizationConfiguration()
          ..id = row[0]
          ..version = row[1];

        if (row[2] != null)
          configuration.domain = row[2];

        configurations.add(configuration);
      }
    } catch (e) {
      print('querySelectOrganizationConfigurations - ${e.runtimeType}, ${e}');
      rethrow;
    }
    return configurations;
  }

  static Future<OrganizationConfiguration> querySelectOrganizationConfiguration(
      OrganizationConfigurationGetRequest request) async {
    List<
        OrganizationConfiguration> configurations = await querySelectOrganizationConfigurations(
        request);
    if (configurations.isNotEmpty)
      return configurations.first;
    else
      return null;
  }

  /// Insert request
  /// return id
  static Future<StringValue> queryInsertOrganizationConfiguration(
      OrganizationConfigurationRequest request) async {

    if (!request.organizationConfiguration.hasId()) {
      request.organizationConfiguration.id = Uuid().v4();
    }
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO general.organization_configurations(id, version, domain, organization_id) "
                "VALUES(@id,"
                "@version,"
                "@domain,"
                "@organization_id)"
            , substitutionValues: {
          "id": request.organizationConfiguration.id,
          "version": request.organizationConfiguration.version,
          "domain": request.organizationConfiguration.hasDomain() ? request.organizationConfiguration.domain : null,
          "organization_id": request.authOrganizationId});

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: {"id": Uuid().v4(),
              "user_id": request.authUserId,
              "organization_id": request.authOrganizationId,
              "object_id": request.organizationConfiguration.id,
              "object_version": request.organizationConfiguration.version,
              "object_class_name": organization_configuration_m
                  .OrganizationConfiguration.className,
              "system_module_index": SystemModule.organization.index,
              "system_function_index": SystemFunction.create.index,
              "date_time": DateTime.now().toUtc(),
              "description": null, // without description, at first moment
              "changed_values": history_item_m.HistoryItemHelper.changedValuesJson({},
                      request.organizationConfiguration.toProto3Json(), removeUserProfileImageField: true)});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return StringValue()
      ..value = request.authOrganizationId;
  }

  static Future<Empty> queryUpdateOrganizationConfiguration(
      OrganizationConfigurationRequest request) async {
    OrganizationConfiguration previousConfiguration = await querySelectOrganizationConfiguration(
        OrganizationConfigurationGetRequest()
          ..organizationId = request.organizationConfiguration.organization.id);
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.organization_configurations "
                "SET version = @version, "
                "domain = @domain, "
                "organization_id = @organization_id "
                "WHERE id = @id AND version = @version - 1 "
                "RETURNING true"
            , substitutionValues: {
          "id": request.organizationConfiguration.id,
          "version": ++request.organizationConfiguration.version,
          "domain": request.organizationConfiguration.hasDomain() ? request.organizationConfiguration.domain : null,
          "organization_id": request.authOrganizationId});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.organizationConfiguration.id,
                "object_version": request.organizationConfiguration.version,
                "object_class_name": organization_configuration_m
                    .OrganizationConfiguration.className,
                "system_module_index": SystemModule.organization.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": null, // without description, at first moment
                "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                        previousConfiguration.toProto3Json(),
                        request.organizationConfiguration.toProto3Json(), removeUserProfileImageField: true)});
      }});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty() /*..webWorkAround = true*/;
  }
}