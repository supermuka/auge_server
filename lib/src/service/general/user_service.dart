// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';

import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_server/model/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_server/model/general/user.dart' as user_m;
import 'package:auge_server/model/general/history_item.dart' as history_item_m;

import 'package:uuid/uuid.dart';

class UserService extends UserServiceBase {

  // API
  @override
  Future<UsersResponse> getUsers(ServiceCall call,
      UserGetRequest request) async {
    return UsersResponse()/*..webWorkAround = true*/..users.addAll(await querySelectUsers(request));
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
  Future<StringValue> createUser(ServiceCall call,
      UserRequest request) async {
    return queryInsertUser(request);
  }

  @override
  Future<Empty> updateUser(ServiceCall call,
      UserRequest request) async {
    return queryUpdateUser(request);
  }

  @override
  Future<Empty> deleteUser(ServiceCall call,
      UserDeleteRequest request) async {
    return queryDeleteUser(request);
  }

  // Query
  static Future<List<User>> querySelectUsers([UserGetRequest request] /* {String id, String eMail, String password, String organizationId, bool withProfile = false} */) async {

    List<List> results;

    String queryStatement = '';
    if (request != null && request.withUserProfile == false) {
      queryStatement = "SELECT "
          " u.id, " //0
          " u.version, " //1
          " u.name " //2
          " FROM general.users u";
          " LEFT OUTER JOIN general.user_profiles user_profile on user_profile.user_id = u.id";

    }
    else {
      queryStatement = "SELECT "
          " u.id, " //0
          " u.version, " //1
          " u.name, " //2
          " user_profile.email, " //3
          " user_profile.image, " //4
          " user_profile.idiom_locale " //5
          " FROM general.users u "
          " LEFT OUTER JOIN general.user_profiles user_profile on user_profile.user_id = u.id";
    }

    String whereAnd = "WHERE";
    Map<String, dynamic> _substitutionValues = Map();
    if (request != null && request.organizationId != null  && request.organizationId.isNotEmpty) {
      queryStatement = queryStatement + " LEFT OUTER JOIN general.user_accesses user_accesses ON user_accesses.user_id = u.id";
      queryStatement = queryStatement + " ${whereAnd} user_accesses.organization_id = @organization_id";
      _substitutionValues.putIfAbsent("organization_id", () => request.organizationId);
      whereAnd = "AND";
    }
    if (request != null && request.id != null && request.id.isNotEmpty) {
      queryStatement = queryStatement + " ${whereAnd} u.id = @id";
      _substitutionValues.putIfAbsent("id", () => request.id);
      whereAnd = "AND";
    }

    List<User> users = [];
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: _substitutionValues);

      for (var row in results) {
        User user = new User()
          ..id = row[0]
          ..version = row[1]
          ..name = row[2];

        if (request != null && request.withUserProfile) {
          user.userProfile = UserProfile();
          if (row[3] != null) user.userProfile.eMail = row[3];
          if (row[4] != null) user.userProfile.image = row[4];
          if (row[5] != null) user.userProfile.idiomLocale = row[5];
        }
        users.add(user);
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
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

  static Future<StringValue> queryInsertUser(UserRequest request) async {
    if (!request.user.hasId()) {
      request.user.id = Uuid().v4();
    }

    request.user.version = 0;

    await (await AugeConnection.getConnection()).transaction((ctx) async {

      try {

        await ctx.query(
            "INSERT INTO general.users(id, version, name, inactive) VALUES("
                "@id,"
                "@version,"
                "@name,"
                "@inactive)"
            , substitutionValues: {
          "id": request.user.id,
          "version": request.user.version,
          "name": request.user.name,
          "inactive": request.user.inactive});

        if (request.user.userProfile != null) {
          await ctx.query(
              "INSERT INTO general.user_profiles(user_id, email, image, idiom_locale) VALUES("
                  "@id,"
                  "@email,"
                  "@image,"
                  "@idiom_locale)", substitutionValues: {
            "id": request.user.id,
            "email": request.user.userProfile.eMail,
            "image": request.user.userProfile.image,
            "idiom_locale": request.user.userProfile.idiomLocale});
        }

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.user.id,
          "object_version": request.user.version,
          "object_class_name": user_m.User.className,
          "system_module_index": SystemModule.users.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.user.name,
          "changed_values": history_item_m.HistoryItem.changedValuesJson({}, user_m.User.fromProtoBufToModelMap(request.user))});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return StringValue()..value = request.user.id;
  }

  static Future<Empty> queryUpdateUser(UserRequest request) async {

    User previousUser = await querySelectUser(UserGetRequest()..id = request.user.id..withUserProfile = true);

    // increment version
    ++request.user.version;

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.users "
                "SET version = @version,"
                "name = @name,"
                "inactivate = @inactivate "
                " WHERE id = @id AND version = @version - 1"
                " RETURNING true", substitutionValues: {
          "id": request.user.id,
          "version": request.user.version,
          "inactivate": request.user.inactive});

        await ctx.query(
            "UPDATE general.user_profiles "
                "SET email = @email, "
                "image = @image, "
                "idiom_locale = @idiom_locale "
                "WHERE user_id = @user_id"
            , substitutionValues: {
          "user_id": request.user.id,
          "email": request.user.userProfile.eMail,
          "image": request.user.userProfile.image,
          "idiom_locale": request.user.userProfile.idiomLocale});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.user.id,
                "object_version": request.user.version,
                "object_class_name": user_m
                    .User.className,
                "system_module_index": SystemModule.users.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": request.user.name,
                "changed_values": history_item_m.HistoryItem
                    .changedValuesJson(
                    user_m.User
                        .fromProtoBufToModelMap(
                        previousUser),
                    user_m.User
                        .fromProtoBufToModelMap(
                        request.user))});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  static Future<Empty> queryDeleteUser(UserDeleteRequest request) async {

    User previousUser = await querySelectUser(UserGetRequest()..id = request.userId);

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        await ctx.query(
            "DELETE FROM general.user_profiles user_profile WHERE user_profile.user_id = @user_id "
            , substitutionValues: {
          "user_id": request.userId});

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.users u WHERE u.id = @id AND u.version = @version RETURNING true"
            , substitutionValues: {
          "id": request.userId,
          "version": request.userVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.userId,
                "object_version": request.userVersion,
                "object_class_name": user_m.User.className,
                "system_module_index": SystemModule.users.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousUser.name,
                "changed_values": history_item_m.HistoryItem.changedValuesJson(
                    user_m.User.fromProtoBufToModelMap(
                        previousUser, true), {})});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

}