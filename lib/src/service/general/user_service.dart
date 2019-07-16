// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';

import 'package:auge_server/src/service/general/db_connection_service.dart';

import 'package:auge_server/src/service/general/organization_service.dart';

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


/* The User and UserProfile C?UD is realized on UserProfileOrganization services. It was decided to put all data on one transaction.
  @override
  Future<IdResponse> createUser(ServiceCall call,
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
      UserRequest request) async {
    
    return await queryDeleteUser(request);
  }
*/

  // Query
  static Future<List<User>> querySelectUsers([UserGetRequest request] /* {String id, String eMail, String password, String organizationId, bool withProfile = false} */) async {

    List<List> results;

    String queryStatement = '';
    if (request != null && request.withProfile == false) {
      queryStatement = "SELECT "
          " u.id, " //0
          " u.version, " //1
          " u.name " //2
          " FROM general.users u";
          " LEFT OUTER JOIN general.users_profile user_profile on user_profile.user_id = u.id";

    }
    else {
      queryStatement = "SELECT "
          " u.id, " //0
          " u.version, " //1
          " u.name, " //2
          " user_profile.email, " //3
          " user_profile.password, " //4
          " user_profile.image, " //5
          " user_profile.idiom_locale, " //6
          " user_profile.organization_id, " //7
          " user_profile.directory_service_id " //8
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
          " ${whereAnd} user_profile.email = @email";

      _substitutionValues.putIfAbsent("email", () => request.eMail);
      whereAnd = "AND";
    }
    if (request != null && request.password != null && request.password.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} user_profile.password = @password";
      _substitutionValues.putIfAbsent("password", () => request.password);
      //The last whereAnd = "AND";
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

        if (request != null && request.withProfile) {
          user.userProfile = UserProfile();
          if (row[3] != null) user.userProfile.eMail = row[3];
          if (row[4] != null) user.userProfile.password = row[4];
          if (row[5] != null) user.userProfile.image = row[5];
          if (row[6] != null) user.userProfile.idiomLocale = row[6];
          if (row[7] != null) user.userProfile.organization =
          await OrganizationService.querySelectOrganization(
              OrganizationGetRequest()
                ..id = row[7]);
          if (row[8] != null) user.userProfile.directoryServiceId = row[8];
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
/*
  static Future<IdResponse> queryInsertUser(UserRequest request) async {
    if (!request.user.hasId()) {
      request.user.id = new Uuid().v4();
    }

    request.user.version = 0;

    await (await AugeConnection.getConnection()).transaction((ctx) async {

      try {

        await ctx.query(
            "INSERT INTO general.users(id, version,name, email, password) VALUES("
                "@id,"
                "@version,"
                "@name,"
                "@email,"
                "@password)"
            , substitutionValues: {
          "id": request.user.id,
          "version": request.user.version,
          "name": request.user.name,
          "email": request.user.eMail,
          "password": request.user.password});


        if (request.user.userProfile != null) {
          await ctx.query(
              "INSERT INTO general.users_profile(user_id, image, is_super_admin, idiom_locale) VALUES("
                  "@id,"
                  "@image,"
                  "@is_super_admin,"
                  "@idiom_locale)", substitutionValues: {
            "id": request.user.id,
            "image": request.user.userProfile.image,
            "is_super_admin": request.user.userProfile.isSuperAdmin,
            "idiom_locale": request.user.userProfile.idiomLocale});
        }

        // HistoryItem
        HistoryItem historyItem = HistoryItem()
          ..id = Uuid().v4()
          ..user = request.authenticatedUser
          ..objectId = request.user.id
          ..objectVersion = request.user.version
          ..objectClassName = request.user.runtimeType
              .toString() // 'User' // objectiveRequest.runtimeType.toString(),
          ..systemModuleIndex = SystemModule.users.index
          ..systemFunctionIndex = SystemFunction.create.index
        // ..dateTime
          ..description = request.user.name
        //  ..changedValuesPrevious.addAll(history_item_m.HistoryItem.changedValues(valuesPrevious, valuesCurrent))
          ..changedValuesJson = history_item_m.HistoryItem.changedValuesJson(
              {}, user_m.User.fromProtoBufToModelMap(request.user, true));

        // Create a history item

        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
            substitutionValues: HistoryItemService
                .querySubstitutionValuesCreateHistoryItem(historyItem));

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return IdResponse()..id = request.user.id;
  }

  static Future<Empty> queryUpdateUser(UserRequest request) async {

    User previousUser = await querySelectUser(UserGetRequest()..id = request.user.id..withProfile = true);

    // increment version
    ++request.user.version;

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.users "
                "SET version = @version,"
                "name = @name,"
                "email = @email,"
                "password = @password "
                " WHERE id = @id AND version = @version - 1"
                " RETURNING true", substitutionValues: {
          "id": request.user.id,
          "version": request.user.version,
          "name": request.user.name,
          "email": request.user.eMail,
          "password": request.user.password});

        await ctx.query(
            "UPDATE general.users_profile "
                "SET image = @image, "
                "is_super_admin = @is_super_admin, "
                "idiom_locale = @idiom_locale "
                "WHERE user_id = @user_id"
            , substitutionValues: {
          "user_id": request.user.id,
          "image": request.user.userProfile.image,
          "is_super_admin": request.user.userProfile.isSuperAdmin,
          "idiom_locale": request.user.userProfile.idiomLocale});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }

        // HistoryItem
        HistoryItem  historyItem = HistoryItem()
          ..id = Uuid().v4()
          ..user = request.authenticatedUser
          ..objectId = request.user.id
          ..objectVersion = request.user.version
          ..objectClassName = request.user.runtimeType.toString() // 'User' // objectiveRequest.runtimeType.toString(),
          ..systemModuleIndex = SystemModule.users.index
          ..systemFunctionIndex = SystemFunction.update.index
        // ..dateTime
          ..description = request.user.name
          ..changedValuesJson = history_item_m.HistoryItem.changedValuesJson(user_m.User.fromProtoBufToModelMap(previousUser, true), user_m.User.fromProtoBufToModelMap(request.user, true));

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(historyItem));


      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }


  static Future<Empty> queryDeleteUser(UserRequest request) async {

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        /*
        await ctx.query(
            "DELETE FROM general.users_profile_organizations user_profile_organization WHERE user_profile_organization.user_id = @user_id AND user_profile_organization.version = @version "
            , substitutionValues: {
          "user_id": request.user.id,
          "version": request.user.version});
*/
        await ctx.query(
            "DELETE FROM general.users_profile user_profile WHERE user_profile.user_id = @user_id "
            , substitutionValues: {
          "user_id": request.user.id});

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.users u WHERE u.id = @id AND u.version = @version RETURNING true"
            , substitutionValues: {
          "id": request.user.id,
          "version": request.user.version});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }

        // HistoryItem
        HistoryItem  historyItem = HistoryItem()
          ..id = Uuid().v4()
          ..user = request.authenticatedUser
          ..objectId = request.user.id
          ..objectVersion = request.user.version
          ..objectClassName = request.user.runtimeType.toString() // 'User' // objectiveRequest.runtimeType.toString(),
          ..systemModuleIndex = SystemModule.users.index
          ..systemFunctionIndex = SystemFunction.delete.index
        // ..dateTime
          ..description = request.user.name
          ..changedValuesJson = history_item_m.HistoryItem.changedValuesJson(user_m.User.fromProtoBufToModelMap(request.user, true), {});

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: HistoryItemService.querySubstitutionValuesCreateHistoryItem(historyItem));

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }
  */
}