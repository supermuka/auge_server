// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

/// Domain model class to represent a group
class Group {

  // Base fields
  String id;
  int version;
  bool isDeleted;

  // Specific
  String name;
  bool active;
  Organization organization;
  GroupType groupType;
  Group superGroup;
  User leader;
  List<User> members = [];

  group_pb.Group writeToProtoBuf() {
    group_pb.Group groupPb = group_pb.Group();

    if (this.id != null) groupPb.id = this.id;
    if (this.version != null) groupPb.version = this.version;
    if (this.isDeleted != null) groupPb.isDeleted = this.isDeleted;
    if (this.name != null) groupPb.name = this.name;
    if (this.active != null) groupPb.active = this.active;
    if (this.organization != null) groupPb.organization = this.organization.writeToProtoBuf();
    if (this.groupType != null) groupPb.groupType = this.groupType.writeToProtoBuf();
    if (this.superGroup != null) groupPb.superGroup = this.superGroup.writeToProtoBuf();
    if (this.leader != null) groupPb.leader = this.leader.writeToProtoBuf();
    if (this.members != null && this.members.isNotEmpty) groupPb.members.addAll(this.members.map((m) => m.writeToProtoBuf()));

    return groupPb;
  }

  readFromProtoBuf(group_pb.Group groupPb) {
    if (groupPb.hasId()) this.id = groupPb.id;
    if (groupPb.hasVersion()) this.version = groupPb.version;
    if (groupPb.hasIsDeleted()) this.isDeleted = groupPb.isDeleted;
    if (groupPb.hasName()) this.name = groupPb.name;
    if (groupPb.hasActive()) this.active = groupPb.active;
    if (groupPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(groupPb.organization);
    if (groupPb.hasGroupType()) this.groupType = GroupType()..readFromProtoBuf(groupPb.groupType);
    if (groupPb.hasSuperGroup()) this.superGroup = Group()..readFromProtoBuf(groupPb.superGroup);
    if (groupPb.hasLeader()) this.leader = User()..readFromProtoBuf(groupPb.leader);
    if (groupPb.members.isNotEmpty) this.members = groupPb.members.map((u) => User()..readFromProtoBuf(u)).toList();
  }
}

/// Domain model class to represent a group type
class GroupType {

  String id;
  String name;

  group_pb.GroupType writeToProtoBuf() {
    group_pb.GroupType groupTypePb = group_pb.GroupType();

    if (this.id != null) groupTypePb.id = this.id;
    if (this.name != null) groupTypePb.name = this.name;

    return groupTypePb;
  }

  readFromProtoBuf(group_pb.GroupType groupPb) {
    if (groupPb.hasId()) this.id = groupPb.id;
    if (groupPb.hasName()) this.name = groupPb.name;
  }
}
