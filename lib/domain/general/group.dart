// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/domain/general/organization.dart';
import 'package:auge_server/domain/general/user.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

enum GroupType {company, businessUnit, department, team}

/// Domain model class to represent a group
class Group {
  static String get className => 'Group';

  // Base fields
  static String get idField => 'id';
  String id;
  static String get versionField => 'version';
  int version;

  // Specific  
  static String nameField = 'name';
  String name;

  static String inactiveField = 'inactive';
  // static final String inactiveField = 'inactive';
  bool inactive;

  static String organizationField = 'organization';
  //static final String organizationField = 'organization';
  Organization organization;

  static String groupTypeField = 'groupType';
  //static final String groupTypeField = 'groupType';
  GroupType groupType;

  static String superGroupField = 'superGroup';
  //static final String superGroupField = 'superGroup';
  Group superGroup;

  static String leaderField = 'leader';
  //static final String leaderField = 'leader';
  User leader;

  static String membersField = 'members';
  //static final String membersField = 'members';
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

  void readFromProtoBuf(group_pb.Group groupPb, Map<String, dynamic> cache) {
    if (groupPb.hasId()) this.id = groupPb.id;
    if (groupPb.hasVersion()) this.version = groupPb.version;
    if (groupPb.hasName()) this.name = groupPb.name;
    if (groupPb.hasInactive()) this.inactive = groupPb.inactive;
    if (groupPb.hasOrganization()) this.organization = cache.putIfAbsent('${Group.organizationField}${groupPb.organization.id}@${Organization.className}', () => Organization()..readFromProtoBuf(groupPb.organization));
    if (groupPb.hasGroupTypeIndex()) this.groupType = GroupType.values[groupPb.groupTypeIndex];
    if (groupPb.hasSuperGroup()) this.superGroup =  cache.putIfAbsent('${Group.superGroupField}${groupPb.superGroup.id}@${Group.className}', () => Group()..readFromProtoBuf(groupPb.superGroup, cache));
    if (groupPb.hasLeader()) this.leader = cache.putIfAbsent('${Group.leaderField}${groupPb.leader.id}@${User.className}', () => User()..readFromProtoBuf(groupPb.leader, cache));
    if (groupPb.members.isNotEmpty) this.members = groupPb.members.map((u) => cache.putIfAbsent('${Group.membersField}${u.id}@${User.className}', () => User()..readFromProtoBuf(u, cache))).toList().cast<User>();
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