// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'dart:convert' show base64, utf8;

import 'package:grpc/grpc.dart';
import 'package:dartdap/dartdap.dart' as dartdap;

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/user_identity.pb.dart';
import 'package:auge_server/src/protos/generated/general/user_access.pb.dart';

import 'package:auge_server/src/protos/generated/general/organization_configuration.pbgrpc.dart';

import 'package:auge_server/src/service/general/organization_service.dart';

import 'package:auge_server/model/general/user_identity.dart' as user_identity_m;
import 'package:auge_server/model/general/organization_configuration.dart' as organization_configuration_m;
import 'package:auge_server/model/general/authorization.dart' show SystemRole, SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;

import 'package:auge_server/shared/common_utils.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';

import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/user_identity_service.dart';
import 'package:auge_server/src/service/general/user_access_service.dart';
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

  @override
  Future<Int32Value> syncDirectoryService(ServiceCall call,
      OrganizationConfigurationRequest request) async {

    return Int32Value()..value = await _syncDirectoryService(request);
  }

  // Query
  static Future<List<OrganizationConfiguration>> querySelectOrganizationConfigurations(OrganizationConfigurationGetRequest request) async {

    var results;

    String queryStatement;

    queryStatement = "SELECT organization_configuration.organization_id," //0
        " organization_configuration.version," //1
        " organization_configuration.domain," //2
        " organization_configuration.directory_service_enabled," //3
        " organization_directory_services.sync_interval," //4
        " organization_directory_services.last_sync," //5
        " organization_directory_services.host_address," //6
        " organization_directory_services.port," //7
        " organization_directory_services.ssl_tls," //8
        " organization_directory_services.password_format," //9
        " organization_directory_services.admin_bind_dn," //10
        " organization_directory_services.admin_password," //11
        " organization_directory_services.group_search_dn," //12
        " organization_directory_services.group_search_scope," //13
        " organization_directory_services.group_search_filter," //14
        " organization_directory_services.group_member_attribute," //15
        " organization_directory_services.user_search_dn," //16
        " organization_directory_services.user_search_scope," //17
        " organization_directory_services.user_search_filter," //18
        " organization_directory_services.user_provider_object_id_attribute," //19
        " organization_directory_services.user_identification_attribute," //20
        " organization_directory_services.user_first_name_attribute," //21
        " organization_directory_services.user_last_name_attribute," //22
        " organization_directory_services.user_email_attribute" //23
        " FROM general.organization_configurations organization_configuration"
        " LEFT OUTER JOIN general.organization_directory_services on organization_directory_services.organization_id = organization_configuration.organization_id";

    Map<String, dynamic> substitutionValues;

    if (request.organizationId != null && request.organizationId.isNotEmpty) {
      queryStatement += " WHERE organization_configuration.organization_id = @organization_id";
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

        configuration.directoryService = DirectoryService();

        if (row[2] != null)
          configuration.domain = row[2];
        if (row[3] != null)
          configuration.directoryServiceEnabled = row[3];
        if (row[4] != null)
          configuration.directoryService.syncInterval = row[4];
        if (row[5] != null)
          configuration.directoryService.lastSync = row[5];
        if (row[6] != null)
          configuration.directoryService.hostAddress = row[6];
        if (row[7] != null)
          configuration.directoryService.port = row[7];
        if (row[8] != null)
          configuration.directoryService.sslTls = row[8];
        if (row[9] != null)
          configuration.directoryService.passwordFormat = row[9];
        if (row[10] != null)
          configuration.directoryService.adminBindDN = row[10];
        if (row[11] != null)
          configuration.directoryService.adminPassword = row[11];
        if (row[12] != null)
          configuration.directoryService.groupSearchDN = row[12];
        if (row[13] != null)
          configuration.directoryService.groupSearchScope = row[13];
        if (row[14] != null)
          configuration.directoryService.groupSearchFilter = row[14];
        if (row[15] != null)
          configuration.directoryService.groupMemberAttribute = row[15];
        if (row[16] != null)
          configuration.directoryService.userSearchDN = row[16];
        if (row[17] != null)
          configuration.directoryService.userSearchScope = row[17];
        if (row[18] != null)
          configuration.directoryService.userSearchFilter = row[18];
        if (row[19] != null)
          configuration.directoryService.userProviderObjectIdAttribute = row[19];
        if (row[20] != null)
          configuration.directoryService.userIdentificationAttribute = row[20];
        if (row[21] != null)
          configuration.directoryService.userFirstNameAttribute = row[21];
        if (row[22] != null)
          configuration.directoryService.userLastNameAttribute = row[22];
        if (row[23] != null)
          configuration.directoryService.userEmailAttribute = row[23];

        configurations.add(configuration);
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

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
            "INSERT INTO general.organization_configurations(organization_id, version, directory_service_enabled) VALUES"
                "(@organization_id,"
                "@version,"
                "@directory_service_enabled)"
            , substitutionValues: {
          "organization_id": request.authOrganizationId,
          "version": request.organizationConfiguration.version,
          "directory_service_enabled": request.organizationConfiguration.directoryServiceEnabled});

        await ctx.query(
            "INSERT INTO general.organization_directory_services("
                "organization_id, "
                "sync_interval,"
                "last_sync,"
                "host_address,"
                "port,"
                "ssl_tls,"
                "password_format,"
                "admin_bind_dn,"
                "admin_password,"
                "group_search_dn,"
                "group_search_scope,"
                "group_search_filter,"
                "group_member_attribute,"
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
                "@sync_interval,"
                "@last_sync,"
                "@host_address,"
                "@port,"
                "@ssl_tls,"
                "@password_format,"
                "@admin_bind_dn,"
                "@admin_password,"
                "@group_search_dn,"
                "@group_search_scope,"
                "@group_search_filter,"
                "@group_member_attribute,"
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
            "sync_interval": request.organizationConfiguration.directoryService.hasSyncInterval() ? request.organizationConfiguration.directoryService.syncInterval : null,
            "last_sync": request.organizationConfiguration.directoryService.hasLastSync() ? CommonUtils.dateTimeFromTimestamp(request.organizationConfiguration.directoryService.lastSync): null,
            "host_address": request.organizationConfiguration.directoryService.hasHostAddress() ? request.organizationConfiguration.directoryService.hostAddress: null,
            "port": request.organizationConfiguration.directoryService.hasPort() ? request.organizationConfiguration.directoryService.port: null,
            "ssl_tls": request.organizationConfiguration.directoryService.hasSslTls() ? request.organizationConfiguration.directoryService.sslTls: null,
            "password_format": request.organizationConfiguration.directoryService.hasPasswordFormat() ? request.organizationConfiguration.directoryService.passwordFormat: null,
            "admin_bind_dn": request.organizationConfiguration.directoryService.hasAdminBindDN() ? request.organizationConfiguration.directoryService.adminBindDN: null,
            "admin_password": request.organizationConfiguration.directoryService.hasAdminPassword() ? request.organizationConfiguration.directoryService.adminPassword: null,
            "group_search_dn": request.organizationConfiguration.directoryService.hasGroupSearchDN() ? request.organizationConfiguration.directoryService.groupSearchDN: null,
            "group_search_scope": request.organizationConfiguration.directoryService.hasGroupSearchScope() ? request.organizationConfiguration.directoryService.groupSearchScope: null,
            "group_search_filter": request.organizationConfiguration.directoryService.hasGroupSearchFilter() ? request.organizationConfiguration.directoryService.groupSearchFilter: null,
            "group_member_attribute": request.organizationConfiguration.directoryService.hasGroupMemberAttribute() ? request.organizationConfiguration.directoryService.groupMemberAttribute: null,
            "user_search_dn": request.organizationConfiguration.directoryService.hasUserSearchDN() ? request.organizationConfiguration.directoryService.userSearchDN: null,
            "user_search_scope": request.organizationConfiguration.directoryService.hasUserSearchScope() ? request.organizationConfiguration.directoryService.userSearchScope: null,
            "user_search_filter": request.organizationConfiguration.directoryService.hasUserSearchFilter() ? request.organizationConfiguration.directoryService.userSearchFilter: null,
            "user_provider_object_id_attribute": request.organizationConfiguration.directoryService.hasUserProviderObjectIdAttribute() ? request.organizationConfiguration.directoryService.userProviderObjectIdAttribute: null,
            "user_identification_attribute": request.organizationConfiguration.directoryService.hasUserIdentificationAttribute() ? request.organizationConfiguration.directoryService.userIdentificationAttribute: null,
            "user_first_name_attribute": request.organizationConfiguration.directoryService.hasUserFirstNameAttribute() ? request.organizationConfiguration.directoryService.userFirstNameAttribute: null,
            "user_last_name_attribute": request.organizationConfiguration.directoryService.hasUserLastNameAttribute() ? request.organizationConfiguration.directoryService.userLastNameAttribute: null,
            "user_email_attribute": request.organizationConfiguration.directoryService.hasUserEmailAttribute() ? request.organizationConfiguration.directoryService.userEmailAttribute: null,
            });

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.authOrganizationId,
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
      ..value = request.authOrganizationId;
  }

  static Future<Empty> queryUpdateOrganizationConfiguration(OrganizationConfigurationRequest request) async {

    OrganizationConfiguration previousConfiguration = await querySelectOrganizationConfiguration(OrganizationConfigurationGetRequest()..organizationId = request.organizationConfiguration.organizationId);
    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result =  await ctx.query(
            "UPDATE general.organization_configurations "
            "SET version = @version, "
            "domain = @domain, "
            "directory_service_enabled = @directory_service_enabled "
            "WHERE organization_id = @organization_id AND version = @version - 1 "
            "RETURNING true"
            , substitutionValues: {
          "organization_id": request.organizationConfiguration.organizationId,
          "version": ++request.organizationConfiguration.version,
          "domain": request.organizationConfiguration.domain,
          "directory_service_enabled": request.organizationConfiguration.directoryServiceEnabled});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          await ctx.query(
              "UPDATE general.organization_directory_services "
              "SET sync_interval = @sync_interval, "
              "last_sync = @last_sync, "
              "host_address = @host_address, "
              "port = @port, "
              "ssl_tls = @ssl_tls, "
              "password_format = @password_format, "
              "admin_bind_dn = @admin_bind_dn, "
              "admin_password = @admin_password, "
              "group_search_dn = @group_search_dn, "
              "group_search_scope = @group_search_scope, "
              "group_search_filter = @group_search_filter, "
              "group_member_attribute = @group_member_attribute, "
              "user_search_dn = @user_search_dn, "
              "user_search_scope = @user_search_scope, "
              "user_search_filter = @user_search_filter, "
              "user_id_attribute = @user_id_attribute, "
              "user_additional_id_attribute = @user_additional_id_attribute, "
              "user_first_name_attribute = @user_first_name_attribute, "
              "user_last_name_attribute = @user_last_name_attribute, "
              "user_email_attribute = @user_email_attribute "
              "WHERE organization_id = @organization_id "
              , substitutionValues: {
            "organization_id": request.organizationConfiguration.organizationId,
            "sync_interval": request.organizationConfiguration.directoryService.hasSyncInterval() ? request.organizationConfiguration.directoryService.syncInterval : null,
            "last_sync": request.organizationConfiguration.directoryService.hasLastSync() ? CommonUtils.dateTimeFromTimestamp(request.organizationConfiguration.directoryService.lastSync): null,
            "host_address": request.organizationConfiguration.directoryService.hasHostAddress() ? request.organizationConfiguration.directoryService.hostAddress: null,
            "port": request.organizationConfiguration.directoryService.hasPort() ? request.organizationConfiguration.directoryService.port: null,
            "ssl_tls": request.organizationConfiguration.directoryService.hasSslTls() ? request.organizationConfiguration.directoryService.sslTls: null,
            "password_format":  request.organizationConfiguration.directoryService.hasPasswordFormat() ? request.organizationConfiguration.directoryService.passwordFormat: null,
            "admin_bind_dn": request.organizationConfiguration.directoryService.hasAdminBindDN() ? request.organizationConfiguration.directoryService.adminBindDN: null,
            "admin_password": request.organizationConfiguration.directoryService.hasAdminPassword() ? request.organizationConfiguration.directoryService.adminPassword: null,
            "group_search_dn": request.organizationConfiguration.directoryService.hasGroupSearchDN() ? request.organizationConfiguration.directoryService.groupSearchDN: null,
            "group_search_scope": request.organizationConfiguration.directoryService.hasGroupSearchScope() ? request.organizationConfiguration.directoryService.groupSearchScope: null,
            "group_search_filter": request.organizationConfiguration.directoryService.hasGroupSearchFilter() ? request.organizationConfiguration.directoryService.groupSearchFilter: null,
            "group_member_attribute": request.organizationConfiguration.directoryService.hasGroupMemberAttribute() ? request.organizationConfiguration.directoryService.groupMemberAttribute: null,
            "user_search_dn": request.organizationConfiguration.directoryService.hasUserSearchDN() ? request.organizationConfiguration.directoryService.userSearchDN: null,
            "user_search_scope": request.organizationConfiguration.directoryService.hasUserSearchScope() ? request.organizationConfiguration.directoryService.userSearchScope: null,
            "user_search_filter": request.organizationConfiguration.directoryService.hasUserSearchFilter() ? request.organizationConfiguration.directoryService.userSearchFilter: null,
            "user_provider_object_id_attribute": request.organizationConfiguration.directoryService.hasUserProviderObjectIdAttribute() ? request.organizationConfiguration.directoryService.userProviderObjectIdAttribute: null,
            "user_identification_attribute": request.organizationConfiguration.directoryService.hasUserIdentificationAttribute() ? request.organizationConfiguration.directoryService.userIdentificationAttribute: null,
            "user_first_name_attribute": request.organizationConfiguration.directoryService.hasUserFirstNameAttribute() ? request.organizationConfiguration.directoryService.userFirstNameAttribute: null,
            "user_last_name_attribute": request.organizationConfiguration.directoryService.hasUserLastNameAttribute() ? request.organizationConfiguration.directoryService.userLastNameAttribute: null,
            "user_email_attribute": request.organizationConfiguration.directoryService.hasUserEmailAttribute() ? request.organizationConfiguration.directoryService.userEmailAttribute: null,});

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
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
    return _processDirectoryService(request);
  }

  Future<int> _syncDirectoryService(OrganizationConfigurationRequest request) async {
    return _processDirectoryService(request, sync: true);
  }


  Future<int> _processDirectoryService(OrganizationConfigurationRequest request, {bool sync = false}) async {

    String hostAddress = request.organizationConfiguration.directoryService.hostAddress;
    int port = request.organizationConfiguration.directoryService.port;
    bool sslTls = request.organizationConfiguration.directoryService.sslTls;
    int passwordFormat = request.organizationConfiguration.directoryService.passwordFormat;

    String adminBindDN = request.organizationConfiguration.directoryService.adminBindDN;
    String adminPassword = request.organizationConfiguration.directoryService.adminPassword;

    String groupSearchDN = request.organizationConfiguration.directoryService.groupSearchDN;
    int groupSearchScopeDN = request.organizationConfiguration.directoryService.groupSearchScope;
    String groupSearchFilter = request.organizationConfiguration.directoryService.groupSearchFilter;
    String groupMemberAttribute  = request.organizationConfiguration.directoryService.groupMemberAttribute;

    String userSearchDN = request.organizationConfiguration.directoryService.userSearchDN;
    int userSearchScopeDN = request.organizationConfiguration.directoryService.userSearchScope;
    String userSearchFilter = request.organizationConfiguration.directoryService.userSearchFilter;
    String userProviderObjectIdAttribute = request.organizationConfiguration.directoryService.userProviderObjectIdAttribute;
    String userIdentificationAttribute = request.organizationConfiguration.directoryService.userIdentificationAttribute;
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
      //TODO - future understand a way to cipher this password. LDAP normaly store in plan text, though isn't the wanted way.
      String adminPasswordDecoded = utf8.decode(base64.decode(adminPassword));

      String passwordFormatStr;
      if ( passwordFormat == organization_configuration_m.DirectoryServicePasswordFormat.des.index) {
        passwordFormatStr = '{DES}';
      } else if ( passwordFormat == organization_configuration_m.DirectoryServicePasswordFormat.sha.index) {
        passwordFormatStr = '{SHA}';
      } else { // passwordFormat == null || passwordFormat == organization_configuration_m.DirectoryServicePasswordFormat.textPlan.index
        passwordFormatStr = '';
      }

      await connection.setAuthentication(adminBindDN, passwordFormatStr + adminPasswordDecoded);
      //await connection.setAuthentication(adminBindDN, adminPassword);

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
        return organization_configuration_m.DirectoryServiceStatus.errorGroupFilterInvalid.index;
        //throw Exception('Group search filter must be in a simple format, i.e. (objectClass=posixGroup)');
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
        return organization_configuration_m.DirectoryServiceStatus.errorUserFilterInvalid.index;
        //throw Exception('Account search filter must be in a simple format, i.e. (objectClass=posixAccount)');
      }

      searchResult = await connection.search(userSearchDN, userSearchFilterDartdap, [userProviderObjectIdAttribute, userIdentificationAttribute, userEmailAttribute, userFirstNameAttribute, userLastNameAttribute], scope: userSearchScopeDN);

      List<UserIdentity> userIdentities = await UserIdentityService.querySelectUserIdentities(UserIdentityGetRequest()..managedByOrganizationId =  request.authOrganizationId);

      List<UserAccess> userAccesses = await UserAccessService.querySelectUserAccesses(UserAccessGetRequest()..organizationId =  request.authOrganizationId);

      UserIdentity userIdentity;
      int userIdentityIndex;

      Organization organization;
      if (sync) organization = await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = request.authOrganizationId);

      countEntry = 0;
      int countProviderObjectIdAttribute = 0,
          countIdentificatorAttribute = 0,
        countEmailAttribute = 0,
        countFirstNameAttribute = 0,
        countLastNameAttribute = 0;

      List<String> directoryServiceProviderObjectIds = [];
      List<UserRequest> insertUsersSync = [], updateUsersSync = [];
      List<UserIdentityDeleteRequest> deleteUserIdentitiesSync = [];
      List<UserAccessDeleteRequest> deleteUserAccessesSync = [];
      List<UserIdentityRequest> insertUserIdentitiesSync = [], updateUserIdentitiesSync = [];
      List<UserAccessRequest> insertUserAccessesSync = [], updateUserAccessesSync = [];

      bool hasChanged;

      String userProviderObjectIdAttributeValue, userIdentificationAttributeValue, userEmailAttributeValue, userFirstNameAttributeValue, userLastNameAttributeValue;

      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
       // print("DN >>>> " + entry.dn);
        countEntry++;
        //print("dn: ${entry.dn}");

        if (sync) {
          userProviderObjectIdAttributeValue = null;
          userIdentificationAttributeValue = null;
          userEmailAttributeValue = null;
          userFirstNameAttributeValue = null;
          userLastNameAttributeValue = null;
        }

        for (var attr in entry.attributes.values) {
          if (attr.name == userProviderObjectIdAttribute) {
            countProviderObjectIdAttribute++;
            if (sync) {
              userProviderObjectIdAttributeValue = attr.values?.first;
              directoryServiceProviderObjectIds.add(userProviderObjectIdAttributeValue);
            }
          }

          // Login = samAccountName / UserPrincipalName / UID
          if (attr.name == userIdentificationAttribute) {
            countIdentificatorAttribute++;
            if (sync) userIdentificationAttributeValue = attr.values?.first;
          }
          if (attr.name == userEmailAttribute) {
            countEmailAttribute++;
            if (sync) userEmailAttributeValue = attr.values?.first;
          }
          if (attr.name == userFirstNameAttribute) {
            countFirstNameAttribute++;
            if (sync) userFirstNameAttributeValue = attr.values?.first;
          }
          if (attr.name == userLastNameAttribute) {
            countLastNameAttribute++;
            if (sync) userLastNameAttributeValue = attr.values?.first;
          }

          //for (var value in attr.values) { // attr.values is a Set
          //  print("  ${attr.name}: $value");
          //}
        }
        if (sync) {

          //TODO - Buscar também pelo email, para evitar possível duplicação.
          userIdentityIndex = userIdentities.indexWhere((t) => t.providerObjectId == userIdentificationAttributeValue);

          // If not found, a new user will be inserted.

          if (userIdentityIndex == -1) {

            UserRequest userRequest = UserRequest();
            userRequest.authUserId = request.authUserId;
            userRequest.authOrganizationId = request.authOrganizationId;

            userRequest.user = User();
            userRequest.user.name = userFirstNameAttributeValue + ' ' + userLastNameAttributeValue;
            userRequest.user.userProfile.eMail = userEmailAttributeValue;

            UserIdentityRequest userIdentityRequest = UserIdentityRequest();
            userIdentityRequest.authUserId = request.authUserId;
            userIdentityRequest.authOrganizationId = request.authOrganizationId;
            userIdentityRequest.userIdentity =  UserIdentity();
            userIdentityRequest.userIdentity.user = userRequest.user;
            userIdentityRequest.userIdentity.provider = user_identity_m.UserIdentityProvider.internal.index;
            userIdentityRequest.userIdentity.providerObjectId = userProviderObjectIdAttributeValue;

            UserAccessRequest userAccessRequest = UserAccessRequest();

            userAccessRequest.userAccess = UserAccess();
            userAccessRequest.userAccess.user = userRequest.user;
            userAccessRequest.userAccess.organization = organization;
            userAccessRequest.userAccess.accessRole = SystemRole.standard.index;

            insertUsersSync.add(userRequest);
            insertUserIdentitiesSync.add(userIdentityRequest);
            insertUserAccessesSync.add(userAccessRequest);
          } else {

            userIdentity = userIdentities[userIdentityIndex];

            hasChanged = false;

            if (userIdentity.user.name != userFirstNameAttribute + ' ' + userLastNameAttribute) {
              userIdentity.user.name = userFirstNameAttribute + ' ' + userLastNameAttribute;
              hasChanged = true;
            }

            if (userIdentity.user.userProfile.eMail != userEmailAttributeValue) {
              userIdentity.user.userProfile.eMail = userEmailAttributeValue;
              hasChanged = true;
            }

            if (userIdentity.identification != userIdentificationAttributeValue) {
              userIdentity.identification = userIdentificationAttributeValue;
              hasChanged = true;
            }

            if (userIdentity.providerObjectId != userProviderObjectIdAttributeValue) {
              userIdentity.providerObjectId = userProviderObjectIdAttributeValue;
              hasChanged = true;
            }

            // If some value changed
            if (hasChanged) {


              UserRequest userRequest = UserRequest();
              userRequest.authUserId = request.authUserId;
              userRequest.authOrganizationId = request.authOrganizationId;

              userRequest.user = User();
              userRequest.user.name = userFirstNameAttributeValue + ' ' + userLastNameAttributeValue;
              userRequest.user.userProfile.eMail = userEmailAttributeValue;

              UserIdentityRequest userIdentityRequest = UserIdentityRequest();
              userIdentityRequest.authUserId = request.authUserId;
              userIdentityRequest.authOrganizationId = request.authOrganizationId;
              userIdentityRequest.userIdentity =  UserIdentity();
              userIdentityRequest.userIdentity.user = userRequest.user;
              userIdentityRequest.userIdentity.provider = user_identity_m.UserIdentityProvider.internal.index;
              userIdentityRequest.userIdentity.providerObjectId = userProviderObjectIdAttributeValue;

              UserAccessRequest userAccessRequest = UserAccessRequest();

              userAccessRequest.userAccess = UserAccess();
              userAccessRequest.userAccess.user = userRequest.user;
              userAccessRequest.userAccess.organization = organization;
              userAccessRequest.userAccess.accessRole = SystemRole.standard.index;

              updateUsersSync.add(userRequest);
              updateUserIdentitiesSync.add(userIdentityRequest);
              updateUserAccessesSync.add(userAccessRequest);

            }
          }
        }
      }

      if (countEntry == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorUserNotFound.index;

      if (countProviderObjectIdAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorProviderObjectIdAttribute.index;

      if (countIdentificatorAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorIdentificationAttribute.index;

      if (countEmailAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorEmailAttribute.index;

      if (countFirstNameAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorFirstNameAttribute.index;

      if (countLastNameAttribute == 0)
        return organization_configuration_m.DirectoryServiceStatus.errorLastNameAttribute.index;

      /// Delete Identity and Access
      if (sync) {

        String providerObjectId;
        int userAccessIndex;
        for (userIdentityIndex = 0;userIdentityIndex<userIdentities.length;userIdentityIndex++) {
          providerObjectId = userIdentities[userIdentityIndex].providerObjectId;
          if (providerObjectId != null) {
            if (directoryServiceProviderObjectIds.indexOf(providerObjectId) == -1) {
              
              UserIdentityDeleteRequest userIdentityDeleteRequest = UserIdentityDeleteRequest();
              userIdentityDeleteRequest.userIdentityId = userIdentities[userIdentityIndex].id;
              userIdentityDeleteRequest.userIdentityVersion = userIdentities[userIdentityIndex].version;

              userIdentityDeleteRequest.authUserId = request.authUserId;
              userIdentityDeleteRequest.authOrganizationId = request.authOrganizationId;

              deleteUserIdentitiesSync.add(userIdentityDeleteRequest);

              userAccessIndex = userAccesses.indexWhere((test) => test.user.id == userIdentities[userIdentityIndex].id);
              if (userAccessIndex != -1) {

                UserAccessDeleteRequest userAccessDeleteRequest = UserAccessDeleteRequest();
                userAccessDeleteRequest.userAccessId = userAccesses[userIdentityIndex].id;
                userAccessDeleteRequest.userAccessVersion = userAccesses[userIdentityIndex].version;

                userAccessDeleteRequest.authUserId = request.authUserId;
                userAccessDeleteRequest.authOrganizationId = request.authOrganizationId;

                deleteUserAccessesSync.add(userAccessDeleteRequest);
              }

            }
          }
        }
      }

      // Insert, update or inactivate users on database
      if (sync) {
        // Insert
        for (UserRequest userRequest in insertUsersSync) {
          UserService.queryInsertUser(userRequest);
        }

        for (UserIdentityRequest userIdentityRequest in insertUserIdentitiesSync) {
          UserIdentityService.queryInsertUserIdentity(userIdentityRequest);
        }

        for (UserAccessRequest userAccessRequest in insertUserAccessesSync) {
          UserAccessService.queryInsertUserAccess(userAccessRequest);
        }
        // Update
        for (UserRequest userRequest in updateUsersSync) {
          UserService.queryUpdateUser(userRequest);
        }

        for (UserIdentityRequest userIdentityRequest in updateUserIdentitiesSync) {
          UserIdentityService.queryUpdateUserIdentity(userIdentityRequest);
        }

        for (UserAccessRequest userAccessRequest in updateUserAccessesSync) {
          UserAccessService.queryUpdateUserAccess(userAccessRequest);
        }

        // Not found [providerObjectId] on directory service, delete identity
        for (UserIdentityDeleteRequest userIdentityDeleteRequest in deleteUserIdentitiesSync) {
          UserIdentityService.queryDeleteUserIdentity(userIdentityDeleteRequest);
        }

        // Not found [providerObjectId] on directory service, delete access
        for (UserAccessDeleteRequest userAccessDeleteRequest in deleteUserAccessesSync) {
          UserAccessService.queryDeleteUserAccess(userAccessDeleteRequest);
        }

      }

      connection.close();
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return organization_configuration_m.DirectoryServiceStatus.success.index;
  }
}