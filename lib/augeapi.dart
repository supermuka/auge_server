// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:async';

import 'package:rpc/rpc.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';
import 'package:auge_server/augeconnection.dart';

import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/user_profile_organization.dart';
import 'package:auge_server/model/group.dart';

import 'package:auge_server/message_type/id_message.dart';

import 'package:auge_server/shared/rpc_error_message.dart';

/// Api for Shared Domain
@ApiClass(version: 'v1')
class AugeApi {

  AugeApi() {
    AugeConnection.createConnection();
  }

  /// Close a database connection
  @ApiMethod( method: 'PUT', path: 'close')
  Future<VoidMessage> closeConnection(VoidMessage _) async {
    try {
      if (!await AugeConnection
          .getConnection()
          .isClosed) {
        await AugeConnection.getConnection().close();
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  // *** ORGANIZATIONS ***
  static Future<List<Organization>> queryOrganizations({String id}) async {
    var results;

    String queryStatement;

    queryStatement = "SELECT organization.id::VARCHAR, organization.name, organization.code FROM auge.organizations organization";
    if (id != null) {
      queryStatement += " WHERE organization.id = '${id}'";
    }

    results =  await AugeConnection.getConnection().query(queryStatement);

    List<Organization> organizations = new List();
    for (var row in results) {
      Organization organization = new Organization()
        ..id = row[0]
        ..name = row[1]
        ..code = row[2];
      organizations.add(organization);
    }
    return organizations;
  }

  /// Return all organizations
  @ApiMethod( method: 'GET', path: 'organizations')
  Future<List<Organization>> getOrganizations() async {
    try {

      List<Organization> organizations = await queryOrganizations();
      return organizations;

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Create (insert) a new organization
  @ApiMethod( method: 'POST', path: 'organizations')
  Future<IdMessage> createOrganization(Organization organization) async {

    if (organization.id == null) {
      organization.id = new Uuid().v4();
    }

    try {
      await AugeConnection.getConnection().query(
          "INSERT INTO auge.organizations(id, name, code) VALUES"
              "(@id,"
              "@name,"
              "@code)"
          , substitutionValues: {
        "id": organization.id,
        "name": organization.name,
        "code": organization.code});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
    return new IdMessage()..id = organization.id;
  }

  /// Update an organization passing an instance of [Organization]
  @ApiMethod( method: 'PUT', path: 'organizations')
  Future<VoidMessage> updateOrganization(Organization organization) async {
    try {
      await AugeConnection.getConnection().query(
          "UPDATE auge.organizations organization SET organization.name = @name,"
              "organization.code = @code"
              "WHERE id = @id "
          , substitutionValues: {
        "id": organization.id,
        "name": organization.name,
        "code": organization.code});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Delete an organization by [id]
  @ApiMethod( method: 'DELETE', path: 'organizations/{id}')
  Future<VoidMessage> deleteOrganization(String id) async {
    try {
      await AugeConnection.getConnection().query(
          "DELETE FROM auge.organizations organization WHERE organization.id = ${PostgreSQLFormat
              .id("id")}"
          , substitutionValues: {
        "id": id});
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  // *** USERS ***
  static Future<List<User>> queryUsers({String id, String eMail, String password, String organizationId, bool withProfile = false}) async {
    List<List> results;

    String queryStatement = '';
    if (withProfile == false) {
      queryStatement = "SELECT u.id::VARCHAR, u.name, u.email, u.password "
          "FROM auge.users u ";
    }
    else {
      queryStatement = "SELECT u.id::VARCHAR, u.name, u.email, u.password, "
          " user_profile.image, "
          " user_profile.is_super_admin, "
          " user_profile.idiom_locale "
          " FROM auge.users u "
          " LEFT OUTER JOIN auge.users_profile user_profile on user_profile.user_id = u.id";
    }

    Map<String, dynamic> _substitutionValues = Map();
    String whereAnd = "WHERE";
    if (id != null) {
       queryStatement = queryStatement + " ${whereAnd} u.id = @id";
       _substitutionValues.putIfAbsent("id", () => id);
       whereAnd = "AND";
    }
    if (eMail != null) {
      queryStatement = queryStatement +
          " ${whereAnd} u.email = @email";

      _substitutionValues.putIfAbsent("email", () => eMail);
      whereAnd = "AND";
    }
    if (password != null) {
      queryStatement = queryStatement +
          " ${whereAnd} u.password = @password";
      _substitutionValues.putIfAbsent("password", () => password);
      whereAnd = "AND";
    }
    if (organizationId != null) {
      queryStatement = queryStatement + " LEFT OUTER JOIN auge.users_profile_organizations user_profile_organization ON user_profile_organization.user_id = u.id";
          queryStatement = queryStatement + " ${whereAnd} user_profile_organization.organization_id = @organization_id";
      _substitutionValues.putIfAbsent("organization_id", () => organizationId);
      whereAnd = "AND";
    }

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: _substitutionValues);

    List<User> users = new List();
    for (var row in results) {
      User user = new User()
        ..id = row[0]
        ..name = row[1]
        ..eMail = row[2]
        ..password = row[3];

      if (withProfile != null && withProfile) {
        user.userProfile = new UserProfile()
          ..image = row[4]
          ..isSuperAdmin = row[5]
          ..idiomLocale = row[6];
      }
      users.add(user);
    }
    return users;
  }

  /// Return [User] list.
  /// Return [User] list by [id] key of the organization
  /// Whether `withProfile` arg is `true`, it is returned profile information like (avatar image, etc.)
  @ApiMethod( method: 'GET', path: 'organization/{organizationId}/users')
  Future<List<User>> getUsers(String organizationId, {bool withProfile = false}) async {
    try {
      List<User> users = await queryUsers(organizationId: organizationId, withProfile: withProfile);
      return users;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Return a [User] authenticated by eMail and password key. Whether `withProfile` arg is `true`, it is returned profile information like (avatar image, etc.)
  @ApiMethod(method: 'GET', path: 'users/{eMail}/{password}')
  Future<User> getAuthenticatedUserWithEmail(String eMail, String password, {bool withProfile = false}) async {
    try {
      List<User> users;
      users = await queryUsers(
          eMail: eMail, password: password, withProfile: withProfile);
      if (users != null && users.length != 0) {
        return users.first;
      } else {
        throw new RpcError(httpCodeNotFound, RpcErrorMessage.dataNotFoundName, RpcErrorMessage.dataNotFoundMessage)
          ..errors.add(new RpcErrorDetail(reason: RpcErrorDetailMessage.userDataNotFoundReason));
      }
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;;
    }
  }

  /// Create (insert) a new user
  @ApiMethod( method: 'POST', path: 'users')
  Future<IdMessage> createUser(User user) async {
    if (user.id == null) {
      user.id = new Uuid().v4();
    }
    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "INSERT INTO auge.users(id, name, email, password) VALUES("
            "@id,"
            "@name,"
            "@email,"
            "@password)"
            , substitutionValues: {
            "id": user.id,
            "name": user.name,
            "email": user.eMail,
            "password": user.password});
        if (user.userProfile != null)
          await ctx.query(
              "INSERT INTO auge.users_profile(user_id, image, is_super_admin, idiom_locale) VALUES("
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
    return new IdMessage()..id = user.id;
  }

  /// Update a [User]
  @ApiMethod( method: 'PUT', path: 'users')
  Future<VoidMessage> updateUser(User user) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "UPDATE auge.users "
                "SET name = @name,"
                "email = @email,"
                "password = @password "
                "WHERE id = '${user.id}'", substitutionValues: {
          "name": user.name,
          "email": user.eMail,
          "password": user.password});

        await ctx.query(
            "UPDATE auge.users_profile "
                "SET image = @image, "
                "is_super_admin = @is_super_admin, "
                "idiom_locale = @idiom_locale "
                "WHERE user_id = '${user.id}'"
            , substitutionValues: {
          "image": user.userProfile.image,
          "is_super_admin": user.userProfile.isSuperAdmin,
          "idiom_locale": user.userProfile.idiomLocale});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  /// Delete a user by [id]
  @ApiMethod( method: 'DELETE', path: 'users/{id}')
  Future<VoidMessage> deleteUser(String id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge.users_profile user_profile WHERE user_profile.user_id = ${PostgreSQLFormat
                .id(
                "user_id")}"
            , substitutionValues: {
          "user_id": id});

        await ctx.query(
            "DELETE FROM auge.users u WHERE u.id = ${PostgreSQLFormat.id(
                "id")}"
            , substitutionValues: {
          "id": id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  // *** USERS AND ORGANIZATIONS  ***
  static Future<List<UserProfileOrganization>> queryUsersProfileOrganizations({String id, String userId, String organizationId}) async {

    List<List> results;

    String queryStatement = '';
    queryStatement = "SELECT "
        "uo.id::VARCHAR, " // 0
        "uo.user_id::VARCHAR, " // 1
        "uo.organization_id::VARCHAR, " //2
        "uo.authorization_level " // 3
        "FROM auge.users_profile_organizations uo ";

    Map<String, dynamic> _substitutionValues = Map<String, dynamic>();
    String whereAnd = 'WHERE';

    if (id != null) {
      queryStatement = queryStatement + " ${whereAnd} uo.id = @id";
      _substitutionValues.putIfAbsent("id", () => id);
      whereAnd = 'AND';
    }

    if (userId != null) {
      queryStatement = queryStatement + " ${whereAnd} uo.user_id = @user_id";
      _substitutionValues.putIfAbsent("user_id", () => userId);
      whereAnd = 'AND';
    }

    if (organizationId != null) {
      queryStatement = queryStatement + " ${whereAnd} uo.organization_id = @organization_id";
      _substitutionValues.putIfAbsent("organization_id", () => organizationId);
     //The last, not need... whereAnd = 'AND';
    }

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: _substitutionValues);

    List<UserProfileOrganization> usersOrganizations = new List();

    List<Organization> organizations;
    List<User> users;
    User user;
    Organization organization;

    if (results.isNotEmpty) {
      for (var row in results) {

        if (user?.id != row[1]) {
          users = await queryUsers(id: row[1], withProfile: true);
          if (users != null && users != 0) {
            user = users.first;
          }
        }

        if (organization?.id != row[2]) {
          organizations = await queryOrganizations(id: row[2]);
          if (organizations != null && organizations.length != 0) {
            organization = organizations.first;
          }
        }

        UserProfileOrganization userProfileOrganization = new UserProfileOrganization();

        userProfileOrganization.id = row[0];
        userProfileOrganization.user = user;
        userProfileOrganization.organization = organization;
        userProfileOrganization.authorizationLevel = row[3];

        usersOrganizations.add(userProfileOrganization);
      }
    }
    return usersOrganizations;
  }

  /// Return an [Organizations] authorizated by User Id
  @ApiMethod( method: 'GET', path: 'users_profile_organizations/users/{user_id}')
  Future<List<UserProfileOrganization>> getAuthorizatedOrganizationsByUserId(String user_id) async {

    try {
      List<UserProfileOrganization> usersOrganizations;
      usersOrganizations =
      await queryUsersProfileOrganizations(userId: user_id);
      return usersOrganizations;

    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Return an [Organizations] authorizated by User Id
  @ApiMethod( method: 'GET', path: 'users_profile_organizations')
  Future<List<UserProfileOrganization>> getUsersProfileOrganizations({String userId, String organizationId}) async {

    try {
      return await queryUsersProfileOrganizations(userId: userId, organizationId: organizationId);
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Create (insert) a new user profile and organization
  @ApiMethod( method: 'POST', path: 'users_profile_organizations')
  Future<IdMessage> createUserProfileOrganization(UserProfileOrganization userProfileOrganization) async {

    if (userProfileOrganization.id == null) {
      userProfileOrganization.id = Uuid().v4();
    }

    await AugeConnection.getConnection().transaction((ctx) async {
      try {

        await ctx.query(
            "INSERT INTO auge.users_profile_organizations(id, user_id, organization_id, authorization_level) VALUES("
                "@id,"
                "@user_id,"
                "@organization_id,"
                "@authorization_level)"
            , substitutionValues: {
          "id": userProfileOrganization.id,
          "user_id": userProfileOrganization.user.id,
          "organization_id": userProfileOrganization.organization.id,
          "authorization_level": userProfileOrganization.authorizationLevel});


      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });

    return new IdMessage()..id = userProfileOrganization.id;
  }

  /// Update a [User]
  @ApiMethod( method: 'PUT', path: 'users_profile_organizations')
  Future<VoidMessage> updateUserProfileOrganization(UserProfileOrganization userProfileOrganization) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "UPDATE auge.users_profile_organizations "
                "SET authorization_level = @authorization_level, "
                "user_id = @user_id, "
                "organization_id = @organization_id "
                "WHERE id = @id", substitutionValues: {
          "id": userProfileOrganization.id,
          "user_id": userProfileOrganization.user.id,
          "organization_id": userProfileOrganization.organization.id,
          "authorization_level": userProfileOrganization.authorizationLevel});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  /// Delete by [UserProfileOrganization.id]
  @ApiMethod( method: 'DELETE', path: 'users_profile_organizations/{id}')
  Future<VoidMessage> deleteUserProfileOrganization(String id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge.users_profile_organizations user_profile_organization "
            "WHERE user_profile_organization.id = @id "
            , substitutionValues: {
            "id": id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  /// Delete all UserProfileOrganization by [User.id]
  @ApiMethod( method: 'DELETE', path: 'users_profile_organizations/users/{user_id}')
  Future<VoidMessage> deleteUserProfileOrganizationByUserId(String user_id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge.users_profile_organizations user_profile_organization "
                "WHERE user_profile_organization.user_id = @user_id "
            , substitutionValues: {
          "user_id": user_id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

   // *** GROUP  ***
  static Future<List<Group>> queryGroups({String id, String organizationId, int alignedToRecursive = 1}) async {
    List<List> results;

    String queryStatement = '';

    queryStatement = "SELECT"
    " g.id::VARCHAR,"     //0
    " g.name,"            //1
    " g.active,"          //2
    " g.organization_id," //3
    " g.group_type_id,"   //4
    " g.leader_user_id,"  //5
    " g.super_group_id "  //6
    " FROM auge.groups g ";

    Map<String, dynamic> _substitutionValues;

    if (id != null) {
      queryStatement = queryStatement + " WHERE g.id = @id";
      _substitutionValues = {
        "id": id
      };

    } else {
      queryStatement = queryStatement + " WHERE g.organization_id = @organization_id";
      _substitutionValues = {
        "organization_id": organizationId
      };
    }

    results =  await AugeConnection.getConnection().query(queryStatement, substitutionValues: _substitutionValues);

    List<Group> groups = new List();
    User leader;
    Group superGroup;
    List<Group> superGroups;
    GroupType groupType;
    List<Organization> organizations;
    List<User> users;
    List<GroupType> groupTypes;

    if (results.length > 0) {
      Organization organization;

      for (var row in results) {
        if (organization == null || organization.id != row[3]) {

          organizations = await queryOrganizations(id: row[3]);

          if (organizations.isNotEmpty) {
            organization = organizations.first;
          }
        }

        if (row[5] != null) {
          users = await queryUsers(id: row[5]);
          if (users != null && users.length != 0) {
            leader = users.first;
          }
        }

        if (row[6] != null && alignedToRecursive > 0) {
          superGroups = await queryGroups(id: row[6],
              alignedToRecursive: --alignedToRecursive);
          superGroup = superGroups.first;
        }

        groupTypes = await queryGroupTypes(id: row[4]);
        if (groupTypes != null && groupTypes.length != 0) {
          groupType = groupTypes.first;
        }

        Group group = new Group()
          ..id = row[0]
          ..name = row[1]
          ..active = row[2]
          ..organization = organization
          ..groupType = groupType
          ..superGroup = superGroup
          ..leader = leader;

        groups.add(group);
      }
    }
    return groups;
  }

  /// Return [Group] list.
  @ApiMethod( method: 'GET', path: 'organization/{organizationId}/groups')
  Future<List<Group>> getGroups(String organizationId) async {
    try {
      List<Group> groups = await queryGroups(organizationId: organizationId);
      return groups;

     } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  /// Create (insert) a new group
  @ApiMethod( method: 'POST', path: 'groups')
  Future<IdMessage> createGroup(Group group) async {

    if (group.id == null) {
      group.id = new Uuid().v4();
    }

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "INSERT INTO auge.groups(id, name, active, organization_id, group_type_id, super_group_id, leader_user_id) VALUES("
                "@id,"
                "@name,"
                "@active,"
                "@organization_id,"
                "@group_type_id,"
                "@super_group_id,"
                "@leader_user_id)"
            , substitutionValues: {
          "id": group.id,
          "name": group.name,
          "active": group.active,
          "organization_id": group.organization.id,
          "group_type_id": group.groupType?.id,
          "super_group_id": group.superGroup?.id,
          "leader_user_id": group.leader?.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });

    return new IdMessage()..id = group.id;
  }

  /// Update a [Group]
  @ApiMethod( method: 'PUT', path: 'groups')
  Future<VoidMessage> updateGroup(Group group) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "UPDATE auge.groups"
                " SET name = @name,"
                " active = @active,"
                " organization_id = @organization_id,"
                " group_type_id = @group_type_id,"
                " super_group_id = @super_group_id,"
                " leader_user_id = @leader_user_id"
                " WHERE id = @id", substitutionValues: {
          "id": group.id,
          "name": group.name,
          "active": group.active,
          "organization_id": group.organization.id,
          "group_type_id": group.groupType?.id,
          "super_group_id": group.superGroup?.id,
          "leader_user_id": group.leader?.id});
      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  /// Delete a group by [id]
  @ApiMethod( method: 'DELETE', path: 'groups/{id}')
  Future<VoidMessage> deleteGroup(String id) async {

    await AugeConnection.getConnection().transaction((ctx) async {
      try {
        await ctx.query(
            "DELETE FROM auge.groups g WHERE g.id = @id "
            , substitutionValues: {
          "id": id});

      } catch (e) {
        print('${e.runtimeType}, ${e}');
        rethrow;
      }
    });
  }

  // *** GROUP TYPES ***
  static Future<List<GroupType>> queryGroupTypes({String id}) async {

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

    return (id != null) ? [groupTypes.singleWhere((t) => (t.id == id))] : groupTypes;
  }

  /// Return [GroupType] list.
  @ApiMethod( method: 'GET', path: 'group_types')
  Future<List<GroupType>> getGroupTypes() async {
    try {
      return await queryGroupTypes();
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
}