///
//  Generated code. Do not modify.
//  source: general/organization_configuration.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'organization.pb.dart' as $0;

class OrganizationConfiguration extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationConfiguration', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'domain')
    ..a<$0.Organization>(4, 'organization', $pb.PbFieldType.OM, $0.Organization.getDefault, $0.Organization.create)
    ..hasRequiredFields = false
  ;

  OrganizationConfiguration._() : super();
  factory OrganizationConfiguration() => create();
  factory OrganizationConfiguration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationConfiguration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationConfiguration clone() => OrganizationConfiguration()..mergeFromMessage(this);
  OrganizationConfiguration copyWith(void Function(OrganizationConfiguration) updates) => super.copyWith((message) => updates(message as OrganizationConfiguration));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationConfiguration create() => OrganizationConfiguration._();
  OrganizationConfiguration createEmptyInstance() => create();
  static $pb.PbList<OrganizationConfiguration> createRepeated() => $pb.PbList<OrganizationConfiguration>();
  static OrganizationConfiguration getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationConfiguration _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $core.String get domain => $_getS(2, '');
  set domain($core.String v) { $_setString(2, v); }
  $core.bool hasDomain() => $_has(2);
  void clearDomain() => clearField(3);

  $0.Organization get organization => $_getN(3);
  set organization($0.Organization v) { setField(4, v); }
  $core.bool hasOrganization() => $_has(3);
  void clearOrganization() => clearField(4);
}

class OrganizationConfigurationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationConfigurationRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<OrganizationConfiguration>(1, 'organizationConfiguration', $pb.PbFieldType.OM, OrganizationConfiguration.getDefault, OrganizationConfiguration.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  OrganizationConfigurationRequest._() : super();
  factory OrganizationConfigurationRequest() => create();
  factory OrganizationConfigurationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationConfigurationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationConfigurationRequest clone() => OrganizationConfigurationRequest()..mergeFromMessage(this);
  OrganizationConfigurationRequest copyWith(void Function(OrganizationConfigurationRequest) updates) => super.copyWith((message) => updates(message as OrganizationConfigurationRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationConfigurationRequest create() => OrganizationConfigurationRequest._();
  OrganizationConfigurationRequest createEmptyInstance() => create();
  static $pb.PbList<OrganizationConfigurationRequest> createRepeated() => $pb.PbList<OrganizationConfigurationRequest>();
  static OrganizationConfigurationRequest getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationConfigurationRequest _defaultInstance;

  OrganizationConfiguration get organizationConfiguration => $_getN(0);
  set organizationConfiguration(OrganizationConfiguration v) { setField(1, v); }
  $core.bool hasOrganizationConfiguration() => $_has(0);
  void clearOrganizationConfiguration() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);
}

class OrganizationConfigurationGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationConfigurationGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..hasRequiredFields = false
  ;

  OrganizationConfigurationGetRequest._() : super();
  factory OrganizationConfigurationGetRequest() => create();
  factory OrganizationConfigurationGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrganizationConfigurationGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OrganizationConfigurationGetRequest clone() => OrganizationConfigurationGetRequest()..mergeFromMessage(this);
  OrganizationConfigurationGetRequest copyWith(void Function(OrganizationConfigurationGetRequest) updates) => super.copyWith((message) => updates(message as OrganizationConfigurationGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrganizationConfigurationGetRequest create() => OrganizationConfigurationGetRequest._();
  OrganizationConfigurationGetRequest createEmptyInstance() => create();
  static $pb.PbList<OrganizationConfigurationGetRequest> createRepeated() => $pb.PbList<OrganizationConfigurationGetRequest>();
  static OrganizationConfigurationGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static OrganizationConfigurationGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get organizationId => $_getS(1, '');
  set organizationId($core.String v) { $_setString(1, v); }
  $core.bool hasOrganizationId() => $_has(1);
  void clearOrganizationId() => clearField(2);
}

