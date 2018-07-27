// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/organization.dart';

/// Domain model class to represent a relationshipt between users and organizations
class UserProfileOrganization extends Object  {

  UserProfile userProfile;
  Organization organization;
  int authorizationLevel;

  void cloneTo(UserProfileOrganization to) {

    if (to == null) return;

    if (this.userProfile != null) {
      to.userProfile = this.userProfile.clone();
    }
    if (this.organization != null) {
      to.organization = this.organization.clone();
    }
    to.authorizationLevel = this.authorizationLevel;

  }

  UserProfileOrganization clone() {

    UserProfileOrganization to = UserProfileOrganization();
    cloneTo(to);
    return to;

  }
}
