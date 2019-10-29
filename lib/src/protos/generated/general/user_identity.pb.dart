///
//  Generated code. Do not modify.
//  source: general/user_identity.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $3;

class UserIdentity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentity', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(4, 'identification')
    ..aOS(5, 'password')
    ..aOS(6, 'passwordSalt')
    ..aOS(7, 'passwordHash')
    ..a<$core.int>(8, 'provider', $pb.PbFieldType.O3)
    ..aOS(9, 'providerObjectId')
    ..aOS(10, 'providerDn')
    ..aOM<$3.User>(11, 'user', subBuilder: $3.User.create)
    ..hasRequiredFields = false
  ;

  UserIdentity._() : super();
  factory UserIdentity() => create();
  factory UserIdentity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserIdentity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserIdentity clone() => UserIdentity()..mergeFromMessage(this);
  UserIdentity copyWith(void Function(UserIdentity) updates) => super.copyWith((message) => updates(message as UserIdentity));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserIdentity create() => UserIdentity._();
  UserIdentity createEmptyInstance() => create();
  static $pb.PbList<UserIdentity> createRepeated() => $pb.PbList<UserIdentity>();
  @$core.pragma('dart2js:noInline')
  static UserIdentity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserIdentity>(create);
  static UserIdentity _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.String get identification => $_getSZ(2);
  @$pb.TagNumber(4)
  set identification($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdentification() => $_has(2);
  @$pb.TagNumber(4)
  void clearIdentification() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(5)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(5)
  void clearPassword() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get passwordSalt => $_getSZ(4);
  @$pb.TagNumber(6)
  set passwordSalt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasPasswordSalt() => $_has(4);
  @$pb.TagNumber(6)
  void clearPasswordSalt() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get passwordHash => $_getSZ(5);
  @$pb.TagNumber(7)
  set passwordHash($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasPasswordHash() => $_has(5);
  @$pb.TagNumber(7)
  void clearPasswordHash() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get provider => $_getIZ(6);
  @$pb.TagNumber(8)
  set provider($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasProvider() => $_has(6);
  @$pb.TagNumber(8)
  void clearProvider() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get providerObjectId => $_getSZ(7);
  @$pb.TagNumber(9)
  set providerObjectId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasProviderObjectId() => $_has(7);
  @$pb.TagNumber(9)
  void clearProviderObjectId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerDn => $_getSZ(8);
  @$pb.TagNumber(10)
  set providerDn($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasProviderDn() => $_has(8);
  @$pb.TagNumber(10)
  void clearProviderDn() => clearField(10);

  @$pb.TagNumber(11)
  $3.User get user => $_getN(9);
  @$pb.TagNumber(11)
  set user($3.User v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUser() => $_has(9);
  @$pb.TagNumber(11)
  void clearUser() => clearField(11);
  @$pb.TagNumber(11)
  $3.User ensureUser() => $_ensure(9);
}

class UserIdentityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentityRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<UserIdentity>(1, 'userIdentity', subBuilder: UserIdentity.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  UserIdentityRequest._() : super();
  factory UserIdentityRequest() => create();
  factory UserIdentityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserIdentityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserIdentityRequest clone() => UserIdentityRequest()..mergeFromMessage(this);
  UserIdentityRequest copyWith(void Function(UserIdentityRequest) updates) => super.copyWith((message) => updates(message as UserIdentityRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserIdentityRequest create() => UserIdentityRequest._();
  UserIdentityRequest createEmptyInstance() => create();
  static $pb.PbList<UserIdentityRequest> createRepeated() => $pb.PbList<UserIdentityRequest>();
  @$core.pragma('dart2js:noInline')
  static UserIdentityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserIdentityRequest>(create);
  static UserIdentityRequest _defaultInstance;

  @$pb.TagNumber(1)
  UserIdentity get userIdentity => $_getN(0);
  @$pb.TagNumber(1)
  set userIdentity(UserIdentity v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserIdentity() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserIdentity() => clearField(1);
  @$pb.TagNumber(1)
  UserIdentity ensureUserIdentity() => $_ensure(0);

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

class UserIdentityDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentityDeleteRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'userIdentityId')
    ..a<$core.int>(2, 'userIdentityVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  UserIdentityDeleteRequest._() : super();
  factory UserIdentityDeleteRequest() => create();
  factory UserIdentityDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserIdentityDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserIdentityDeleteRequest clone() => UserIdentityDeleteRequest()..mergeFromMessage(this);
  UserIdentityDeleteRequest copyWith(void Function(UserIdentityDeleteRequest) updates) => super.copyWith((message) => updates(message as UserIdentityDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserIdentityDeleteRequest create() => UserIdentityDeleteRequest._();
  UserIdentityDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<UserIdentityDeleteRequest> createRepeated() => $pb.PbList<UserIdentityDeleteRequest>();
  @$core.pragma('dart2js:noInline')
  static UserIdentityDeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserIdentityDeleteRequest>(create);
  static UserIdentityDeleteRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userIdentityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userIdentityId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserIdentityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserIdentityId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get userIdentityVersion => $_getIZ(1);
  @$pb.TagNumber(2)
  set userIdentityVersion($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserIdentityVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserIdentityVersion() => clearField(2);

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

class UserIdentityGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentityGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'identification')
    ..aOS(3, 'password')
    ..aOS(4, 'userId')
    ..aOS(5, 'managedByOrganizationId')
    ..aOB(6, 'withUserProfile')
    ..hasRequiredFields = false
  ;

  UserIdentityGetRequest._() : super();
  factory UserIdentityGetRequest() => create();
  factory UserIdentityGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserIdentityGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserIdentityGetRequest clone() => UserIdentityGetRequest()..mergeFromMessage(this);
  UserIdentityGetRequest copyWith(void Function(UserIdentityGetRequest) updates) => super.copyWith((message) => updates(message as UserIdentityGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserIdentityGetRequest create() => UserIdentityGetRequest._();
  UserIdentityGetRequest createEmptyInstance() => create();
  static $pb.PbList<UserIdentityGetRequest> createRepeated() => $pb.PbList<UserIdentityGetRequest>();
  @$core.pragma('dart2js:noInline')
  static UserIdentityGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserIdentityGetRequest>(create);
  static UserIdentityGetRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get identification => $_getSZ(1);
  @$pb.TagNumber(2)
  set identification($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentification() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentification() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get managedByOrganizationId => $_getSZ(4);
  @$pb.TagNumber(5)
  set managedByOrganizationId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasManagedByOrganizationId() => $_has(4);
  @$pb.TagNumber(5)
  void clearManagedByOrganizationId() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get withUserProfile => $_getBF(5);
  @$pb.TagNumber(6)
  set withUserProfile($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasWithUserProfile() => $_has(5);
  @$pb.TagNumber(6)
  void clearWithUserProfile() => clearField(6);
}

class UserIdentitiesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentitiesResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<UserIdentity>(1, 'userIdentities', $pb.PbFieldType.PM, protoName: 'userIdentities', subBuilder: UserIdentity.create)
    ..hasRequiredFields = false
  ;

  UserIdentitiesResponse._() : super();
  factory UserIdentitiesResponse() => create();
  factory UserIdentitiesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserIdentitiesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserIdentitiesResponse clone() => UserIdentitiesResponse()..mergeFromMessage(this);
  UserIdentitiesResponse copyWith(void Function(UserIdentitiesResponse) updates) => super.copyWith((message) => updates(message as UserIdentitiesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserIdentitiesResponse create() => UserIdentitiesResponse._();
  UserIdentitiesResponse createEmptyInstance() => create();
  static $pb.PbList<UserIdentitiesResponse> createRepeated() => $pb.PbList<UserIdentitiesResponse>();
  @$core.pragma('dart2js:noInline')
  static UserIdentitiesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserIdentitiesResponse>(create);
  static UserIdentitiesResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserIdentity> get userIdentities => $_getList(0);
}

