///
//  Generated code. Do not modify.
//  source: general/user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'organization.pb.dart' as $0;

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('User', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOB(4, 'inactive')
    ..a<$0.Organization>(5, 'managedByOrganization', $pb.PbFieldType.OM, $0.Organization.getDefault, $0.Organization.create)
    ..a<UserProfile>(6, 'userProfile', $pb.PbFieldType.OM, UserProfile.getDefault, UserProfile.create)
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User() => create();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  User clone() => User()..mergeFromMessage(this);
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  static User getDefault() => _defaultInstance ??= create()..freeze();
  static User _defaultInstance;

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

  $0.Organization get managedByOrganization => $_getN(4);
  set managedByOrganization($0.Organization v) { setField(5, v); }
  $core.bool hasManagedByOrganization() => $_has(4);
  void clearManagedByOrganization() => clearField(5);

  UserProfile get userProfile => $_getN(5);
  set userProfile(UserProfile v) { setField(6, v); }
  $core.bool hasUserProfile() => $_has(5);
  void clearUserProfile() => clearField(6);
}

class UserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<User>(1, 'user', $pb.PbFieldType.OM, User.getDefault, User.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  UserRequest._() : super();
  factory UserRequest() => create();
  factory UserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserRequest clone() => UserRequest()..mergeFromMessage(this);
  UserRequest copyWith(void Function(UserRequest) updates) => super.copyWith((message) => updates(message as UserRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserRequest create() => UserRequest._();
  UserRequest createEmptyInstance() => create();
  static $pb.PbList<UserRequest> createRepeated() => $pb.PbList<UserRequest>();
  static UserRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserRequest _defaultInstance;

  User get user => $_getN(0);
  set user(User v) { setField(1, v); }
  $core.bool hasUser() => $_has(0);
  void clearUser() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);
}

class UserDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'userId')
    ..a<$core.int>(2, 'userVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  UserDeleteRequest._() : super();
  factory UserDeleteRequest() => create();
  factory UserDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserDeleteRequest clone() => UserDeleteRequest()..mergeFromMessage(this);
  UserDeleteRequest copyWith(void Function(UserDeleteRequest) updates) => super.copyWith((message) => updates(message as UserDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserDeleteRequest create() => UserDeleteRequest._();
  UserDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<UserDeleteRequest> createRepeated() => $pb.PbList<UserDeleteRequest>();
  static UserDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserDeleteRequest _defaultInstance;

  $core.String get userId => $_getS(0, '');
  set userId($core.String v) { $_setString(0, v); }
  $core.bool hasUserId() => $_has(0);
  void clearUserId() => clearField(1);

  $core.int get userVersion => $_get(1, 0);
  set userVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasUserVersion() => $_has(1);
  void clearUserVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class UserProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserProfile', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'eMail')
    ..aOS(2, 'image')
    ..aOS(3, 'idiomLocale')
    ..hasRequiredFields = false
  ;

  UserProfile._() : super();
  factory UserProfile() => create();
  factory UserProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserProfile clone() => UserProfile()..mergeFromMessage(this);
  UserProfile copyWith(void Function(UserProfile) updates) => super.copyWith((message) => updates(message as UserProfile));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserProfile create() => UserProfile._();
  UserProfile createEmptyInstance() => create();
  static $pb.PbList<UserProfile> createRepeated() => $pb.PbList<UserProfile>();
  static UserProfile getDefault() => _defaultInstance ??= create()..freeze();
  static UserProfile _defaultInstance;

  $core.String get eMail => $_getS(0, '');
  set eMail($core.String v) { $_setString(0, v); }
  $core.bool hasEMail() => $_has(0);
  void clearEMail() => clearField(1);

  $core.String get image => $_getS(1, '');
  set image($core.String v) { $_setString(1, v); }
  $core.bool hasImage() => $_has(1);
  void clearImage() => clearField(2);

  $core.String get idiomLocale => $_getS(2, '');
  set idiomLocale($core.String v) { $_setString(2, v); }
  $core.bool hasIdiomLocale() => $_has(2);
  void clearIdiomLocale() => clearField(3);
}

class UserGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'managedByOrganizationId')
    ..aOS(3, 'managedByOrganizationIdOrAccessedByOrganizationId')
    ..aOS(4, 'accessedByOrganizationId')
    ..aOB(5, 'withUserProfile')
    ..hasRequiredFields = false
  ;

  UserGetRequest._() : super();
  factory UserGetRequest() => create();
  factory UserGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserGetRequest clone() => UserGetRequest()..mergeFromMessage(this);
  UserGetRequest copyWith(void Function(UserGetRequest) updates) => super.copyWith((message) => updates(message as UserGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserGetRequest create() => UserGetRequest._();
  UserGetRequest createEmptyInstance() => create();
  static $pb.PbList<UserGetRequest> createRepeated() => $pb.PbList<UserGetRequest>();
  static UserGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get managedByOrganizationId => $_getS(1, '');
  set managedByOrganizationId($core.String v) { $_setString(1, v); }
  $core.bool hasManagedByOrganizationId() => $_has(1);
  void clearManagedByOrganizationId() => clearField(2);

  $core.String get managedByOrganizationIdOrAccessedByOrganizationId => $_getS(2, '');
  set managedByOrganizationIdOrAccessedByOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasManagedByOrganizationIdOrAccessedByOrganizationId() => $_has(2);
  void clearManagedByOrganizationIdOrAccessedByOrganizationId() => clearField(3);

  $core.String get accessedByOrganizationId => $_getS(3, '');
  set accessedByOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAccessedByOrganizationId() => $_has(3);
  void clearAccessedByOrganizationId() => clearField(4);

  $core.bool get withUserProfile => $_get(4, false);
  set withUserProfile($core.bool v) { $_setBool(4, v); }
  $core.bool hasWithUserProfile() => $_has(4);
  void clearWithUserProfile() => clearField(5);
}

class UsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UsersResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<User>(1, 'users', $pb.PbFieldType.PM,User.create)
    ..hasRequiredFields = false
  ;

  UsersResponse._() : super();
  factory UsersResponse() => create();
  factory UsersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UsersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UsersResponse clone() => UsersResponse()..mergeFromMessage(this);
  UsersResponse copyWith(void Function(UsersResponse) updates) => super.copyWith((message) => updates(message as UsersResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UsersResponse create() => UsersResponse._();
  UsersResponse createEmptyInstance() => create();
  static $pb.PbList<UsersResponse> createRepeated() => $pb.PbList<UsersResponse>();
  static UsersResponse getDefault() => _defaultInstance ??= create()..freeze();
  static UsersResponse _defaultInstance;

  $core.List<User> get users => $_getList(0);
}

