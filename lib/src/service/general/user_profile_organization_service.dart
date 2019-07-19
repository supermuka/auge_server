// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pbgrpc.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';

import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;
import 'package:auge_server/model/general/user_profile_organization.dart' as user_profile_organization_m;

import 'package:uuid/uuid.dart';

class UserProfileOrganizationService extends UserProfileOrganizationServiceBase {

  // API
  @override
  Future<UsersProfileOrganizationsResponse> getUsersProfileOrganizations(ServiceCall call,
      UserProfileOrganizationGetRequest userProfileOrganizationGetRequest) async {
    return UsersProfileOrganizationsResponse()/*..webWorkAround = true*/..usersProfileOrganizations.addAll(await querySelectUsersProfileOrganizations(userProfileOrganizationGetRequest));
  }

  @override
  Future<UserProfileOrganization> getUserProfileOrganization(ServiceCall call,
      UserProfileOrganizationGetRequest request) async {
    //return UserProfileOrganization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
    return querySelectUserProfileOrganization(request);
  }

  @override
  Future<IdResponse> createUserProfileOrganization(ServiceCall call,
      UserProfileOrganizationRequest request) async {
    IdResponse idResponse = await queryInsertUserProfileOrganization(request);
    if (idResponse == null ) throw new GrpcError.notFound("User Profile Organization not found.");
    return idResponse;
  }

  @override
  Future<Empty> updateUserProfileOrganization(ServiceCall call,
      UserProfileOrganizationRequest request) async {
    return queryUpdateUserProfileOrganization(request);
  }

  @override
  Future<Empty> deleteUserProfileOrganization(ServiceCall call,
      UserProfileOrganizationDeleteRequest request) async {
    return queryDeleteUserProfileOrganization(request);
  }

  // Query
  static Future<List<UserProfileOrganization>> querySelectUsersProfileOrganizations([UserProfileOrganizationGetRequest userProfileOrganizationGetRequest] /* {String id, String userId, String organizationId} */) async {
    Map<String, User> _userCache = {};
    Map<String, Organization> _organizationCache = {};

    List<List> results;
    String queryStatement = '';
    queryStatement = "SELECT "
        "uo.id, " // 0
        "uo.version, " // 1
        "uo.user_id, " // 2
        "uo.organization_id, " //3
        "uo.authorization_role " // 4
        "FROM general.users_profile_organizations uo "
        "JOIN general.users u ON u.id = uo.user_id "
        "LEFT OUTER JOIN general.users_profile user_profile on user_profile.user_id = u.id ";

    Map<String, dynamic> _substitutionValues = Map<String, dynamic>();
    String whereAnd = 'WHERE';

    if (userProfileOrganizationGetRequest.hasId()) {
      queryStatement += " ${whereAnd} uo.id = @id";
      _substitutionValues.putIfAbsent("id", () => userProfileOrganizationGetRequest.id);
      whereAnd = 'AND';
    }

    if (userProfileOrganizationGetRequest.hasUserId()) {
      queryStatement += " ${whereAnd} uo.user_id = @user_id";
      _substitutionValues.putIfAbsent("user_id", () => userProfileOrganizationGetRequest.userId);
      whereAnd = 'AND';
    }

    if (userProfileOrganizationGetRequest.hasOrganizationId()) {
      queryStatement += " ${whereAnd} uo.organization_id = @organization_id";
      _substitutionValues.putIfAbsent("organization_id", () => userProfileOrganizationGetRequest.organizationId);
      whereAnd = 'AND';
    }

    if (userProfileOrganizationGetRequest.hasEMail()) {
      queryStatement = queryStatement +
          " ${whereAnd} user_profile.email = @email";

      _substitutionValues.putIfAbsent("email", () => userProfileOrganizationGetRequest.eMail);
      whereAnd = 'AND';
    }
    if (userProfileOrganizationGetRequest.hasPassword()) {
      queryStatement = queryStatement +
          " ${whereAnd} user_profile.password = @password";
      _substitutionValues.putIfAbsent("password", () => userProfileOrganizationGetRequest.password);
      //The last, not need... whereAnd = 'AND';
    }

    List<UserProfileOrganization> usersOrganizations = [];

    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: _substitutionValues);

      User user;
      Organization organization;

      if (results.isNotEmpty) {
        for (var row in results) {

          if (row[2] != null) {
            if (_userCache.containsKey(row[2])) {
              user = _userCache[row[2]];
            } else {
              user =
              await UserService.querySelectUser(UserGetRequest()
                ..id = row[2]
                ..withProfile = true);
              if (user != null) _userCache[row[2]] = user;
            }
          }
          if (row[3] != null) {
            if (_organizationCache.containsKey(row[3])) {
              organization = _organizationCache[row[3]];
            } else {
              organization =
              await OrganizationService.querySelectOrganization(
                  OrganizationGetRequest()
                    ..id = row[3]);
              if (organization != null)
                _organizationCache[row[3]] = organization;
            }
          }

          UserProfileOrganization userProfileOrganization = new UserProfileOrganization();

          userProfileOrganization.id = row[0];
          userProfileOrganization.version = row[1];
          userProfileOrganization.user = user;
          userProfileOrganization.organization = organization;
          userProfileOrganization.authorizationRole = row[4];
          usersOrganizations.add(userProfileOrganization);
        }
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return usersOrganizations;
  }

  static Future<UserProfileOrganization> querySelectUserProfileOrganization(UserProfileOrganizationGetRequest request) async {
    List<UserProfileOrganization> usersProfileOrganizations = await querySelectUsersProfileOrganizations(request);
    if (usersProfileOrganizations == null || usersProfileOrganizations.isEmpty) throw new GrpcError.notFound("User Profile Organization not found.");
    return usersProfileOrganizations.first;
  }

  static Future<IdResponse> queryInsertUserProfileOrganization(UserProfileOrganizationRequest request) async {

    try {

    await (await AugeConnection.getConnection()).transaction((ctx) async {

        if (request.hasWithUserProfile() && request.withUserProfile)  {

          print('DEBUG 00 ${request.userProfileOrganization.user.hasId()}');

          if (!request.userProfileOrganization.user.hasId()) {
            request.userProfileOrganization.user.id = new Uuid().v4();
          }

          print('DEBUG 01 ${request.userProfileOrganization.user.id}');

          request.userProfileOrganization.user.version = 0;

          await ctx.query(
              "INSERT INTO general.users(id, version, name, inactive) VALUES("
                  "@id,"
                  "@version,"
                  "@name,"
                  "@inactive)"
              , substitutionValues: {
            "id": request.userProfileOrganization.user.id,
            "version": request.userProfileOrganization.user.version,
            "name": request.userProfileOrganization.user.name,
            "inactive": request.userProfileOrganization.user.inactive});

          print('DEBUG INSERT ZZ');
          if (request.userProfileOrganization.user.userProfile != null) {
            await ctx.query(
                "INSERT INTO general.users_profile(user_id, additional_id, email, password, image, idiom_locale, organization_id, directory_service_id) VALUES("
                    "@id,"
                    "@additional_id,"
                    "@email,"
                    "@password,"
                    "@image,"
                    "@idiom_locale,"
                    "@organization_id,"
                    "@directory_service_id)", substitutionValues: {
              "id": request.userProfileOrganization.user.id,
              "additional_id": request.userProfileOrganization.user.userProfile.hasAdditionalId() ? request.userProfileOrganization.user.userProfile.additionalId : null,
              "email": request.userProfileOrganization.user.userProfile.eMail,
              "password": request.userProfileOrganization.user.userProfile.password,
              "image": request.userProfileOrganization.user.userProfile.image,
              "idiom_locale": request.userProfileOrganization.user.userProfile.idiomLocale,
              "organization_id": request.userProfileOrganization.user.userProfile.organization.id,
              "directory_service_id": request.userProfileOrganization.user.userProfile.hasDirectoryServiceId() ? request.userProfileOrganization.user.userProfile.directoryServiceId : null,
              });
          }
          print('DEBUG INSERT ZZZZ');
        }

        if (!request.userProfileOrganization.hasId()) {
          request.userProfileOrganization.id = new Uuid().v4();
        }

        request.userProfileOrganization.version = 0;

        print('DEBUG INSERT A ${request.userProfileOrganization.id}');
        print('DEBUG INSERT B ${request.userProfileOrganization.user.id}');
        print('DEBUG INSERT C ${request.userProfileOrganization.organization.id}');

        await ctx.query(
            "INSERT INTO general.users_profile_organizations(id, version, user_id, organization_id, authorization_role) VALUES("
                "@id,"
                "@version,"
                "@user_id,"
                "@organization_id,"
                "@authorization_role)"
            , substitutionValues: {
          "id": request.userProfileOrganization.id,
          "version": request.userProfileOrganization.version,
          "user_id": request.userProfileOrganization.hasUser() ? request.userProfileOrganization.user.id : null,
          "organization_id": request.userProfileOrganization.hasOrganization() ? request.userProfileOrganization.organization.id : null,
          "authorization_role": request.userProfileOrganization.authorizationRole});

        print('DEBUG XX');
        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authenticatedUserId,
          "organization_id": request.authenticatedOrganizationId,
          "object_id": request.userProfileOrganization.id,
          "object_version": request.userProfileOrganization.version,
          "object_class_name": user_profile_organization_m.UserProfileOrganization.className,
          "system_module_index": SystemModule.users.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.userProfileOrganization.user.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, user_profile_organization_m.UserProfileOrganization.fromProtoBufToModelMap(request.userProfileOrganization))});
        print('DEBUG XXXX');
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return IdResponse()..id = request.userProfileOrganization.id;
  }

  static Future<Empty> queryUpdateUserProfileOrganization(UserProfileOrganizationRequest request) async {

    UserProfileOrganization previousUserProfileOrganization = await querySelectUserProfileOrganization(UserProfileOrganizationGetRequest()..id = request.userProfileOrganization.id);

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        if (request.hasWithUserProfile() && request.withUserProfile)  {
          List<List<dynamic>> result = await ctx.query(
              "UPDATE general.users "
                  "SET version = @version,"
                  "name = @name, "
                  "inactive = @inactive "
                  " WHERE id = @id AND version = @version - 1"
                  " RETURNING true", substitutionValues: {
            "id": request.userProfileOrganization.user.id,
            "version": ++request.userProfileOrganization.user.version,
            "name": request.userProfileOrganization.user.name,
            "inactive": request.userProfileOrganization.user.inactive});

          await ctx.query(
              "UPDATE general.users_profile "
                  "SET email = @email, "
                  "password = @password, "
                  "image = @image, "
                  "idiom_locale = @idiom_locale, "
                  "organization_id = @organization_id, "
                  "directory_service_id = @directory_service_id "
                  "WHERE user_id = @user_id"
              , substitutionValues: {
            "user_id": request.userProfileOrganization.user.id,
            "email": request.userProfileOrganization.user.userProfile.eMail,
            "password": request.userProfileOrganization.user.userProfile.password,
            "image": request.userProfileOrganization.user.userProfile.image,
            "idiom_locale": request.userProfileOrganization.user.userProfile.idiomLocale,
            "organization_id": request.userProfileOrganization.user.userProfile.organization.id,
            "directory_service_id": request.userProfileOrganization.user.userProfile.directoryServiceId,});

          // Optimistic concurrency control
          if (result.length == 0) {
            throw new GrpcError.failedPrecondition('Precondition Failed');
          }
        }

        List<List<dynamic>> result = await ctx.query(
              "UPDATE general.users_profile_organizations "
                  "SET version = @version, "
                  "authorization_role = @authorization_role, "
                  "user_id = @user_id, "
                  "organization_id = @organization_id "
                  "WHERE id = @id AND version = @version - 1 "
                  "RETURNING true", substitutionValues: {
            "id": request.userProfileOrganization.id,
            "version": ++request.userProfileOrganization.version,
            "user_id": request.userProfileOrganization.user.id,
            "organization_id": request.userProfileOrganization.organization.id,
            "authorization_role": request.userProfileOrganization.authorizationRole});

          // Optimistic concurrency control
          if (result.length == 0) {
            throw new GrpcError.failedPrecondition('Precondition Failed');
          } else {
            // Create a history item
            await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
                substitutionValues: {"id": Uuid().v4(),
                  "user_id": request.authenticatedUserId,
                  "organization_id": request.authenticatedOrganizationId,
                  "object_id": request.userProfileOrganization.id,
                  "object_version": request.userProfileOrganization.version,
                  "object_class_name": user_profile_organization_m
                      .UserProfileOrganization.className,
                  "system_module_index": SystemModule.users.index,
                  "system_function_index": SystemFunction.update.index,
                  "date_time": DateTime.now().toUtc(),
                  "description": request.userProfileOrganization.user.name,
                  "changed_values": history_item_m.HistoryItem
                      .changedValuesJson(
                      user_profile_organization_m.UserProfileOrganization
                          .fromProtoBufToModelMap(
                          previousUserProfileOrganization),
                      user_profile_organization_m.UserProfileOrganization
                          .fromProtoBufToModelMap(
                          request.userProfileOrganization))});
          }

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  static Future<Empty> queryDeleteUserProfileOrganization(UserProfileOrganizationDeleteRequest request) async {

    UserProfileOrganization previousUserProfileOrganization = await querySelectUserProfileOrganization(UserProfileOrganizationGetRequest()..id = request.userProfileOrganizationId);

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.users_profile_organizations user_profile_organization "
                "WHERE user_profile_organization.id = @id AND user_profile_organization.version = @version "
                "RETURNING true"
            , substitutionValues: {
          "id": request.userProfileOrganizationId,
          "version": request.userProfileOrganizationVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }

        await ctx.query(
            "DELETE FROM general.users_profile user_profile WHERE user_profile.user_id = @user_id "
            , substitutionValues: {
          "user_id": previousUserProfileOrganization.user.id});

        result = await ctx.query(
            "DELETE FROM general.users u WHERE u.id = @id AND u.version = @version RETURNING true"
            , substitutionValues: {
          "id": previousUserProfileOrganization.user.id,
          "version": previousUserProfileOrganization.user.version});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authenticatedUserId,
                "organization_id": request.authenticatedOrganizationId,
                "object_id": request.userProfileOrganizationId,
                "object_version": request.userProfileOrganizationVersion,
                "object_class_name": user_profile_organization_m.UserProfileOrganization.className,
                "system_module_index": SystemModule.users.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousUserProfileOrganization.user.name,
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    user_profile_organization_m.UserProfileOrganization.fromProtoBufToModelMap(
                        previousUserProfileOrganization, true), {})});
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }
}