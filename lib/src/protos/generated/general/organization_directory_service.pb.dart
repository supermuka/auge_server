///
//  Generated code. Do not modify.
//  source: general/organization_directory_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $4;
import 'organization.pb.dart' as $0;

class OrganizationDirectoryService extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryService', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOB(3, 'directoryServiceEnabled')
    ..aOS(4, 'hostAddress')
    ..a<$core.int>(5, 'port', $pb.PbFieldType.O3)
    ..aOB(6, 'sslTls')
    ..aOS(7, 'syncBindDn')
    ..aOS(8, 'syncBindPassword')
    ..a<$core.int>(9, 'syncInterval', $pb.PbFieldType.O3)
    ..aOM<$4.Timestamp>(10, 'syncLastDateTime', subBuilder: $4.Timestamp.create)
    ..aOS(11, 'syncLastResult')
    ..aOS(12, 'groupSearchDN', protoName: 'group_search_DN')
    ..a<$core.int>(13, 'groupSearchScope', $pb.PbFieldType.O3)
    ..aOS(14, 'groupSearchFilter')
    ..aOS(15, 'groupMemberUserAttribute')
    ..aOS(16, 'userSearchDN', protoName: 'user_search_DN')
    ..a<$core.int>(17, 'userSearchScope', $pb.PbFieldType.O3)
    ..aOS(18, 'userSearchFilter')
    ..aOS(19, 'userProviderObjectIdAttribute')
    ..aOS(20, 'userIdentificationAttribute')
    ..aOS(21, 'userEmailAttribute')
    ..aOS(22, 'userFirstNameAttribute')
    ..aOS(23, 'userLastNameAttribute')
    ..aOS(24, 'userAttributeForGroupRelationship')
    ..aOM<$0.Organization>(25, 'organization', subBuilder: $0.Organization.create)
    ..hasRequiredFields = false
  ;

  OrganizationDirectoryService._() : super();
  factory OrganizationDirectoryService() => create();
  factory OrganizationDirectoryService.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationDirectoryService.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationDirectoryService clone() => OrganizationDirectoryService()..mergeFromMessage(this);
  OrganizationDirectoryService copyWith(void Function(OrganizationDirectoryService) updates) => super.copyWith((message) => updates(message as OrganizationDirectoryService));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryService create() => OrganizationDirectoryService._();
  OrganizationDirectoryService createEmptyInstance() => create();
  static $pb.PbList<OrganizationDirectoryService> createRepeated() => $pb.PbList<OrganizationDirectoryService>();
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryService getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationDirectoryService>(create);
  static OrganizationDirectoryService _defaultInstance;

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
  $core.bool get directoryServiceEnabled => $_getBF(2);
  @$pb.TagNumber(3)
  set directoryServiceEnabled($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirectoryServiceEnabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirectoryServiceEnabled() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get hostAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set hostAddress($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHostAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearHostAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get port => $_getIZ(4);
  @$pb.TagNumber(5)
  set port($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPort() => $_has(4);
  @$pb.TagNumber(5)
  void clearPort() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get sslTls => $_getBF(5);
  @$pb.TagNumber(6)
  set sslTls($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSslTls() => $_has(5);
  @$pb.TagNumber(6)
  void clearSslTls() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get syncBindDn => $_getSZ(6);
  @$pb.TagNumber(7)
  set syncBindDn($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSyncBindDn() => $_has(6);
  @$pb.TagNumber(7)
  void clearSyncBindDn() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get syncBindPassword => $_getSZ(7);
  @$pb.TagNumber(8)
  set syncBindPassword($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSyncBindPassword() => $_has(7);
  @$pb.TagNumber(8)
  void clearSyncBindPassword() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get syncInterval => $_getIZ(8);
  @$pb.TagNumber(9)
  set syncInterval($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSyncInterval() => $_has(8);
  @$pb.TagNumber(9)
  void clearSyncInterval() => clearField(9);

  @$pb.TagNumber(10)
  $4.Timestamp get syncLastDateTime => $_getN(9);
  @$pb.TagNumber(10)
  set syncLastDateTime($4.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSyncLastDateTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearSyncLastDateTime() => clearField(10);
  @$pb.TagNumber(10)
  $4.Timestamp ensureSyncLastDateTime() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.String get syncLastResult => $_getSZ(10);
  @$pb.TagNumber(11)
  set syncLastResult($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSyncLastResult() => $_has(10);
  @$pb.TagNumber(11)
  void clearSyncLastResult() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get groupSearchDN => $_getSZ(11);
  @$pb.TagNumber(12)
  set groupSearchDN($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasGroupSearchDN() => $_has(11);
  @$pb.TagNumber(12)
  void clearGroupSearchDN() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get groupSearchScope => $_getIZ(12);
  @$pb.TagNumber(13)
  set groupSearchScope($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasGroupSearchScope() => $_has(12);
  @$pb.TagNumber(13)
  void clearGroupSearchScope() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get groupSearchFilter => $_getSZ(13);
  @$pb.TagNumber(14)
  set groupSearchFilter($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasGroupSearchFilter() => $_has(13);
  @$pb.TagNumber(14)
  void clearGroupSearchFilter() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get groupMemberUserAttribute => $_getSZ(14);
  @$pb.TagNumber(15)
  set groupMemberUserAttribute($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasGroupMemberUserAttribute() => $_has(14);
  @$pb.TagNumber(15)
  void clearGroupMemberUserAttribute() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get userSearchDN => $_getSZ(15);
  @$pb.TagNumber(16)
  set userSearchDN($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasUserSearchDN() => $_has(15);
  @$pb.TagNumber(16)
  void clearUserSearchDN() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get userSearchScope => $_getIZ(16);
  @$pb.TagNumber(17)
  set userSearchScope($core.int v) { $_setSignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasUserSearchScope() => $_has(16);
  @$pb.TagNumber(17)
  void clearUserSearchScope() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get userSearchFilter => $_getSZ(17);
  @$pb.TagNumber(18)
  set userSearchFilter($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasUserSearchFilter() => $_has(17);
  @$pb.TagNumber(18)
  void clearUserSearchFilter() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get userProviderObjectIdAttribute => $_getSZ(18);
  @$pb.TagNumber(19)
  set userProviderObjectIdAttribute($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasUserProviderObjectIdAttribute() => $_has(18);
  @$pb.TagNumber(19)
  void clearUserProviderObjectIdAttribute() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get userIdentificationAttribute => $_getSZ(19);
  @$pb.TagNumber(20)
  set userIdentificationAttribute($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasUserIdentificationAttribute() => $_has(19);
  @$pb.TagNumber(20)
  void clearUserIdentificationAttribute() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get userEmailAttribute => $_getSZ(20);
  @$pb.TagNumber(21)
  set userEmailAttribute($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasUserEmailAttribute() => $_has(20);
  @$pb.TagNumber(21)
  void clearUserEmailAttribute() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get userFirstNameAttribute => $_getSZ(21);
  @$pb.TagNumber(22)
  set userFirstNameAttribute($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasUserFirstNameAttribute() => $_has(21);
  @$pb.TagNumber(22)
  void clearUserFirstNameAttribute() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get userLastNameAttribute => $_getSZ(22);
  @$pb.TagNumber(23)
  set userLastNameAttribute($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasUserLastNameAttribute() => $_has(22);
  @$pb.TagNumber(23)
  void clearUserLastNameAttribute() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get userAttributeForGroupRelationship => $_getSZ(23);
  @$pb.TagNumber(24)
  set userAttributeForGroupRelationship($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasUserAttributeForGroupRelationship() => $_has(23);
  @$pb.TagNumber(24)
  void clearUserAttributeForGroupRelationship() => clearField(24);

  @$pb.TagNumber(25)
  $0.Organization get organization => $_getN(24);
  @$pb.TagNumber(25)
  set organization($0.Organization v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasOrganization() => $_has(24);
  @$pb.TagNumber(25)
  void clearOrganization() => clearField(25);
  @$pb.TagNumber(25)
  $0.Organization ensureOrganization() => $_ensure(24);
}

class OrganizationDirectoryServiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryServiceRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<OrganizationDirectoryService>(1, 'organizationDirectoryService', protoName: 'organizationDirectoryService', subBuilder: OrganizationDirectoryService.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  OrganizationDirectoryServiceRequest._() : super();
  factory OrganizationDirectoryServiceRequest() => create();
  factory OrganizationDirectoryServiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationDirectoryServiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationDirectoryServiceRequest clone() => OrganizationDirectoryServiceRequest()..mergeFromMessage(this);
  OrganizationDirectoryServiceRequest copyWith(void Function(OrganizationDirectoryServiceRequest) updates) => super.copyWith((message) => updates(message as OrganizationDirectoryServiceRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryServiceRequest create() => OrganizationDirectoryServiceRequest._();
  OrganizationDirectoryServiceRequest createEmptyInstance() => create();
  static $pb.PbList<OrganizationDirectoryServiceRequest> createRepeated() => $pb.PbList<OrganizationDirectoryServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryServiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationDirectoryServiceRequest>(create);
  static OrganizationDirectoryServiceRequest _defaultInstance;

  @$pb.TagNumber(1)
  OrganizationDirectoryService get organizationDirectoryService => $_getN(0);
  @$pb.TagNumber(1)
  set organizationDirectoryService(OrganizationDirectoryService v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganizationDirectoryService() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganizationDirectoryService() => clearField(1);
  @$pb.TagNumber(1)
  OrganizationDirectoryService ensureOrganizationDirectoryService() => $_ensure(0);

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

class OrganizationDirectoryServiceAuthRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryServiceAuthRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'organizationId')
    ..aOS(2, 'identification')
    ..aOS(3, 'password')
    ..hasRequiredFields = false
  ;

  OrganizationDirectoryServiceAuthRequest._() : super();
  factory OrganizationDirectoryServiceAuthRequest() => create();
  factory OrganizationDirectoryServiceAuthRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationDirectoryServiceAuthRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationDirectoryServiceAuthRequest clone() => OrganizationDirectoryServiceAuthRequest()..mergeFromMessage(this);
  OrganizationDirectoryServiceAuthRequest copyWith(void Function(OrganizationDirectoryServiceAuthRequest) updates) => super.copyWith((message) => updates(message as OrganizationDirectoryServiceAuthRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryServiceAuthRequest create() => OrganizationDirectoryServiceAuthRequest._();
  OrganizationDirectoryServiceAuthRequest createEmptyInstance() => create();
  static $pb.PbList<OrganizationDirectoryServiceAuthRequest> createRepeated() => $pb.PbList<OrganizationDirectoryServiceAuthRequest>();
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryServiceAuthRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationDirectoryServiceAuthRequest>(create);
  static OrganizationDirectoryServiceAuthRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get organizationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set organizationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganizationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganizationId() => clearField(1);

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
}

class OrganizationDirectoryServiceGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryServiceGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..hasRequiredFields = false
  ;

  OrganizationDirectoryServiceGetRequest._() : super();
  factory OrganizationDirectoryServiceGetRequest() => create();
  factory OrganizationDirectoryServiceGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationDirectoryServiceGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationDirectoryServiceGetRequest clone() => OrganizationDirectoryServiceGetRequest()..mergeFromMessage(this);
  OrganizationDirectoryServiceGetRequest copyWith(void Function(OrganizationDirectoryServiceGetRequest) updates) => super.copyWith((message) => updates(message as OrganizationDirectoryServiceGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryServiceGetRequest create() => OrganizationDirectoryServiceGetRequest._();
  OrganizationDirectoryServiceGetRequest createEmptyInstance() => create();
  static $pb.PbList<OrganizationDirectoryServiceGetRequest> createRepeated() => $pb.PbList<OrganizationDirectoryServiceGetRequest>();
  @$core.pragma('dart2js:noInline')
  static OrganizationDirectoryServiceGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationDirectoryServiceGetRequest>(create);
  static OrganizationDirectoryServiceGetRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get organizationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organizationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrganizationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganizationId() => clearField(2);
}

