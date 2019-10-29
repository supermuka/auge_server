///
//  Generated code. Do not modify.
//  source: general/history_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $5;
import 'user.pb.dart' as $3;
import 'organization.pb.dart' as $0;

class HistoryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HistoryItem', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'objectClassName')
    ..aOS(3, 'objectId')
    ..a<$core.int>(4, 'objectVersion', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'systemModuleIndex', $pb.PbFieldType.O3)
    ..a<$core.int>(6, 'systemFunctionIndex', $pb.PbFieldType.O3)
    ..aOM<$5.Timestamp>(7, 'dateTime', subBuilder: $5.Timestamp.create)
    ..aOM<$3.User>(8, 'user', subBuilder: $3.User.create)
    ..aOM<$0.Organization>(9, 'organization', subBuilder: $0.Organization.create)
    ..aOS(10, 'description')
    ..aOS(11, 'changedValuesJson')
    ..hasRequiredFields = false
  ;

  HistoryItem._() : super();
  factory HistoryItem() => create();
  factory HistoryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HistoryItem clone() => HistoryItem()..mergeFromMessage(this);
  HistoryItem copyWith(void Function(HistoryItem) updates) => super.copyWith((message) => updates(message as HistoryItem));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryItem create() => HistoryItem._();
  HistoryItem createEmptyInstance() => create();
  static $pb.PbList<HistoryItem> createRepeated() => $pb.PbList<HistoryItem>();
  @$core.pragma('dart2js:noInline')
  static HistoryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryItem>(create);
  static HistoryItem _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get objectClassName => $_getSZ(1);
  @$pb.TagNumber(2)
  set objectClassName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasObjectClassName() => $_has(1);
  @$pb.TagNumber(2)
  void clearObjectClassName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get objectId => $_getSZ(2);
  @$pb.TagNumber(3)
  set objectId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasObjectId() => $_has(2);
  @$pb.TagNumber(3)
  void clearObjectId() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get objectVersion => $_getIZ(3);
  @$pb.TagNumber(4)
  set objectVersion($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasObjectVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearObjectVersion() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get systemModuleIndex => $_getIZ(4);
  @$pb.TagNumber(5)
  set systemModuleIndex($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSystemModuleIndex() => $_has(4);
  @$pb.TagNumber(5)
  void clearSystemModuleIndex() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get systemFunctionIndex => $_getIZ(5);
  @$pb.TagNumber(6)
  set systemFunctionIndex($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSystemFunctionIndex() => $_has(5);
  @$pb.TagNumber(6)
  void clearSystemFunctionIndex() => clearField(6);

  @$pb.TagNumber(7)
  $5.Timestamp get dateTime => $_getN(6);
  @$pb.TagNumber(7)
  set dateTime($5.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDateTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateTime() => clearField(7);
  @$pb.TagNumber(7)
  $5.Timestamp ensureDateTime() => $_ensure(6);

  @$pb.TagNumber(8)
  $3.User get user => $_getN(7);
  @$pb.TagNumber(8)
  set user($3.User v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUser() => $_has(7);
  @$pb.TagNumber(8)
  void clearUser() => clearField(8);
  @$pb.TagNumber(8)
  $3.User ensureUser() => $_ensure(7);

  @$pb.TagNumber(9)
  $0.Organization get organization => $_getN(8);
  @$pb.TagNumber(9)
  set organization($0.Organization v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasOrganization() => $_has(8);
  @$pb.TagNumber(9)
  void clearOrganization() => clearField(9);
  @$pb.TagNumber(9)
  $0.Organization ensureOrganization() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get description => $_getSZ(9);
  @$pb.TagNumber(10)
  set description($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescription() => $_has(9);
  @$pb.TagNumber(10)
  void clearDescription() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get changedValuesJson => $_getSZ(10);
  @$pb.TagNumber(11)
  set changedValuesJson($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasChangedValuesJson() => $_has(10);
  @$pb.TagNumber(11)
  void clearChangedValuesJson() => clearField(11);
}

class HistoryItemGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HistoryItemGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..a<$core.int>(3, 'systemModuleIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  HistoryItemGetRequest._() : super();
  factory HistoryItemGetRequest() => create();
  factory HistoryItemGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryItemGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HistoryItemGetRequest clone() => HistoryItemGetRequest()..mergeFromMessage(this);
  HistoryItemGetRequest copyWith(void Function(HistoryItemGetRequest) updates) => super.copyWith((message) => updates(message as HistoryItemGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryItemGetRequest create() => HistoryItemGetRequest._();
  HistoryItemGetRequest createEmptyInstance() => create();
  static $pb.PbList<HistoryItemGetRequest> createRepeated() => $pb.PbList<HistoryItemGetRequest>();
  @$core.pragma('dart2js:noInline')
  static HistoryItemGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryItemGetRequest>(create);
  static HistoryItemGetRequest _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get systemModuleIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set systemModuleIndex($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSystemModuleIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearSystemModuleIndex() => clearField(3);
}

class HistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HistoryResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<HistoryItem>(1, 'history', $pb.PbFieldType.PM, subBuilder: HistoryItem.create)
    ..hasRequiredFields = false
  ;

  HistoryResponse._() : super();
  factory HistoryResponse() => create();
  factory HistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HistoryResponse clone() => HistoryResponse()..mergeFromMessage(this);
  HistoryResponse copyWith(void Function(HistoryResponse) updates) => super.copyWith((message) => updates(message as HistoryResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryResponse create() => HistoryResponse._();
  HistoryResponse createEmptyInstance() => create();
  static $pb.PbList<HistoryResponse> createRepeated() => $pb.PbList<HistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static HistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryResponse>(create);
  static HistoryResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<HistoryItem> get history => $_getList(0);
}

