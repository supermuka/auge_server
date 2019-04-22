// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pbgrpc.dart';

import 'package:auge_server/augeconnection.dart';

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
      OrganizationRequest organization) async {
    return queryDeleteOrganization(organization);
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

    try {
      await (await AugeConnection.getConnection()).query(
          "INSERT INTO general.organizations(id, name, code) VALUES"
              "(@id,"
              "@name,"
              "@code)"
          , substitutionValues: {
        "id": request.organization.id,
        "name": request.organization.name,
        "code": request.organization.code});

      return IdResponse()..id = request.organization.id;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  static Future<Empty> queryUpdateOrganization(OrganizationRequest request) async {
    try {
      await (await AugeConnection.getConnection()).query(
          "UPDATE general.organizations SET name = @name,"
              " code = @code"
              " WHERE id = @id "
          , substitutionValues: {
        "id": request.organization.id,
        "name": request.organization.name,
        "code": request.organization.code});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()..webWorkAround = true;

  }

  // Delete
  static Future<Empty> queryDeleteOrganization(OrganizationRequest request) async {
    try {
      await (await AugeConnection.getConnection()).query(
          "DELETE FROM general.organizations organization WHERE organization.id = @id"
          , substitutionValues: {
        "id": request.organization.id});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()..webWorkAround = true;
  }
}