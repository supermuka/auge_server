// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/general/organization.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pb.dart' as user_profile_organization_pb;

/// Domain model class to represent a relationship between users and organizations
class UserProfileOrganization {

  // Base fields
  String id;
  int version;

  // Specific fields
  int authorizationRole;
  User user;
  Organization organization;

  user_profile_organization_pb.UserProfileOrganization writeToProtoBuf() {
    user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb = user_profile_organization_pb.UserProfileOrganization();

    if (this.id != null) userProfileOrganizationPb.id = this.id;
    if (this.version != null) userProfileOrganizationPb.version = this.version;
    if (this.authorizationRole != null) userProfileOrganizationPb.authorizationRole = this.authorizationRole;
    if (this.user != null) userProfileOrganizationPb.user = this.user.writeToProtoBuf();
    if (this.organization != null) userProfileOrganizationPb.organization = this.organization.writeToProtoBuf();

    return userProfileOrganizationPb;
  }

  readFromProtoBuf(user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb) {
    if (userProfileOrganizationPb.hasId()) this.id = userProfileOrganizationPb.id;
    if (userProfileOrganizationPb.hasVersion()) this.version = userProfileOrganizationPb.version;
    if (userProfileOrganizationPb.hasAuthorizationRole()) this.authorizationRole = userProfileOrganizationPb.authorizationRole;
    if (userProfileOrganizationPb.hasUser()) this.user = User()..readFromProtoBuf(userProfileOrganizationPb.user);
    if (userProfileOrganizationPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(userProfileOrganizationPb.organization);
  }
}