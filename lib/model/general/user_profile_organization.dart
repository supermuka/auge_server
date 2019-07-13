// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/general/organization.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pb.dart' as user_profile_organization_pb;

/// Domain model class to represent a relationship between users and organizations

class UserProfileOrganization {
  static final String className = 'UserProfileOrganization';

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
  static final String authorizationRoleField = 'authorizationRole';
  int authorizationRole;

  UserProfileOrganization() {
    user = User();
  }

  user_profile_organization_pb.UserProfileOrganization writeToProtoBuf() {
    user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb = user_profile_organization_pb.UserProfileOrganization();

    if (this.id != null) userProfileOrganizationPb.id = this.id;
    if (this.version != null) userProfileOrganizationPb.version = this.version;
    if (this.user != null) userProfileOrganizationPb.user = this.user.writeToProtoBuf();
    if (this.organization != null) userProfileOrganizationPb.organization = this.organization.writeToProtoBuf();
    if (this.authorizationRole != null) userProfileOrganizationPb.authorizationRole = this.authorizationRole;

    return userProfileOrganizationPb;
  }

  readFromProtoBuf(user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb) {
    if (userProfileOrganizationPb.hasId()) this.id = userProfileOrganizationPb.id;
    if (userProfileOrganizationPb.hasVersion()) this.version = userProfileOrganizationPb.version;
    if (userProfileOrganizationPb.hasUser()) this.user = User()..readFromProtoBuf(userProfileOrganizationPb.user);
    if (userProfileOrganizationPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(userProfileOrganizationPb.organization);
    if (userProfileOrganizationPb.hasAuthorizationRole()) this.authorizationRole = userProfileOrganizationPb.authorizationRole;
  }
  static Map<String, dynamic> fromProtoBufToModelMap(user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (userProfileOrganizationPb.hasId())
        map[UserProfileOrganization.idField] = userProfileOrganizationPb.id;
      if (userProfileOrganizationPb.hasUser()) {
        map[UserProfileOrganization.userField] =
            User.fromProtoBufToModelMap(userProfileOrganizationPb.user, onlyIdAndSpecificationForDepthFields, true);
      }
      if (userProfileOrganizationPb.hasOrganization())
        map[UserProfileOrganization.organizationField] =
            Organization.fromProtoBufToModelMap(
                userProfileOrganizationPb.organization, onlyIdAndSpecificationForDepthFields, true);
    } else {
      if (userProfileOrganizationPb.hasId())
        map[UserProfileOrganization.idField] = userProfileOrganizationPb.id;
      if (userProfileOrganizationPb.hasVersion())
        map[UserProfileOrganization.versionField] =
            userProfileOrganizationPb.version;
      if (userProfileOrganizationPb.hasAuthorizationRole() )
        map[UserProfileOrganization.authorizationRoleField] =
            userProfileOrganizationPb.authorizationRole;
      if (userProfileOrganizationPb.hasUser())
        map[UserProfileOrganization.userField] =
            User.fromProtoBufToModelMap(userProfileOrganizationPb.user, onlyIdAndSpecificationForDepthFields, true);
      if (userProfileOrganizationPb.hasOrganization())
        map[UserProfileOrganization.organizationField] =
            Organization.fromProtoBufToModelMap(
                userProfileOrganizationPb.organization, onlyIdAndSpecificationForDepthFields, true);
    }
    return map;
  }
}