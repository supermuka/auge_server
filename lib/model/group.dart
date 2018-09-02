// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';

/// Domain model class to represent a group
class Group {

  String id;
  String name;

  Organization organization;
  GroupType groupType;
  Group superGroup;
  User leader;
  bool active;

  void cloneTo(Group to) {
    to.id = this.id;
    to.name = this.name;
    to.active = this.active;

    if (this.organization != null) {
      to.organization = this.organization.clone();
    } else {
      to.organization = null;
    }

    if (this.groupType != null) {
      to.groupType = this.groupType.clone();
    } else {
      to.groupType = null;
    }

    if (this.superGroup != null) {
      to.superGroup = this.superGroup.clone();
    } else {
      to.superGroup = null;
    }

    if (this.leader != null) {
      to.leader = this.leader.clone();
    } else {
      to.leader = null;
    }
  }

  Group clone() {
    Group to = new Group();
    cloneTo(to);
    return to;
  }

}

/// Domain model class to represent a group type
class GroupType {

  String id;
  String name;

  void cloneTo(GroupType to) {
    to.id = this.id;
    to.name = this.name;
  }

  GroupType clone() {
    GroupType to = new GroupType();
    cloneTo(to);
    return to;
  }
}