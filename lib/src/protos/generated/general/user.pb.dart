///
//  Generated code. Do not modify.
//  source: general/user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'organization.pb.dart' as $0;

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('User', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOB(4, 'inactive')
    ..aOM<$0.Organization>(5, 'managedByOrganization', subBuilder: $0.Organization.create)
    ..aOM<UserProfile>(6, 'userProfile', subBuilder: UserProfile.create)
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
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get inactive => $_getBF(3);
  @$pb.TagNumber(4)
  set inactive($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInactive() => $_has(3);
  @$pb.TagNumber(4)
  void clearInactive() => clearField(4);

  @$pb.TagNumber(5)
  $0.Organization get managedByOrganization => $_getN(4);
  @$pb.TagNumber(5)
  set managedByOrganization($0.Organization v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasManagedByOrganization() => $_has(4);
  @$pb.TagNumber(5)
  void clearManagedByOrganization() => clearField(5);
  @$pb.TagNumber(5)
  $0.Organization ensureManagedByOrganization() => $_ensure(4);

  @$pb.TagNumber(6)
  UserProfile get userProfile => $_getN(5);
  @$pb.TagNumber(6)
  set userProfile(UserProfile v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUserProfile() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserProfile() => clearField(6);
  @$pb.TagNumber(6)
  UserProfile ensureUserProfile() => $_ensure(5);
}

class UserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<User>(1, 'user', subBuilder: User.create)
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
  @$core.pragma('dart2js:noInline')
  static UserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRequest>(create);
  static UserRequest _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get authUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set authUserId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get authOrganizationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set authOrganizationId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthOrganizationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthOrganizationId() => clearField(3);
}

class UserDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserDeleteRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
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
  @$core.pragma('dart2js:noInline')
  static UserDeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserDeleteRequest>(create);
  static UserDeleteRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get userVersion => $_getIZ(1);
  @$pb.TagNumber(2)
  set userVersion($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get authUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set authUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get authOrganizationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set authOrganizationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthOrganizationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthOrganizationId() => clearField(4);
}

class UserProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserProfile', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'eMail')
    ..aOB(2, 'eMailNotification')
    ..aOS(3, 'image')
    ..aOS(4, 'idiomLocale')
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
  @$core.pragma('dart2js:noInline')
  static UserProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserProfile>(create);
  static UserProfile _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eMail => $_getSZ(0);
  @$pb.TagNumber(1)
  set eMail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEMail() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get eMailNotification => $_getBF(1);
  @$pb.TagNumber(2)
  set eMailNotification($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEMailNotification() => $_has(1);
  @$pb.TagNumber(2)
  void clearEMailNotification() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get image => $_getSZ(2);
  @$pb.TagNumber(3)
  set image($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get idiomLocale => $_getSZ(3);
  @$pb.TagNumber(4)
  set idiomLocale($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdiomLocale() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdiomLocale() => clearField(4);
}

class UserGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'managedByOrganizationId')
    ..aOS(3, 'managedByOrganizationIdOrAccessedByOrganizationId')
    ..aOS(4, 'accessedByOrganizationId', protoName: 'accessedByOrganizationId')
    ..aOB(5, 'withUserProfile')
    ..aOB(6, 'withObjective')
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
  @$core.pragma('dart2js:noInline')
  static UserGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserGetRequest>(create);
  static UserGetRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get managedByOrganizationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set managedByOrganizationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasManagedByOrganizationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearManagedByOrganizationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get managedByOrganizationIdOrAccessedByOrganizationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set managedByOrganizationIdOrAccessedByOrganizationId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasManagedByOrganizationIdOrAccessedByOrganizationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearManagedByOrganizationIdOrAccessedByOrganizationId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accessedByOrganizationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set accessedByOrganizationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccessedByOrganizationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccessedByOrganizationId() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get withUserProfile => $_getBF(4);
  @$pb.TagNumber(5)
  set withUserProfile($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWithUserProfile() => $_has(4);
  @$pb.TagNumber(5)
  void clearWithUserProfile() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get withObjective => $_getBF(5);
  @$pb.TagNumber(6)
  set withObjective($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasWithObjective() => $_has(5);
  @$pb.TagNumber(6)
  void clearWithObjective() => clearField(6);
}

class UsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UsersResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<User>(1, 'users', $pb.PbFieldType.PM, subBuilder: User.create)
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
  @$core.pragma('dart2js:noInline')
  static UsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UsersResponse>(create);
  static UsersResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<User> get users => $_getList(0);
}

