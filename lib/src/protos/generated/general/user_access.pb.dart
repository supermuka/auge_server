///
//  Generated code. Do not modify.
//  source: general/user_access.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $0;
import 'organization.pb.dart' as $3;

class UserAccess extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAccess', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..a<$0.User>(3, 'user', $pb.PbFieldType.OM, $0.User.getDefault, $0.User.create)
    ..a<$3.Organization>(4, 'organization', $pb.PbFieldType.OM, $3.Organization.getDefault, $3.Organization.create)
    ..a<$core.int>(5, 'accessRole', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  UserAccess._() : super();
  factory UserAccess() => create();
  factory UserAccess.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccess.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAccess clone() => UserAccess()..mergeFromMessage(this);
  UserAccess copyWith(void Function(UserAccess) updates) => super.copyWith((message) => updates(message as UserAccess));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAccess create() => UserAccess._();
  UserAccess createEmptyInstance() => create();
  static $pb.PbList<UserAccess> createRepeated() => $pb.PbList<UserAccess>();
  static UserAccess getDefault() => _defaultInstance ??= create()..freeze();
  static UserAccess _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $0.User get user => $_getN(2);
  set user($0.User v) { setField(3, v); }
  $core.bool hasUser() => $_has(2);
  void clearUser() => clearField(3);

  $3.Organization get organization => $_getN(3);
  set organization($3.Organization v) { setField(4, v); }
  $core.bool hasOrganization() => $_has(3);
  void clearOrganization() => clearField(4);

  $core.int get accessRole => $_get(4, 0);
  set accessRole($core.int v) { $_setSignedInt32(4, v); }
  $core.bool hasAccessRole() => $_has(4);
  void clearAccessRole() => clearField(5);
}

class UserAccessRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAccessRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<UserAccess>(1, 'userAccess', $pb.PbFieldType.OM, UserAccess.getDefault, UserAccess.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..aOB(4, 'withUserProfile')
    ..hasRequiredFields = false
  ;

  UserAccessRequest._() : super();
  factory UserAccessRequest() => create();
  factory UserAccessRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccessRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAccessRequest clone() => UserAccessRequest()..mergeFromMessage(this);
  UserAccessRequest copyWith(void Function(UserAccessRequest) updates) => super.copyWith((message) => updates(message as UserAccessRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAccessRequest create() => UserAccessRequest._();
  UserAccessRequest createEmptyInstance() => create();
  static $pb.PbList<UserAccessRequest> createRepeated() => $pb.PbList<UserAccessRequest>();
  static UserAccessRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserAccessRequest _defaultInstance;

  UserAccess get userAccess => $_getN(0);
  set userAccess(UserAccess v) { setField(1, v); }
  $core.bool hasUserAccess() => $_has(0);
  void clearUserAccess() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);

  $core.bool get withUserProfile => $_get(3, false);
  set withUserProfile($core.bool v) { $_setBool(3, v); }
  $core.bool hasWithUserProfile() => $_has(3);
  void clearWithUserProfile() => clearField(4);
}

class UserAccessDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAccessDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'userAccessId')
    ..a<$core.int>(2, 'userAccessVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  UserAccessDeleteRequest._() : super();
  factory UserAccessDeleteRequest() => create();
  factory UserAccessDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccessDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAccessDeleteRequest clone() => UserAccessDeleteRequest()..mergeFromMessage(this);
  UserAccessDeleteRequest copyWith(void Function(UserAccessDeleteRequest) updates) => super.copyWith((message) => updates(message as UserAccessDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAccessDeleteRequest create() => UserAccessDeleteRequest._();
  UserAccessDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<UserAccessDeleteRequest> createRepeated() => $pb.PbList<UserAccessDeleteRequest>();
  static UserAccessDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserAccessDeleteRequest _defaultInstance;

  $core.String get userAccessId => $_getS(0, '');
  set userAccessId($core.String v) { $_setString(0, v); }
  $core.bool hasUserAccessId() => $_has(0);
  void clearUserAccessId() => clearField(1);

  $core.int get userAccessVersion => $_get(1, 0);
  set userAccessVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasUserAccessVersion() => $_has(1);
  void clearUserAccessVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class UserAccessGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAccessGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'userId')
    ..aOS(3, 'organizationId')
    ..aOS(4, 'identification')
    ..aOS(5, 'password')
    ..aOB(6, 'withUserProfile')
    ..hasRequiredFields = false
  ;

  UserAccessGetRequest._() : super();
  factory UserAccessGetRequest() => create();
  factory UserAccessGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccessGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAccessGetRequest clone() => UserAccessGetRequest()..mergeFromMessage(this);
  UserAccessGetRequest copyWith(void Function(UserAccessGetRequest) updates) => super.copyWith((message) => updates(message as UserAccessGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAccessGetRequest create() => UserAccessGetRequest._();
  UserAccessGetRequest createEmptyInstance() => create();
  static $pb.PbList<UserAccessGetRequest> createRepeated() => $pb.PbList<UserAccessGetRequest>();
  static UserAccessGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserAccessGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get userId => $_getS(1, '');
  set userId($core.String v) { $_setString(1, v); }
  $core.bool hasUserId() => $_has(1);
  void clearUserId() => clearField(2);

  $core.String get organizationId => $_getS(2, '');
  set organizationId($core.String v) { $_setString(2, v); }
  $core.bool hasOrganizationId() => $_has(2);
  void clearOrganizationId() => clearField(3);

  $core.String get identification => $_getS(3, '');
  set identification($core.String v) { $_setString(3, v); }
  $core.bool hasIdentification() => $_has(3);
  void clearIdentification() => clearField(4);

  $core.String get password => $_getS(4, '');
  set password($core.String v) { $_setString(4, v); }
  $core.bool hasPassword() => $_has(4);
  void clearPassword() => clearField(5);

  $core.bool get withUserProfile => $_get(5, false);
  set withUserProfile($core.bool v) { $_setBool(5, v); }
  $core.bool hasWithUserProfile() => $_has(5);
  void clearWithUserProfile() => clearField(6);
}

class UserAccessesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAccessesResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<UserAccess>(1, 'userAccesses', $pb.PbFieldType.PM,UserAccess.create)
    ..hasRequiredFields = false
  ;

  UserAccessesResponse._() : super();
  factory UserAccessesResponse() => create();
  factory UserAccessesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAccessesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAccessesResponse clone() => UserAccessesResponse()..mergeFromMessage(this);
  UserAccessesResponse copyWith(void Function(UserAccessesResponse) updates) => super.copyWith((message) => updates(message as UserAccessesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAccessesResponse create() => UserAccessesResponse._();
  UserAccessesResponse createEmptyInstance() => create();
  static $pb.PbList<UserAccessesResponse> createRepeated() => $pb.PbList<UserAccessesResponse>();
  static UserAccessesResponse getDefault() => _defaultInstance ??= create()..freeze();
  static UserAccessesResponse _defaultInstance;

  $core.List<UserAccess> get userAccesses => $_getList(0);
}

