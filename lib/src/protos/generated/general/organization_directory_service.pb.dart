///
//  Generated code. Do not modify.
//  source: general/organization_directory_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $4;
import 'organization.pb.dart' as $0;

class OrganizationDirectoryService extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryService', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOB(3, 'directoryServiceEnabled')
    ..aOS(4, 'hostAddress')
    ..a<$core.int>(5, 'port', $pb.PbFieldType.O3)
    ..aOB(6, 'sslTls')
    ..aOS(7, 'syncBindDn')
    ..aOS(8, 'syncBindPassword')
    ..a<$core.int>(9, 'syncInterval', $pb.PbFieldType.O3)
    ..a<$4.Timestamp>(10, 'syncLastDateTime', $pb.PbFieldType.OM, $4.Timestamp.getDefault, $4.Timestamp.create)
    ..aOS(11, 'syncLastResult')
    ..aOS(12, 'groupSearchDN')
    ..a<$core.int>(13, 'groupSearchScope', $pb.PbFieldType.O3)
    ..aOS(14, 'groupSearchFilter')
    ..aOS(15, 'groupMemberUserAttribute')
    ..aOS(16, 'userSearchDN')
    ..a<$core.int>(17, 'userSearchScope', $pb.PbFieldType.O3)
    ..aOS(18, 'userSearchFilter')
    ..aOS(19, 'userProviderObjectIdAttribute')
    ..aOS(20, 'userIdentificationAttribute')
    ..aOS(21, 'userEmailAttribute')
    ..aOS(22, 'userFirstNameAttribute')
    ..aOS(23, 'userLastNameAttribute')
    ..aOS(24, 'userAttributeForGroupRelationship')
    ..a<$0.Organization>(25, 'organization', $pb.PbFieldType.OM, $0.Organization.getDefault, $0.Organization.create)
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
  static OrganizationDirectoryService getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationDirectoryService _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $core.bool get directoryServiceEnabled => $_get(2, false);
  set directoryServiceEnabled($core.bool v) { $_setBool(2, v); }
  $core.bool hasDirectoryServiceEnabled() => $_has(2);
  void clearDirectoryServiceEnabled() => clearField(3);

  $core.String get hostAddress => $_getS(3, '');
  set hostAddress($core.String v) { $_setString(3, v); }
  $core.bool hasHostAddress() => $_has(3);
  void clearHostAddress() => clearField(4);

  $core.int get port => $_get(4, 0);
  set port($core.int v) { $_setSignedInt32(4, v); }
  $core.bool hasPort() => $_has(4);
  void clearPort() => clearField(5);

  $core.bool get sslTls => $_get(5, false);
  set sslTls($core.bool v) { $_setBool(5, v); }
  $core.bool hasSslTls() => $_has(5);
  void clearSslTls() => clearField(6);

  $core.String get syncBindDn => $_getS(6, '');
  set syncBindDn($core.String v) { $_setString(6, v); }
  $core.bool hasSyncBindDn() => $_has(6);
  void clearSyncBindDn() => clearField(7);

  $core.String get syncBindPassword => $_getS(7, '');
  set syncBindPassword($core.String v) { $_setString(7, v); }
  $core.bool hasSyncBindPassword() => $_has(7);
  void clearSyncBindPassword() => clearField(8);

  $core.int get syncInterval => $_get(8, 0);
  set syncInterval($core.int v) { $_setSignedInt32(8, v); }
  $core.bool hasSyncInterval() => $_has(8);
  void clearSyncInterval() => clearField(9);

  $4.Timestamp get syncLastDateTime => $_getN(9);
  set syncLastDateTime($4.Timestamp v) { setField(10, v); }
  $core.bool hasSyncLastDateTime() => $_has(9);
  void clearSyncLastDateTime() => clearField(10);

  $core.String get syncLastResult => $_getS(10, '');
  set syncLastResult($core.String v) { $_setString(10, v); }
  $core.bool hasSyncLastResult() => $_has(10);
  void clearSyncLastResult() => clearField(11);

  $core.String get groupSearchDN => $_getS(11, '');
  set groupSearchDN($core.String v) { $_setString(11, v); }
  $core.bool hasGroupSearchDN() => $_has(11);
  void clearGroupSearchDN() => clearField(12);

  $core.int get groupSearchScope => $_get(12, 0);
  set groupSearchScope($core.int v) { $_setSignedInt32(12, v); }
  $core.bool hasGroupSearchScope() => $_has(12);
  void clearGroupSearchScope() => clearField(13);

  $core.String get groupSearchFilter => $_getS(13, '');
  set groupSearchFilter($core.String v) { $_setString(13, v); }
  $core.bool hasGroupSearchFilter() => $_has(13);
  void clearGroupSearchFilter() => clearField(14);

  $core.String get groupMemberUserAttribute => $_getS(14, '');
  set groupMemberUserAttribute($core.String v) { $_setString(14, v); }
  $core.bool hasGroupMemberUserAttribute() => $_has(14);
  void clearGroupMemberUserAttribute() => clearField(15);

  $core.String get userSearchDN => $_getS(15, '');
  set userSearchDN($core.String v) { $_setString(15, v); }
  $core.bool hasUserSearchDN() => $_has(15);
  void clearUserSearchDN() => clearField(16);

  $core.int get userSearchScope => $_get(16, 0);
  set userSearchScope($core.int v) { $_setSignedInt32(16, v); }
  $core.bool hasUserSearchScope() => $_has(16);
  void clearUserSearchScope() => clearField(17);

  $core.String get userSearchFilter => $_getS(17, '');
  set userSearchFilter($core.String v) { $_setString(17, v); }
  $core.bool hasUserSearchFilter() => $_has(17);
  void clearUserSearchFilter() => clearField(18);

  $core.String get userProviderObjectIdAttribute => $_getS(18, '');
  set userProviderObjectIdAttribute($core.String v) { $_setString(18, v); }
  $core.bool hasUserProviderObjectIdAttribute() => $_has(18);
  void clearUserProviderObjectIdAttribute() => clearField(19);

  $core.String get userIdentificationAttribute => $_getS(19, '');
  set userIdentificationAttribute($core.String v) { $_setString(19, v); }
  $core.bool hasUserIdentificationAttribute() => $_has(19);
  void clearUserIdentificationAttribute() => clearField(20);

  $core.String get userEmailAttribute => $_getS(20, '');
  set userEmailAttribute($core.String v) { $_setString(20, v); }
  $core.bool hasUserEmailAttribute() => $_has(20);
  void clearUserEmailAttribute() => clearField(21);

  $core.String get userFirstNameAttribute => $_getS(21, '');
  set userFirstNameAttribute($core.String v) { $_setString(21, v); }
  $core.bool hasUserFirstNameAttribute() => $_has(21);
  void clearUserFirstNameAttribute() => clearField(22);

  $core.String get userLastNameAttribute => $_getS(22, '');
  set userLastNameAttribute($core.String v) { $_setString(22, v); }
  $core.bool hasUserLastNameAttribute() => $_has(22);
  void clearUserLastNameAttribute() => clearField(23);

  $core.String get userAttributeForGroupRelationship => $_getS(23, '');
  set userAttributeForGroupRelationship($core.String v) { $_setString(23, v); }
  $core.bool hasUserAttributeForGroupRelationship() => $_has(23);
  void clearUserAttributeForGroupRelationship() => clearField(24);

  $0.Organization get organization => $_getN(24);
  set organization($0.Organization v) { setField(25, v); }
  $core.bool hasOrganization() => $_has(24);
  void clearOrganization() => clearField(25);
}

class OrganizationDirectoryServiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryServiceRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<OrganizationDirectoryService>(1, 'organizationDirectoryService', $pb.PbFieldType.OM, OrganizationDirectoryService.getDefault, OrganizationDirectoryService.create)
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
  static OrganizationDirectoryServiceRequest getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationDirectoryServiceRequest _defaultInstance;

  OrganizationDirectoryService get organizationDirectoryService => $_getN(0);
  set organizationDirectoryService(OrganizationDirectoryService v) { setField(1, v); }
  $core.bool hasOrganizationDirectoryService() => $_has(0);
  void clearOrganizationDirectoryService() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);
}

class OrganizationDirectoryServiceAuthRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryServiceAuthRequest', package: const $pb.PackageName('auge.protobuf'))
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
  static OrganizationDirectoryServiceAuthRequest getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationDirectoryServiceAuthRequest _defaultInstance;

  $core.String get organizationId => $_getS(0, '');
  set organizationId($core.String v) { $_setString(0, v); }
  $core.bool hasOrganizationId() => $_has(0);
  void clearOrganizationId() => clearField(1);

  $core.String get identification => $_getS(1, '');
  set identification($core.String v) { $_setString(1, v); }
  $core.bool hasIdentification() => $_has(1);
  void clearIdentification() => clearField(2);

  $core.String get password => $_getS(2, '');
  set password($core.String v) { $_setString(2, v); }
  $core.bool hasPassword() => $_has(2);
  void clearPassword() => clearField(3);
}

class OrganizationDirectoryServiceGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationDirectoryServiceGetRequest', package: const $pb.PackageName('auge.protobuf'))
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
  static OrganizationDirectoryServiceGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationDirectoryServiceGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get organizationId => $_getS(1, '');
  set organizationId($core.String v) { $_setString(1, v); }
  $core.bool hasOrganizationId() => $_has(1);
  void clearOrganizationId() => clearField(2);
}

