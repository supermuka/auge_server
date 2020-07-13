// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:grpc/grpc.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/organization.pb.dart';
import 'package:auge_shared/protos/generated/general/user_access.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';

import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/general/user_access.dart' as user_access_m;

import 'package:uuid/uuid.dart';

class UserAccessService extends UserAccessServiceBase {

  // API
  @override
  Future<UserAccessesResponse> getUserAccesses(ServiceCall call,
      UserAccessGetRequest UserAccessGetRequest) async {
    return UserAccessesResponse()..userAccesses.addAll(await querySelectUserAccesses(UserAccessGetRequest));
  }
/*
  @override
  Future<UserAccess> getUserAccess(ServiceCall call,
      UserAccessGetRequest request) async {
    //return UserProfileOrganization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
    return querySelectUserAccess(request);
  }
*/
  @override
  Future<StringValue> createUserAccess(ServiceCall call,
      UserAccessRequest request) async {
    StringValue id = await queryInsertUserAccess(request);
    if (id == null ) throw new GrpcError.notFound("User Organization Access not found.");
    return id;
  }

  @override
  Future<Empty> updateUserAccess(ServiceCall call,
      UserAccessRequest request) async {
    return queryUpdateUserAccess(request);
  }

  @override
  Future<Empty> deleteUserAccess(ServiceCall call,
      UserAccessDeleteRequest request) async {
    return queryDeleteUserAccess(request);
  }

  // Query
  static Future<List<UserAccess>> querySelectUserAccesses([UserAccessGetRequest UserAccessGetRequest] /* {String id, String userId, String organizationId} */) async {
    Map<String, User> _userCache = {};
    Map<String, Organization> _organizationCache = {};

    List<List> results;
    String queryStatement = '';
    queryStatement = "SELECT "
        "uo.id, " // 0
        "uo.version, " // 1
        "uo.user_id, " // 2
        "uo.organization_id, " //3
        "uo.access_role " // 4
        "FROM general.user_accesses uo ";
/*
        "JOIN general.users u ON u.id = uo.user_id "
        "LEFT OUTER JOIN general.users_profile user_profile on user_profile.user_id = u.id ";
*/
    Map<String, dynamic> _substitutionValues = Map<String, dynamic>();
    String whereAnd = 'WHERE';

    if (UserAccessGetRequest.hasId()) {
      queryStatement += " ${whereAnd} uo.id = @id";
      _substitutionValues.putIfAbsent("id", () => UserAccessGetRequest.id);
      whereAnd = 'AND';
    }

    if (UserAccessGetRequest.hasUserId()) {
      queryStatement += " ${whereAnd} uo.user_id = @user_id";
      _substitutionValues.putIfAbsent("user_id", () => UserAccessGetRequest.userId);
      whereAnd = 'AND';
    }

    if (UserAccessGetRequest.hasOrganizationId()) {
      queryStatement += " ${whereAnd} uo.organization_id = @organization_id";
      _substitutionValues.putIfAbsent("organization_id", () => UserAccessGetRequest.organizationId);
      whereAnd = 'AND';
    }
/*
    if (UserAccessGetRequest.hasEMail()) {
      queryStatement = queryStatement +
          " ${whereAnd} user_profile.email = @email";

      _substitutionValues.putIfAbsent("email", () => UserAccessGetRequest.eMail);
      whereAnd = 'AND';
    }
    if (UserAccessGetRequest.hasPassword()) {
      queryStatement = queryStatement +
          " ${whereAnd} user_profile.password = @password";
      _substitutionValues.putIfAbsent("password", () => UserAccessGetRequest.password);
      //The last, not need... whereAnd = 'AND';
    }
*/
    List<UserAccess> userAccesses = [];

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
                ..customUser = CustomUser.userOnlySpecificationProfileImage);

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
                    ..id = row[3]..customOrganization = CustomOrganization.organizationSpecification);

              if (organization != null)
                _organizationCache[row[3]] = organization;
            }
          }

          UserAccess userAccess = new UserAccess();

          userAccess.id = row[0];
          userAccess.version = row[1];
          userAccess.user = user;
          userAccess.organization = organization;
          userAccess.accessRole = row[4];
          userAccesses.add(userAccess);
        }
      }
    } catch (e) {
      print('querySelectUserAccesses ${e.runtimeType}, ${e}, ${e}');
      rethrow;
    }

    return userAccesses;
  }

  static Future<UserAccess> querySelectUserAccess(UserAccessGetRequest request) async {
    List<UserAccess> UserAccesses = await querySelectUserAccesses(request);
    if (UserAccesses == null || UserAccesses.isEmpty) throw new GrpcError.notFound("User Organization Access not found.");
    return UserAccesses.first;
  }

  static Future<StringValue> queryInsertUserAccess(UserAccessRequest request) async {

    try {

    await (await AugeConnection.getConnection()).transaction((ctx) async {

      /*
        if (request.hasWithUserProfile() && request.withUserProfile)  {


          if (!request.userProfileOrganization.user.hasId()) {
            request.userProfileOrganization.user.id = new Uuid().v4();
          }

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
        }
*/
        if (!request.userAccess.hasId()) {
          request.userAccess.id = new Uuid().v4();
        }

        request.userAccess.version = 0;

        await ctx.query(
            "INSERT INTO general.user_accesses(id, version, user_id, organization_id, access_role) VALUES("
                "@id,"
                "@version,"
                "@user_id,"
                "@organization_id,"
                "@access_role)"
            , substitutionValues: {
          "id": request.userAccess.id,
          "version": request.userAccess.version,
          "user_id": request.userAccess.hasUser() ? request.userAccess.user.id : null,
          "organization_id": request.userAccess.hasOrganization() ? request.userAccess.organization.id : null,
          "access_role": request.userAccess.accessRole});

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.userAccess.id,
          "object_version": request.userAccess.version,
          "object_class_name": user_access_m.UserAccess.className,
          "system_module_index": SystemModule.users.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.userAccess.user.name,
          "changed_values": history_item_m.HistoryItemHelper.changedValuesJson({}, request.userAccess.toProto3Json() )});
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.userAccess.id;
  }

  static Future<Empty> queryUpdateUserAccess(UserAccessRequest request) async {

    UserAccess previousUserAccess = await querySelectUserAccess(UserAccessGetRequest()..id = request.userAccess.id);

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {
/*
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
*/
        List<List<dynamic>> result = await ctx.query(
              "UPDATE general.user_accesses "
                  "SET version = @version, "
                  "access_role = @access_role, "
                  "user_id = @user_id, "
                  "organization_id = @organization_id "
                  "WHERE id = @id AND version = @version - 1 "
                  "RETURNING true", substitutionValues: {
            "id": request.userAccess.id,
            "version": ++request.userAccess.version,
            "user_id": request.userAccess.user.id,
            "organization_id": request.userAccess.organization.id,
            "access_role": request.userAccess.accessRole});

          // Optimistic concurrency control
          if (result.length == 0) {
            throw new GrpcError.failedPrecondition('Precondition Failed');
          } else {
            // Create a history item
            await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
                substitutionValues: {"id": Uuid().v4(),
                  "user_id": request.authUserId,
                  "organization_id": request.authOrganizationId,
                  "object_id": request.userAccess.id,
                  "object_version": request.userAccess.version,
                  "object_class_name": user_access_m
                      .UserAccess.className,
                  "system_module_index": SystemModule.users.index,
                  "system_function_index": SystemFunction.update.index,
                  "date_time": DateTime.now().toUtc(),
                  "description": request.userAccess.user.name,
                  "changed_values": history_item_m.HistoryItemHelper
                      .changedValuesJson(
                      previousUserAccess.toProto3Json(),
                      request.userAccess.toProto3Json())});
          }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  static Future<Empty> queryDeleteUserAccess(UserAccessDeleteRequest request) async {

    UserAccess previousUserAccess = await querySelectUserAccess(UserAccessGetRequest()..id = request.userAccessId);

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.user_accesses user_access "
                "WHERE user_access.id = @id AND user_access.version = @version "
                "RETURNING true"
            , substitutionValues: {
          "id": request.userAccessId,
          "version": request.userAccessVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }

       // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.userAccessId,
                "object_version": request.userAccessVersion,
                "object_class_name": user_access_m.UserAccess.className,
                "system_module_index": SystemModule.users.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousUserAccess.user.name,
                "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                        previousUserAccess.toProto3Json(), {})});
        }
      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty();
  }
}