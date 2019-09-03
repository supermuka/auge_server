// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'dart:convert' show json;

import 'package:auge_server/src/protos/generated/general/organization_configuration.pb.dart';
import 'package:grpc/grpc.dart';
import 'package:dartdap/dartdap.dart' as dartdap;

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/user_identity.pb.dart';
import 'package:auge_server/src/protos/generated/general/user_access.pb.dart';

import 'package:auge_server/src/protos/generated/general/organization_directory_service.pbgrpc.dart';

import 'package:auge_server/src/service/general/organization_service.dart';

import 'package:auge_server/model/general/user_identity.dart' as user_identity_m;
import 'package:auge_server/model/general/organization_configuration.dart' as organization_configuration_m;
import 'package:auge_server/model/general/organization_directory_service.dart' as organization_directory_service_m;
import 'package:auge_server/model/general/authorization.dart' show SystemRole, SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;

import 'package:auge_server/shared/common_utils.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';

import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/user_identity_service.dart';
import 'package:auge_server/src/service/general/user_access_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/general/organization_configuration_service.dart';

import 'package:uuid/uuid.dart';

class OrganizationDirectoryServiceService extends OrganizationDirectoryServiceServiceBase {

  // API
  @override
  Future<OrganizationDirectoryService> getOrganizationDirectoryService(
      ServiceCall call,
      OrganizationDirectoryServiceGetRequest request) async {
    OrganizationDirectoryService organizationDirectoryService = await querySelectOrganizationDirectoryService(
        request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
    if (organizationDirectoryService == null) throw new GrpcError.notFound(
        "Directory Service not found.");
    return organizationDirectoryService;
  }

  @override
  Future<StringValue> createOrganizationDirectoryService(ServiceCall call,
      OrganizationDirectoryServiceRequest request) async {
    return queryInsertOrganizationDirectoryService(request);
  }

  @override
  Future<Empty> updateOrganizationDirectoryService(ServiceCall call,
      OrganizationDirectoryServiceRequest request) async {
    return queryUpdateOrganizationDirectoryService(request);
  }

  @override
  Future<Int32Value> testOrganizationDirectoryService(ServiceCall call,
      OrganizationDirectoryServiceRequest request) async {
    return Int32Value()
      ..value = await _testDirectoryService(request);
  }

  @override
  Future<Int32Value> syncOrganizationDirectoryService(ServiceCall call,
      OrganizationDirectoryServiceRequest request) async {
    return Int32Value()
      ..value = await _syncDirectoryService(request);
  }

  // Query
  static Future<
      List<OrganizationDirectoryService>> querySelectOrganizationDirectoryServices(
      OrganizationDirectoryServiceGetRequest request) async {
    var results;

    String queryStatement;

    queryStatement = "SELECT organization_directory_services.organization_id," //0
        " organization_directory_services.version," //1
        " organization_directory_services.directory_service_enabled," //2
        " organization_directory_services.host_address," //3
        " organization_directory_services.port," //4
        " organization_directory_services.ssl_tls," //5
        " organization_directory_services.sync_bind_dn," //6
        " organization_directory_services.sync_interval," //7
        " organization_directory_services.sync_last_date_time," //8
        " organization_directory_services.sync_last_result," //9
        " organization_directory_services.group_search_dn," //10
        " organization_directory_services.group_search_scope," //11
        " organization_directory_services.group_search_filter," //12
        " organization_directory_services.group_member_user_attribute," //13
        " organization_directory_services.user_attribute_for_group_relationship," //14
        " organization_directory_services.user_search_dn," //15
        " organization_directory_services.user_search_scope," //16
        " organization_directory_services.user_search_filter," //17
        " organization_directory_services.user_provider_object_id_attribute," //18
        " organization_directory_services.user_identification_attribute," //19
        " organization_directory_services.user_first_name_attribute," //20
        " organization_directory_services.user_last_name_attribute," //21
        " organization_directory_services.user_email_attribute" //22
        " FROM general.organization_configurations organization_configuration"
        " LEFT OUTER JOIN general.organization_directory_services on organization_directory_services.organization_id = organization_configuration.organization_id";

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

    List<OrganizationDirectoryService> organizationDirectoryServices = [];
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      for (var row in results) {
        OrganizationDirectoryService organizationDirectoryService = OrganizationDirectoryService()
          ..organizationId = row[0]
          ..version = row[1];

        if (row[2] != null)
          organizationDirectoryService.directoryServiceEnabled = row[2];

        if (row[3] != null)
          organizationDirectoryService.hostAddress = row[3];

        if (row[4] != null)
          organizationDirectoryService.port = row[4];

        if (row[5] != null)
          organizationDirectoryService.sslTls = row[5];

        if (row[6] != null)
          organizationDirectoryService.syncBindDn = row[6];

        /* password not saved
        if (row[11] != null)
          configuration.directoryService.syncBindPassword = row[11];

         */
        if (row[7] != null)
          organizationDirectoryService.syncInterval = row[7];

        if (row[8] != null)
          organizationDirectoryService.syncLastDateTime =
              CommonUtils.timestampFromDateTime(row[8]);

        if (row[9] != null)
          organizationDirectoryService.syncLastResult = row[9];

        if (row[10] != null)
          organizationDirectoryService.groupSearchDN = row[10];

        if (row[11] != null)
          organizationDirectoryService.groupSearchScope = row[11];

        if (row[12] != null)
          organizationDirectoryService.groupSearchFilter = row[12];

        if (row[13] != null)
          organizationDirectoryService.groupMemberUserAttribute = row[13];

        if (row[14] != null)
          organizationDirectoryService.userAttributeForGroupRelationship =
          row[14];

        if (row[15] != null)
          organizationDirectoryService.userSearchDN = row[15];

        if (row[16] != null)
          organizationDirectoryService.userSearchScope = row[16];

        if (row[17] != null)
          organizationDirectoryService.userSearchFilter = row[17];

        if (row[18] != null)
          organizationDirectoryService.userProviderObjectIdAttribute =
          row[18];

        if (row[19] != null)
          organizationDirectoryService.userIdentificationAttribute = row[19];

        if (row[20] != null)
          organizationDirectoryService.userFirstNameAttribute = row[20];

        if (row[21] != null)
          organizationDirectoryService.userLastNameAttribute = row[21];

        if (row[22] != null)
          organizationDirectoryService.userEmailAttribute = row[22];

        organizationDirectoryServices.add(organizationDirectoryService);
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return organizationDirectoryServices;
  }

  static Future<OrganizationDirectoryService> querySelectOrganizationDirectoryService(
      OrganizationDirectoryServiceGetRequest request) async {
    List<
        OrganizationDirectoryService> organizationDirectoryServices = await querySelectOrganizationDirectoryServices(
        request);
    if (organizationDirectoryServices.isNotEmpty)
      return organizationDirectoryServices.first;
    else
      return null;
  }

  /// Insert request
  /// return id
  static Future<StringValue> queryInsertOrganizationDirectoryService(
      OrganizationDirectoryServiceRequest request) async {
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
        await ctx.query(
            "INSERT INTO general.organization_directory_services("
                "organization_id, "
                "version,"
                "directory_service_enabled,"
                "sync_bind_dn,"
                "sync_interval,"
                "sync_last_date_time,"
                "sync_last_result,"
                "host_address,"
                "port,"
                "ssl_tls,"
                "group_search_dn,"
                "group_search_scope,"
                "group_search_filter,"
                "group_member_user_attribute,"
                "user_attribute_for_group_relationship,"
                "user_search_dn,"
                "user_search_scope,"
                "user_search_filter,"
                "user_provider_object_id_attribute,"
                "user_identification_attribute,"
                "user_first_name_attribute,"
                "user_last_name_attribute,"
                "user_email_attribute)"
                " VALUES("
                "@organization_id, "
                "@version,"
                "@directory_service_enabled,"
                "@sync_bind_dn,"
                "@sync_interval,"
                "@sync_last_date_time,"
                "@sync_last_result,"
                "@host_address,"
                "@port,"
                "@ssl_tls,"
                "@group_search_dn,"
                "@group_search_scope,"
                "@group_search_filter,"
                "@group_member_user_attribute,"
                "@user_attribute_for_group_relationship,"
                "@user_search_dn,"
                "@user_search_scope,"
                "@user_search_filter,"
                "@user_provider_object_id_attribute,"
                "@user_identification_attribute,"
                "@user_first_name_attribute,"
                "@user_last_name_attribute,"
                "@user_email_attribute)"
            , substitutionValues: {
          "organization_id": request.authOrganizationId,
          "version": request.organizationDirectoryService.version,
          "directory_service_enabled": request.organizationDirectoryService.directoryServiceEnabled,
          "sync_bind_dn": request.organizationDirectoryService.hasSyncBindDn() ? request.organizationDirectoryService.syncBindDn : null,
          "sync_interval": request.organizationDirectoryService.hasSyncInterval() ? request.organizationDirectoryService.syncInterval : null,
          "sync_last_date_time": request.organizationDirectoryService.hasSyncLastDateTime() ? CommonUtils
              .dateTimeFromTimestamp(
              request.organizationDirectoryService.syncLastDateTime) : null,
          "sync_last_result": request.organizationDirectoryService.hasSyncLastResult() ? request.organizationDirectoryService.syncLastResult : null,
          "host_address": request.organizationDirectoryService.hasHostAddress() ? request.organizationDirectoryService.hostAddress : null,
          "port": request.organizationDirectoryService.hasPort() ? request.organizationDirectoryService.port : null,
          "ssl_tls": request.organizationDirectoryService.hasSslTls() ? request.organizationDirectoryService.sslTls : null,
          "group_search_dn": request.organizationDirectoryService.hasGroupSearchDN() ? request.organizationDirectoryService.groupSearchDN : null,
          "group_search_scope": request.organizationDirectoryService.hasGroupSearchScope() ? request.organizationDirectoryService.groupSearchScope : null,
          "group_search_filter": request.organizationDirectoryService.hasGroupSearchFilter() ? request.organizationDirectoryService.groupSearchFilter : null,
          "group_member_user_attribute": request.organizationDirectoryService.hasGroupMemberUserAttribute() ? request.organizationDirectoryService.groupMemberUserAttribute : null,
          "user_attribute_for_group_relationship": request.organizationDirectoryService.hasUserAttributeForGroupRelationship() ? request.organizationDirectoryService.userAttributeForGroupRelationship : null,
          "user_search_dn": request.organizationDirectoryService.hasUserSearchDN() ? request.organizationDirectoryService.userSearchDN : null,
          "user_search_scope": request.organizationDirectoryService.hasUserSearchScope() ? request.organizationDirectoryService.userSearchScope : null,
          "user_search_filter": request.organizationDirectoryService.hasUserSearchFilter()  ? request.organizationDirectoryService.userSearchFilter : null,
          "user_provider_object_id_attribute": request.organizationDirectoryService.hasUserProviderObjectIdAttribute() ? request.organizationDirectoryService.userProviderObjectIdAttribute : null,
          "user_identification_attribute": request.organizationDirectoryService.hasUserIdentificationAttribute() ? request.organizationDirectoryService.userIdentificationAttribute : null,
          "user_first_name_attribute": request.organizationDirectoryService.hasUserFirstNameAttribute()  ? request.organizationDirectoryService.userFirstNameAttribute : null,
          "user_last_name_attribute": request.organizationDirectoryService.hasUserLastNameAttribute()
              ? request.organizationDirectoryService.userLastNameAttribute
              : null,
          "user_email_attribute": request.organizationDirectoryService.hasUserEmailAttribute()
              ? request.organizationDirectoryService.userEmailAttribute : null,
        });

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: {"id": Uuid().v4(),
              "user_id": request.authUserId,
              "organization_id": request.authOrganizationId,
              "object_id": request.authOrganizationId,
              "object_version": request.organizationDirectoryService.version,
              "object_class_name": organization_configuration_m
                  .OrganizationConfiguration.className,
              "system_module_index": SystemModule.configuration.index,
              "system_function_index": SystemFunction.create.index,
              "date_time": DateTime.now().toUtc(),
              "description": null,
              "changed_values": history_item_m.HistoryItem.changedValuesJson({},
                  organization_directory_service_m.OrganizationDirectoryService
                      .fromProtoBufToModelMap(
                      request.organizationDirectoryService, true))});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return StringValue()
      ..value = request.authOrganizationId;
  }

  static Future<Empty> queryUpdateOrganizationDirectoryService(
      OrganizationDirectoryServiceRequest request) async {
    OrganizationDirectoryService previousDirectoryService = await querySelectOrganizationDirectoryService(
        OrganizationDirectoryServiceGetRequest()
          ..organizationId = request.organizationDirectoryService.organizationId);
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
              "UPDATE general.organization_directory_services "
                  "SET version = @version, "
                  "directory_service_enabled = @directory_service_enabled, "
                  "sync_bind_dn = @sync_bind_dn,"
                  "sync_interval = @sync_interval, "
                  "sync_last_date_time = @sync_last_date_time, "
                  "sync_last_result = @sync_last_result, "
                  "host_address = @host_address, "
                  "port = @port, "
                  "ssl_tls = @ssl_tls, "
                  "group_search_dn = @group_search_dn, "
                  "group_search_scope = @group_search_scope, "
                  "group_search_filter = @group_search_filter, "
                  "group_member_user_attribute = @group_member_user_attribute, "
                  "user_attribute_for_group_relationship = @user_attribute_for_group_relationship, "
                  "user_search_dn = @user_search_dn, "
                  "user_search_scope = @user_search_scope, "
                  "user_search_filter = @user_search_filter, "
                  "user_provider_object_id_attribute = @user_provider_object_id_attribute, "
                  "user_identification_attribute = @user_identification_attribute, "
                  "user_first_name_attribute = @user_first_name_attribute, "
                  "user_last_name_attribute = @user_last_name_attribute, "
                  "user_email_attribute = @user_email_attribute "
                  "WHERE organization_id = @organization_id AND version = @version - 1 "
                  "RETURNING true"
              , substitutionValues: {
            "organization_id": request.organizationDirectoryService.organizationId,
            "version": ++request.organizationDirectoryService.version,
            "directory_service_enabled": request.organizationDirectoryService.directoryServiceEnabled,
            "sync_bind_dn": request.organizationDirectoryService.hasSyncBindDn() ? request.organizationDirectoryService.syncBindDn : null,
            "sync_interval": request.organizationDirectoryService.hasSyncInterval() ? request.organizationDirectoryService.syncInterval : null,
            "sync_last_date_time": request.organizationDirectoryService.hasSyncLastDateTime() ? CommonUtils
                .dateTimeFromTimestamp(
                request.organizationDirectoryService.syncLastDateTime) : null,
            "sync_last_result": request.organizationDirectoryService.hasSyncLastResult()
                ? request.organizationDirectoryService.syncLastResult
                : null,
            "host_address": request.organizationDirectoryService.hasHostAddress() ? request.organizationDirectoryService.hostAddress : null,
            "port": request.organizationDirectoryService.hasPort()
                ? request.organizationDirectoryService.port
                : null,
            "ssl_tls": request.organizationDirectoryService.hasSslTls() ? request.organizationDirectoryService.sslTls : null,
            "group_search_dn": request.organizationDirectoryService.hasGroupSearchDN()
                ? request.organizationDirectoryService.groupSearchDN
                : null,
            "group_search_scope": request.organizationDirectoryService.hasGroupSearchScope()
                ? request.organizationDirectoryService.groupSearchScope
                : null,
            "group_search_filter": request.organizationDirectoryService.hasGroupSearchFilter()
                ? request.organizationDirectoryService.groupSearchFilter
                : null,
            "group_member_user_attribute": request.organizationDirectoryService.hasGroupMemberUserAttribute() ? request
                .organizationDirectoryService.groupMemberUserAttribute : null,
            "user_attribute_for_group_relationship": request
                .organizationDirectoryService.hasUserAttributeForGroupRelationship() ? request
                .organizationDirectoryService.userAttributeForGroupRelationship : null,
            "user_search_dn": request.organizationDirectoryService.hasUserSearchDN() ? request.organizationDirectoryService.userSearchDN : null,
            "user_search_scope": request.organizationDirectoryService.hasUserSearchScope()
                ? request.organizationDirectoryService.userSearchScope
                : null,
            "user_search_filter": request.organizationDirectoryService.hasUserSearchFilter()
                ? request.organizationDirectoryService.userSearchFilter
                : null,
            "user_provider_object_id_attribute": request
                .organizationDirectoryService.hasUserProviderObjectIdAttribute() ? request
                .organizationDirectoryService.userProviderObjectIdAttribute : null,
            "user_identification_attribute": request.organizationDirectoryService.hasUserIdentificationAttribute() ? request
                .organizationDirectoryService.userIdentificationAttribute : null,
            "user_first_name_attribute": request.organizationDirectoryService.hasUserFirstNameAttribute() ? request
                .organizationDirectoryService.userFirstNameAttribute : null,
            "user_last_name_attribute": request.organizationDirectoryService.hasUserLastNameAttribute() ? request
                .organizationDirectoryService.userLastNameAttribute : null,
            "user_email_attribute": request.organizationDirectoryService.hasUserEmailAttribute()
                ? request.organizationDirectoryService.userEmailAttribute
                : null,});

      // Optimistic concurrency control
      if (result.length == 0) {
      throw new GrpcError.failedPrecondition('Precondition Failed');
      } else {

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.organizationDirectoryService.organizationId,
                "object_version": request.organizationDirectoryService.version,
                "object_class_name": organization_configuration_m
                    .OrganizationConfiguration.className,
                "system_module_index": SystemModule.configuration.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": null, // without description, at first moment
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    organization_directory_service_m.OrganizationDirectoryService
                        .fromProtoBufToModelMap(
                        previousDirectoryService, true),
                    organization_directory_service_m.OrganizationDirectoryService
                        .fromProtoBufToModelMap(
                        request.organizationDirectoryService, true))});

        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty() /*..webWorkAround = true*/;
  }

  static Future<dartdap.LdapConnection> _connectDirectoryService(String hostAddress, bool sslTls, int port) async {
    // Connect to directory service
    dartdap.LdapConnection connection = dartdap.LdapConnection(
        host: hostAddress,
        ssl: sslTls,
        port: port);

    await connection.open();

    if (connection.state != dartdap.ConnectionState.ready) {
      return null;
    } else {
      return connection;
    }
  }

  // TEST BIND
  // If dn and password is informed, set authentication and return isAuthenticated, otherwise, return true as a anonymous.
  static Future<bool> _bindDirectoryService(dartdap.LdapConnection connection, String bindDn, String bindPassword,
       [bool allowAnonymous = false]) async {
    // Authenticate. Not Anonymous
    if (!(bindDn == null && bindPassword == null)) {
      /*
      String bindPasswordDecoded = utf8.decode(base64.decode(
          bindPassword));

      connection.setAuthentication(
          bindDn,
          bindPasswordDecoded);
     */

      await connection.setAuthentication(
          bindDn,
          bindPassword);

      return connection.isAuthenticated; //connection.isAuthenticated;

    }

    return allowAnonymous;
  }

  static Future<bool> _searchGroupMemberUserDirectoryService(
      dartdap.LdapConnection connection,
      String groupSearchFilter,
      String groupMemberUserAttribute,
      String groupSearchDN,
      int groupSearchScope,
      String groupMemberUserAttributeValue) async {
    //TODO waiting for String Representation to dartdap. For while, it´s accept just one equals filter

    int startSymbol = groupSearchFilter.indexOf('(');
    int equalSymbol = groupSearchFilter.indexOf('=');
    int endSymbol = groupSearchFilter.indexOf(')');

    dartdap.Filter groupSearchFilterDartdapPrimary;
    if (startSymbol != -1 && equalSymbol != -1 && endSymbol != -1 &&
        groupSearchFilter
            .length - 1 == endSymbol) {
      String att = groupSearchFilter.substring(startSymbol + 1, equalSymbol);
      String val = groupSearchFilter.substring(equalSymbol + 1, endSymbol);

      groupSearchFilterDartdapPrimary = dartdap.Filter.equals(att, val);
    } else {
      // throw 'Group filter invalid.';
      throw Exception(
          'Group search filter must be in a simple format, i.e. (objectClass=posixGroup)');
    }

    dartdap.Filter groupSearchFilterDartdap;
    if (groupMemberUserAttribute == null) {
      throw Exception('Group member user attribute not defined.');
    } else if (groupMemberUserAttributeValue == null) {
      throw
          Exception('Group member user value not defined.');
    } else {
      groupSearchFilterDartdap = dartdap.Filter.and([
        groupSearchFilterDartdapPrimary,
        dartdap.Filter.equals(
            groupMemberUserAttribute, groupMemberUserAttributeValue)
      ]);
    }

    var searchResult = await connection.search(
        groupSearchDN, groupSearchFilterDartdap, [], scope: groupSearchScope);

    return (await searchResult.stream.length == 1);
/*
    int countEntry = 0, countAttribute = 0;
    List<String> groupMemberUsers;
    await for (var entry in searchResult.stream) {
      // Processing stream of SearchEntry
      countEntry++;
      //print("dn: ${entry.dn}");
      for (var attr in entry.attributes.values) {
        if (attr.name == groupMemberUserAttribute) {
          countAttribute++;
          for (var value in attr.values) { // attr.values is a Set
            //print("  ${attr.name}: $value");
            groupMemberUsers.add(value);
          }
        }
      }
    }

    if (countEntry > 1) {
      throw 'Too many groups found to filter ${request.organizationConfiguration.directoryService.groupSearchFilter}.';
    }

    return groupMemberUsers;
*/
  }

  static Future<int> _testDirectoryService(
      OrganizationDirectoryServiceRequest request) async {

    dartdap.LdapConnection connection;

    try {
      connection = await _connectDirectoryService(
          request.organizationDirectoryService.hostAddress,
          request.organizationDirectoryService.sslTls,
          request.organizationDirectoryService.port);
      if (connection == null) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotConnected.index;
      }

      // TEST BIND
      // Authenticate. Not Anonymous
      bool bindDirectoryService = await _bindDirectoryService(connection,
          request.organizationDirectoryService.syncBindDn,
          request.organizationDirectoryService.syncBindPassword);

      if (!bindDirectoryService) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotBoundInvalidCredentials.index;
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      return organization_directory_service_m.DirectoryServiceStatus
          .errorException.index;
    }
    return organization_directory_service_m.DirectoryServiceStatus
        .finished.index;
  }

  //TODO Avaliar a necessidde de colocar um semáfaro, de forma que quando iniciar o processo de sincronização, ninguém pode realizar qualquer alteração nos usuários, identidade e acesso
  static Future<int> _syncDirectoryService(
      OrganizationDirectoryServiceRequest request) async {

    OrganizationConfiguration organizationConfiguration = await OrganizationConfigurationService.querySelectOrganizationConfiguration(OrganizationConfigurationGetRequest()..organizationId = request.organizationDirectoryService.organizationId);

    if (organizationConfiguration == null) {
      throw 'Organization configuration not found';
    } else if (organizationConfiguration.domain == null || organizationConfiguration.domain.trim().isEmpty) {
      throw 'Organization configuration domain not found';
    }

    String userAttributeForGroupRelationship = request.organizationDirectoryService.userAttributeForGroupRelationship;

    String userSearchDN = request.organizationDirectoryService.userSearchDN;
    int userSearchScopeDN = request.organizationDirectoryService.userSearchScope;
    String userSearchFilter = request.organizationDirectoryService.userSearchFilter;
    String userProviderObjectIdAttribute = request.organizationDirectoryService.userProviderObjectIdAttribute;
    String userIdentificationAttribute = request.organizationDirectoryService.userIdentificationAttribute;
    String userEmailAttribute = request.organizationDirectoryService.userEmailAttribute;
    String userFirstNameAttribute = request.organizationDirectoryService.userFirstNameAttribute;
    String userLastNameAttribute = request.organizationDirectoryService.userLastNameAttribute;

    // OrganizationConfiguration organizationConfiguration = await OrganizationConfigurationService.querySelectOrganizationConfiguration(OrganizationConfigurationGetRequest()..organizationId = request.authOrganizationId);

    Map<String, List<String>> syncLastResult = {};

    addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent directoryServiceEvent, [String detail]) {
      syncLastResult.putIfAbsent(directoryServiceEvent.toString(), () => List<String>());
      if (detail != null) syncLastResult[directoryServiceEvent.toString()].add(detail);
    }

    dartdap.LdapConnection connection;

    try {
      connection = await _connectDirectoryService(
          request.organizationDirectoryService.hostAddress,
          request.organizationDirectoryService.sslTls,
          request.organizationDirectoryService.port);
      if (connection == null) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotConnected.index;
      }

      // TEST BIND
      // Authenticate. Not Anonymous
      bool bindDirectoryService = await _bindDirectoryService(connection,
          request.organizationDirectoryService.syncBindDn,
          request.organizationDirectoryService.syncBindPassword);

      if (!bindDirectoryService) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotBoundInvalidCredentials.index;
      }

      // TEST GROUP
      //TODO waiting for String Representation to dartdap. For while, it´s accept just one equals filter
      /*
      int startSymbol = request.organizationConfiguration.directoryService.groupSearchFilter.indexOf('(');
      int equalSymbol = request.organizationConfiguration.directoryService.groupSearchFilter.indexOf('=');
      int endSymbol = request.organizationConfiguration.directoryService.groupSearchFilter.indexOf(')');

      dartdap.Filter groupSearchFilterDartdap;
      if (startSymbol != -1 && equalSymbol != -1 && endSymbol != -1 && request.organizationConfiguration.directoryService.groupSearchFilter.length-1 == endSymbol) {

        String att = request.organizationConfiguration.directoryService.groupSearchFilter.substring(startSymbol+1, equalSymbol);
        String val = request.organizationConfiguration.directoryService.groupSearchFilter.substring(equalSymbol+1, endSymbol);

        groupSearchFilterDartdap =  dartdap.Filter.equals(att, val);
      } else {
        throw 'Group filter invalid.';
        //throw Exception('Group search filter must be in a simple format, i.e. (objectClass=posixGroup)');
      }

      var searchResult = await connection.search(groupSearchDN, groupSearchFilterDartdap, [groupMemberUserAttribute], scope: groupSearchScopeDN);

      int countEntry = 0, countAttribute = 0;
      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        countEntry++;
        //print("dn: ${entry.dn}");
        for (var attr in entry.attributes.values) {
          if (attr.name == groupMemberUserAttribute) {
            countAttribute++;
            for (var value in attr.values) { // attr.values is a Set
              //print("  ${attr.name}: $value");
              groupMemberUsers.add(value);
            }
          }
        }
      }

      if (countEntry > 1) {
        throw 'Too many groups found.';
      }

      if (countEntry == 0) {
        return organization_configuration_m.DirectoryServiceStatus
            .errorGroupNotFound.index;

      }

      if (countAttribute == 0) {
        return organization_configuration_m.DirectoryServiceStatus.errorGroupMemberAttributeNotFound.index;
      }
*/


      // SYNC USERS
      int startSymbol = userSearchFilter.indexOf('(');
      int equalSymbol = userSearchFilter.indexOf('=');
      int endSymbol = userSearchFilter.indexOf(')');

      dartdap.Filter userSearchFilterDartdap;
      if (startSymbol != -1 && equalSymbol != -1 && endSymbol != -1 &&
          userSearchFilter.length - 1 == endSymbol) {
        String att = userSearchFilter.substring(startSymbol + 1, equalSymbol);
        String val = userSearchFilter.substring(equalSymbol + 1, endSymbol);

        userSearchFilterDartdap = dartdap.Filter.equals(att, val);
      } else {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorUserFilterInvalid.index;

        //throw Exception('Account search filter must be in a simple format, i.e. (objectClass=posixAccount)');
      }


      var searchResult = await connection.search(
          userSearchDN, userSearchFilterDartdap, [
        userProviderObjectIdAttribute,
        userIdentificationAttribute,
        userEmailAttribute,
        userFirstNameAttribute,
        userLastNameAttribute,
        userAttributeForGroupRelationship
      ], scope: userSearchScopeDN);

      List<UserIdentity> usersIdentities = await UserIdentityService
          .querySelectUserIdentities(UserIdentityGetRequest()
        ..managedByOrganizationId = request.authOrganizationId
        ..withUserProfile = true);

      List<UserAccess> userAccesses = await UserAccessService
          .querySelectUserAccesses(UserAccessGetRequest()
        ..organizationId = request.authOrganizationId);

      UserIdentity userIdentity;
      int userIdentityIndex;

      Organization organization;
      organization =
      await OrganizationService.querySelectOrganization(OrganizationGetRequest()
        ..id = request.authOrganizationId);

      int countEntry = 0;
      int countProviderObjectIdAttribute = 0,
          countIdentificatorAttribute = 0,
          countEmailAttribute = 0,
          countFirstNameAttribute = 0,
          countLastNameAttribute = 0,
          countGroupRelationshipUserAttribute = 0;

      List<String> directoryServiceProviderObjectIds = [];
      List<User> usersInsertSync = [],
          usersUpdateSync = [];
      List<UserIdentity> userIdentitiesDeleteSync = [],
          userIdentitiesInsertSync = [],
          userIdentitiesUpdateSync = [];
      List<UserAccess> userAccessesDeleteSync = [],
          userAccessesInsertSync = [],
          userAccessesUpdateSync = [];

      bool userHasChanged, userIdentityHasChanged;

      String userProviderObjectIdAttributeValue,
          userIdentificationAttributeValue, userEmailAttributeValue,
          userFirstNameAttributeValue, userLastNameAttributeValue,
          userAttributeForGroupRelationshipValue;

      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        // print("DN >>>> " + entry.dn);
        countEntry++;
        print("DEBUG dn: ${entry.dn}");



        userProviderObjectIdAttributeValue = null;
        userIdentificationAttributeValue = null;
        userEmailAttributeValue = null;
        userFirstNameAttributeValue = null;
        userLastNameAttributeValue = null;
        userAttributeForGroupRelationshipValue = null;


        for (var attr in entry.attributes.values) {
          if (attr.name == userProviderObjectIdAttribute) {
            countProviderObjectIdAttribute++;

            userProviderObjectIdAttributeValue = attr.values?.first;
            directoryServiceProviderObjectIds.add(
                userProviderObjectIdAttributeValue);
          }

          // Login = samAccountName / UserPrincipalName / UID
          if (attr.name == userIdentificationAttribute) {
            countIdentificatorAttribute++;
            userIdentificationAttributeValue = attr.values?.first;
          }

          if (attr.name == userEmailAttribute) {
            countEmailAttribute++;
            userEmailAttributeValue = attr.values?.first;
          }
          if (attr.name == userFirstNameAttribute) {
            countFirstNameAttribute++;
            userFirstNameAttributeValue = attr.values?.first;
          }
          if (attr.name == userLastNameAttribute) {
            countLastNameAttribute++;
            userLastNameAttributeValue = attr.values?.first;
          }
          if (attr.name == userAttributeForGroupRelationship) {
            countGroupRelationshipUserAttribute++;
            userAttributeForGroupRelationshipValue = attr.values?.first;
          }
        }

        addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
            .entry,
            '[OK] ${userIdentificationAttributeValue} ${userAttributeForGroupRelationshipValue} DN: ${entry.dn}');

        //Verify if user is member of group
        if (!await _searchGroupMemberUserDirectoryService(
            connection, request.organizationDirectoryService.groupSearchFilter,
            request.organizationDirectoryService.groupMemberUserAttribute,
            request.organizationDirectoryService.groupSearchDN,
            request.organizationDirectoryService.groupSearchScope,
            userAttributeForGroupRelationshipValue)) {

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .skipEntry,
              '[NOK] ' + userIdentificationAttributeValue + ' ' +
                  userAttributeForGroupRelationshipValue +
                  ' >>> User not found as a group member.');

          continue;
        }

        int userIdentityIndexByIdentification;
        int indexAt;
        String userIdentificationAttributeValueFormated;

        userIdentityIndex =
            usersIdentities.indexWhere((t) => t.providerObjectId ==
                userProviderObjectIdAttributeValue);

        // If not found, a new user will be inserted.
        indexAt = userIdentificationAttributeValue.indexOf('@');

        if (indexAt == -1) {
          indexAt = userIdentificationAttributeValue.length;
        } else {
          if (userIdentificationAttributeValue != userIdentificationAttributeValue.substring(0, indexAt) + '@' +
              organizationConfiguration.domain) {

            addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
                .skipEntry,
                '[NOK] ' + userIdentificationAttributeValue +
                    ' >>> It is not to according the pattern: UserId without @ or UserId@${organizationConfiguration.domain}.');

            continue;

          }
        }

        userIdentificationAttributeValueFormated =
            userIdentificationAttributeValue.substring(0, indexAt) + '@' +
                organizationConfiguration.domain;

        // Verify if identification already exists
        if (userIdentityIndex == -1) {
          // Verify if identification already exists
          userIdentityIndexByIdentification = usersIdentities.indexWhere((t) =>
          t.identification == userIdentificationAttributeValueFormated);

          if (userIdentityIndexByIdentification == -1) {
            User user = User();
            user.managedByOrganization = organization;
            user.name = userFirstNameAttributeValue + ' ' +
                userLastNameAttributeValue;
            user.userProfile = UserProfile();
            if (userEmailAttributeValue != null && userEmailAttributeValue
                .trim()
                .isNotEmpty)
              user.userProfile.eMail = userEmailAttributeValue;

            UserIdentity userIdentity = UserIdentity();

            /// need to format to domain
            userIdentity.identification =
                userIdentificationAttributeValueFormated;
            userIdentity.user = user;
            userIdentity.provider =
                user_identity_m.UserIdentityProvider.directoryService.index;
            userIdentity.providerObjectId =
                userProviderObjectIdAttributeValue;

            UserAccess userAccess = UserAccess();

            userAccess = UserAccess();
            userAccess.user = user;
            userAccess.organization = organization;
            userAccess.accessRole =
                SystemRole.standard.index;

            usersInsertSync.add(user);
            userIdentitiesInsertSync.add(userIdentity);
            userAccessesInsertSync.add(userAccess);
          } else {

              addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
                  .skipEntry,
                  '[NOK] ' + userIdentificationAttributeValueFormated +
                      ' >>> Already exists.');
          }
        } else if (usersIdentities[userIdentityIndex].provider ==
            user_identity_m.UserIdentityProvider.directoryService.index) {
          userIdentity = usersIdentities[userIdentityIndex];

          userHasChanged = false;
          userIdentityHasChanged = false;

          if (userIdentity.user.name !=
              userFirstNameAttributeValue + ' ' + userLastNameAttributeValue) {
            userIdentity.user.name =
                userFirstNameAttributeValue + ' ' + userLastNameAttributeValue;
            userHasChanged = true;
          }

          if (userEmailAttributeValue != null &&
              userIdentity.user.userProfile.eMail != userEmailAttributeValue) {
            userIdentity.user.userProfile.eMail = userEmailAttributeValue;
            userHasChanged = true;
          }

          if (userIdentity.identification !=
              userIdentificationAttributeValueFormated) {
            userIdentity.identification =
                userIdentificationAttributeValueFormated;
            userIdentityHasChanged = true;
          }

          if (userIdentity.providerObjectId !=
              userProviderObjectIdAttributeValue) {
            userIdentity.providerObjectId = userProviderObjectIdAttributeValue;
            userIdentityHasChanged = true;
          }

          // If some value changed
          if (userHasChanged) {
            usersUpdateSync.add(userIdentity.user);
          }
          if (userIdentityHasChanged) {
            userIdentitiesUpdateSync.add(userIdentity);
            //  updateUserAccessesSync.add(userAccessRequest);
          }
        } else {

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .skipEntry,
              '[NOK] ' + userIdentificationAttributeValueFormated +
                  ' >>> Already exists with another provider id.');
        }
      }
      if (countEntry == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorUserNotFound.index;
      }

      if (countProviderObjectIdAttribute == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorProviderObjectIdAttributeNotFound.index;
      }

      if (countIdentificatorAttribute == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorIdentificationAttributeNotFound.index;
      }

      if (countEmailAttribute == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorEmailAttributeNotFound.index;
      }

      if (countFirstNameAttribute == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorFirstNameAttributeNotFound.index;
      }

      if (countLastNameAttribute == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorLastNameAttributeNotFound.index;
      }

      if (countGroupRelationshipUserAttribute == 0) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorUserAttributeForGroupRelationshipNotFound.index;
      }

      /// Delete Identity and Access

      String providerObjectId;
      int userAccessIndex;
      for (userIdentityIndex = 0; userIdentityIndex <
          usersIdentities.length; userIdentityIndex++) {
        providerObjectId = usersIdentities[userIdentityIndex].providerObjectId;
        if (providerObjectId != null && providerObjectId
            .trim()
            .isNotEmpty) {
          if (directoryServiceProviderObjectIds.indexOf(providerObjectId) ==
              -1) {
            userIdentitiesDeleteSync.add(usersIdentities[userIdentityIndex]);

            userAccessIndex = userAccesses.indexWhere((test) => test.user.id ==
                usersIdentities[userIdentityIndex].user.id);
            if (userAccessIndex != -1) {
              userAccessesDeleteSync.add(userAccesses[userAccessIndex]);
            }
          }
        }
      }

      // Insert, update or inactivate users on database



      // Not found [providerObjectId] on directory service, delete identity
      for (UserIdentity userIdentity in userIdentitiesDeleteSync) {
        UserIdentityDeleteRequest userIdentityDeleteRequest = UserIdentityDeleteRequest();
        userIdentityDeleteRequest.userIdentityId = userIdentity.id;
        userIdentityDeleteRequest.userIdentityVersion = userIdentity.version;

        userIdentityDeleteRequest.authUserId = request.authUserId;
        userIdentityDeleteRequest.authOrganizationId =
            request.authOrganizationId;

        try {
          UserIdentityService.queryDeleteUserIdentity(
              userIdentityDeleteRequest);

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userIdentityDelete,
              '[OK]  ' + userIdentity.identification + ' ' +
                  userIdentity.user.name);

        } catch (e) {
          print('${e.runtimeType}, ${e}');

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userIdentityDelete,
              '[NOK] ' + userIdentity.identification + ' ' +
                  userIdentity.user.name + ' >>> ' + e.toString());

        }
      }

      // Not found [providerObjectId] on directory service, delete access
      for (UserAccess userAccess in userAccessesDeleteSync) {
        // UserAccessService.queryDeleteUserAccess(userAccessDeleteRequest);

        UserAccessDeleteRequest userAccessDeleteRequest = UserAccessDeleteRequest();
        userAccessDeleteRequest.userAccessId = userAccess.id;
        userAccessDeleteRequest.userAccessVersion = userAccess.version;

        userAccessDeleteRequest.authUserId = request.authUserId;
        userAccessDeleteRequest.authOrganizationId = request.authOrganizationId;

        try {
          UserAccessService.queryDeleteUserAccess(userAccessDeleteRequest);

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userAccessDelete,
              '[OK]  ' + userIdentity.identification + ' ' +
                  userIdentity.user.name);

        } catch (e) {
          print('${e.runtimeType}, ${e}');
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userAccessDelete,'[NOK] ' + userIdentity.identification + ' ' +
              userIdentity.user.name + ' >>> ' + e.toString());

        }
      }

      // Update
      for (User user in usersUpdateSync) {
        UserRequest userRequest = UserRequest();
        userRequest.authUserId = request.authUserId;
        userRequest.authOrganizationId = request.authOrganizationId;

        userRequest.user = user;

        try {
          await UserService.queryUpdateUser(userRequest);
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userUpdate, '[OK]  ' + user.name);

        } catch (e) {
          print('${e.runtimeType}, ${e}');

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userUpdate,
              '[NOK] ' + user.name + ' >>> ' + e.toString());

        }
      }

      for (UserIdentity userIdentity in userIdentitiesUpdateSync) {
        UserIdentityRequest userIdentityRequest = UserIdentityRequest();
        userIdentityRequest.authUserId = request.authUserId;
        userIdentityRequest.authOrganizationId = request.authOrganizationId;
        userIdentityRequest.userIdentity = userIdentity;

        try {
          await UserIdentityService.queryUpdateUserIdentity(
              userIdentityRequest);
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userIdentityUpdate,
              '[OK]  ' + userIdentity.user.name + ' ' +
                  userIdentity.identification);

        } catch (e) {
          print('${e.runtimeType}, ${e}');

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userIdentityUpdate,
              '[NOK] ' + userIdentity.user.name + ' ' +
                  userIdentity.identification + ' >>> ' + e.toString());

        }
      }

      for (UserAccess userAccess in userAccessesUpdateSync) {
        UserAccessRequest userAccessRequest = UserAccessRequest();

        userAccessRequest.authUserId = request.authUserId;
        userAccessRequest.authOrganizationId = request.authOrganizationId;
        userAccessRequest.userAccess = userAccess;

        try {
          await UserAccessService.queryUpdateUserAccess(userAccessRequest);

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userAccessUpdate,
              '[OK]  ' + userAccess.user.name + ' ' +
                  userAccess.organization.name + ' ' +
                  SystemRole.values[userAccess.accessRole].toString());

        } catch (e) {
          print('${e.runtimeType}, ${e}');
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userAccessUpdate,
              '[NOK] ' + userAccess.user.name + ' ' +
                  userAccess.organization.name + ' ' +
                  SystemRole.values[userAccess.accessRole].toString() +
                  ' >>> ' + e.toString());

        }
      }

      // Insert
      for (User user in usersInsertSync) {
        UserRequest userRequest = UserRequest();
        userRequest.authUserId = request.authUserId;
        userRequest.authOrganizationId = request.authOrganizationId;

        userRequest.user = user;

        try {
          await UserService.queryInsertUser(userRequest);

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userInsert,'[OK]  ' + user.name);

        } catch (e) {
          print('${e.runtimeType}, ${e}');
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userInsert,'[NOK] ' + user.name + ' >>> ' + e.toString());

        }
      }

      for (UserIdentity userIdentity in userIdentitiesInsertSync) {
        UserIdentityRequest userIdentityRequest = UserIdentityRequest();
        userIdentityRequest.authUserId = request.authUserId;
        userIdentityRequest.authOrganizationId =
            request.authOrganizationId;
        userIdentityRequest.userIdentity = userIdentity;

        try {
          await UserIdentityService.queryInsertUserIdentity(
              userIdentityRequest);

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userIdentityInsert,'[OK]  ' + userIdentity.identification + ' ' +
              userIdentity.user.name);

        } catch (e) {
          print('${e.runtimeType}, ${e}');
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userIdentityInsert,
              '[NOK] ' + userIdentity.identification + ' ' +
                  userIdentity.user.name + ' >>> ' + e.toString());

        }
      }

      for (UserAccess userAccess in userAccessesInsertSync) {
        UserAccessRequest userAccessRequest = UserAccessRequest();

        userAccessRequest.authUserId = request.authUserId;
        userAccessRequest.authOrganizationId = request.authOrganizationId;
        userAccessRequest.userAccess = userAccess;
        try {
          await UserAccessService.queryInsertUserAccess(userAccessRequest);

          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userAccessInsert,
          '[OK]  ' + userAccess.user.name + ' ' +
          userAccess.organization.name + ' ' +
          SystemRole.values[userAccess.accessRole].toString());


        } catch (e) {
          print('${e.runtimeType}, ${e}');
          addSyncLastResult(organization_directory_service_m.DirectoryServiceEvent
              .userAccessInsert,'[NOK] ' + userAccess.user.name + ' ' +
              userAccess.organization.name + ' ' +
              SystemRole.values[userAccess.accessRole].toString() +
              ' >>> ' + e.toString());

        }
      }
      request.organizationDirectoryService.syncLastDateTime =
          CommonUtils.timestampFromDateTime(DateTime.now().toUtc());
      request.organizationDirectoryService.syncLastResult =
          json.encode(syncLastResult);

      OrganizationDirectoryServiceService.queryUpdateOrganizationDirectoryService(
          request);

      connection.close();
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return organization_directory_service_m.DirectoryServiceStatus.finished
        .index;



  }

  static Future<int> authDirectoryService(String organizationId, String userIdentityIdentification, String userIdentityProviderDn, String userIdentityPassword) async {

    OrganizationConfiguration organizationConfiguration = await OrganizationConfigurationService.querySelectOrganizationConfiguration(OrganizationConfigurationGetRequest()..organizationId = organizationId);
    OrganizationDirectoryService organizationDirectoryService = await OrganizationDirectoryServiceService.querySelectOrganizationDirectoryService(OrganizationDirectoryServiceGetRequest()..organizationId = organizationId);

    dartdap.LdapConnection connection;

    try {
      connection = await _connectDirectoryService(
          organizationDirectoryService.hostAddress,
          organizationDirectoryService.sslTls,
          organizationDirectoryService.port
      );
      if (connection == null) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotConnected.index;
      }

      // TEST BIND
      // Authenticate. Not Anonymous
      bool bindDirectoryService = await _bindDirectoryService(connection,
          userIdentityProviderDn,
          userIdentityPassword);

      if (!bindDirectoryService) {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotBoundInvalidCredentials.index;
      }

      int startSymbol = organizationDirectoryService.userSearchFilter.indexOf('(');
      int equalSymbol = organizationDirectoryService.userSearchFilter.indexOf('=');
      int endSymbol = organizationDirectoryService.userSearchFilter.indexOf(')');

      dartdap.Filter userSearchFilterDartdapPrimary;
      if (startSymbol != -1 && equalSymbol != -1 && endSymbol != -1 &&
          organizationDirectoryService.userSearchFilter
              .length - 1 == endSymbol) {
        String att = organizationDirectoryService
            .userSearchFilter.substring(startSymbol + 1, equalSymbol);
        String val = organizationDirectoryService
            .userSearchFilter.substring(equalSymbol + 1, endSymbol);

        userSearchFilterDartdapPrimary = dartdap.Filter.equals(att, val);
      } else {
        return organization_directory_service_m.DirectoryServiceStatus
            .errorUserFilterInvalid.index;

        //throw Exception('Account search filter must be in a simple format, i.e. (objectClass=posixAccount)');
      }

      String userIdentityIdentificationWithoutAt;
      if (userIdentityIdentification.indexOf('@') != -1) {
        userIdentityIdentificationWithoutAt = userIdentityIdentification
            .substring(
            0, userIdentityIdentification.indexOf('@'));
      } else {
        userIdentityIdentificationWithoutAt = userIdentityIdentification;
      }

      dartdap.Filter userSearchFilterDartdap = dartdap.Filter.and([
        userSearchFilterDartdapPrimary,
        dartdap.Filter.or([
          dartdap.Filter.equals(
              organizationDirectoryService.userIdentificationAttribute, userIdentityIdentification),
          dartdap.Filter.equals(
              organizationDirectoryService.userIdentificationAttribute, userIdentityIdentificationWithoutAt)
        ])
      ]);

      var searchResult = await connection.search(
          connection.bindDN, userSearchFilterDartdap, [
        organizationDirectoryService.userAttributeForGroupRelationship
      ], scope: dartdap.SearchScope.BASE_LEVEL);

      int countEntry = 0;
      String userAttributeForGroupRelationshipValue = null;
      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        // print("DN >>>> " + entry.dn);
        countEntry++;
        //print("dn: ${entry.dn}");

        for (var attr in entry.attributes.values) {
          if (attr.name == organizationDirectoryService.userAttributeForGroupRelationship) {
            userAttributeForGroupRelationshipValue = attr.values?.first;
          }
        }
      }

      if (countEntry == 0) {

        // found with DB. But not match with identification (uid, samaccountname, etc.)
        return organization_directory_service_m.DirectoryServiceStatus
            .errorNotBoundInvalidCredentials.index;

    //    throw Exception('User found by DN. But not found by identification.');
      } else if (countEntry > 1) {
        throw Exception('More than one user found.');
      }

      bool searchGroupMemberUserDirectoryService = await _searchGroupMemberUserDirectoryService(
          connection, organizationDirectoryService.groupSearchFilter,
          organizationDirectoryService.groupMemberUserAttribute,
          organizationDirectoryService.groupSearchDN,
          organizationDirectoryService.groupSearchScope,
          userAttributeForGroupRelationshipValue);

      if (!searchGroupMemberUserDirectoryService) {

        return organization_directory_service_m.DirectoryServiceStatus
            .errorUserAttributeValueForGroupRelationshipNotFound.index;
      }

      return organization_directory_service_m.DirectoryServiceStatus.finished.index;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }


}
