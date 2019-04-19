// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pbgrpc.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';

import 'package:uuid/uuid.dart';

class UserProfileOrganizationService extends UserProfileOrganizationServiceBase {

  // API
  @override
  Future<UsersProfileOrganizationsResponse> getUsersProfileOrganizations(ServiceCall call,
      UserProfileOrganizationGetRequest userProfileOrganizationGetRequest) async {
    return UsersProfileOrganizationsResponse()..webWorkAround = true..usersProfileOrganizations.addAll(await querySelectUsersProfileOrganizations(userProfileOrganizationGetRequest));
  }

  @override
  Future<UserProfileOrganization> getUserProfileOrganization(ServiceCall call,
      UserProfileOrganizationGetRequest request) async {
    //return UserProfileOrganization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
    return querySelectUserProfileOrganization(request);
  }

  @override
  Future<IdResponse> createUserProfileOrganization(ServiceCall call,
      UserProfileOrganization userProfileOrganization) async {
    IdResponse idResponse = await queryInsertUserProfileOrganization(userProfileOrganization);
    if (idResponse == null ) throw new GrpcError.notFound("User Profile Organization not found.");
    return idResponse;
  }

  @override
  Future<Empty> updateUserProfileOrganization(ServiceCall call,
      UserProfileOrganization userProfileOrganization) async {
    return queryUpdateUserProfileOrganization(userProfileOrganization);
  }

  @override
  Future<Empty> deleteUserProfileOrganization(ServiceCall call,
      UserProfileOrganization userProfileOrganization) async {
    return queryDeleteUserProfileOrganization(userProfileOrganization);
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
        "LEFT OUTER JOIN general.users u ON u.id = uo.user_id ";

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
          " ${whereAnd} u.email = @email";

      _substitutionValues.putIfAbsent("email", () => userProfileOrganizationGetRequest.eMail);
      whereAnd = 'AND';
    }
    if (userProfileOrganizationGetRequest.hasPassword()) {
      queryStatement = queryStatement +
          " ${whereAnd} u.password = @password";
      _substitutionValues.putIfAbsent("password", () => userProfileOrganizationGetRequest.password);
      //The last, not need... whereAnd = 'AND';
    }

    results = await (await AugeConnection.getConnection()).query(
        queryStatement, substitutionValues: _substitutionValues);

    List<UserProfileOrganization> usersOrganizations = new List();

    User user;
    Organization organization;

    if (results.isNotEmpty) {
      for (var row in results) {
        if (row[2] != null) {
          if (_userCache.containsKey(row[2])) {
            user = _userCache[row[2]];
          } else {
            user =
            await UserService.querySelectUser(UserGetRequest()..id = row[2]..withProfile = true);
            if (user != null) _userCache[row[2]] = user;
          }
        }

        if (row[3] != null) {
          if (_organizationCache.containsKey(row[3])) {
            organization = _organizationCache[row[3]];
          } else {
            organization =
            await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = row[3]);
            if (organization != null) _organizationCache[row[3]] = organization;
          }
        }

        UserProfileOrganization userProfileOrganization = new UserProfileOrganization();

        userProfileOrganization.id = row[0];
        userProfileOrganization.user = user;
        userProfileOrganization.organization = organization;
        userProfileOrganization.authorizationRole = row[4];

        usersOrganizations.add(userProfileOrganization);
      }
    }

    return usersOrganizations;
  }

  static Future<UserProfileOrganization> querySelectUserProfileOrganization(UserProfileOrganizationGetRequest request) async {
    List<UserProfileOrganization> usersProfileOrganizations = await querySelectUsersProfileOrganizations(request);
    if (usersProfileOrganizations == null || usersProfileOrganizations.isEmpty) throw new GrpcError.notFound("User Profile Organization not found.");
    return usersProfileOrganizations.first;
  }

  static Future<IdResponse> queryInsertUserProfileOrganization(UserProfileOrganization userProfileOrganization) async {

    if (!userProfileOrganization.hasId()) {
      userProfileOrganization.id = new Uuid().v4();
    }

    userProfileOrganization.version = 0;

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        await ctx.query(
            "INSERT INTO general.users_profile_organizations(id, version, user_id, organization_id, authorization_role) VALUES("
                "@id,"
                "@version,"
                "@user_id,"
                "@organization_id,"
                "@authorization_role)"
            , substitutionValues: {
          "id": userProfileOrganization.id,
          "version": userProfileOrganization.version,
          "user_id": userProfileOrganization.hasUser() ? userProfileOrganization.user.id : null,
          "organization_id": userProfileOrganization.hasOrganization() ? userProfileOrganization.organization.id : null,
          "authorization_role": userProfileOrganization.authorizationRole});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });

    return IdResponse()..id = userProfileOrganization.id;
  }

  static Future<Empty> queryUpdateUserProfileOrganization(UserProfileOrganization userProfileOrganization) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        List<List<dynamic>> result = await ctx.query(
              "UPDATE general.users_profile_organizations "
                  "SET version = @version + 1, "
                  "authorization_role = @authorization_role, "
                  "user_id = @user_id, "
                  "organization_id = @organization_id "
                  "WHERE id = @id "
                  "RETURNING true", substitutionValues: {
            "id": userProfileOrganization.id,
            "version": userProfileOrganization.version,
            "user_id": userProfileOrganization.user.id,
            "organization_id": userProfileOrganization.organization.id,
            "authorization_role": userProfileOrganization.authorizationRole});

          // Optimistic concurrency control
          if (result.length == 0) {
            throw new GrpcError.failedPrecondition('Precondition Failed');
          }

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }

  static Future<Empty> queryDeleteUserProfileOrganization(UserProfileOrganization userProfileOrganization) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM general.users_profile_organizations user_profile_organization "
                "WHERE user_profile_organization.id = @id "
            , substitutionValues: {
          "id": userProfileOrganization.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }
}