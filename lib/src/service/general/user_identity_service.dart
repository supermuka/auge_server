// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'dart:math';

import 'dart:convert' show base64;
import 'package:auge_shared/message/messages.dart';
import 'package:crypto/crypto.dart' show sha256;

import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:auge_shared/src/util/common_utils.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';

import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/user_identity.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/organization_directory_service_service.dart';

import 'package:auge_shared/domain/general/user_identity.dart' as user_identity_m;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/general/organization_directory_service.dart' as organization_directory_service_m;

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;

import 'package:auge_server/src/util/mail.dart';

class UserIdentityService extends UserIdentityServiceBase {

  // API
  @override
  Future<UserIdentitiesResponse> getUserIdentities(ServiceCall call,
      UserIdentityGetRequest request) async {
    return UserIdentitiesResponse()/*..webWorkAround = true*/..userIdentities.addAll(await querySelectUserIdentities(request));
  }
/*
  @override
  Future<UserIdentity> getUserIdentity(ServiceCall call,
      UserIdentityGetRequest request) async {
    UserIdentity userIdentity = await querySelectUserIdentity(request);
    // if (user == null) call.sendTrailers(status: StatusCode.notFound, message: "User not found.");
    if (userIdentity == null) throw new GrpcError.notFound("User Identity not found.");
    return userIdentity;
  }
*/
  @override
  Future<StringValue> createUserIdentity(ServiceCall call,
      UserIdentityRequest request) async {
    return queryInsertUserIdentity(request);
  }

  @override
  Future<Empty> updateUserIdentity(ServiceCall call,
      UserIdentityRequest request) async {
    return queryUpdateUserIdentity(request);
  }

  @override
  Future<Empty> deleteUserIdentity(ServiceCall call,
      UserIdentityDeleteRequest request) async {
    return queryDeleteUserIdentity(request);
  }

  @override
  Future<NewPasswordCodeResponse> generateNewPasswordCodeAndSendEmail(ServiceCall call,
      NewPasswordCodeRequest request) async {
    return queryGenerateNewPasswordCodeAndSendEmail(request);
  }

  @override
  Future<Empty> updateUserIdentityPassword(ServiceCall call,
      UserIdentityPasswordRequest request) async {
    return queryUpdateUserIdentityPassword(request);
  }

  // Query
  static Future<List<UserIdentity>> querySelectUserIdentities([UserIdentityGetRequest request]) async {

    List<List> results;
    String queryStatement = '';
    if (request != null) {
      queryStatement = "SELECT "
          " ui.id, " //0
          " ui.version, " //1
          " ui.identification, " //2
          " ui.password_salt, " //3
          " ui.password_hash, " //4
          " ui.provider,  " //5
          " ui.provider_object_id,  " //6
          " ui.user_id " //7
          " FROM general.user_identities ui"
          " JOIN general.users u ON u.id = ui.user_id";
    }

    String whereAnd = "WHERE";
    Map<String, dynamic> _substitutionValues = Map();
    if (request != null && request.id != null && request.id.isNotEmpty) {
      queryStatement = queryStatement + " ${whereAnd} ui.id = @id";
      _substitutionValues.putIfAbsent("id", () => request.id);
      whereAnd = "AND";
    }
    if (request != null && request.identification != null && request.identification.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} ui.identification = @identification";

      _substitutionValues.putIfAbsent("identification", () => request.identification);
      whereAnd = "AND";
    }
    if (request != null && request.managedByOrganizationId != null && request.managedByOrganizationId.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} u.managed_by_organization_id = @managed_by_organization_id";

      _substitutionValues.putIfAbsent("managed_by_organization_id", () => request.managedByOrganizationId);
      // whereAnd = "AND";
    }

    /*
    if (request != null && request.password_hash != null && request.password_hash.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} ui.password_hash = @password_hash";
      _substitutionValues.putIfAbsent("password_hash", () => request.password);
      //The last whereAnd = "AND";
    }
    */

    if (request.hasUserId() && request.userId != null && request.userId.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} ui.user_id = @user_id";

      _substitutionValues.putIfAbsent("user_id", () => request.userId);
      // whereAnd = "AND";
    }

    List<UserIdentity> userIdentities = [];
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: _substitutionValues);

      for (var row in results) {
        UserIdentity userIdentity = new UserIdentity()
          ..id = row[0]
          ..identification = row[2];

        if (row[1] != null) userIdentity.version = row[1];
        if (row[3] != null) userIdentity.passwordSalt = row[3];
        if (row[4] != null) userIdentity.passwordHash = row[4];
        if (row[5] != null) userIdentity.provider = row[5];
        if (row[6] != null) userIdentity.providerObjectId = row[6];

        userIdentity.user = await UserService.querySelectUser(UserGetRequest()
          ..id = row[7]);
          // Need to get organization managed ..customUser = CustomUser.userOnlySpecification /*..withUserProfile = UserGetRequest_WithUserProfile.only_image */);

        // If password is informed, calc a hash and compare to passward_hash stored
        if (request.hasPassword() && request.password.isNotEmpty) {

          // Internal identity provider
          if (userIdentity.provider ==
              user_identity_m.UserIdentityProvider.internal.index) {
            String passwordHashComputed = base64.encode(sha256
                .convert(
                (userIdentity.passwordSalt + request.password).codeUnits)
                .bytes);

            if (userIdentity.passwordHash != passwordHashComputed) {
              // Not add to userIdentities list.
              continue;
            }

          // Directory Service identity provider
          } else if (userIdentity.provider ==
              user_identity_m.UserIdentityProvider.directoryService.index) {

            if (await OrganizationDirectoryServiceService.authDirectoryService(userIdentity.user.managedByOrganization.id, userIdentity.identification, userIdentity.providerDn, request.password) != organization_directory_service_m.DirectoryServiceStatus.finished.index)

              continue;

          } else {
            continue;
          }
        }

        userIdentities.add(userIdentity);
      }
    } catch (e) {
      print('querySelectUserIdentities - ${e.runtimeType}, ${e}');
      rethrow;
    }
    return userIdentities;
  }

  static Future<UserIdentity> querySelectUserIdentity(UserIdentityGetRequest request, {Map<String, UserIdentity> cache}) async {
    if (cache != null && cache.containsKey(request.id)) {
      return cache[request.id];
    } else {

      List<UserIdentity> userIdentities = await querySelectUserIdentities(request);
      if (userIdentities.isNotEmpty) {
        if (cache != null) cache[request.id] = userIdentities.first;
        return userIdentities.first;
      } else {
        return null;
      }
    }
  }

  static Future<StringValue> queryInsertUserIdentity(UserIdentityRequest request) async {
    if (!request.userIdentity.hasId()) {
      request.userIdentity.id = Uuid().v4();
    }

    request.userIdentity.version = 0;

    await (await AugeConnection.getConnection()).transaction((ctx) async {

      try {

        if (request.userIdentity.hasPassword() && request.userIdentity.password.isNotEmpty) {
          request.userIdentity.passwordSalt = CommonUtils.createCryptoRandomString();
          request.userIdentity.passwordHash = base64.encode(sha256
              .convert((request.userIdentity.passwordSalt + request.userIdentity.password).codeUnits)
              .bytes);

          // Not save original password into history.
          request.userIdentity.password = '*******';
        }

        await ctx.query(
            "INSERT INTO general.user_identities(id, version, identification, provider, provider_object_id, password_salt, password_hash, user_id) VALUES("
                "@id,"
                "@version,"
                "@identification,"
                "@provider,"
                "@provider_object_id,"
                "@password_salt,"
                "@password_hash,"
                "@user_id)"
            , substitutionValues: {
          "id": request.userIdentity.id,
          "version": request.userIdentity.version,
          "identification": request.userIdentity.identification,
          "provider": request.userIdentity.provider,
          "provider_object_id": request.userIdentity.providerObjectId,
          "password_salt": request.userIdentity.hasPasswordSalt() ? request.userIdentity.passwordSalt : null,
          "password_hash": request.userIdentity.hasPasswordHash() ? request.userIdentity.passwordHash : null,
          "user_id": request.userIdentity.user.id});

        // Doesn't save hash and salt into history.
        request.userIdentity.clearPasswordHash();
        request.userIdentity.clearPasswordSalt();

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id": request.userIdentity.id,
          "object_version": request.userIdentity.version,
          "object_class_name": user_identity_m.UserIdentity.className,
          "system_module_index": SystemModule.users.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.userIdentity.user.name,
          "changed_values": history_item_m.HistoryItemHelper.changedValuesJson({}, request.userIdentity.toProto3Json() )});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return StringValue()..value = request.userIdentity.id;
  }

  static Future<Empty> queryUpdateUserIdentity(UserIdentityRequest request) async {

    UserIdentity previousUserIdentity = await querySelectUserIdentity(UserIdentityGetRequest()..id = request.userIdentity.id);

    // increment version
    ++request.userIdentity.version;

    // If has password (new), new salt and hash is calculated.
    if (request.userIdentity.hasPassword() && request.userIdentity.password.isNotEmpty) {

      request.userIdentity.passwordSalt = CommonUtils.createCryptoRandomString();
      request.userIdentity.passwordHash = base64.encode(sha256
          .convert((request.userIdentity.passwordSalt + request.userIdentity.password).codeUnits)
          .bytes);

      // Not save original password into history.
      request.userIdentity.password = '*******';
    }

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result = await ctx.query(
            "UPDATE general.user_identities "
                "SET version = @version,"
                "identification = @identification,"
                "provider = @provider,"
                "provider_object_id = @provider_object_id,"
                "password_salt = @password_salt,"
                "password_hash = @password_hash,"
                "user_id = @user_id"
                " WHERE id = @id AND version = @version - 1"
                " RETURNING true", substitutionValues: {
          "id": request.userIdentity.id,
          "version": request.userIdentity.version,
          "identification": request.userIdentity.identification,
          "provider": request.userIdentity.provider,
          "provider_object_id": request.userIdentity.providerObjectId,
          "password_salt": request.userIdentity.hasPasswordSalt() ? request.userIdentity.passwordSalt : null,
          "password_hash": request.userIdentity.hasPasswordHash() ? request.userIdentity.passwordHash : null,
          "user_id": request.userIdentity.user.id});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {

          // Doesn't save hash and salt into history.
          request.userIdentity.clearPasswordHash();
          request.userIdentity.clearPasswordSalt();

          previousUserIdentity.password = '******';
          previousUserIdentity.clearPasswordHash();
          previousUserIdentity.clearPasswordSalt();

          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.userIdentity.id,
                "object_version": request.userIdentity.version,
                "object_class_name": user_identity_m
                    .UserIdentity.className,
                "system_module_index": SystemModule.users.index,
                "system_function_index": SystemFunction.update.index,
                "date_time": DateTime.now().toUtc(),
                "description": request.userIdentity.user.name,
                "changed_values": history_item_m.HistoryItemHelper
                    .changedValuesJson(
                        previousUserIdentity.toProto3Json(),
                        request.userIdentity.toProto3Json() )});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  static Future<Empty> queryUpdateUserIdentityPassword(UserIdentityPasswordRequest request) async {

    UserIdentityRequest userIdentityRequest = UserIdentityRequest();
    userIdentityRequest.userIdentity = await querySelectUserIdentity(UserIdentityGetRequest()..identification = request.identification);
    userIdentityRequest.userIdentity.password = request.password;

    // Get organization and user related to UserIdentity
    userIdentityRequest.authUserId = userIdentityRequest.userIdentity.user.id;
    userIdentityRequest.authOrganizationId = userIdentityRequest.userIdentity.user.managedByOrganization.id;

    queryUpdateUserIdentity(userIdentityRequest);

    return Empty();
  }

  static Future<Empty> queryDeleteUserIdentity(UserIdentityDeleteRequest request) async {

    UserIdentity previousUserIdentity = await querySelectUserIdentity(UserIdentityGetRequest()..id = request.userIdentityId);

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        List<List<dynamic>> result = await ctx.query(
            "DELETE FROM general.user_identities user_identity WHERE user_identity.id = @id AND user_identity.version = @version RETURNING true"
            , substitutionValues: {
          "id": request.userIdentityId,
          "version": request.userIdentityVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.userIdentityId,
                "object_version": request.userIdentityVersion,
                "object_class_name": user_identity_m.UserIdentity.className,
                "system_module_index": SystemModule.users.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousUserIdentity.user.name,
                "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                        previousUserIdentity.toProto3Json(), {})});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty();
  }

  /// Send email with code used to define the new password.
  static Future<NewPasswordCodeResponse> queryGenerateNewPasswordCodeAndSendEmail(NewPasswordCodeRequest newPasswordCodeRequest) async {

    List<List> results;

    String queryStatement = '';

    queryStatement = "SELECT "
        "u.name, "
        "user_identity.provider, "
        "user_profile.email "
        "FROM general.user_profiles user_profile "
        "JOIN general.users u ON u.id = user_profile.user_id "
        "JOIN general.user_identities user_identity ON user_identity.user_id = user_profile.user_id "
        "WHERE u.inactive = false ";
    
    Map<String, dynamic> _substitutionValues = {};
    
    if (newPasswordCodeRequest.hasIdentification()) {
      queryStatement = queryStatement + 'AND user_identity.identification = @identification';
      _substitutionValues.putIfAbsent("identification", () => newPasswordCodeRequest.identification);
    } else {
        throw new GrpcError.failedPrecondition('Identification address not informed.');
    }
    /*
    if (request != null && request.password_hash != null && request.password_hash.isNotEmpty) {
      queryStatement = queryStatement +
          " ${whereAnd} ui.password_hash = @password_hash";
      _substitutionValues.putIfAbsent("password_hash", () => request.password);
      //The last whereAnd = "AND";
    }
    */

    String eMail;
    String code;
    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: _substitutionValues);

      if (results.isEmpty) {
        throw new GrpcError.notFound('User with eMail address infomed not found.');
      } else {
        var row = results.first;

        // Just define new passward when user is managed by internal provider (auge)
        if (row[1] != 0) {
          throw new GrpcError.notFound('User with identification infomed have external provider to authenticate. Then the password should be defined in external provider.');
        } else {
          code = Random().nextInt(9999).toString().padLeft(4, '0');
          eMail = row[2];

          String subject = MailMsg.subjectNewPasswordRequired();
          String html = '<p>'
              '${row[0]}, '
              '</p>'
              '<p>'
              '${MailMsg
              .toDefineNewPasswordInformTheCode()}: <strong>${code}</storng>'
              '</p>'
              '<p style="font-size:small;color:#666;">'
              '<span>__</span>'
              '<br/>'
              '${MailMsg
              .youIsReceivingThisEMailBecauseNewPasswordWasRequired()}'
              '<br/>'
              '<a href="http://auge.levius.com.br/">${MailMsg
              .InformIt()}</a>.'
              '</p>';

          bool result = await AugeMail().sendMessage(List<String>()
            ..add(row[2]), subject, html);

          if (!result) {
            throw new GrpcError.unknown('E-Mail not sent.');
          }
        }
      }
    } catch (e) {

      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return NewPasswordCodeResponse()..code = code..eMail = eMail;

  }
}