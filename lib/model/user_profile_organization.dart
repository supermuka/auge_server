// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/organization.dart';


/// Domain model class to represent a relationship between users and organizations
class UserProfileOrganization extends Object  {

  String id;
  User user;
  Organization organization;
  int authorizationRole;

  void cloneTo(UserProfileOrganization to) {
    if (to == null) return;

    to.id = this.id;

    if (this.user != null) {
      to.user = this.user.clone();
    }
    if (this.organization != null) {
      to.organization = this.organization.clone();
    }
    to.authorizationRole = this.authorizationRole;
  }

  UserProfileOrganization clone() {
    UserProfileOrganization to = UserProfileOrganization();
    cloneTo(to);
    return to;
  }
}