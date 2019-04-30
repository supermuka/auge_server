// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:collection/collection.dart';

import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

/// Domain model class to represent a group
class Group {

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific
  static final String nameField = 'name';
  String name;
  static final String activeField = 'active';
  bool active;
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
    if (groupPb.hasName()) this.name = groupPb.name;
    if (groupPb.hasActive()) this.active = groupPb.active;
    if (groupPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(groupPb.organization);
    if (groupPb.hasGroupType()) this.groupType = GroupType()..readFromProtoBuf(groupPb.groupType);
    if (groupPb.hasSuperGroup()) this.superGroup = Group()..readFromProtoBuf(groupPb.superGroup);
    if (groupPb.hasLeader()) this.leader = User()..readFromProtoBuf(groupPb.leader);
    if (groupPb.members.isNotEmpty) this.members = groupPb.members.map((u) => User()..readFromProtoBuf(u)).toList();
  }

  static Map<String, dynamic> fromProtoBufToModelMap(group_pb.Group groupPb, [group_pb.Group deltaComparedToGroupPb]) {
    Map<String, dynamic> map = Map();

    if (groupPb.hasId() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasId() && groupPb.id != deltaComparedToGroupPb.id)) map[Group.idField] = groupPb.id;
    if (groupPb.hasVersion() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasVersion() &&  groupPb.version != deltaComparedToGroupPb.version)) map[Group.versionField] = groupPb.version;
    if (groupPb.hasName() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasName() && groupPb.name != deltaComparedToGroupPb.name)) map[Group.nameField] = groupPb.name;
    if (groupPb.hasActive() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasActive() && groupPb.active != deltaComparedToGroupPb.active)) map[Group.activeField] = groupPb.active;
    if (groupPb.hasOrganization() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasOrganization() && groupPb.organization != deltaComparedToGroupPb.organization)) map[Group.organizationField] = Organization.fromProtoBufToModelMap(groupPb.organization);
    if (groupPb.hasGroupType() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasGroupType() && groupPb.groupType != deltaComparedToGroupPb.groupType)) map[Group.groupTypeField] = GroupType.fromProtoBufToModelMap(groupPb.groupType);
    if (groupPb.hasSuperGroup() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasSuperGroup() && groupPb.superGroup != deltaComparedToGroupPb.superGroup)) map[Group.superGroupField] = Group.fromProtoBufToModelMap(groupPb.superGroup);
    if (groupPb.hasLeader() && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.hasLeader() && groupPb.leader != deltaComparedToGroupPb.leader)) map[Group.leaderField] = User.fromProtoBufToModelMap(groupPb.leader);
    if (groupPb.members.isNotEmpty && (deltaComparedToGroupPb == null || deltaComparedToGroupPb.members.isNotEmpty && !DeepCollectionEquality.unordered().equals(groupPb.members, deltaComparedToGroupPb.members))) map[Group.membersField] = groupPb.members.map((u) => User.fromProtoBufToModelMap(u)).toList();

    return map;
  }
}

/// Domain model class to represent a group type
class GroupType {

  static const String idField = 'id';
  String id;
  static const String nameField = 'name';
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

  static Map<String, dynamic> fromProtoBufToModelMap(group_pb.GroupType groupTypePb, [group_pb.GroupType deltaComparedToGroupTypePb]) {
    Map<String, dynamic> map = Map();

    if (groupTypePb.hasId() && (deltaComparedToGroupTypePb == null || deltaComparedToGroupTypePb.hasId() && groupTypePb.id != deltaComparedToGroupTypePb.id)) map[GroupType.idField] = groupTypePb.id;
    if (groupTypePb.hasName() && (deltaComparedToGroupTypePb == null || deltaComparedToGroupTypePb.hasName() && groupTypePb.name != deltaComparedToGroupTypePb.name)) map[GroupType.nameField] = groupTypePb.name;

    return map;
  }

}
