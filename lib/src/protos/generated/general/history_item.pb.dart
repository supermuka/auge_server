///
//  Generated code. Do not modify.
//  source: general/history_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $6;
import 'user.pb.dart' as $4;
import 'organization.pb.dart' as $1;

class HistoryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HistoryItem', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'objectClassName')
    ..aOS(3, 'objectId')
    ..a<$core.int>(4, 'objectVersion', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'systemModuleIndex', $pb.PbFieldType.O3)
    ..a<$core.int>(6, 'systemFunctionIndex', $pb.PbFieldType.O3)
    ..a<$6.Timestamp>(7, 'dateTime', $pb.PbFieldType.OM, $6.Timestamp.getDefault, $6.Timestamp.create)
    ..a<$4.User>(8, 'user', $pb.PbFieldType.OM, $4.User.getDefault, $4.User.create)
    ..a<$1.Organization>(9, 'organization', $pb.PbFieldType.OM, $1.Organization.getDefault, $1.Organization.create)
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
  static HistoryItem getDefault() => _defaultInstance ??= create()..freeze();
  static HistoryItem _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get objectClassName => $_getS(1, '');
  set objectClassName($core.String v) { $_setString(1, v); }
  $core.bool hasObjectClassName() => $_has(1);
  void clearObjectClassName() => clearField(2);

  $core.String get objectId => $_getS(2, '');
  set objectId($core.String v) { $_setString(2, v); }
  $core.bool hasObjectId() => $_has(2);
  void clearObjectId() => clearField(3);

  $core.int get objectVersion => $_get(3, 0);
  set objectVersion($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasObjectVersion() => $_has(3);
  void clearObjectVersion() => clearField(4);

  $core.int get systemModuleIndex => $_get(4, 0);
  set systemModuleIndex($core.int v) { $_setSignedInt32(4, v); }
  $core.bool hasSystemModuleIndex() => $_has(4);
  void clearSystemModuleIndex() => clearField(5);

  $core.int get systemFunctionIndex => $_get(5, 0);
  set systemFunctionIndex($core.int v) { $_setSignedInt32(5, v); }
  $core.bool hasSystemFunctionIndex() => $_has(5);
  void clearSystemFunctionIndex() => clearField(6);

  $6.Timestamp get dateTime => $_getN(6);
  set dateTime($6.Timestamp v) { setField(7, v); }
  $core.bool hasDateTime() => $_has(6);
  void clearDateTime() => clearField(7);

  $4.User get user => $_getN(7);
  set user($4.User v) { setField(8, v); }
  $core.bool hasUser() => $_has(7);
  void clearUser() => clearField(8);

  $1.Organization get organization => $_getN(8);
  set organization($1.Organization v) { setField(9, v); }
  $core.bool hasOrganization() => $_has(8);
  void clearOrganization() => clearField(9);

  $core.String get description => $_getS(9, '');
  set description($core.String v) { $_setString(9, v); }
  $core.bool hasDescription() => $_has(9);
  void clearDescription() => clearField(10);

  $core.String get changedValuesJson => $_getS(10, '');
  set changedValuesJson($core.String v) { $_setString(10, v); }
  $core.bool hasChangedValuesJson() => $_has(10);
  void clearChangedValuesJson() => clearField(11);
}

class HistoryItemGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HistoryItemGetRequest', package: const $pb.PackageName('auge.protobuf'))
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
  static HistoryItemGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static HistoryItemGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get organizationId => $_getS(1, '');
  set organizationId($core.String v) { $_setString(1, v); }
  $core.bool hasOrganizationId() => $_has(1);
  void clearOrganizationId() => clearField(2);

  $core.int get systemModuleIndex => $_get(2, 0);
  set systemModuleIndex($core.int v) { $_setSignedInt32(2, v); }
  $core.bool hasSystemModuleIndex() => $_has(2);
  void clearSystemModuleIndex() => clearField(3);
}

class HistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HistoryResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<HistoryItem>(1, 'history', $pb.PbFieldType.PM,HistoryItem.create)
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
  static HistoryResponse getDefault() => _defaultInstance ??= create()..freeze();
  static HistoryResponse _defaultInstance;

  $core.List<HistoryItem> get history => $_getList(0);
}

