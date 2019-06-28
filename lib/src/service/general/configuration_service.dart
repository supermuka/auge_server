// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:dartdap/dartdap.dart' as dartdap;

import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/configuration.pbgrpc.dart';

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

/*

  @override
  Future<Empty> deleteUser(ServiceCall call,
      UserRequest request) async {
    
    return await queryDeleteUser(request);
  }
*/

  // Query

  // Operations
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


      testOk = (connection.state == dartdap.ConnectionState.ready);
      connection.close();
    } catch (e) {
      print(e);
      rethrow;
    }
    return testOk;
  }

}