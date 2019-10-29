///
//  Generated code. Do not modify.
//  source: work/work_stage.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class WorkStage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStage', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
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
  @$core.pragma('dart2js:noInline')
  static WorkStage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkStage>(create);
  static WorkStage _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get stateIndex => $_getIZ(3);
  @$pb.TagNumber(4)
  set stateIndex($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStateIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearStateIndex() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get index => $_getIZ(4);
  @$pb.TagNumber(5)
  set index($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIndex() => $_has(4);
  @$pb.TagNumber(5)
  void clearIndex() => clearField(5);
}

class WorkStageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStageRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<WorkStage>(1, 'workStage', subBuilder: WorkStage.create)
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
  @$core.pragma('dart2js:noInline')
  static WorkStageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkStageRequest>(create);
  static WorkStageRequest _defaultInstance;

  @$pb.TagNumber(1)
  WorkStage get workStage => $_getN(0);
  @$pb.TagNumber(1)
  set workStage(WorkStage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkStage() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkStage() => clearField(1);
  @$pb.TagNumber(1)
  WorkStage ensureWorkStage() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get workId => $_getSZ(1);
  @$pb.TagNumber(2)
  set workId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkId() => clearField(2);

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

class WorkStageDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStageDeleteRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
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
  @$core.pragma('dart2js:noInline')
  static WorkStageDeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkStageDeleteRequest>(create);
  static WorkStageDeleteRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workStageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workStageId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkStageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkStageId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get workStageVersion => $_getIZ(1);
  @$pb.TagNumber(2)
  set workStageVersion($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkStageVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkStageVersion() => clearField(2);

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

class WorkStagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStagesResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<WorkStage>(1, 'workStages', $pb.PbFieldType.PM, subBuilder: WorkStage.create)
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
  @$core.pragma('dart2js:noInline')
  static WorkStagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkStagesResponse>(create);
  static WorkStagesResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WorkStage> get workStages => $_getList(0);
}

class WorkStageGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkStageGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
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
  @$core.pragma('dart2js:noInline')
  static WorkStageGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkStageGetRequest>(create);
  static WorkStageGetRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get workId => $_getSZ(1);
  @$pb.TagNumber(2)
  set workId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkId() => clearField(2);
}

