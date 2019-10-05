// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

enum GroupType {company, businessUnit, department, team}

/// Domain model class to represent a group
class Group {
  static final String className = 'Group';

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific
  static final String nameField = 'name';
  String name;
  static final String inactiveField = 'inactive';
  bool inactive;
  static final String organizationField = 'organization';
  Organization organization;
  static final String groupTypeField = 'groupType';
  GroupType groupType;
  static final String superGroupField = 'superGroup';
  Group superGroup;
  static final String leaderField = 'leader';
  User leader;
  static final String membersField = 'members';
  List<User> members = [];

  group_pb.Group writeToProtoBuf() {
    group_pb.Group groupPb = group_pb.Group();

    if (this.id != null) groupPb.id = this.id;
    if (this.version != null) groupPb.version = this.version;
    if (this.name != null) groupPb.name = this.name;
    if (this.inactive != null) groupPb.inactive = this.inactive;
    if (this.organization != null) groupPb.organization = this.organization.writeToProtoBuf();
    if (this.groupType != null) groupPb.groupTypeIndex = this.groupType.index;
    if (this.superGroup != null) groupPb.superGroup = this.superGroup.writeToProtoBuf();
    if (this.leader != null) groupPb.leader = this.leader.writeToProtoBuf();
    if (this.members != null && this.members.isNotEmpty) groupPb.members.addAll(this.members.map((m) => m.writeToProtoBuf()));

    return groupPb;
  }

  void readFromProtoBuf(group_pb.Group groupPb) {
    if (groupPb.hasId()) this.id = groupPb.id;
    if (groupPb.hasVersion()) this.version = groupPb.version;
    if (groupPb.hasName()) this.name = groupPb.name;
    if (groupPb.hasInactive()) this.inactive = groupPb.inactive;
    if (groupPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(groupPb.organization);
    if (groupPb.hasGroupTypeIndex()) this.groupType = GroupType.values[groupPb.groupTypeIndex];
    if (groupPb.hasSuperGroup()) this.superGroup = Group()..readFromProtoBuf(groupPb.superGroup);
    if (groupPb.hasLeader()) this.leader = User()..readFromProtoBuf(groupPb.leader);
    if (groupPb.members.isNotEmpty) this.members = groupPb.members.map((u) => User()..readFromProtoBuf(u)).toList();
  }


  static Map<String, dynamic> fromProtoBufToModelMap(group_pb.Group groupPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (groupPb.hasId()) map[Group.idField] = groupPb.id;
      if (groupPb.hasName()) map[Group.nameField] = groupPb.name;
    } else {
      if (groupPb.hasId()) map[Group.idField] = groupPb.id;
      if (groupPb.hasVersion()) map[Group.versionField] = groupPb.version;
      if (groupPb.hasName()) map[Group.nameField] = groupPb.name;
      if (groupPb.hasInactive()) map[Group.inactiveField] = groupPb.inactive;
      if (groupPb.hasOrganization()) map[Group.organizationField] =
          Organization.fromProtoBufToModelMap(groupPb.organization, onlyIdAndSpecificationForDepthFields, true);
      if (groupPb.hasGroupTypeIndex()) map[Group.groupTypeField] = groupPb.groupTypeIndex;
      if (groupPb.hasSuperGroup()) map[Group.superGroupField] =
          Group.fromProtoBufToModelMap(groupPb.superGroup, onlyIdAndSpecificationForDepthFields, true);
      if (groupPb.hasLeader()) map[Group.leaderField] =
          User.fromProtoBufToModelMap(groupPb.leader, onlyIdAndSpecificationForDepthFields, true);
      if (groupPb.members.isNotEmpty) map[Group.membersField] =
          groupPb.members.map((u) => User.fromProtoBufToModelMap(u, onlyIdAndSpecificationForDepthFields, true))
              .toList();
    }
    return map;
  }
}