// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_shared/src/util/common_utils.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';

import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/user_control.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/general/user_service.dart';

class UserControlService extends UserControlServiceBase {

  // API
  @override
  Future<UserControl> getUserControl(ServiceCall call,
      UserControlGetRequest request) async {
    UserControl userControl = await querySelectUserControl(request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
   // Does not need to throw an exception.
   // if (userControl == null) throw new GrpcError.notFound("User Control not found.");
    return userControl ?? UserControl();
  }

  @override
  Future<Empty> createOrUpdateUserControl(ServiceCall call,
      UserControlRequest request) async {
    return queryInsertOrUpdateUserControl(request);
  }

  @override
  Future<Empty> deleteUserControl(ServiceCall call,
      UserControlDeleteRequest request) async {
    return queryDeleteUserControl(request);
  }

  // Query
  static Future<UserControl> querySelectUserControl(UserControlGetRequest request) async {

    List<List> results;

    String queryStatement = '';
    queryStatement = "SELECT "
        " user_control.user_id, "   //0
        " user_control.date_time_last_notification " //1
        " FROM general.user_controls user_control "
        " WHERE user_control.user_id = @user_id"; // [user_id] is primary key

    Map<String, dynamic> _substitutionValues = {"user_id": request.userId};

    UserControl userControl;
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: _substitutionValues);

      if (results != null && results.isNotEmpty) {
        var row = results.first;

        if (row != null && row.isNotEmpty) {
          userControl = UserControl();

        userControl.user =
        await UserService.querySelectUser(UserGetRequest()
          ..customUser = CustomUser.userOnlySpecification
          ..id = row[0]);

          userControl.dateTimeLastNotification =
              CommonUtils.timestampFromDateTime(row[1]);
        }
      }

    } catch (e) {
      print('querySelectUserControl - ${e.runtimeType}, ${e}');
      rethrow;
    }

    return userControl;
  }


  static Future<Empty> queryInsertOrUpdateUserControl(UserControlRequest request) async {
    if (!request.userControl.hasUser()) {
      throw Exception('User id does not exist.');
    }

    List<List> results;

    await (await AugeConnection.getConnection()).transaction((ctx) async {

      try {

        results = await ctx.query(
            "UPDATE general.user_controls SET date_time_last_notification = @date_time_last_notification WHERE user_id = @user_id RETURNING true"
            , substitutionValues: {
          "user_id": request.userControl.user.id,
          "date_time_last_notification": request.userControl.dateTimeLastNotification.toDateTime()});

        if (results.length == 0) {
          await ctx.query(
              "INSERT INTO general.user_controls(user_id, date_time_last_notification) VALUES("
                  "@user_id,"
                  "@date_time_last_notification)"
              , substitutionValues: {
            "user_id": request.userControl.user.id,
            "date_time_last_notification": request.userControl
                .dateTimeLastNotification.toDateTime()});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  static Future<Empty> queryDeleteUserControl(UserControlDeleteRequest request) async {

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.user_controls user_control WHERE user_control.user_id = @user_id RETURNING true"
            , substitutionValues: {
          "id": request.userId});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }
}