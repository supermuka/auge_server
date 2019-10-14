///
//  Generated code. Do not modify.
//  source: work/work_stage.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

class WorkStage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStage', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..a<$core.int>(4, 'stateIndex', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'index', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  WorkStage._() : super();
  factory WorkStage() => create();
  factory WorkStage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkStage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkStage clone() => WorkStage()..mergeFromMessage(this);
  WorkStage copyWith(void Function(WorkStage) updates) => super.copyWith((message) => updates(message as WorkStage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkStage create() => WorkStage._();
  WorkStage createEmptyInstance() => create();
  static $pb.PbList<WorkStage> createRepeated() => $pb.PbList<WorkStage>();
  static WorkStage getDefault() => _defaultInstance ??= create()..freeze();
  static WorkStage _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $core.String get name => $_getS(2, '');
  set name($core.String v) { $_setString(2, v); }
  $core.bool hasName() => $_has(2);
  void clearName() => clearField(3);

  $core.int get stateIndex => $_get(3, 0);
  set stateIndex($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasStateIndex() => $_has(3);
  void clearStateIndex() => clearField(4);

  $core.int get index => $_get(4, 0);
  set index($core.int v) { $_setSignedInt32(4, v); }
  $core.bool hasIndex() => $_has(4);
  void clearIndex() => clearField(5);
}

class WorkStageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStageRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<WorkStage>(1, 'workStage', $pb.PbFieldType.OM, WorkStage.getDefault, WorkStage.create)
    ..aOS(2, 'workId')
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  WorkStageRequest._() : super();
  factory WorkStageRequest() => create();
  factory WorkStageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkStageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkStageRequest clone() => WorkStageRequest()..mergeFromMessage(this);
  WorkStageRequest copyWith(void Function(WorkStageRequest) updates) => super.copyWith((message) => updates(message as WorkStageRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkStageRequest create() => WorkStageRequest._();
  WorkStageRequest createEmptyInstance() => create();
  static $pb.PbList<WorkStageRequest> createRepeated() => $pb.PbList<WorkStageRequest>();
  static WorkStageRequest getDefault() => _defaultInstance ??= create()..freeze();
  static WorkStageRequest _defaultInstance;

  WorkStage get workStage => $_getN(0);
  set workStage(WorkStage v) { setField(1, v); }
  $core.bool hasWorkStage() => $_has(0);
  void clearWorkStage() => clearField(1);

  $core.String get workId => $_getS(1, '');
  set workId($core.String v) { $_setString(1, v); }
  $core.bool hasWorkId() => $_has(1);
  void clearWorkId() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class WorkStageDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStageDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'workStageId')
    ..a<$core.int>(2, 'workStageVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  WorkStageDeleteRequest._() : super();
  factory WorkStageDeleteRequest() => create();
  factory WorkStageDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkStageDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkStageDeleteRequest clone() => WorkStageDeleteRequest()..mergeFromMessage(this);
  WorkStageDeleteRequest copyWith(void Function(WorkStageDeleteRequest) updates) => super.copyWith((message) => updates(message as WorkStageDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkStageDeleteRequest create() => WorkStageDeleteRequest._();
  WorkStageDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<WorkStageDeleteRequest> createRepeated() => $pb.PbList<WorkStageDeleteRequest>();
  static WorkStageDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static WorkStageDeleteRequest _defaultInstance;

  $core.String get workStageId => $_getS(0, '');
  set workStageId($core.String v) { $_setString(0, v); }
  $core.bool hasWorkStageId() => $_has(0);
  void clearWorkStageId() => clearField(1);

  $core.int get workStageVersion => $_get(1, 0);
  set workStageVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasWorkStageVersion() => $_has(1);
  void clearWorkStageVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class WorkStagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStagesResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<WorkStage>(1, 'workStages', $pb.PbFieldType.PM,WorkStage.create)
    ..hasRequiredFields = false
  ;

  WorkStagesResponse._() : super();
  factory WorkStagesResponse() => create();
  factory WorkStagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkStagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkStagesResponse clone() => WorkStagesResponse()..mergeFromMessage(this);
  WorkStagesResponse copyWith(void Function(WorkStagesResponse) updates) => super.copyWith((message) => updates(message as WorkStagesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkStagesResponse create() => WorkStagesResponse._();
  WorkStagesResponse createEmptyInstance() => create();
  static $pb.PbList<WorkStagesResponse> createRepeated() => $pb.PbList<WorkStagesResponse>();
  static WorkStagesResponse getDefault() => _defaultInstance ??= create()..freeze();
  static WorkStagesResponse _defaultInstance;

  $core.List<WorkStage> get workStages => $_getList(0);
}

class WorkStageGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStageGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'workId')
    ..hasRequiredFields = false
  ;

  WorkStageGetRequest._() : super();
  factory WorkStageGetRequest() => create();
  factory WorkStageGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkStageGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkStageGetRequest clone() => WorkStageGetRequest()..mergeFromMessage(this);
  WorkStageGetRequest copyWith(void Function(WorkStageGetRequest) updates) => super.copyWith((message) => updates(message as WorkStageGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkStageGetRequest create() => WorkStageGetRequest._();
  WorkStageGetRequest createEmptyInstance() => create();
  static $pb.PbList<WorkStageGetRequest> createRepeated() => $pb.PbList<WorkStageGetRequest>();
  static WorkStageGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static WorkStageGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get workId => $_getS(1, '');
  set workId($core.String v) { $_setString(1, v); }
  $core.bool hasWorkId() => $_has(1);
  void clearWorkId() => clearField(2);
}

