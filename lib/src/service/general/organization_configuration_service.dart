// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';

import 'package:auge_server/src/protos/generated/general/organization_configuration.pbgrpc.dart';


import 'package:auge_server/src/service/general/db_connection_service.dart';

import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/user_identity_service.dart';
import 'package:auge_server/src/service/general/user_access_service.dart';
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

    queryStatement = "SELECT organization_configuration.organization_id," //0
        " organization_configuration.version," //1
        " organization_configuration.domain" //2
        " FROM general.organization_configurations organization_configuration";

    Map<String, dynamic> substitutionValues;

    if (request.organizationId != null && request.organizationId.isNotEmpty) {
      queryStatement +=
      " WHERE organization_configuration.organization_id = @organization_id";
      substitutionValues = {
        "organization_id": request.organizationId,
      };
    } else {
      throw Exception('Organization id does not informed.');
    }

    List<OrganizationConfiguration> configurations = [];
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      for (var row in results) {
        OrganizationConfiguration configuration = OrganizationConfiguration()
          ..organizationId = row[0]
          ..version = row[1];

        if (row[2] != null)
          configuration.domain = row[2];

        configurations.add(configuration);
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
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
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query(
            "INSERT INTO general.organization_configurations(organization_id, version, domain) VALUES"
                "(@organization_id,"
                "@version,"
                "@domain)"
            , substitutionValues: {
          "organization_id": request.authOrganizationId,
          "version": request.organizationConfiguration.version,
          "domain": request.organizationConfiguration
              .domain});
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
          ..organizationId = request.organizationConfiguration.organizationId);
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.organization_configurations "
                "SET version = @version, "
                "domain = @domain "
                "WHERE organization_id = @organization_id AND version = @version - 1 "
                "RETURNING true"
            , substitutionValues: {
          "organization_id": request.organizationConfiguration.organizationId,
          "version": ++request.organizationConfiguration.version,
          "domain": request.organizationConfiguration.hasDomain() ? request.organizationConfiguration.domain : null});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty() /*..webWorkAround = true*/;
  }
}
