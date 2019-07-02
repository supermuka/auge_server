// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:dartdap/dartdap.dart' as dartdap;

import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/configuration.pbgrpc.dart';

import 'package:auge_server/model/general/configuration.dart' as configuration_m;

import 'package:auge_server/src/service/general/db_connection_service.dart';

class ConfigurationService extends ConfigurationServiceBase {

  // API
  @override
  Future<Configuration> getConfiguration(ServiceCall call,
      ConfigurationGetRequest request) async {
    Configuration configuration = null;//await querySelectConfiguration(request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
    if (configuration == null) throw new GrpcError.notFound("Configuration not found.");
    return configuration;
  }

  @override
  Future<IdResponse> createConfiguration(ServiceCall call,
      ConfigurationRequest request) async {
   // return queryInsertConfiguration(request);
    return null;
  }

  @override
  Future<Empty> updateConfiguration(ServiceCall call,
      ConfigurationRequest request) async {
    //return queryUpdateUser(request);
    return null;
  }
/*
  @override
  Future<BoolValue> testConnection(ServiceCall call,
      ConfigurationRequest request) async {

    return BoolValue()..value = await _testConnection(request);
  }

  @override
  Future<BoolValue> testBind(ServiceCall call,
      ConfigurationRequest request) async {

    return BoolValue()..value = await _testBind(request);
  }

  @override
  Future<BoolValue> testGroup(ServiceCall call,
      ConfigurationRequest request) async {

    return BoolValue()..value = await _testSearchGroup(request);
  }

*/
  @override
  Future<Int32Value> testDirectoryService(ServiceCall call,
      ConfigurationRequest request) async {

    return Int32Value()..value = await _testDirectoryService(request);
  }
/*

  @override
  Future<Empty> deleteUser(ServiceCall call,
      UserRequest request) async {
    
    return await queryDeleteUser(request);
  }
*/

  // Query

  // Operations
  /*
  Future<bool> _testConnection(ConfigurationRequest request) async {

    String hostAddress = request.configuration.directoryService.hostAddress;
    int port = request.configuration.directoryService.port;
    bool sslTls = request.configuration.directoryService.sslTls;

    dartdap.LdapConnection connection;
    bool testOk = false;
    try {
      connection =
          dartdap.LdapConnection(host: hostAddress, ssl: sslTls, port: port);
      await connection.open();

      testOk = (connection.state == dartdap.ConnectionState.ready);

      connection.close();

    } catch (e) {
      print(e);
      rethrow;
    }

    return testOk;
  }

  Future<bool> _testBind(ConfigurationRequest request) async {
    String hostAddress = request.configuration.directoryService.hostAddress;
    int port = request.configuration.directoryService.port;
    bool sslTls = request.configuration.directoryService.sslTls;

    String adminBindDN = request.configuration.directoryService.adminBindDN;
    String adminPassword = request.configuration.directoryService.adminPassword;

    dartdap.LdapConnection connection;
    bool testOk = false;
    try {

      connection = dartdap.LdapConnection(host: hostAddress, ssl: sslTls, port: port, bindDN: adminBindDN, password: adminPassword);

      await connection.open();

      testOk = (connection.state == dartdap.ConnectionState.ready);

      connection.close();
    } catch (e) {
      print(e);
      rethrow;
    }
    return testOk;
  }

  Future<bool> _testSearchGroup(ConfigurationRequest request) async {
    String hostAddress = request.configuration.directoryService.hostAddress;
    int port = request.configuration.directoryService.port;
    bool sslTls = request.configuration.directoryService.sslTls;

    String adminBindDN = request.configuration.directoryService.adminBindDN;
    String adminPassword = request.configuration.directoryService.adminPassword;

    String groupSearchDN = request.configuration.directoryService.groupSearchDN;
    int groupSearchScopeDN = request.configuration.directoryService.groupSearchScope;
    String groupSearchFilter = request.configuration.directoryService.groupSearchFilter;
    String groupMemberAttribute  = request.configuration.directoryService.groupMemberAttribute;

    dartdap.LdapConnection connection;
    bool testOk = false;
    try {

      connection = dartdap.LdapConnection(host: hostAddress, ssl: sslTls, port: port, bindDN: adminBindDN, password: adminPassword);

      await connection.open();

      //testOk = (connection.state == dartdap.ConnectionState.ready);

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

      print('DEBUG SEARCH GROUP');
      int count = 0;
      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        count++;
        print("dn: ${entry.dn}");
        for (var attr in entry.attributes.values) {
          for (var value in attr.values) { // attr.values is a Set
            print("  ${attr.name}: $value");
          }
        }
      }

      testOk = (count != 0);
      connection.close();
    } catch (e) {
      print(e);
      rethrow;
    }
    return testOk;
  }
  */

  Future<int> _testDirectoryService(ConfigurationRequest request) async {
    String hostAddress = request.configuration.directoryService.hostAddress;
    int port = request.configuration.directoryService.port;
    bool sslTls = request.configuration.directoryService.sslTls;

    String adminBindDN = request.configuration.directoryService.adminBindDN;
    String adminPassword = request.configuration.directoryService.adminPassword;

    String groupSearchDN = request.configuration.directoryService.groupSearchDN;
    int groupSearchScopeDN = request.configuration.directoryService.groupSearchScope;
    String groupSearchFilter = request.configuration.directoryService.groupSearchFilter;
    String groupMemberAttribute  = request.configuration.directoryService.groupMemberAttribute;

    String userSearchDN = request.configuration.directoryService.userSearchDN;
    int userSearchScopeDN = request.configuration.directoryService.userSearchScope;
    String userSearchFilter = request.configuration.directoryService.userSearchFilter;
    String userLoginAttribute  = request.configuration.directoryService.userLoginAttribute;
    String userEmailAttribute = request.configuration.directoryService.userEmailAttribute;
    String userFirstNameAttribute  = request.configuration.directoryService.userFirstNameAttribute;
    String userLastNameAttribute = request.configuration.directoryService.userLastNameAttribute;

    dartdap.LdapConnection connection;

    try {

      // TEST CONNECTION
      connection = dartdap.LdapConnection(host: hostAddress, ssl: sslTls, port: port);

      await connection.open();

      if (connection.state != dartdap.ConnectionState.ready)
        return configuration_m.DirectoryServiceStatus.errorNotConnected.index;

      // TEST BIND
      await connection.setAuthentication(adminBindDN, adminPassword);

      if (!connection.isAuthenticated)
        return configuration_m.DirectoryServiceStatus.errorNotBindedInvalidCredentials.index;

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
        return configuration_m.DirectoryServiceStatus.errorGroupNotFound.index;

      if (countEntry > 1)
        return configuration_m.DirectoryServiceStatus.errorManyGroupsFound.index;

      if (countAttribute == 0)
        return configuration_m.DirectoryServiceStatus.errorGroupMemberAttributeNotFound.index;

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


      print('DEBUG');
      print(userSearchDN);
      print(userSearchFilterDartdap);
      print([userLoginAttribute, userEmailAttribute, userFirstNameAttribute, userLastNameAttribute]);
      print(userSearchScopeDN);

      countEntry = 0;
      int countLoginAttribute = 0,
        countEmailAttribute = 0,
        countFirstNameAttribute = 0,
        countLastNameAttribute = 0;
      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        countEntry++;
        //print("dn: ${entry.dn}");
        for (var attr in entry.attributes.values) {
          if (attr.name == userLoginAttribute)
             countLoginAttribute++;
          if (attr.name == userEmailAttribute)
             countEmailAttribute++;
          if (attr.name == userFirstNameAttribute)
            countFirstNameAttribute;
          if (attr.name == userLastNameAttribute)
            countLastNameAttribute;
          //for (var value in attr.values) { // attr.values is a Set
          //  print("  ${attr.name}: $value");
          //}
        }
        // Test just first entry to verify if there are attributes;
        break;
      }

      if (countEntry == 0)
        return configuration_m.DirectoryServiceStatus.errorUserNotFound.index;

      if (countLoginAttribute == 0)
        return configuration_m.DirectoryServiceStatus.errorLoginAttribute.index;

      if (countEmailAttribute == 0)
        return configuration_m.DirectoryServiceStatus.errorEmailAttribute.index;

      if (countFirstNameAttribute == 0)
        return configuration_m.DirectoryServiceStatus.errorFirstNameAttribute.index;

      if (countLastNameAttribute == 0)
        return configuration_m.DirectoryServiceStatus.errorLastNameAttribute.index;

      connection.close();
    } catch (e) {
      print(e);
      rethrow;
    }
    return configuration_m.DirectoryServiceStatus.success.index;
  }

}