// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pbgrpc.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/model/general/organization.dart' as organization_m;

import 'package:uuid/uuid.dart';

class OrganizationService extends OrganizationServiceBase {

  // API
  @override
  Future<OrganizationsResponse> getOrganizations(ServiceCall call,
      OrganizationGetRequest request) async {

    return OrganizationsResponse()..webWorkAround = true..organizations.addAll(await querySelectOrganizations(request));
  }

  @override
  Future<Organization> getOrganization(ServiceCall call,
      OrganizationGetRequest request) async {
    Organization organization = await querySelectOrganization(request);
    if (organization == null) throw new GrpcError.notFound("Organization not found.");
    return organization;
  }

  @override
  Future<IdResponse> createOrganization(ServiceCall call,
      OrganizationRequest organization) {
    return queryInsertOrganization(organization);
  }

  @override
  Future<Empty> updateOrganization(ServiceCall call,
      OrganizationRequest organization) {
    return queryUpdateOrganization(organization);
  }

  @override
  Future<Empty> deleteOrganization(ServiceCall call,
      OrganizationDeleteRequest request) async {
    return queryDeleteOrganization(request);
  }

  // Query
  static Future<List<Organization>> querySelectOrganizations(OrganizationGetRequest request) async {

    var results;

    String queryStatement;

    queryStatement = "SELECT organization.id," //0
    " organization.version," //1
    " organization.name," //2
    " organization.code" //3
    " FROM general.organizations organization";

    Map<String, dynamic> substitutionValues;

    if (request.id != null && request.id.isNotEmpty) {
      queryStatement += " WHERE organization.id = @id";
      substitutionValues = {
        "id": request.id,
      };
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<Organization> organizations = new List();
    for (var row in results) {
      Organization organization = new Organization()
        ..id = row[0]
        ..version = row[1]
        ..name = row[2]
        ..code = row[3];
      organizations.add(organization);
    }
    return organizations;
  }

  static Future<Organization> querySelectOrganization(OrganizationGetRequest request, {Map<String, Organization> cache}) async {
    if (cache != null && cache.containsKey(request.id)) {
      return cache[request.id];
    } else {
      List<Organization> organizations = await querySelectOrganizations(request);
      if (organizations.isNotEmpty) {
        if (cache != null) cache[request.id] = organizations.first;
        return organizations.first;
      } else {
        return null;
      }
    }
  }

  static Future<IdResponse> queryInsertOrganization(OrganizationRequest request) async {

    if (!request.organization.hasId()) {
      request.organization.id = new Uuid().v4();
    }

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "INSERT INTO general.organizations(id, version, name, code) VALUES"
                "(@id,"
                "@version,"
                "@name,"
                "@code)"
            , substitutionValues: {
          "id": request.organization.id,
          "version": request.organization.version,
          "name": request.organization.name,
          "code": request.organization.code});

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authenticatedUserId,
          "organization_id": request.authenticatedOrganizationId,
          "object_id": request.organization.id,
          "object_version": request.organization.version,
          "object_class_name": organization_m.Organization.className,
          "system_module_index": SystemModule.groups.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.organization.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, organization_m.Organization.fromProtoBufToModelMap(request.organization, true))});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return IdResponse()
      ..id = request.organization.id;
  }

  static Future<Empty> queryUpdateOrganization(OrganizationRequest request) async {

    Organization previousOrganization = await querySelectOrganization(OrganizationGetRequest()..id = request.organization.id);

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "UPDATE general.organizations SET name = @name,"
                " version = @version,"
                " code = @code"
                " WHERE id = @id AND version = @version - 1"
            , substitutionValues: {
          "id": request.organization.id,
          "version": ++request.organization.version,
          "name": request.organization.name,
          "code": request.organization.code});

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authenticatedUserId,
          "organization_id": request.authenticatedOrganizationId,
          "object_id": request.organization.id,
          "object_version": request.organization.version,
          "object_class_name": organization_m.Organization.className,
          "system_module_index": SystemModule.groups.index,
          "system_function_index": SystemFunction.update.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.organization.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson(organization_m.Organization.fromProtoBufToModelMap(previousOrganization, true), organization_m.Organization.fromProtoBufToModelMap(request.organization, true))});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;

  }

  // Delete
  static Future<Empty> queryDeleteOrganization(OrganizationDeleteRequest request) async {

    Organization previousOrganization = await querySelectOrganization(OrganizationGetRequest()..id = request.organizationId);

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.organizations organization WHERE organization.id = @id AND organization.version = @version"
            "RETURNING true"
            , substitutionValues: {
          "id": request.organizationId,
          "version": request.organizationVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authenticatedUserId,
                "organization_id": request.authenticatedOrganizationId,
                "object_id": request.organizationId,
                "object_version": request.organizationVersion,
                "object_class_name": organization_m.Organization.className,
                "system_module_index": SystemModule.groups.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousOrganization.name,
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
              organization_m.Organization.fromProtoBufToModelMap(
              previousOrganization, true), {})});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()
      ..webWorkAround = true;
  }
}