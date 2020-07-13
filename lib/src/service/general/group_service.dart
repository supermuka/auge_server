// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:auge_shared/protos/generated/general/group.pbgrpc.dart';

import 'package:auge_server/src/util/db_connection.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';

import 'package:auge_shared/domain/general/authorization.dart' show SystemModule, SystemFunction;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;
import 'package:auge_shared/domain/general/group.dart' as group_m;

import 'package:uuid/uuid.dart';

class GroupService extends GroupServiceBase {

  // API
  /*
  @override
  Future<GroupTypesResponse> getGroupTypes(ServiceCall call,
      Empty empty) async {
    return GroupTypesResponse()..groupTypes.addAll(await querySelectGroupTypes());
  }

  @override
  Future<GroupType> getGroupType(ServiceCall call,
      GroupTypeGetRequest request) async {
    GroupType groupType = await querySelectGroupType(request);
    if (groupType == null) throw new GrpcError.notFound("Group Type not found.");
    return groupType;
  }
*/

  @override
  Future<GroupsResponse> getGroups(ServiceCall call,
      GroupGetRequest request) async {
    try {
      return GroupsResponse()/*..webWorkAround = true*/..groups.addAll(await querySelectGroups(request));
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /*

  @override
  Future<Group> getGroup(ServiceCall call,
      GroupGetRequest request) async {
    Group group = await querySelectGroup(request);
    if (group == null) throw new GrpcError.notFound("Group not found.");
    return group;
  }

   */

  @override
  Future<StringValue> createGroup(ServiceCall call,
      GroupRequest request) async {
    return queryInsertGroup(request);
  }

  @override
  Future<Empty> updateGroup(ServiceCall call,
      GroupRequest request) async {
    return queryUpdateGroup(request);
  }

  @override
  Future<Empty> deleteGroup(ServiceCall call,
      GroupDeleteRequest request) async {
    return queryDeleteGroup(request);
  }

  // Query
  static Future<List<Group>> querySelectGroups( GroupGetRequest request /* {String id, String organizationId, int alignedToRecursive = 1} */ ) async {

    List<Group> groups = [];

    String queryStatement = "SELECT";

    if (request.hasCustomGroup()) {

      if (request.customGroup == CustomGroup.groupOnlySpecification) {
        queryStatement = queryStatement +
            " g.id" //0
                ",g.name" //1
                ",null" //2
                ",null" //3
                ",null" //4
                ",null" //5
                ",null"; //6
      } else if (request.customGroup == CustomGroup.groupWithMembers) {
        queryStatement = queryStatement +
            " g.id" //0
            ",g.name"  //1
            ",g.version" //2
            ",g.inactive" //3
            ",g.group_type_index" //4
            ",g.leader_user_id" //5
            ",g.super_group_id"; //6
      } else { // none
        return null;
      }
    } else {
      queryStatement = queryStatement +
          " g.id" //0
          ",g.name"  //1
          ",g.version" //2
          ",g.inactive" //3
          ",g.group_type_index" //4
          ",g.leader_user_id" //5
          ",g.super_group_id"; //6
      }

    queryStatement = queryStatement + " FROM general.groups g ";

    Map<String, dynamic> substitutionValues;

    if (request.hasId()) {
      queryStatement = queryStatement + " WHERE g.id = @id";
      substitutionValues = {
        "id": request.id,
      };
    }
    else if (request.hasOrganizationId()) {
      queryStatement = queryStatement + " WHERE g.organization_id = @organization_id";
      substitutionValues = {
        "organization_id": request.organizationId,
      };
    } else {
      throw Exception('id or organization id does not informed.');
    }

    List<List> results;
    //   Map<String, Organization> organizationCache = {};
    Map<String, User> userCache = {};
    Map<String, Group> groupCache = {};

    try {
      results = await (await AugeConnection.getConnection()).query(
          queryStatement, substitutionValues: substitutionValues);

      if (results.length > 0) {

        User leader;
        Group superGroup;
        List<User> members;

        fillFields(Group group, row) async {

          group.id = row[0];
          group.name = row[1];

          if (row[2] != null) group.version = row[2];
          if (row[3] != null) group.inactive = row[3];
          if (row[4] != null) group.groupTypeIndex = row[4];

          if (row[5] != null) {
            leader =
                await UserService.querySelectUser(UserGetRequest()
              ..customUser = CustomUser.userOnlySpecificationProfileImage
              ..id = row[5], cache: userCache);
          } else {
            leader = null;
          }

          if (row[6] != null && request.alignedToRecursive > 0) {

            superGroup =
                await querySelectGroup(GroupGetRequest()
              ..id = row[6]
              ..customGroup = CustomGroup.groupOnlySpecification
              ..alignedToRecursive = --request.alignedToRecursive,
                cache: groupCache);

          } else {
            superGroup = null;
          }


          if (superGroup != null) {
            group.superGroup = superGroup;
          }

          if (leader != null) {
            group.leader = leader;
          }
        }

        fillMembersField(Group group, row) async {
          members = await querySelectGroupMembers(row[0]);
          if (members.isNotEmpty) {
            group.members.addAll(members);
          }
        }

        if (request.hasCustomGroup()) {
          if (request.customGroup == CustomGroup.groupOnlySpecification) {
            for (var row in results) {
              Group group = Group()
                ..id = row[0]
                ..name = row[1];
              groups.add(group);
            }
          } else if (request.customGroup == CustomGroup.groupWithMembers) {
            for (var row in results) {
              Group group = Group();
              await fillFields(group, row);
              await fillMembersField(group, row);
              groups.add(group);
            }
          }
        } else {
          for (var row in results) {
            Group group = Group();
            await fillFields(group, row);
            groups.add(group);
          }
        }
      }
    } catch (e) {
      print('querySelectGroups - ${e.runtimeType}, ${e}');
      rethrow;
    }
    return groups;
  }

  static Future<Group> querySelectGroup(GroupGetRequest request, {Map<String, Group> cache}) async {
    if (cache != null && cache.containsKey(request.id)) {
      return cache[request.id];
    } else {
      List<Group> groups = await querySelectGroups(request);

      if (groups.isNotEmpty) {
        if (cache != null) cache[request.id] = groups.first;
        return groups.first;
      } else {
        return null;
      }
    }
  }

  static Future<StringValue> queryInsertGroup(GroupRequest request) async {

    if (!request.group.hasId()) {
      request.group.id = Uuid().v4();
    }

    request.group.version = 0;

    try {

      await (await AugeConnection.getConnection()).transaction((ctx) async {

        await ctx.query(
            "INSERT INTO general.groups(id, version, name, inactive, organization_id, group_type_index, super_group_id, leader_user_id) VALUES("
                "@id,"
                "@version,"
                "@name,"
                "@inactive,"
                "@organization_id,"
                "@group_type_index,"
                "@super_group_id,"
                "@leader_user_id)"
            , substitutionValues: {
          "id": request.group.id,
          "version": request.group.version,
          "name": request.group.name,
          "inactive": request.group.inactive,
          "organization_id": request.group.hasOrganization() ? request.group.organization.id : null,
          "group_type_index": request.group.hasGroupTypeIndex() ? request.group.groupTypeIndex : null,
          "super_group_id": request.group.hasSuperGroup() ? request.group.superGroup.id : null,
          "leader_user_id": request.group.hasLeader() ? request.group.leader.id : null});

        // Assigned Members Users
        for (User user in request.group.members) {
          await ctx.query("INSERT INTO general.group_users"
              " (group_id,"
              " user_id)"
              " VALUES"
              " (@id,"
              " @user_id)"
              , substitutionValues: {
                "id": request.group.id,
                "user_id": user.id});
        }

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id":  request.group.id,
          "object_version": request.group.version,
          "object_class_name": group_m.Group.className,
          "system_module_index": SystemModule.groups.index,
          "system_function_index": SystemFunction.create.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.group.name,
          "changed_values": history_item_m.HistoryItemHelper.changedValuesJson({}, request.group.toProto3Json())});

      });

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }

    return StringValue()..value = request.group.id;
  }

  static Future<Empty> queryUpdateGroup(GroupRequest request) async {

    Group previousGroup = await querySelectGroup(GroupGetRequest()..id = request.group.id);

    List<List<dynamic>> result;

    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        result = await ctx.query(
            "UPDATE general.groups"
                " SET version = @version,"
                " name = @name,"
                " inactive = @inactive,"
                " organization_id = @organization_id,"
                " group_type_index = @group_type_index,"
                " super_group_id = @super_group_id,"
                " leader_user_id = @leader_user_id"
                " WHERE id = @id AND version = @version - 1"
                " RETURNING true", substitutionValues: {
          "id": request.group.id,
          "version": ++request.group.version,
          "name": request.group.name,
          "inactive": request.group.inactive,
          "organization_id": request.authOrganizationId,
          "group_type_index": request.group.hasGroupTypeIndex() ?  request.group.groupTypeIndex : null,
          "super_group_id": request.group.hasSuperGroup() ? request.group.superGroup.id : null,
          "leader_user_id": request.group.hasLeader() ? request.group.leader.id : null}
        );

        // Members users
        StringBuffer membersUsersId = new StringBuffer();
        for (User user in request.group.members) {
          await ctx.query("INSERT INTO general.group_users"
              " (group_id,"
              " user_id)"
              " VALUES"
              " (@id,"
              " @user_id)"
              " ON CONFLICT (group_id, user_id) DO NOTHING"
              , substitutionValues: {
                "id": request.group.id,
                "user_id": user.id
              });


          if (membersUsersId.isNotEmpty)
            membersUsersId.write(',');
          membersUsersId.write("'");
          membersUsersId.write(user.id);
          membersUsersId.write("'");
        }

        if (membersUsersId.isNotEmpty) {
          await ctx.query("DELETE FROM general.group_users"
              " WHERE group_id = @id"
              " AND user_id NOT IN (${membersUsersId.toString()})"
              , substitutionValues: {
                "id": request.group.id
              });
        }

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        }

        // Create a history item
        await ctx.query(HistoryItemService.queryStatementCreateHistoryItem, substitutionValues: {"id": Uuid().v4(),
          "user_id": request.authUserId,
          "organization_id": request.authOrganizationId,
          "object_id":  request.group.id,
          "object_version": request.group.version,
          "object_class_name": group_m.Group.className,
          "system_module_index": SystemModule.groups.index,
          "system_function_index": SystemFunction.update.index,
          "date_time": DateTime.now().toUtc(),
          "description": request.group.name,
          "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(previousGroup.toProto3Json(), request.group.toProto3Json())});

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  static Future<Empty> queryDeleteGroup(GroupDeleteRequest request) async {

    Group previousGroup = await querySelectGroup(GroupGetRequest()..id = request.groupId);

    List<List<dynamic>> result;
    try {
      await (await AugeConnection.getConnection()).transaction((ctx) async {

        // It hasn´t version concurrent control, because just it is included or deleted.
        await ctx.query(
            "DELETE FROM general.group_users gu WHERE gu.group_id = @group_id  "
                "RETURNING true"
            , substitutionValues: {
          "group_id": request.groupId});

        result = await ctx.query(
            "DELETE FROM general.groups g WHERE g.id = @id AND g.version = @version "
                "RETURNING true"
            , substitutionValues: {
          "id": request.groupId,
          "version": request.groupVersion});

        // Optimistic concurrency control
        if (result.length == 0) {
          throw new GrpcError.failedPrecondition('Precondition Failed');
        } else {
          // Create a history item
          await ctx.query(HistoryItemService.queryStatementCreateHistoryItem,
              substitutionValues: {"id": Uuid().v4(),
                "user_id": request.authUserId,
                "organization_id": request.authOrganizationId,
                "object_id": request.groupId,
                "object_version": request.groupVersion,
                "object_class_name": group_m.Group.className,
                "system_module_index": SystemModule.groups.index,
                "system_function_index": SystemFunction.delete.index,
                "date_time": DateTime.now().toUtc(),
                "description": previousGroup.name,
                "changed_values": history_item_m.HistoryItemHelper.changedValuesJson(
                    previousGroup.toProto3Json(),
                    {})});
        }

      });
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return Empty()/*..webWorkAround = true*/;
  }

  // *** GROUP TYPES ***
  /*
  static Future<List<GroupType>> querySelectGroupTypes([GroupTypeGetRequest request]) async {

    List<GroupType> groupTypes = new List();

    groupTypes.add(new GroupType()
      ..id = '1dce85a6-f876-4f96-8342-5890457d5154'
      ..name = 'Company' // GroupMessage.groupTypeLabel('Company')
    );
    groupTypes.add(new GroupType()
      ..id = '97611ed6-895e-4aa9-afe7-88f1238e21e5'
      ..name = 'Business Unit'  // GroupMessage.groupTypeLabel('Business Unit')
    );

    groupTypes.add(new GroupType()
      ..id = 'df25232f-3f85-4c1a-b685-3b958b486dcf'
      ..name = 'Department' // GroupMessage.groupTypeLabel('Department')
    );

    groupTypes.add(new GroupType()
      ..id = '0a3614a3-887e-45eb-9464-30ccf4be6c65'
      ..name = 'Team' // GroupMessage.groupTypeLabel('Team')
    );

    return (request != null && request.id != null) ? [groupTypes.singleWhere((t) => (t.id == request.id))] : groupTypes;
  }
*/

  /*
  static Future<GroupType> querySelectGroupType(GroupTypeGetRequest request) async {

    List<GroupType> groupTypes = await querySelectGroupTypes(request);

    return (groupTypes.isNotEmpty) ? groupTypes.first : [];

  }

*/

  // *** GROUP MEMBERS ***
  static Future<List<User>> querySelectGroupMembers(String groupId) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT group_users.user_id"
        " FROM general.group_users group_users";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE group_users.group_id = @group_id";
    substitutionValues = {"group_id": groupId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<User> groupMembers = [];
    List<User> users;
    User user;

    for (var row in results) {

      users = await UserService.querySelectUsers(UserGetRequest()
        ..id = row[0]
        ..customUser = CustomUser.userOnlySpecificationProfileImage);

      if (users != null && users.length != 0) {
        user = users.first;
        groupMembers.add(user);
      }

    }

    return groupMembers;
  }
}