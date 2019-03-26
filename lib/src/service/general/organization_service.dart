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
    return OrganizationsResponse()..organizations.addAll(await querySelectOrganizations(request));
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
      Organization organization) {
    return queryInsertOrganization(organization);
  }

  @override
  Future<Empty> updateOrganization(ServiceCall call,
      Organization organization) {
    return queryUpdateOrganization(organization);
  }

  @override
  Future<Empty> deleteOrganization(ServiceCall call,
      Organization organization) async {
    return queryDeleteOrganization(organization);
  }

  @override
  Future<Empty> softDeleteOrganization(ServiceCall call,
      Organization organization) {
    organization.isDeleted = true;
    return queryUpdateOrganization(organization);
  }

  // Query
  static Future<List<Organization>> querySelectOrganizations(OrganizationGetRequest request) async {

    var results;

    String queryStatement;

    queryStatement = "SELECT organization.id," //0
    " organization.version," //1
    " organization.is_deleted," //2
    " organization.name," //3
    " organization.code" //4
    " FROM auge.organizations organization";

    Map<String, dynamic> substitutionValues;

    if (request.id != null && request.id.isNotEmpty) {
      queryStatement += " WHERE organization.id = @id AND organization.is_deleted = @is_deleted";
      substitutionValues = {
        "id": request.id,
        "is_deleted": request.isDeleted
      };
    } else {
      queryStatement += " WHERE organization.is_deleted = @is_deleted";
      substitutionValues = {
        "is_deleted": request.isDeleted
      };
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<Organization> organizations = new List();
    for (var row in results) {
      Organization organization = new Organization()
        ..id = row[0]
        ..version = row[1]
        ..isDeleted = row[2]
        ..name = row[3]
        ..code = row[4];
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

  static Future<IdResponse> queryInsertOrganization(Organization organization) async {

    if (!organization.hasId()) {
      organization.id = new Uuid().v4();
    }

    try {
      await (await AugeConnection.getConnection()).query(
          "INSERT INTO auge.organizations(id, name, code) VALUES"
              "(@id,"
              "@name,"
              "@code)"
          , substitutionValues: {
        "id": organization.id,
        "name": organization.name,
        "code": organization.code});

      return IdResponse()..id = organization.id;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  static Future<Empty> queryUpdateOrganization(Organization organization) async {
    try {
      await (await AugeConnection.getConnection()).query(
          "UPDATE auge.organizations SET name = @name,"
              " code = @code"
              " WHERE id = @id "
          , substitutionValues: {
        "id": organization.id,
        "name": organization.name,
        "code": organization.code});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty();

  }

  // Delete
  static Future<Empty> queryDeleteOrganization(Organization organization) async {
    try {
      await (await AugeConnection.getConnection()).query(
          "DELETE FROM auge.organizations organization WHERE organization.id = @id"
          , substitutionValues: {
        "id": organization.id});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty();
  }
}