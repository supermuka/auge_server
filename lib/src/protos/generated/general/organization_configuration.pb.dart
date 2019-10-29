///
//  Generated code. Do not modify.
//  source: general/organization_configuration.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'organization.pb.dart' as $0;

class OrganizationConfiguration extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationConfiguration', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'domain')
    ..aOM<$0.Organization>(4, 'organization', subBuilder: $0.Organization.create)
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
  @$core.pragma('dart2js:noInline')
  static OrganizationConfiguration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationConfiguration>(create);
  static OrganizationConfiguration _defaultInstance;

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
  $core.String get domain => $_getSZ(2);
  @$pb.TagNumber(3)
  set domain($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDomain() => $_has(2);
  @$pb.TagNumber(3)
  void clearDomain() => clearField(3);

  @$pb.TagNumber(4)
  $0.Organization get organization => $_getN(3);
  @$pb.TagNumber(4)
  set organization($0.Organization v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrganization() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrganization() => clearField(4);
  @$pb.TagNumber(4)
  $0.Organization ensureOrganization() => $_ensure(3);
}

class OrganizationConfigurationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationConfigurationRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<OrganizationConfiguration>(1, 'organizationConfiguration', protoName: 'organizationConfiguration', subBuilder: OrganizationConfiguration.create)
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
  @$core.pragma('dart2js:noInline')
  static OrganizationConfigurationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationConfigurationRequest>(create);
  static OrganizationConfigurationRequest _defaultInstance;

  @$pb.TagNumber(1)
  OrganizationConfiguration get organizationConfiguration => $_getN(0);
  @$pb.TagNumber(1)
  set organizationConfiguration(OrganizationConfiguration v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganizationConfiguration() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganizationConfiguration() => clearField(1);
  @$pb.TagNumber(1)
  OrganizationConfiguration ensureOrganizationConfiguration() => $_ensure(0);

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

class OrganizationConfigurationGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OrganizationConfigurationGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
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
  @$core.pragma('dart2js:noInline')
  static OrganizationConfigurationGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrganizationConfigurationGetRequest>(create);
  static OrganizationConfigurationGetRequest _defaultInstance;

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

