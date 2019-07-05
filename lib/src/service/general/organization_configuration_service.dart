// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:dartdap/dartdap.dart' as dartdap;

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization_configuration.pbgrpc.dart';

import 'package:auge_server/model/general/organization_configuration.dart' as organization_configuration_m;
import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;

import 'package:auge_server/shared/common_utils.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:uuid/uuid.dart';

class OrganizationConfigurationService extends OrganizationConfigurationServiceBase {

  // API
  @override
  Future<OrganizationConfiguration> getOrganizationConfiguration(ServiceCall call,
      OrganizationConfigurationGetRequest request) async {
    OrganizationConfiguration organizationConfiguration = await querySelectOrganizationConfiguration(request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
    if (organizationConfiguration == null) throw new GrpcError.notFound("Configuration not found.");
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

  @override
  Future<Int32Value> testDirectoryService(ServiceCall call,
      OrganizationConfigurationRequest request) async {

    return Int32Value()..value = await _testDirectoryService(request);
  }

  // Query
  static Future<List<OrganizationConfiguration>> querySelectOrganizationConfigurations(OrganizationConfigurationGetRequest request) async {

    var results;

    String queryStatement;

    queryStatement = "SELECT organization_configuration.organization_id," //0
        " organization_configuration.version," //1
        " organization_configuration.directory_service_enabled," //2
        " organization_directory_service.sync_interval," //3
        " organization_directory_service.last_sync," //4
        " organization_directory_service.host_address," //5
        " organization_directory_service.port," //6
        " organization_directory_service.ssl_tls," //7
        " organization_directory_service.admin_bind_dn," //8
        " organization_directory_service.admin_password," //9
        " organization_directory_service.group_search_dn," //10
        " organization_directory_service.group_search_scope," //11
        " organization_directory_service.group_search_filter," //12
        " organization_directory_service.group_member_attribute," //13
        " organization_directory_service.user_search_dn," //14
        " organization_directory_service.user_search_scope," //15
        " organization_directory_service.user_search_filter," //16
        " organization_directory_service.user_login_attribute," //17
        " organization_directory_service.user_first_name_attribute," //18
        " organization_directory_service.user_last_name_attribute," //19
        " organization_directory_service.user_email_attribute" //20
        " FROM general.organization_configurations organization_configuration"
        " LEFT OUTER JOIN general.organization_directory_service on organization_directory_service.organization_id = organization_configuration.organization_id";

    Map<String, dynamic> substitutionValues;

    if (request.organizationId != null && request.organizationId.isNotEmpty) {
      queryStatement += " WHERE organization_configuration.organization_id = @organization_id";
      substitutionValues = {
        "organization_id": request.organizationId,
      };
    } else {
      throw Exception('Organization id does not informed.');
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<OrganizationConfiguration> configurations = [];
    for (var row in results) {
      OrganizationConfiguration configuration = OrganizationConfiguration()
        ..organizationId = row[0]
        ..version = row[1]
        ..directoryServiceEnabled = row[2];


      if (row[3] != null)
        configuration.directoryService.syncInterval = row[3];
      if (row[4] != null)
        configuration.directoryService.lastSync = row[4];
      if (row[5] != null)
        configuration.directoryService.hostAddress = row[5];
      if (row[6] != null)
        configuration.directoryService.port = row[6];
      if (row[7] != null)
        configuration.directoryService.sslTls = row[7];
      if (row[8] != null)
        configuration.directoryService.adminBindDN = row[8];
      if (row[9] != null)
        configuration.directoryService.adminPassword = row[9];
      if (row[10] != null)
        configuration.directoryService.groupSearchDN = row[10];
      if (row[11] != null)
        configuration.directoryService.groupSearchScope = row[11];
      if (row[12] != null)
        configuration.directoryService.groupSearchFilter = row[12];
      if (row[13] != null)
        configuration.directoryService.groupMemberAttribute = row[13];
      if (row[14] != null)
        configuration.directoryService.userSearchDN = row[14];
      if (row[15] != null)
        configuration.directoryService.userSearchScope = row[15];
      if (row[16] != null)
        configuration.directoryService.userSearchFilter = row[16];
      if (row[17] != null)
        configuration.directoryService.userLoginAttribute = row[17];
      if (row[18] != null)
        configuration.directoryService.userFirstNameAttribute = row[18];
      if (row[19] != null)
        configuration.directoryService.userLastNameAttribute = row[19];
      if (row[20] != null)
        configuration.directoryService.userEmailAttribute = row[20];

      configurations.add(configuration);
    }
    print('DEBUG PASSOU DA LISTA');
    print(configurations);
    return configurations;
  }

  static Future<OrganizationConfiguration> querySelectOrganizationConfiguration(OrganizationConfigurationGetRequest request) async {
      List<OrganizationConfiguration> configurations = await querySelectOrganizationConfigurations(request);
      if (configurations.isNotEmpty)
        return configurations.first;
      else
        return null;
  }

  /// Insert request
  /// return id
  static Future<StringValue> queryInsertOrganizationConfiguration(OrganizationConfigurationRequest request) async {

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO general.organization_configurations(organization_id, version, directory_service_enabled, organization_id) VALUES"
                "(@organization_id,"
                "@version,"
                "@directory_service_enabled)"
            , substitutionValues: {
          "organization_id": request.organizationConfiguration.organizationId,
          "version": request.organizationConfiguration.version,
          "directory_service_enabled": request.organizationConfiguration.directoryServiceEnabled});

        await ctx.query(
            "INSERT INTO general.organization_directory_service("
                "configuration_id, "
                "sync_interval,"
                "last_sync,"
                "host_address,"
                "port,"
                "ssl_tls,"
                "admin_bind_dn,"
                "admin_password,"
                "group_search_dn,"
                "group_search_scope,"
                "group_search_filter,"
                "group_member_attribute,"
                "user_search_dn,"
                "user_search_scope,"
                "user_search_filter,"
                "user_login_attribute,"
                "user_first_name_attribute,"
                "user_last_name_attribute,"
                "user_email_attribute)"
                " VALUES("
                "@configuration_id, "
                "@sync_interval,"
                "@last_sync,"
                "@host_address,"
                "@port,"
                "@ssl_tls,"
                "@admin_bind_dn,"
                "@admin_password,"
                "@group_search_dn,"
                "@group_search_scope,"
                "@group_search_filter,"
                "@group_member_attribute,"
                "@user_search_dn,"
                "@user_search_scope,"
                "@user_search_filter,"
                "@user_login_attribute,"
                "@user_first_name_attribute,"
                "@user_last_name_attribute,"
                "@user_email_attribute)"
            , substitutionValues: {
              "configuration_id": request.organizationConfiguration.organizationId,
            "sync_interval": request.organizationConfiguration.directoryService.hasSyncInterval() ? request.organizationConfiguration.directoryService.syncInterval : null,
            "last_sync": request.organizationConfiguration.directoryService.hasLastSync() ? CommonUtils.dateTimeFromTimestamp(request.organizationConfiguration.directoryService.lastSync): null,
            "host_address": request.organizationConfiguration.directoryService.hasHostAddress() ? request.organizationConfiguration.directoryService.hostAddress: null,
            "port": request.organizationConfiguration.directoryService.hasPort() ? request.organizationConfiguration.directoryService.port: null,
            "ssl_tls": request.organizationConfiguration.directoryService.hasSslTls() ? request.organizationConfiguration.directoryService.sslTls: null,
            "admin_bind_dn": request.organizationConfiguration.directoryService.hasAdminBindDN() ? request.organizationConfiguration.directoryService.adminBindDN: null,
            "admin_password": request.organizationConfiguration.directoryService.hasAdminPassword() ? request.organizationConfiguration.directoryService.adminPassword: null,
            "group_search_dn": request.organizationConfiguration.directoryService.hasGroupSearchDN() ? request.organizationConfiguration.directoryService.groupSearchDN: null,
            "group_search_scope": request.organizationConfiguration.directoryService.hasGroupSearchScope() ? request.organizationConfiguration.directoryService.groupSearchScope: null,
            "group_search_filter": request.organizationConfiguration.directoryService.hasGroupSearchFilter() ? request.organizationConfiguration.directoryService.groupSearchFilter: null,
            "group_member_attribute": request.organizationConfiguration.directoryService.hasGroupMemberAttribute() ? request.organizationConfiguration.directoryService.groupMemberAttribute: null,
            "user_search_dn": request.organizationConfiguration.directoryService.hasUserSearchDN() ? request.organizationConfiguration.directoryService.userSearchDN: null,
            "user_search_scope": request.organizationConfiguration.directoryService.hasUserSearchScope() ? request.organizationConfiguration.directoryService.userSearchScope: null,
            "user_search_filter": request.organizationConfiguration.directoryService.hasUserSearchFilter() ? request.organizationConfiguration.directoryService.userSearchFilter: null,
            "user_login_attribute": request.organizationConfiguration.directoryService.hasUserLoginAttribute() ? request.organizationConfiguration.directoryService.userLoginAttribute: null,
            "user_first_name_attribute": request.organizationConfiguration.directoryService.hasUserFirstNameAttribute() ? request.organizationConfiguration.directoryService.userFirstNameAttribute: null,
            "user_last_name_attribute": request.organizationConfiguration.directoryService.hasUserLastNameAttribute() ? request.organizationConfiguration.directoryService.userLastNameAttribute: null,
            "user_email_attribute": request.organizationConfiguration.directoryService.hasUserEmailAttribute() ? request.organizationConfiguration.directoryService.userEmailAttribute: null,
            });

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authenticatedUserId,
          "organization_id": request.authenticatedOrganizationId,
          "object_id": request.organizationConfiguration.organizationId,
          "object_version": request.organizationConfiguration.version,
          "object_class_name": organization_configuration_m.OrganizationConfiguration.className,
          "system_module_index": SystemModule.configuration.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": null,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, organization_configuration_m.OrganizationConfiguration.fromProtoBufToModelMap(request.organizationConfiguration, true))});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return StringValue()
      ..value = request.organizationConfiguration.organizationId;
  }

  static Future<Empty> queryUpdateOrganizationConfiguration(OrganizationConfigurationRequest request) async {

    OrganizationConfiguration previousConfiguration = await querySelectOrganizationConfiguration(OrganizationConfigurationGetRequest()..organizationId = request.organizationConfiguration.organizationId);
    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result =  await ctx.query(
            "UPDATE general.organization_configurations"
            "SET version = @version, "
            "directory_service_enabled = @directory_service_enabled"
            "WHERE organization_id = @organization_id AND version = @version - 1"
            , substitutionValues: {
          "organization_id": request.organizationConfiguration.organizationId,
          "version": request.organizationConfiguration.version,
          "directory_service_enabled": request.organizationConfiguration.directoryServiceEnabled});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          await ctx.query(
              "UPDATE general.organization_directory_service "
              "SET sync_interval = @sync_interval, "
              "last_sync = @last_sync, "
              "host_address = @host_address, "
              "port = @port, "
              "ssl_tls = @ssl_tls, "
              "admin_bind_dn = @admin_bind_dn, "
              "admin_password = @admin_password, "
              "group_search_dn = @group_search_dn, "
              "group_search_scope = @group_search_scope, "
              "group_search_filter = @group_search_filter, "
              "group_member_attribute = @group_member_attribute, "
              "user_search_dn = @user_search_dn, "
              "user_search_scope = @user_search_scope, "
              "user_search_filter = @user_search_filter, "
              "user_login_attribute = @user_login_attribute, "
              "user_first_name_attribute = @user_first_name_attribute, "
              "user_last_name_attribute = @user_last_name_attribute, "
              "user_email_attribute = @user_email_attribute "
              " WHERE organizaion_id = @organization_id "
              , substitutionValues: {
            "configuration_id": request.organizationConfiguration.organizationId,
            "sync_interval": request.organizationConfiguration.directoryService.hasSyncInterval() ? request.organizationConfiguration.directoryService.syncInterval : null,
            "last_sync": request.organizationConfiguration.directoryService.hasLastSync() ? CommonUtils.dateTimeFromTimestamp(request.organizationConfiguration.directoryService.lastSync): null,
            "host_address": request.organizationConfiguration.directoryService.hasHostAddress() ? request.organizationConfiguration.directoryService.hostAddress: null,
            "port": request.organizationConfiguration.directoryService.hasPort() ? request.organizationConfiguration.directoryService.port: null,
            "ssl_tls": request.organizationConfiguration.directoryService.hasSslTls() ? request.organizationConfiguration.directoryService.sslTls: null,
            "admin_bind_dn": request.organizationConfiguration.directoryService.hasAdminBindDN() ? request.organizationConfiguration.directoryService.adminBindDN: null,
            "admin_password": request.organizationConfiguration.directoryService.hasAdminPassword() ? request.organizationConfiguration.directoryService.adminPassword: null,
            "group_search_dn": request.organizationConfiguration.directoryService.hasGroupSearchDN() ? request.organizationConfiguration.directoryService.groupSearchDN: null,
            "group_search_scope": request.organizationConfiguration.directoryService.hasGroupSearchScope() ? request.organizationConfiguration.directoryService.groupSearchScope: null,
            "group_search_filter": request.organizationConfiguration.directoryService.hasGroupSearchFilter() ? request.organizationConfiguration.directoryService.groupSearchFilter: null,
            "group_member_attribute": request.organizationConfiguration.directoryService.hasGroupMemberAttribute() ? request.organizationConfiguration.directoryService.groupMemberAttribute: null,
            "user_search_dn": request.organizationConfiguration.directoryService.hasUserSearchDN() ? request.organizationConfiguration.directoryService.userSearchDN: null,
            "user_search_scope": request.organizationConfiguration.directoryService.hasUserSearchScope() ? request.organizationConfiguration.directoryService.userSearchScope: null,
            "user_search_filter": request.organizationConfiguration.directoryService.hasUserSearchFilter() ? request.organizationConfiguration.directoryService.userSearchFilter: null,
            "user_login_attribute": request.organizationConfiguration.directoryService.hasUserLoginAttribute() ? request.organizationConfiguration.directoryService.userLoginAttribute: null,
            "user_first_name_attribute": request.organizationConfiguration.directoryService.hasUserFirstNameAttribute() ? request.organizationConfiguration.directoryService.userFirstNameAttribute: null,
            "user_last_name_attribute": request.organizationConfiguration.directoryService.hasUserLastNameAttribute() ? request.organizationConfiguration.directoryService.userLastNameAttribute: null,
            "user_email_attribute": request.organizationConfiguration.directoryService.hasUserEmailAttribute() ? request.organizationConfiguration.directoryService.userEmailAttribute: null,});

          await ctx.query(
              "UPDATE general.organization_directory_service "
                  " SET version = @version,"
                  " WHERE configuration_id = @configuration_id"
              , substitutionValues: {
            "id": request.organizationConfiguration.organizationId,
            "version": ++request.organizationConfiguration.version,
            "directory_service_enabled": request.organizationConfiguration
                .directoryServiceEnabled});

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authenticatedUserId,
                "organization_id": request.authenticatedOrganizationId,
                "object_id": request.organizationConfiguration.organizationId,
                "object_version": request.organizationConfiguration.version,
                "object_class_name": organization_configuration_m.OrganizationConfiguration.className,
                "system_module_index": SystemModule.configuration.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": null, // without description, at first moment
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    organization_configuration_m.OrganizationConfiguration.fromProtoBufToModelMap(
                        previousConfiguration, true),
                    organization_configuration_m.OrganizationConfiguration.fromProtoBufToModelMap(
                        request.organizationConfiguration, true))});
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  // Operation
  Future<int> _testDirectoryService(OrganizationConfigurationRequest request) async {
    _processDirectoryService(request);
  }

  Future<int> _syncDirectoryService(OrganizationConfigurationRequest request) async {
    _processDirectoryService(request, sync: true);
  }


  Future<int> _processDirectoryService(OrganizationConfigurationRequest request, {bool sync = false}) async {
    String hostAddress = request.organizationConfiguration.directoryService.hostAddress;
    int port = request.organizationConfiguration.directoryService.port;
    bool sslTls = request.organizationConfiguration.directoryService.sslTls;

    String adminBindDN = request.organizationConfiguration.directoryService.adminBindDN;
    String adminPassword = request.organizationConfiguration.directoryService.adminPassword;

    String groupSearchDN = request.organizationConfiguration.directoryService.groupSearchDN;
    int groupSearchScopeDN = request.organizationConfiguration.directoryService.groupSearchScope;
    String groupSearchFilter = request.organizationConfiguration.directoryService.groupSearchFilter;
    String groupMemberAttribute  = request.organizationConfiguration.directoryService.groupMemberAttribute;

    String userSearchDN = request.organizationConfiguration.directoryService.userSearchDN;
    int userSearchScopeDN = request.organizationConfiguration.directoryService.userSearchScope;
    String userSearchFilter = request.organizationConfiguration.directoryService.userSearchFilter;
    String userLoginAttribute  = request.organizationConfiguration.directoryService.userLoginAttribute;
    String userEmailAttribute = request.organizationConfiguration.directoryService.userEmailAttribute;
    String userFirstNameAttribute  = request.organizationConfiguration.directoryService.userFirstNameAttribute;
    String userLastNameAttribute = request.organizationConfiguration.directoryService.userLastNameAttribute;

    dartdap.LdapConnection connection;

    try {

      // TEST CONNECTION
      connection = dartdap.LdapConnection(host: hostAddress, ssl: sslTls, port: port);

      await connection.open();

      if (connection.state != dartdap.ConnectionState.ready)
        return organization_configuration_m.DirectoryServiceStatus.errorNotConnected.index;

      // TEST BIND
      await connection.setAuthentication(adminBindDN, adminPassword);

      if (!connection.isAuthenticated)
        return organization_configuration_m.DirectoryServiceStatus.errorNotBindedInvalidCredentials.index;

      // TEST GROUP
      //TODO waiting for String Representation to dartdap. For while, it´s accept just one equals filter
      int startSymbol = groupSearchFilter.indexOf('(');
      int equalSymbol = groupSearchFilter.indexOf('=');
      int endSymbol = groupSearchFilter.indexOf(')');

      dartdap.Filter groupSearchFilterDartdap;
      if (startSymbol != -1 && equalSymbol != -1 && endSymbol != -1 && groupSearchFilter.length-1 == endSymbol) {

        String att = groupSearchFilter.substring(startSymbol+1, equalSymbol);
        String val = groupSearchFilter.substring(equalSymbol+1, endSymbol);

        groupSearchFilterDartdap =  dartdap.Filter.equals(att, val);
      } else {
        throw Exception('Group search filter must be in a simple format, i.e. (objectClass=posixGroup)');
      }

      var searchResult = await connection.search(groupSearchDN, groupSearchFilterDartdap, [groupMemberAttribute], scope: groupSearchScopeDN);

      int countEntry = 0, countAttribute = 0;
      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        countEntry++;
        //print("dn: ${entry.dn}");
        for (var attr in entry.attributes.values) {
          if (attr.name == groupMemberAttribute)
            countAttribute++;
          //for (var value in attr.values) { // attr.values is a Set
          //  print("  ${attr.name}: $value");
          //}
        }
      }

      if (countEntry == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorGroupNotFound.index;

      if (countEntry > 1)
        return organization_configuration_m.DirectoryServiceStatus.errorManyGroupsFound.index;

      if (countAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorGroupMemberAttributeNotFound.index;

      // TEST USER
      startSymbol = userSearchFilter.indexOf('(');
      equalSymbol = userSearchFilter.indexOf('=');
      endSymbol = userSearchFilter.indexOf(')');

      dartdap.Filter userSearchFilterDartdap;
      if (startSymbol != -1 && equalSymbol != -1 && endSymbol != -1 && userSearchFilter.length-1 == endSymbol) {

        String att = userSearchFilter.substring(startSymbol+1, equalSymbol);
        String val = userSearchFilter.substring(equalSymbol+1, endSymbol);

        userSearchFilterDartdap =  dartdap.Filter.equals(att, val);
      } else {
        throw Exception('Account search filter must be in a simple format, i.e. (objectClass=posixAccount)');
      }

      searchResult = await connection.search(userSearchDN, userSearchFilterDartdap, [userLoginAttribute, userEmailAttribute, userFirstNameAttribute, userLastNameAttribute], scope: userSearchScopeDN);

/*
      print('DEBUG');
      print(connection.state);
      print(userSearchDN);
      print(userSearchFilterDartdap);
      print([userLoginAttribute, userEmailAttribute, userFirstNameAttribute, userLastNameAttribute]);
      print(userSearchScopeDN);
*/
      countEntry = 0;
      int countLoginAttribute = 0,
        countEmailAttribute = 0,
        countFirstNameAttribute = 0,
        countLastNameAttribute = 0;

      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        print(entry.dn);
        countEntry++;
        //print("dn: ${entry.dn}");
        for (var attr in entry.attributes.values) {
          if (attr.name == userLoginAttribute)
             countLoginAttribute++;
          if (attr.name == userEmailAttribute)
             countEmailAttribute++;
          if (attr.name == userFirstNameAttribute)
            countFirstNameAttribute++;
          if (attr.name == userLastNameAttribute)
            countLastNameAttribute++;
          //for (var value in attr.values) { // attr.values is a Set
          //  print("  ${attr.name}: $value");
          //}
        }
        // Test just first entry to verify if there are attributes;
      }

      if (countEntry == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorUserNotFound.index;

      if (countLoginAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorLoginAttribute.index;

      if (countEmailAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorEmailAttribute.index;

      if (countFirstNameAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorFirstNameAttribute.index;

      if (countLastNameAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorLastNameAttribute.index;

      if (sync) {

      }

      connection.close();
    } catch (e) {
      print(e);
      rethrow;
    }
    return organization_configuration_m.DirectoryServiceStatus.success.index;
  }
}