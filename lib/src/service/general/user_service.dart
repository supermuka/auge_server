// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';

import 'package:auge_server/augeconnection.dart';

import 'package:uuid/uuid.dart';

class UserService extends UserServiceBase {

  // API
  @override
  Future<UsersResponse> getUsers(ServiceCall call,
      UserGetRequest request) async {
    return UsersResponse()..webListWorkAround = true..users.addAll(await querySelectUsers(request));
  }

  @override
  Future<User> getUser(ServiceCall call,
      UserGetRequest request) async {
    User user = await querySelectUser(request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
    if (user == null) throw new GrpcError.notFound("User not found.");
    return user;
  }

  @override
  Future<IdResponse> createUser(ServiceCall call,
      User request) async {
    return queryInsertUser(request);
  }

  @override
  Future<Empty> updateUser(ServiceCall call,
      User request) async {
    return queryUpdateUser(request);
  }

  @override
  Future<Empty> deleteUser(ServiceCall call,
      User request) async {
    return Empty()..webWorkAround = true;
  }

  @override
  Future<Empty> softDeleteUser(ServiceCall call,
      User request) async {
    return querySoftDeleteUser(request);
  }

  // Query
  static Future<List<User>> querySelectUsers([UserGetRequest request] /* {String id, String eMail, String password, String organizationId, bool withProfile = false} */) async {

    List<List> results;

    String queryStatement = '';
    if (request != null && request.withProfile == false) {
      queryStatement = "SELECT u.id, u.version, u.is_deleted, u.name, u.email, u.password "
          "FROM general.users u ";
    }
    else {
      queryStatement = "SELECT u.id, u.version, u.is_deleted, u.name, u.email, u.password, "
          " user_profile.image, "
          " user_profile.is_super_admin, "
          " user_profile.idiom_locale "
          " FROM general.users u "
          " LEFT OUTER JOIN general.users_profile user_profile on user_profile.user_id = u.id";
    }

    String whereAnd = "WHERE";
    Map<String, dynamic> _substitutionValues = Map();
    if (request != null && request.organizationId != null  && request.organizationId.isNotEmpty) {
      queryStatement = queryStatement + " LEFT OUTER JOIN general.users_profile_organizations user_profile_organization ON user_profile_organization.user_id = u.id";
      queryStatement = queryStatement + " ${whereAnd} user_profile_organization.organization_id = @organization_id";
      _substitutionValues.putIfAbsent("organization_id", () => request.organizationId);
      whereAnd = "AND";
    }
    if (request != null && request.id != null && request.id.isNotEmpty) {
      queryStatement = queryStatement + " ${whereAnd} u.id = @id";
      _substitutionValues.putIfAbsent("id", () => request.id);
      whereAnd = "AND";
    }
    if (request != null && request.eMail != null && request.eMail.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} u.email = @email";

      _substitutionValues.putIfAbsent("email", () => request.eMail);
      whereAnd = "AND";
    }
    if (request != null && request.password != null && request.password.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} u.password = @password";
      _substitutionValues.putIfAbsent("password", () => request.password);
      whereAnd = "AND";
    }
    if (request != null && request.isDeleted != null) {
      queryStatement = queryStatement + " ${whereAnd} u.is_deleted = @is_deleted";
      _substitutionValues.putIfAbsent("is_deleted", () => request.isDeleted);
      // whereAnd = "AND";
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: _substitutionValues);

    List<User> users = new List();
    for (var row in results) {
      User user = new User()
        ..id = row[0]
        ..version = row[1]
        ..isDeleted = row[2]
        ..name = row[3]
        ..eMail = row[4]
        ..password = row[5];

      if (request != null && request.withProfile) {
        user.userProfile = UserProfile();
        if (row[6] != null) user.userProfile.image = row[6];
        if (row[7] != null) user.userProfile.isSuperAdmin = row[7];
        if (row[8] != null) user.userProfile.idiomLocale = row[8];
      }
      users.add(user);
    }

    return users;
  }

  static Future<User> querySelectUser(UserGetRequest request, /*String id,  {bool withProfile = false,*/ {Map<String, User> cache}) async {
    if (cache != null && cache.containsKey(request.id)) {
      return cache[request.id];
    } else {

      List<User> users = await querySelectUsers(request /* id: id, withProfile: withProfile */);
      if (users.isNotEmpty) {
        if (cache != null) cache[request.id] = users.first;
        return users.first;
      } else {
        return null;
      }
    }
  }

  static Future<IdResponse> queryInsertUser(User user) async {
    if (!user.hasId()) {
      user.id = new Uuid().v4();
    }
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "INSERT INTO general.users(id, version, is_deleted, name, email, password) VALUES("
                "@id,"
                "@version,"
                "@is_deleted,"
                "@name,"
                "@email,"
                "@password)"
            , substitutionValues: {
          "id": user.id,
          "version": 0,
          "is_deleted": false,
          "name": user.name,
          "email": user.eMail,
          "password": user.password});
        if (user.userProfile != null)
          await ctx.query(
              "INSERT INTO general.users_profile(user_id, image, is_super_admin, idiom_locale) VALUES("
                  "@id,"
                  "@image,"
                  "@is_super_admin,"
                  "@idiom_locale)", substitutionValues: {
            "id": user.id,
            "image": user.userProfile.image,
            "is_super_admin": user.userProfile.isSuperAdmin,
            "idiom_locale": user.userProfile.idiomLocale});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });

    return IdResponse()..id = user.id;

  }

  static Future<Empty> queryUpdateUser(User user) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.users "
                "SET version = @version + 1,"
                "name = @name,"
                "email = @email,"
                "password = @password "
                " WHERE id = @id AND version = @version"
                " RETURNING true", substitutionValues: {
          "id": user.id,
          "version": user.version,
          "name": user.name,
          "email": user.eMail,
          "password": user.password});

        await ctx.query(
            "UPDATE general.users_profile "
                "SET image = @image, "
                "is_super_admin = @is_super_admin, "
                "idiom_locale = @idiom_locale "
                "WHERE user_id = @user_id"
            , substitutionValues: {
          "user_id": user.id,
          "image": user.userProfile.image,
          "is_super_admin": user.userProfile.isSuperAdmin,
          "idiom_locale": user.userProfile.idiomLocale});

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

  static Future<Empty> querySoftDeleteUser(User user) async {
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.users "
                "SET version = @version + 1, "
                "is_deleted = @is_deleted "
                "WHERE id = @id AND version = @version "
                "RETURNING true", substitutionValues: {
          "id": user.id,
          "version": user.version,
          "is_deleted": true});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }

        // Soft delete user_profile_organizations related to user
        await ctx.query(
            "UPDATE general.users_profile_organizations "
                "SET version = version + 1, "
                "is_deleted = @is_deleted "
                "WHERE user_id = @user_id", substitutionValues: {
          "user_id": user.id,
          "is_deleted": true});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }


  static Future<Empty> queryDeleteUser(User user) async {

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM general.users_profile user_profile WHERE user_profile.user_id = @user_id"
            , substitutionValues: {
          "user_id": user.id});

        await ctx.query(
            "DELETE FROM general.users u WHERE u.id = @id"
            , substitutionValues: {
          "id": user.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }
}