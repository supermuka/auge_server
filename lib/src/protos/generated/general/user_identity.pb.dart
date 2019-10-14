///
//  Generated code. Do not modify.
//  source: general/user_identity.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $3;

class UserIdentity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentity', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(4, 'identification')
    ..aOS(5, 'password')
    ..aOS(6, 'passwordSalt')
    ..aOS(7, 'passwordHash')
    ..a<$core.int>(8, 'provider', $pb.PbFieldType.O3)
    ..aOS(9, 'providerObjectId')
    ..aOS(10, 'providerDn')
    ..a<$3.User>(11, 'user', $pb.PbFieldType.OM, $3.User.getDefault, $3.User.create)
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
  static UserIdentity getDefault() => _defaultInstance ??= create()..freeze();
  static UserIdentity _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $core.String get identification => $_getS(2, '');
  set identification($core.String v) { $_setString(2, v); }
  $core.bool hasIdentification() => $_has(2);
  void clearIdentification() => clearField(4);

  $core.String get password => $_getS(3, '');
  set password($core.String v) { $_setString(3, v); }
  $core.bool hasPassword() => $_has(3);
  void clearPassword() => clearField(5);

  $core.String get passwordSalt => $_getS(4, '');
  set passwordSalt($core.String v) { $_setString(4, v); }
  $core.bool hasPasswordSalt() => $_has(4);
  void clearPasswordSalt() => clearField(6);

  $core.String get passwordHash => $_getS(5, '');
  set passwordHash($core.String v) { $_setString(5, v); }
  $core.bool hasPasswordHash() => $_has(5);
  void clearPasswordHash() => clearField(7);

  $core.int get provider => $_get(6, 0);
  set provider($core.int v) { $_setSignedInt32(6, v); }
  $core.bool hasProvider() => $_has(6);
  void clearProvider() => clearField(8);

  $core.String get providerObjectId => $_getS(7, '');
  set providerObjectId($core.String v) { $_setString(7, v); }
  $core.bool hasProviderObjectId() => $_has(7);
  void clearProviderObjectId() => clearField(9);

  $core.String get providerDn => $_getS(8, '');
  set providerDn($core.String v) { $_setString(8, v); }
  $core.bool hasProviderDn() => $_has(8);
  void clearProviderDn() => clearField(10);

  $3.User get user => $_getN(9);
  set user($3.User v) { setField(11, v); }
  $core.bool hasUser() => $_has(9);
  void clearUser() => clearField(11);
}

class UserIdentityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentityRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<UserIdentity>(1, 'userIdentity', $pb.PbFieldType.OM, UserIdentity.getDefault, UserIdentity.create)
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
  static UserIdentityRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserIdentityRequest _defaultInstance;

  UserIdentity get userIdentity => $_getN(0);
  set userIdentity(UserIdentity v) { setField(1, v); }
  $core.bool hasUserIdentity() => $_has(0);
  void clearUserIdentity() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);
}

class UserIdentityDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentityDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
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
  static UserIdentityDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserIdentityDeleteRequest _defaultInstance;

  $core.String get userIdentityId => $_getS(0, '');
  set userIdentityId($core.String v) { $_setString(0, v); }
  $core.bool hasUserIdentityId() => $_has(0);
  void clearUserIdentityId() => clearField(1);

  $core.int get userIdentityVersion => $_get(1, 0);
  set userIdentityVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasUserIdentityVersion() => $_has(1);
  void clearUserIdentityVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class UserIdentityGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentityGetRequest', package: const $pb.PackageName('auge.protobuf'))
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
  static UserIdentityGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static UserIdentityGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get identification => $_getS(1, '');
  set identification($core.String v) { $_setString(1, v); }
  $core.bool hasIdentification() => $_has(1);
  void clearIdentification() => clearField(2);

  $core.String get password => $_getS(2, '');
  set password($core.String v) { $_setString(2, v); }
  $core.bool hasPassword() => $_has(2);
  void clearPassword() => clearField(3);

  $core.String get userId => $_getS(3, '');
  set userId($core.String v) { $_setString(3, v); }
  $core.bool hasUserId() => $_has(3);
  void clearUserId() => clearField(4);

  $core.String get managedByOrganizationId => $_getS(4, '');
  set managedByOrganizationId($core.String v) { $_setString(4, v); }
  $core.bool hasManagedByOrganizationId() => $_has(4);
  void clearManagedByOrganizationId() => clearField(5);

  $core.bool get withUserProfile => $_get(5, false);
  set withUserProfile($core.bool v) { $_setBool(5, v); }
  $core.bool hasWithUserProfile() => $_has(5);
  void clearWithUserProfile() => clearField(6);
}

class UserIdentitiesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserIdentitiesResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<UserIdentity>(1, 'userIdentities', $pb.PbFieldType.PM,UserIdentity.create)
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
  static UserIdentitiesResponse getDefault() => _defaultInstance ??= create()..freeze();
  static UserIdentitiesResponse _defaultInstance;

  $core.List<UserIdentity> get userIdentities => $_getList(0);
}

