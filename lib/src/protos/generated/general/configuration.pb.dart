///
//  Generated code. Do not modify.
//  source: general/configuration.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'organization.pb.dart' as $1;
import '../google/protobuf/timestamp.pb.dart' as $5;

class Configuration extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Configuration', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOB(3, 'directoryServiceEnabled')
    ..a<$1.Organization>(4, 'organization', $pb.PbFieldType.OM, $1.Organization.getDefault, $1.Organization.create)
    ..a<DirectoryService>(5, 'directoryService', $pb.PbFieldType.OM, DirectoryService.getDefault, DirectoryService.create)
    ..hasRequiredFields = false
  ;

  Configuration._() : super();
  factory Configuration() => create();
  factory Configuration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Configuration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Configuration clone() => Configuration()..mergeFromMessage(this);
  Configuration copyWith(void Function(Configuration) updates) => super.copyWith((message) => updates(message as Configuration));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Configuration create() => Configuration._();
  Configuration createEmptyInstance() => create();
  static $pb.PbList<Configuration> createRepeated() => $pb.PbList<Configuration>();
  static Configuration getDefault() => _defaultInstance ??= create()..freeze();
  static Configuration _defaultInstance;

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

  $1.Organization get organization => $_getN(3);
  set organization($1.Organization v) { setField(4, v); }
  $core.bool hasOrganization() => $_has(3);
  void clearOrganization() => clearField(4);

  DirectoryService get directoryService => $_getN(4);
  set directoryService(DirectoryService v) { setField(5, v); }
  $core.bool hasDirectoryService() => $_has(4);
  void clearDirectoryService() => clearField(5);
}

class DirectoryService extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DirectoryService', package: const $pb.PackageName('auge.protobuf'))
    ..a<$core.int>(1, 'syncInterval', $pb.PbFieldType.O3)
    ..a<$5.Timestamp>(2, 'lastSync', $pb.PbFieldType.OM, $5.Timestamp.getDefault, $5.Timestamp.create)
    ..aOS(3, 'hostAddress')
    ..a<$core.int>(4, 'port', $pb.PbFieldType.O3)
    ..aOB(5, 'sslTls')
    ..aOS(6, 'adminBindDN')
    ..aOS(7, 'adminPassword')
    ..aOS(8, 'groupSearchDN')
    ..a<$core.int>(9, 'groupSearchScope', $pb.PbFieldType.O3)
    ..aOS(10, 'groupSearchFilter')
    ..aOS(11, 'groupMemberAttribute')
    ..aOS(12, 'userSearchDN')
    ..a<$core.int>(13, 'userSearchScope', $pb.PbFieldType.O3)
    ..aOS(14, 'userSearchFilter')
    ..aOS(15, 'userLoginAttribute')
    ..aOS(16, 'userEmailAttribute')
    ..aOS(17, 'userFirstNameAttribute')
    ..aOS(18, 'userLastNameAttribute')
    ..hasRequiredFields = false
  ;

  DirectoryService._() : super();
  factory DirectoryService() => create();
  factory DirectoryService.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DirectoryService.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DirectoryService clone() => DirectoryService()..mergeFromMessage(this);
  DirectoryService copyWith(void Function(DirectoryService) updates) => super.copyWith((message) => updates(message as DirectoryService));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DirectoryService create() => DirectoryService._();
  DirectoryService createEmptyInstance() => create();
  static $pb.PbList<DirectoryService> createRepeated() => $pb.PbList<DirectoryService>();
  static DirectoryService getDefault() => _defaultInstance ??= create()..freeze();
  static DirectoryService _defaultInstance;

  $core.int get syncInterval => $_get(0, 0);
  set syncInterval($core.int v) { $_setSignedInt32(0, v); }
  $core.bool hasSyncInterval() => $_has(0);
  void clearSyncInterval() => clearField(1);

  $5.Timestamp get lastSync => $_getN(1);
  set lastSync($5.Timestamp v) { setField(2, v); }
  $core.bool hasLastSync() => $_has(1);
  void clearLastSync() => clearField(2);

  $core.String get hostAddress => $_getS(2, '');
  set hostAddress($core.String v) { $_setString(2, v); }
  $core.bool hasHostAddress() => $_has(2);
  void clearHostAddress() => clearField(3);

  $core.int get port => $_get(3, 0);
  set port($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasPort() => $_has(3);
  void clearPort() => clearField(4);

  $core.bool get sslTls => $_get(4, false);
  set sslTls($core.bool v) { $_setBool(4, v); }
  $core.bool hasSslTls() => $_has(4);
  void clearSslTls() => clearField(5);

  $core.String get adminBindDN => $_getS(5, '');
  set adminBindDN($core.String v) { $_setString(5, v); }
  $core.bool hasAdminBindDN() => $_has(5);
  void clearAdminBindDN() => clearField(6);

  $core.String get adminPassword => $_getS(6, '');
  set adminPassword($core.String v) { $_setString(6, v); }
  $core.bool hasAdminPassword() => $_has(6);
  void clearAdminPassword() => clearField(7);

  $core.String get groupSearchDN => $_getS(7, '');
  set groupSearchDN($core.String v) { $_setString(7, v); }
  $core.bool hasGroupSearchDN() => $_has(7);
  void clearGroupSearchDN() => clearField(8);

  $core.int get groupSearchScope => $_get(8, 0);
  set groupSearchScope($core.int v) { $_setSignedInt32(8, v); }
  $core.bool hasGroupSearchScope() => $_has(8);
  void clearGroupSearchScope() => clearField(9);

  $core.String get groupSearchFilter => $_getS(9, '');
  set groupSearchFilter($core.String v) { $_setString(9, v); }
  $core.bool hasGroupSearchFilter() => $_has(9);
  void clearGroupSearchFilter() => clearField(10);

  $core.String get groupMemberAttribute => $_getS(10, '');
  set groupMemberAttribute($core.String v) { $_setString(10, v); }
  $core.bool hasGroupMemberAttribute() => $_has(10);
  void clearGroupMemberAttribute() => clearField(11);

  $core.String get userSearchDN => $_getS(11, '');
  set userSearchDN($core.String v) { $_setString(11, v); }
  $core.bool hasUserSearchDN() => $_has(11);
  void clearUserSearchDN() => clearField(12);

  $core.int get userSearchScope => $_get(12, 0);
  set userSearchScope($core.int v) { $_setSignedInt32(12, v); }
  $core.bool hasUserSearchScope() => $_has(12);
  void clearUserSearchScope() => clearField(13);

  $core.String get userSearchFilter => $_getS(13, '');
  set userSearchFilter($core.String v) { $_setString(13, v); }
  $core.bool hasUserSearchFilter() => $_has(13);
  void clearUserSearchFilter() => clearField(14);

  $core.String get userLoginAttribute => $_getS(14, '');
  set userLoginAttribute($core.String v) { $_setString(14, v); }
  $core.bool hasUserLoginAttribute() => $_has(14);
  void clearUserLoginAttribute() => clearField(15);

  $core.String get userEmailAttribute => $_getS(15, '');
  set userEmailAttribute($core.String v) { $_setString(15, v); }
  $core.bool hasUserEmailAttribute() => $_has(15);
  void clearUserEmailAttribute() => clearField(16);

  $core.String get userFirstNameAttribute => $_getS(16, '');
  set userFirstNameAttribute($core.String v) { $_setString(16, v); }
  $core.bool hasUserFirstNameAttribute() => $_has(16);
  void clearUserFirstNameAttribute() => clearField(17);

  $core.String get userLastNameAttribute => $_getS(17, '');
  set userLastNameAttribute($core.String v) { $_setString(17, v); }
  $core.bool hasUserLastNameAttribute() => $_has(17);
  void clearUserLastNameAttribute() => clearField(18);
}

class ConfigurationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ConfigurationRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<Configuration>(1, 'configuration', $pb.PbFieldType.OM, Configuration.getDefault, Configuration.create)
    ..aOS(2, 'authenticatedUserId')
    ..aOS(3, 'authenticatedOrganizationId')
    ..hasRequiredFields = false
  ;

  ConfigurationRequest._() : super();
  factory ConfigurationRequest() => create();
  factory ConfigurationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfigurationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ConfigurationRequest clone() => ConfigurationRequest()..mergeFromMessage(this);
  ConfigurationRequest copyWith(void Function(ConfigurationRequest) updates) => super.copyWith((message) => updates(message as ConfigurationRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConfigurationRequest create() => ConfigurationRequest._();
  ConfigurationRequest createEmptyInstance() => create();
  static $pb.PbList<ConfigurationRequest> createRepeated() => $pb.PbList<ConfigurationRequest>();
  static ConfigurationRequest getDefault() => _defaultInstance ??= create()..freeze();
  static ConfigurationRequest _defaultInstance;

  Configuration get configuration => $_getN(0);
  set configuration(Configuration v) { setField(1, v); }
  $core.bool hasConfiguration() => $_has(0);
  void clearConfiguration() => clearField(1);

  $core.String get authenticatedUserId => $_getS(1, '');
  set authenticatedUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthenticatedUserId() => $_has(1);
  void clearAuthenticatedUserId() => clearField(2);

  $core.String get authenticatedOrganizationId => $_getS(2, '');
  set authenticatedOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthenticatedOrganizationId() => $_has(2);
  void clearAuthenticatedOrganizationId() => clearField(3);
}

class ConfigurationGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ConfigurationGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..hasRequiredFields = false
  ;

  ConfigurationGetRequest._() : super();
  factory ConfigurationGetRequest() => create();
  factory ConfigurationGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfigurationGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ConfigurationGetRequest clone() => ConfigurationGetRequest()..mergeFromMessage(this);
  ConfigurationGetRequest copyWith(void Function(ConfigurationGetRequest) updates) => super.copyWith((message) => updates(message as ConfigurationGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConfigurationGetRequest create() => ConfigurationGetRequest._();
  ConfigurationGetRequest createEmptyInstance() => create();
  static $pb.PbList<ConfigurationGetRequest> createRepeated() => $pb.PbList<ConfigurationGetRequest>();
  static ConfigurationGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static ConfigurationGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get organizationId => $_getS(1, '');
  set organizationId($core.String v) { $_setString(1, v); }
  $core.bool hasOrganizationId() => $_has(1);
  void clearOrganizationId() => clearField(2);
}

