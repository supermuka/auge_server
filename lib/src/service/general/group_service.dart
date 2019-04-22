// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/group.pbgrpc.dart';

import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';

import 'package:uuid/uuid.dart';

class GroupService extends GroupServiceBase {

  // API
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

  @override
  Future<GroupsResponse> getGroups(ServiceCall call,
      GroupGetRequest request) async {
    try {
      return GroupsResponse()..webWorkAround = true..groups.addAll(await querySelectGroups(request));
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  @override
  Future<Group> getGroup(ServiceCall call,
      GroupGetRequest request) async {
    Group group = await querySelectGroup(request);
    if (group == null) throw new GrpcError.notFound("Group not found.");
    return group;
  }

  @override
  Future<IdResponse> createGroup(ServiceCall call,
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
      GroupRequest request) async {
    return queryDeleteGroup(request);
  }

  // Query
  static Future<List<Group>> querySelectGroups( GroupGetRequest request /* {String id, String organizationId, int alignedToRecursive = 1} */ ) async {
    List<List> results;
    Map<String, Organization> organizationCache = {};
    Map<String, User> userCache = {};
    Map<String, Group> groupCache = {};

    String queryStatement = '';

    queryStatement = "SELECT"
        " g.id,"              //0
        " g.version, "        //1
        " g.name,"            //2
        " g.active,"          //3
        " g.organization_id," //4
        " g.group_type_id,"   //5
        " g.leader_user_id,"  //6
        " g.super_group_id "  //7
        " FROM general.groups g ";

    Map<String, dynamic> substitutionValues;

    if (request.id != null && request.id.isNotEmpty) {
      queryStatement = queryStatement + " WHERE g.id = @id";
      substitutionValues = {
        "id": request.id,
      };

    } else if (request.organizationId != null) {
      queryStatement = queryStatement + " WHERE g.organization_id = @organization_id";
      substitutionValues = {
        "organization_id": request.organizationId,
      };
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);
    List<Group> groups = [];
    User leader;
    Group superGroup;
    GroupType groupType;
    List<User> members;

    if (results.length > 0) {
      Organization organization;

      for (var row in results) {

        if (row[4] != null) {
            organization =
            await OrganizationService.querySelectOrganization(OrganizationGetRequest()..id = row[4], cache: organizationCache);
        }

        if (row[6] != null) {
            leader =
            await UserService.querySelectUser(UserGetRequest()..id = row[6], cache: userCache);
        }

        if (row[7] != null && request.alignedToRecursive > 0) {
            superGroup =
            await querySelectGroup(GroupGetRequest()..id = row[7]..alignedToRecursive = --request.alignedToRecursive, cache: groupCache);
        }

        // No need of the cache. It´s doesn't persist on data base.
        groupType = await GroupService.querySelectGroupType(GroupTypeGetRequest()..id = row[5]);
        //sleep(Duration(seconds: 1));

        members = await querySelectGroupMembers(row[0]);

        Group group = Group()
          ..id = row[0]
          ..version = row[1]
          ..name = row[2]
          ..active = row[3]
          ..organization = organization
          ..groupType = groupType;

        if (superGroup != null) {
          group.superGroup = superGroup;
        }

        if (leader != null) {
          group.leader = leader;
        }

        if (members.isNotEmpty) {
          group.members.addAll(members);
        }

        groups.add(group);

      }
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

  static Future<IdResponse> queryInsertGroup(GroupRequest request) async {

    if (!request.group.hasId()) {
      request.group.id = Uuid().v4();
    }

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        await ctx.query(
            //"INSERT INTO auge.groups(id, version, is_deleted, name, active, organization_id, group_type_id) VALUES("
            "INSERT INTO general.groups(id, version, name, active, organization_id, group_type_id, super_group_id, leader_user_id) VALUES("
                "@id,"
                "@version,"
                "@name,"
                "@active,"
                "@organization_id,"
                "@group_type_id,"
                "@super_group_id,"
                "@leader_user_id)"
            , substitutionValues: {
          "id": request.group.id,
          "version": 0,
          "name": request.group.name,
          "active": request.group.active,
          "organization_id": request.group.hasOrganization() ? request.group.organization.id : null,
          "group_type_id": request.group.hasGroupType() ? request.group.groupType.id : null,
          "super_group_id": request.group.hasSuperGroup() ? request.group.superGroup.id : null,
          "leader_user_id": request.group.hasLeader() ? request.group.leader.id : null});

        // Assigned Members Users
        for (User user in request.group.members) {
          await ctx.query("INSERT INTO general.groups_users"
              " (group_id,"
              " user_id)"
              " VALUES"
              " (@id,"
              " @user_id)"
              , substitutionValues: {
                "id": request.group.id,
                "user_id": user.id});
        }
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });

    return IdResponse()..id = request.group.id;
  }

  static Future<Empty> queryUpdateGroup(GroupRequest request) async {
    List<List<dynamic>> result;

    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {
        result = await ctx.query(
            "UPDATE general.groups"
                " SET version = @version + 1,"
                " name = @name,"
                " active = @active,"
                " organization_id = @organization_id,"
                " group_type_id = @group_type_id,"
                " super_group_id = @super_group_id,"
                " leader_user_id = @leader_user_id"
                " WHERE id = @id AND version = @version"
                " RETURNING true", substitutionValues: {
          "id": request.group.id,
          "version": request.group.version,
          "name": request.group.name,
          "active": request.group.active,
          "organization_id": request.group.hasOrganization() ? request.group.organization.id : null,
          "group_type_id": request.group.hasGroupType() ?  request.group.groupType.id : null,
          "super_group_id": request.group.hasSuperGroup() ? request.group.superGroup.id : null,
          "leader_user_id": request.group.hasLeader() ? request.group.leader.id : null}
        );

        // Members users
        StringBuffer membersUsersId = new StringBuffer();
        for (User user in request.group.members) {
          await ctx.query("INSERT INTO general.groups_users"
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
          await ctx.query("DELETE FROM general.groups_users"
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

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
    return Empty()..webWorkAround = true;
  }

  static Future<Empty> queryDeleteGroup(GroupRequest request) async {
    List<List<dynamic>> result;
    await (await AugeConnection.getConnection()).transaction((ctx) async {
      try {

        await ctx.query(
            "DELETE FROM general.groups_users gu WHERE gu.group_id = @group_id "
                "RETURNING true"
            , substitutionValues: {
          "group_id": request.group.id});

        result = await ctx.query(
            "DELETE FROM general.groups g WHERE g.id = @id AND g.version = @version "
            "RETURNING true"
            , substitutionValues: {
          "id": request.group.id,
           "version": request.group.version});

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

  // *** GROUP TYPES ***
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

  static Future<GroupType> querySelectGroupType(GroupTypeGetRequest request) async {

    List<GroupType> groupTypes = await querySelectGroupTypes(request);

    return (groupTypes.isNotEmpty) ? groupTypes.first : [];

  }

  // *** GROUP MEMBERS ***
  static Future<List<User>> querySelectGroupMembers(String groupId) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT group_users.user_id"
        " FROM general.groups_users group_users";

    Map<String, dynamic> substitutionValues;

    queryStatement += " WHERE group_users.group_id = @group_id";
    substitutionValues = {"group_id": groupId};

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);

    List<User> groupMembers = [];
    List<User> users;
    User user;

    for (var row in results) {

      users = await UserService.querySelectUsers(UserGetRequest()..id = row[0]..withProfile = true);

      if (users != null && users.length != 0) {
        user = users.first;
        groupMembers.add(user);
      }

    }

    return groupMembers;
  }
}