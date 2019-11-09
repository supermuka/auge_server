// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/general/organization.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/user_access.pb.dart' as user_access_pb;

/// Domain model class to represent a relationship between users and organizations
class UserAccess {
  static final String className = 'UserAccess';

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific fields
  static final String userField = 'user';
  User user;
  static final String organizationField = 'organization';
  Organization organization;
  static final String accessRoleField = 'accessRole';
  int accessRole;

  UserAccess() {
    user = User();
    organization = Organization();
  }

  user_access_pb.UserAccess writeToProtoBuf() {
    user_access_pb.UserAccess userAccessPb = user_access_pb.UserAccess();

    if (this.id != null) userAccessPb.id = this.id;
    if (this.version != null) userAccessPb.version = this.version;
    if (this.user != null) userAccessPb.user = this.user.writeToProtoBuf();
    if (this.organization != null) userAccessPb.organization = this.organization.writeToProtoBuf();
    if (this.accessRole != null) userAccessPb.accessRole = this.accessRole;

    return userAccessPb;
  }

  readFromProtoBuf(user_access_pb.UserAccess userAccessPb, Map<String, dynamic> cache) {
    if (userAccessPb.hasId()) this.id = userAccessPb.id;
    if (userAccessPb.hasVersion()) this.version = userAccessPb.version;
    if (userAccessPb.hasUser()) this.user =  cache.putIfAbsent('${UserAccess.userField}${userAccessPb.user.id}@${User.className}', () => User()..readFromProtoBuf(userAccessPb.user, cache));
    if (userAccessPb.hasOrganization()) this.organization = cache.putIfAbsent('${UserAccess.userField}${userAccessPb.organization.id}@${Organization.className}', () => Organization()..readFromProtoBuf(userAccessPb.organization));
    if (userAccessPb.hasAccessRole()) this.accessRole = userAccessPb.accessRole;
  }
  static Map<String, dynamic> fromProtoBufToModelMap(user_access_pb.UserAccess userAccessPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (userAccessPb.hasId())
        map[UserAccess.idField] = userAccessPb.id;
      if (userAccessPb.hasUser()) {
        map[UserAccess.userField] =
            User.fromProtoBufToModelMap(userAccessPb.user, onlyIdAndSpecificationForDepthFields, true);
      }
      if (userAccessPb.hasOrganization())
        map[UserAccess.organizationField] =
            Organization.fromProtoBufToModelMap(
                userAccessPb.organization, onlyIdAndSpecificationForDepthFields, true);
    } else {
      if (userAccessPb.hasId())
        map[UserAccess.idField] = userAccessPb.id;
      if (userAccessPb.hasVersion())
        map[UserAccess.versionField] =
            userAccessPb.version;
      if (userAccessPb.hasAccessRole() )
        map[UserAccess.accessRoleField] =
            userAccessPb.accessRole;
      if (userAccessPb.hasUser())
        map[UserAccess.userField] =
            User.fromProtoBufToModelMap(userAccessPb.user, onlyIdAndSpecificationForDepthFields, true);
      if (userAccessPb.hasOrganization())
        map[UserAccess.organizationField] =
            Organization.fromProtoBufToModelMap(
                userAccessPb.organization, onlyIdAndSpecificationForDepthFields, true);
    }
    return map;
  }
}