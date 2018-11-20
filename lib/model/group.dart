// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';

/// Domain model class to represent a group
class GroupBase {
  String id;
}
/*
class GroupPersistent<TOrganization extends OrganizationBase, TGroupType extends GroupTypeBase, TGroup extends GroupBase, TUser extends UserBase> implements GroupBase {

  String id;
  String name;

  TOrganization organization;
  TGroupType groupType;
  TGroup superGroup;
  TUser leader;
  List<TUser> members;
  bool active;

  GroupPersistent() {
    members = List<TUser>();
  }
}
*/


class Group implements GroupBase {

  String id;
  String name;

  Organization organization;
  GroupType groupType;
  Group superGroup;
  User leader;
  List<User> members;
  bool active;

  Group() {
    members = List<User>();
  }

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

    if (this.members != null && this.members.length != 0) {
      to.members.clear();
      this.members.forEach((o) =>
          to.members.add(o.clone()));
    }
  }

  Group clone() {
    Group to = new Group();
    cloneTo(to);
    return to;
  }
}
/*
class GroupMessage {
  String id;
  String name;

  OrganizationBase organization;
  GroupTypeBase groupType;
  GroupBase superGroup;
  UserBase leader;
  List<UserBase> members;
  bool active;
}
*/

/// Domain model class to represent a group type
class GroupTypeBase {
  String id;
}

class GroupType implements GroupTypeBase {

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

class GroupFacilities {
/*
  static GroupMessage messageFrom(Group group) {
    return GroupMessage()
      ..id = group.id
      ..name = group.name
      ..leader = group.leader
      ..organization = group.organization
     // ..superGroup = group.superGroup
      ..active = group.active
      ..groupType = group.groupType
      ..members = group.members;

  }
  */
}