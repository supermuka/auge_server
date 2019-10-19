///
//  Generated code. Do not modify.
//  source: general/group.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'organization.pb.dart' as $0;
import 'user.pb.dart' as $3;

class Group extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Group', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOB(4, 'inactive')
    ..a<$core.int>(5, 'groupTypeIndex', $pb.PbFieldType.O3)
    ..a<$0.Organization>(6, 'organization', $pb.PbFieldType.OM, $0.Organization.getDefault, $0.Organization.create)
    ..a<Group>(7, 'superGroup', $pb.PbFieldType.OM, Group.getDefault, Group.create)
    ..a<$3.User>(8, 'leader', $pb.PbFieldType.OM, $3.User.getDefault, $3.User.create)
    ..pc<$3.User>(9, 'members', $pb.PbFieldType.PM,$3.User.create)
    ..hasRequiredFields = false
  ;

  Group._() : super();
  factory Group() => create();
  factory Group.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Group.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Group clone() => Group()..mergeFromMessage(this);
  Group copyWith(void Function(Group) updates) => super.copyWith((message) => updates(message as Group));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Group create() => Group._();
  Group createEmptyInstance() => create();
  static $pb.PbList<Group> createRepeated() => $pb.PbList<Group>();
  static Group getDefault() => _defaultInstance ??= create()..freeze();
  static Group _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $core.String get name => $_getS(2, '');
  set name($core.String v) { $_setString(2, v); }
  $core.bool hasName() => $_has(2);
  void clearName() => clearField(3);

  $core.bool get inactive => $_get(3, false);
  set inactive($core.bool v) { $_setBool(3, v); }
  $core.bool hasInactive() => $_has(3);
  void clearInactive() => clearField(4);

  $core.int get groupTypeIndex => $_get(4, 0);
  set groupTypeIndex($core.int v) { $_setSignedInt32(4, v); }
  $core.bool hasGroupTypeIndex() => $_has(4);
  void clearGroupTypeIndex() => clearField(5);

  $0.Organization get organization => $_getN(5);
  set organization($0.Organization v) { setField(6, v); }
  $core.bool hasOrganization() => $_has(5);
  void clearOrganization() => clearField(6);

  Group get superGroup => $_getN(6);
  set superGroup(Group v) { setField(7, v); }
  $core.bool hasSuperGroup() => $_has(6);
  void clearSuperGroup() => clearField(7);

  $3.User get leader => $_getN(7);
  set leader($3.User v) { setField(8, v); }
  $core.bool hasLeader() => $_has(7);
  void clearLeader() => clearField(8);

  $core.List<$3.User> get members => $_getList(8);
}

class GroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GroupRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<Group>(1, 'group', $pb.PbFieldType.OM, Group.getDefault, Group.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  GroupRequest._() : super();
  factory GroupRequest() => create();
  factory GroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GroupRequest clone() => GroupRequest()..mergeFromMessage(this);
  GroupRequest copyWith(void Function(GroupRequest) updates) => super.copyWith((message) => updates(message as GroupRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupRequest create() => GroupRequest._();
  GroupRequest createEmptyInstance() => create();
  static $pb.PbList<GroupRequest> createRepeated() => $pb.PbList<GroupRequest>();
  static GroupRequest getDefault() => _defaultInstance ??= create()..freeze();
  static GroupRequest _defaultInstance;

  Group get group => $_getN(0);
  set group(Group v) { setField(1, v); }
  $core.bool hasGroup() => $_has(0);
  void clearGroup() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);
}

class GroupDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GroupDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'groupId')
    ..a<$core.int>(2, 'groupVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  GroupDeleteRequest._() : super();
  factory GroupDeleteRequest() => create();
  factory GroupDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GroupDeleteRequest clone() => GroupDeleteRequest()..mergeFromMessage(this);
  GroupDeleteRequest copyWith(void Function(GroupDeleteRequest) updates) => super.copyWith((message) => updates(message as GroupDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupDeleteRequest create() => GroupDeleteRequest._();
  GroupDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<GroupDeleteRequest> createRepeated() => $pb.PbList<GroupDeleteRequest>();
  static GroupDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static GroupDeleteRequest _defaultInstance;

  $core.String get groupId => $_getS(0, '');
  set groupId($core.String v) { $_setString(0, v); }
  $core.bool hasGroupId() => $_has(0);
  void clearGroupId() => clearField(1);

  $core.int get groupVersion => $_get(1, 0);
  set groupVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasGroupVersion() => $_has(1);
  void clearGroupVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class GroupGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GroupGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..a<$core.int>(3, 'alignedToRecursive', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GroupGetRequest._() : super();
  factory GroupGetRequest() => create();
  factory GroupGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GroupGetRequest clone() => GroupGetRequest()..mergeFromMessage(this);
  GroupGetRequest copyWith(void Function(GroupGetRequest) updates) => super.copyWith((message) => updates(message as GroupGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupGetRequest create() => GroupGetRequest._();
  GroupGetRequest createEmptyInstance() => create();
  static $pb.PbList<GroupGetRequest> createRepeated() => $pb.PbList<GroupGetRequest>();
  static GroupGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static GroupGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get organizationId => $_getS(1, '');
  set organizationId($core.String v) { $_setString(1, v); }
  $core.bool hasOrganizationId() => $_has(1);
  void clearOrganizationId() => clearField(2);

  $core.int get alignedToRecursive => $_get(2, 0);
  set alignedToRecursive($core.int v) { $_setSignedInt32(2, v); }
  $core.bool hasAlignedToRecursive() => $_has(2);
  void clearAlignedToRecursive() => clearField(3);
}

class GroupTypeGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GroupTypeGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  GroupTypeGetRequest._() : super();
  factory GroupTypeGetRequest() => create();
  factory GroupTypeGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupTypeGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GroupTypeGetRequest clone() => GroupTypeGetRequest()..mergeFromMessage(this);
  GroupTypeGetRequest copyWith(void Function(GroupTypeGetRequest) updates) => super.copyWith((message) => updates(message as GroupTypeGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupTypeGetRequest create() => GroupTypeGetRequest._();
  GroupTypeGetRequest createEmptyInstance() => create();
  static $pb.PbList<GroupTypeGetRequest> createRepeated() => $pb.PbList<GroupTypeGetRequest>();
  static GroupTypeGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static GroupTypeGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);
}

class GroupsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GroupsResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<Group>(1, 'groups', $pb.PbFieldType.PM,Group.create)
    ..hasRequiredFields = false
  ;

  GroupsResponse._() : super();
  factory GroupsResponse() => create();
  factory GroupsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GroupsResponse clone() => GroupsResponse()..mergeFromMessage(this);
  GroupsResponse copyWith(void Function(GroupsResponse) updates) => super.copyWith((message) => updates(message as GroupsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupsResponse create() => GroupsResponse._();
  GroupsResponse createEmptyInstance() => create();
  static $pb.PbList<GroupsResponse> createRepeated() => $pb.PbList<GroupsResponse>();
  static GroupsResponse getDefault() => _defaultInstance ??= create()..freeze();
  static GroupsResponse _defaultInstance;

  $core.List<Group> get groups => $_getList(0);
}

