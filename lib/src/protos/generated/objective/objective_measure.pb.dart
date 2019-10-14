///
//  Generated code. Do not modify.
//  source: objective/objective_measure.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $6;
import '../general/organization.pb.dart' as $0;
import '../general/group.pb.dart' as $4;
import '../general/user.pb.dart' as $3;

class Objective extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Objective', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOS(4, 'description')
    ..a<$6.Timestamp>(5, 'startDate', $pb.PbFieldType.OM, $6.Timestamp.getDefault, $6.Timestamp.create)
    ..a<$6.Timestamp>(6, 'endDate', $pb.PbFieldType.OM, $6.Timestamp.getDefault, $6.Timestamp.create)
    ..a<$0.Organization>(7, 'organization', $pb.PbFieldType.OM, $0.Organization.getDefault, $0.Organization.create)
    ..a<$4.Group>(8, 'group', $pb.PbFieldType.OM, $4.Group.getDefault, $4.Group.create)
    ..a<Objective>(9, 'alignedTo', $pb.PbFieldType.OM, Objective.getDefault, Objective.create)
    ..a<$3.User>(10, 'leader', $pb.PbFieldType.OM, $3.User.getDefault, $3.User.create)
    ..aOB(11, 'archived')
    ..pc<Objective>(12, 'alignedWithChildren', $pb.PbFieldType.PM,Objective.create)
    ..pc<Measure>(13, 'measures', $pb.PbFieldType.PM,Measure.create)
    ..hasRequiredFields = false
  ;

  Objective._() : super();
  factory Objective() => create();
  factory Objective.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Objective.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Objective clone() => Objective()..mergeFromMessage(this);
  Objective copyWith(void Function(Objective) updates) => super.copyWith((message) => updates(message as Objective));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Objective create() => Objective._();
  Objective createEmptyInstance() => create();
  static $pb.PbList<Objective> createRepeated() => $pb.PbList<Objective>();
  static Objective getDefault() => _defaultInstance ??= create()..freeze();
  static Objective _defaultInstance;

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

  $core.String get description => $_getS(3, '');
  set description($core.String v) { $_setString(3, v); }
  $core.bool hasDescription() => $_has(3);
  void clearDescription() => clearField(4);

  $6.Timestamp get startDate => $_getN(4);
  set startDate($6.Timestamp v) { setField(5, v); }
  $core.bool hasStartDate() => $_has(4);
  void clearStartDate() => clearField(5);

  $6.Timestamp get endDate => $_getN(5);
  set endDate($6.Timestamp v) { setField(6, v); }
  $core.bool hasEndDate() => $_has(5);
  void clearEndDate() => clearField(6);

  $0.Organization get organization => $_getN(6);
  set organization($0.Organization v) { setField(7, v); }
  $core.bool hasOrganization() => $_has(6);
  void clearOrganization() => clearField(7);

  $4.Group get group => $_getN(7);
  set group($4.Group v) { setField(8, v); }
  $core.bool hasGroup() => $_has(7);
  void clearGroup() => clearField(8);

  Objective get alignedTo => $_getN(8);
  set alignedTo(Objective v) { setField(9, v); }
  $core.bool hasAlignedTo() => $_has(8);
  void clearAlignedTo() => clearField(9);

  $3.User get leader => $_getN(9);
  set leader($3.User v) { setField(10, v); }
  $core.bool hasLeader() => $_has(9);
  void clearLeader() => clearField(10);

  $core.bool get archived => $_get(10, false);
  set archived($core.bool v) { $_setBool(10, v); }
  $core.bool hasArchived() => $_has(10);
  void clearArchived() => clearField(11);

  $core.List<Objective> get alignedWithChildren => $_getList(11);

  $core.List<Measure> get measures => $_getList(12);
}

class ObjectiveRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectiveRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<Objective>(1, 'objective', $pb.PbFieldType.OM, Objective.getDefault, Objective.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  ObjectiveRequest._() : super();
  factory ObjectiveRequest() => create();
  factory ObjectiveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ObjectiveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ObjectiveRequest clone() => ObjectiveRequest()..mergeFromMessage(this);
  ObjectiveRequest copyWith(void Function(ObjectiveRequest) updates) => super.copyWith((message) => updates(message as ObjectiveRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ObjectiveRequest create() => ObjectiveRequest._();
  ObjectiveRequest createEmptyInstance() => create();
  static $pb.PbList<ObjectiveRequest> createRepeated() => $pb.PbList<ObjectiveRequest>();
  static ObjectiveRequest getDefault() => _defaultInstance ??= create()..freeze();
  static ObjectiveRequest _defaultInstance;

  Objective get objective => $_getN(0);
  set objective(Objective v) { setField(1, v); }
  $core.bool hasObjective() => $_has(0);
  void clearObjective() => clearField(1);

  $core.String get authUserId => $_getS(1, '');
  set authUserId($core.String v) { $_setString(1, v); }
  $core.bool hasAuthUserId() => $_has(1);
  void clearAuthUserId() => clearField(2);

  $core.String get authOrganizationId => $_getS(2, '');
  set authOrganizationId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthOrganizationId() => $_has(2);
  void clearAuthOrganizationId() => clearField(3);
}

class ObjectiveDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectiveDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'objectiveId')
    ..a<$core.int>(2, 'objectiveVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  ObjectiveDeleteRequest._() : super();
  factory ObjectiveDeleteRequest() => create();
  factory ObjectiveDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ObjectiveDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ObjectiveDeleteRequest clone() => ObjectiveDeleteRequest()..mergeFromMessage(this);
  ObjectiveDeleteRequest copyWith(void Function(ObjectiveDeleteRequest) updates) => super.copyWith((message) => updates(message as ObjectiveDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ObjectiveDeleteRequest create() => ObjectiveDeleteRequest._();
  ObjectiveDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<ObjectiveDeleteRequest> createRepeated() => $pb.PbList<ObjectiveDeleteRequest>();
  static ObjectiveDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static ObjectiveDeleteRequest _defaultInstance;

  $core.String get objectiveId => $_getS(0, '');
  set objectiveId($core.String v) { $_setString(0, v); }
  $core.bool hasObjectiveId() => $_has(0);
  void clearObjectiveId() => clearField(1);

  $core.int get objectiveVersion => $_get(1, 0);
  set objectiveVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasObjectiveVersion() => $_has(1);
  void clearObjectiveVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class Objectives extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Objectives', package: const $pb.PackageName('auge.protobuf'))
    ..pc<Objective>(1, 'objectives', $pb.PbFieldType.PM,Objective.create)
    ..hasRequiredFields = false
  ;

  Objectives._() : super();
  factory Objectives() => create();
  factory Objectives.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Objectives.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Objectives clone() => Objectives()..mergeFromMessage(this);
  Objectives copyWith(void Function(Objectives) updates) => super.copyWith((message) => updates(message as Objectives));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Objectives create() => Objectives._();
  Objectives createEmptyInstance() => create();
  static $pb.PbList<Objectives> createRepeated() => $pb.PbList<Objectives>();
  static Objectives getDefault() => _defaultInstance ??= create()..freeze();
  static Objectives _defaultInstance;

  $core.List<Objective> get objectives => $_getList(0);
}

class ObjectiveGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectiveGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..a<$core.int>(3, 'alignedToRecursive', $pb.PbFieldType.O3)
    ..aOB(4, 'treeAlignedWithChildren')
    ..aOB(5, 'withMeasures')
    ..aOB(6, 'withUserProfile')
    ..aOB(7, 'withArchived')
    ..hasRequiredFields = false
  ;

  ObjectiveGetRequest._() : super();
  factory ObjectiveGetRequest() => create();
  factory ObjectiveGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ObjectiveGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ObjectiveGetRequest clone() => ObjectiveGetRequest()..mergeFromMessage(this);
  ObjectiveGetRequest copyWith(void Function(ObjectiveGetRequest) updates) => super.copyWith((message) => updates(message as ObjectiveGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ObjectiveGetRequest create() => ObjectiveGetRequest._();
  ObjectiveGetRequest createEmptyInstance() => create();
  static $pb.PbList<ObjectiveGetRequest> createRepeated() => $pb.PbList<ObjectiveGetRequest>();
  static ObjectiveGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static ObjectiveGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get organizationId => $_getS(1, '');
  set organizationId($core.String v) { $_setString(1, v); }
  $core.bool hasOrganizationId() => $_has(1);
  void clearOrganizationId() => clearField(2);

  $core.int get alignedToRecursive => $_get(2, 0);
  set alignedToRecursive($core.int v) { $_setSignedInt32(2, v); }
  $core.bool hasAlignedToRecursive() => $_has(2);
  void clearAlignedToRecursive() => clearField(3);

  $core.bool get treeAlignedWithChildren => $_get(3, false);
  set treeAlignedWithChildren($core.bool v) { $_setBool(3, v); }
  $core.bool hasTreeAlignedWithChildren() => $_has(3);
  void clearTreeAlignedWithChildren() => clearField(4);

  $core.bool get withMeasures => $_get(4, false);
  set withMeasures($core.bool v) { $_setBool(4, v); }
  $core.bool hasWithMeasures() => $_has(4);
  void clearWithMeasures() => clearField(5);

  $core.bool get withUserProfile => $_get(5, false);
  set withUserProfile($core.bool v) { $_setBool(5, v); }
  $core.bool hasWithUserProfile() => $_has(5);
  void clearWithUserProfile() => clearField(6);

  $core.bool get withArchived => $_get(6, false);
  set withArchived($core.bool v) { $_setBool(6, v); }
  $core.bool hasWithArchived() => $_has(6);
  void clearWithArchived() => clearField(7);
}

class ObjectivesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectivesResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<Objective>(1, 'objectives', $pb.PbFieldType.PM,Objective.create)
    ..hasRequiredFields = false
  ;

  ObjectivesResponse._() : super();
  factory ObjectivesResponse() => create();
  factory ObjectivesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ObjectivesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ObjectivesResponse clone() => ObjectivesResponse()..mergeFromMessage(this);
  ObjectivesResponse copyWith(void Function(ObjectivesResponse) updates) => super.copyWith((message) => updates(message as ObjectivesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ObjectivesResponse create() => ObjectivesResponse._();
  ObjectivesResponse createEmptyInstance() => create();
  static $pb.PbList<ObjectivesResponse> createRepeated() => $pb.PbList<ObjectivesResponse>();
  static ObjectivesResponse getDefault() => _defaultInstance ??= create()..freeze();
  static ObjectivesResponse _defaultInstance;

  $core.List<Objective> get objectives => $_getList(0);
}

class Measure extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Measure', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOS(4, 'description')
    ..aOS(5, 'metric')
    ..a<$core.int>(6, 'decimalsNumber', $pb.PbFieldType.O3)
    ..a<$core.double>(7, 'startValue', $pb.PbFieldType.OD)
    ..a<$core.double>(8, 'endValue', $pb.PbFieldType.OD)
    ..a<MeasureUnit>(9, 'measureUnit', $pb.PbFieldType.OM, MeasureUnit.getDefault, MeasureUnit.create)
    ..a<$core.double>(10, 'currentValue', $pb.PbFieldType.OD)
    ..pc<MeasureProgress>(11, 'measureProgress', $pb.PbFieldType.PM,MeasureProgress.create)
    ..a<Objective>(12, 'objective', $pb.PbFieldType.OM, Objective.getDefault, Objective.create)
    ..hasRequiredFields = false
  ;

  Measure._() : super();
  factory Measure() => create();
  factory Measure.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Measure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Measure clone() => Measure()..mergeFromMessage(this);
  Measure copyWith(void Function(Measure) updates) => super.copyWith((message) => updates(message as Measure));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Measure create() => Measure._();
  Measure createEmptyInstance() => create();
  static $pb.PbList<Measure> createRepeated() => $pb.PbList<Measure>();
  static Measure getDefault() => _defaultInstance ??= create()..freeze();
  static Measure _defaultInstance;

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

  $core.String get description => $_getS(3, '');
  set description($core.String v) { $_setString(3, v); }
  $core.bool hasDescription() => $_has(3);
  void clearDescription() => clearField(4);

  $core.String get metric => $_getS(4, '');
  set metric($core.String v) { $_setString(4, v); }
  $core.bool hasMetric() => $_has(4);
  void clearMetric() => clearField(5);

  $core.int get decimalsNumber => $_get(5, 0);
  set decimalsNumber($core.int v) { $_setSignedInt32(5, v); }
  $core.bool hasDecimalsNumber() => $_has(5);
  void clearDecimalsNumber() => clearField(6);

  $core.double get startValue => $_getN(6);
  set startValue($core.double v) { $_setDouble(6, v); }
  $core.bool hasStartValue() => $_has(6);
  void clearStartValue() => clearField(7);

  $core.double get endValue => $_getN(7);
  set endValue($core.double v) { $_setDouble(7, v); }
  $core.bool hasEndValue() => $_has(7);
  void clearEndValue() => clearField(8);

  MeasureUnit get measureUnit => $_getN(8);
  set measureUnit(MeasureUnit v) { setField(9, v); }
  $core.bool hasMeasureUnit() => $_has(8);
  void clearMeasureUnit() => clearField(9);

  $core.double get currentValue => $_getN(9);
  set currentValue($core.double v) { $_setDouble(9, v); }
  $core.bool hasCurrentValue() => $_has(9);
  void clearCurrentValue() => clearField(10);

  $core.List<MeasureProgress> get measureProgress => $_getList(10);

  Objective get objective => $_getN(11);
  set objective(Objective v) { setField(12, v); }
  $core.bool hasObjective() => $_has(11);
  void clearObjective() => clearField(12);
}

class MeasureRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<Measure>(1, 'measure', $pb.PbFieldType.OM, Measure.getDefault, Measure.create)
    ..aOS(2, 'objectiveId')
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  MeasureRequest._() : super();
  factory MeasureRequest() => create();
  factory MeasureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureRequest clone() => MeasureRequest()..mergeFromMessage(this);
  MeasureRequest copyWith(void Function(MeasureRequest) updates) => super.copyWith((message) => updates(message as MeasureRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureRequest create() => MeasureRequest._();
  MeasureRequest createEmptyInstance() => create();
  static $pb.PbList<MeasureRequest> createRepeated() => $pb.PbList<MeasureRequest>();
  static MeasureRequest getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureRequest _defaultInstance;

  Measure get measure => $_getN(0);
  set measure(Measure v) { setField(1, v); }
  $core.bool hasMeasure() => $_has(0);
  void clearMeasure() => clearField(1);

  $core.String get objectiveId => $_getS(1, '');
  set objectiveId($core.String v) { $_setString(1, v); }
  $core.bool hasObjectiveId() => $_has(1);
  void clearObjectiveId() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class MeasureDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'measureId')
    ..a<$core.int>(2, 'measureVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  MeasureDeleteRequest._() : super();
  factory MeasureDeleteRequest() => create();
  factory MeasureDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureDeleteRequest clone() => MeasureDeleteRequest()..mergeFromMessage(this);
  MeasureDeleteRequest copyWith(void Function(MeasureDeleteRequest) updates) => super.copyWith((message) => updates(message as MeasureDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureDeleteRequest create() => MeasureDeleteRequest._();
  MeasureDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<MeasureDeleteRequest> createRepeated() => $pb.PbList<MeasureDeleteRequest>();
  static MeasureDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureDeleteRequest _defaultInstance;

  $core.String get measureId => $_getS(0, '');
  set measureId($core.String v) { $_setString(0, v); }
  $core.bool hasMeasureId() => $_has(0);
  void clearMeasureId() => clearField(1);

  $core.int get measureVersion => $_get(1, 0);
  set measureVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasMeasureVersion() => $_has(1);
  void clearMeasureVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class MeasuresResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasuresResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<Measure>(1, 'measures', $pb.PbFieldType.PM,Measure.create)
    ..hasRequiredFields = false
  ;

  MeasuresResponse._() : super();
  factory MeasuresResponse() => create();
  factory MeasuresResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasuresResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasuresResponse clone() => MeasuresResponse()..mergeFromMessage(this);
  MeasuresResponse copyWith(void Function(MeasuresResponse) updates) => super.copyWith((message) => updates(message as MeasuresResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasuresResponse create() => MeasuresResponse._();
  MeasuresResponse createEmptyInstance() => create();
  static $pb.PbList<MeasuresResponse> createRepeated() => $pb.PbList<MeasuresResponse>();
  static MeasuresResponse getDefault() => _defaultInstance ??= create()..freeze();
  static MeasuresResponse _defaultInstance;

  $core.List<Measure> get measures => $_getList(0);
}

class MeasureGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'objectiveId')
    ..aOS(2, 'id')
    ..aOB(3, 'withObjective')
    ..hasRequiredFields = false
  ;

  MeasureGetRequest._() : super();
  factory MeasureGetRequest() => create();
  factory MeasureGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureGetRequest clone() => MeasureGetRequest()..mergeFromMessage(this);
  MeasureGetRequest copyWith(void Function(MeasureGetRequest) updates) => super.copyWith((message) => updates(message as MeasureGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureGetRequest create() => MeasureGetRequest._();
  MeasureGetRequest createEmptyInstance() => create();
  static $pb.PbList<MeasureGetRequest> createRepeated() => $pb.PbList<MeasureGetRequest>();
  static MeasureGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureGetRequest _defaultInstance;

  $core.String get objectiveId => $_getS(0, '');
  set objectiveId($core.String v) { $_setString(0, v); }
  $core.bool hasObjectiveId() => $_has(0);
  void clearObjectiveId() => clearField(1);

  $core.String get id => $_getS(1, '');
  set id($core.String v) { $_setString(1, v); }
  $core.bool hasId() => $_has(1);
  void clearId() => clearField(2);

  $core.bool get withObjective => $_get(2, false);
  set withObjective($core.bool v) { $_setBool(2, v); }
  $core.bool hasWithObjective() => $_has(2);
  void clearWithObjective() => clearField(3);
}

class MeasureUnit extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureUnit', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'symbol')
    ..aOS(3, 'name')
    ..hasRequiredFields = false
  ;

  MeasureUnit._() : super();
  factory MeasureUnit() => create();
  factory MeasureUnit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureUnit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureUnit clone() => MeasureUnit()..mergeFromMessage(this);
  MeasureUnit copyWith(void Function(MeasureUnit) updates) => super.copyWith((message) => updates(message as MeasureUnit));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureUnit create() => MeasureUnit._();
  MeasureUnit createEmptyInstance() => create();
  static $pb.PbList<MeasureUnit> createRepeated() => $pb.PbList<MeasureUnit>();
  static MeasureUnit getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureUnit _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get symbol => $_getS(1, '');
  set symbol($core.String v) { $_setString(1, v); }
  $core.bool hasSymbol() => $_has(1);
  void clearSymbol() => clearField(2);

  $core.String get name => $_getS(2, '');
  set name($core.String v) { $_setString(2, v); }
  $core.bool hasName() => $_has(2);
  void clearName() => clearField(3);
}

class MeasureUnitsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureUnitsResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<MeasureUnit>(1, 'measureUnits', $pb.PbFieldType.PM,MeasureUnit.create)
    ..hasRequiredFields = false
  ;

  MeasureUnitsResponse._() : super();
  factory MeasureUnitsResponse() => create();
  factory MeasureUnitsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureUnitsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureUnitsResponse clone() => MeasureUnitsResponse()..mergeFromMessage(this);
  MeasureUnitsResponse copyWith(void Function(MeasureUnitsResponse) updates) => super.copyWith((message) => updates(message as MeasureUnitsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureUnitsResponse create() => MeasureUnitsResponse._();
  MeasureUnitsResponse createEmptyInstance() => create();
  static $pb.PbList<MeasureUnitsResponse> createRepeated() => $pb.PbList<MeasureUnitsResponse>();
  static MeasureUnitsResponse getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureUnitsResponse _defaultInstance;

  $core.List<MeasureUnit> get measureUnits => $_getList(0);
}

class MeasureProgress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureProgress', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..a<$6.Timestamp>(3, 'date', $pb.PbFieldType.OM, $6.Timestamp.getDefault, $6.Timestamp.create)
    ..a<$core.double>(4, 'currentValue', $pb.PbFieldType.OD)
    ..aOS(5, 'comment')
    ..a<Measure>(6, 'measure', $pb.PbFieldType.OM, Measure.getDefault, Measure.create)
    ..hasRequiredFields = false
  ;

  MeasureProgress._() : super();
  factory MeasureProgress() => create();
  factory MeasureProgress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureProgress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureProgress clone() => MeasureProgress()..mergeFromMessage(this);
  MeasureProgress copyWith(void Function(MeasureProgress) updates) => super.copyWith((message) => updates(message as MeasureProgress));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureProgress create() => MeasureProgress._();
  MeasureProgress createEmptyInstance() => create();
  static $pb.PbList<MeasureProgress> createRepeated() => $pb.PbList<MeasureProgress>();
  static MeasureProgress getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureProgress _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $6.Timestamp get date => $_getN(2);
  set date($6.Timestamp v) { setField(3, v); }
  $core.bool hasDate() => $_has(2);
  void clearDate() => clearField(3);

  $core.double get currentValue => $_getN(3);
  set currentValue($core.double v) { $_setDouble(3, v); }
  $core.bool hasCurrentValue() => $_has(3);
  void clearCurrentValue() => clearField(4);

  $core.String get comment => $_getS(4, '');
  set comment($core.String v) { $_setString(4, v); }
  $core.bool hasComment() => $_has(4);
  void clearComment() => clearField(5);

  Measure get measure => $_getN(5);
  set measure(Measure v) { setField(6, v); }
  $core.bool hasMeasure() => $_has(5);
  void clearMeasure() => clearField(6);
}

class MeasureProgressRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureProgressRequest', package: const $pb.PackageName('auge.protobuf'))
    ..a<MeasureProgress>(1, 'measureProgress', $pb.PbFieldType.OM, MeasureProgress.getDefault, MeasureProgress.create)
    ..aOS(2, 'measureId')
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  MeasureProgressRequest._() : super();
  factory MeasureProgressRequest() => create();
  factory MeasureProgressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureProgressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureProgressRequest clone() => MeasureProgressRequest()..mergeFromMessage(this);
  MeasureProgressRequest copyWith(void Function(MeasureProgressRequest) updates) => super.copyWith((message) => updates(message as MeasureProgressRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureProgressRequest create() => MeasureProgressRequest._();
  MeasureProgressRequest createEmptyInstance() => create();
  static $pb.PbList<MeasureProgressRequest> createRepeated() => $pb.PbList<MeasureProgressRequest>();
  static MeasureProgressRequest getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureProgressRequest _defaultInstance;

  MeasureProgress get measureProgress => $_getN(0);
  set measureProgress(MeasureProgress v) { setField(1, v); }
  $core.bool hasMeasureProgress() => $_has(0);
  void clearMeasureProgress() => clearField(1);

  $core.String get measureId => $_getS(1, '');
  set measureId($core.String v) { $_setString(1, v); }
  $core.bool hasMeasureId() => $_has(1);
  void clearMeasureId() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class MeasureProgressDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureProgressDeleteRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'measureProgressId')
    ..a<$core.int>(2, 'measureProgressVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  MeasureProgressDeleteRequest._() : super();
  factory MeasureProgressDeleteRequest() => create();
  factory MeasureProgressDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureProgressDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureProgressDeleteRequest clone() => MeasureProgressDeleteRequest()..mergeFromMessage(this);
  MeasureProgressDeleteRequest copyWith(void Function(MeasureProgressDeleteRequest) updates) => super.copyWith((message) => updates(message as MeasureProgressDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureProgressDeleteRequest create() => MeasureProgressDeleteRequest._();
  MeasureProgressDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<MeasureProgressDeleteRequest> createRepeated() => $pb.PbList<MeasureProgressDeleteRequest>();
  static MeasureProgressDeleteRequest getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureProgressDeleteRequest _defaultInstance;

  $core.String get measureProgressId => $_getS(0, '');
  set measureProgressId($core.String v) { $_setString(0, v); }
  $core.bool hasMeasureProgressId() => $_has(0);
  void clearMeasureProgressId() => clearField(1);

  $core.int get measureProgressVersion => $_get(1, 0);
  set measureProgressVersion($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasMeasureProgressVersion() => $_has(1);
  void clearMeasureProgressVersion() => clearField(2);

  $core.String get authUserId => $_getS(2, '');
  set authUserId($core.String v) { $_setString(2, v); }
  $core.bool hasAuthUserId() => $_has(2);
  void clearAuthUserId() => clearField(3);

  $core.String get authOrganizationId => $_getS(3, '');
  set authOrganizationId($core.String v) { $_setString(3, v); }
  $core.bool hasAuthOrganizationId() => $_has(3);
  void clearAuthOrganizationId() => clearField(4);
}

class MeasureProgressesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureProgressesResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<MeasureProgress>(1, 'measureProgresses', $pb.PbFieldType.PM,MeasureProgress.create)
    ..hasRequiredFields = false
  ;

  MeasureProgressesResponse._() : super();
  factory MeasureProgressesResponse() => create();
  factory MeasureProgressesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureProgressesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureProgressesResponse clone() => MeasureProgressesResponse()..mergeFromMessage(this);
  MeasureProgressesResponse copyWith(void Function(MeasureProgressesResponse) updates) => super.copyWith((message) => updates(message as MeasureProgressesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureProgressesResponse create() => MeasureProgressesResponse._();
  MeasureProgressesResponse createEmptyInstance() => create();
  static $pb.PbList<MeasureProgressesResponse> createRepeated() => $pb.PbList<MeasureProgressesResponse>();
  static MeasureProgressesResponse getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureProgressesResponse _defaultInstance;

  $core.List<MeasureProgress> get measureProgresses => $_getList(0);
}

class MeasureProgressGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MeasureProgressGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..aOS(2, 'measureId')
    ..aOB(3, 'withMeasure')
    ..hasRequiredFields = false
  ;

  MeasureProgressGetRequest._() : super();
  factory MeasureProgressGetRequest() => create();
  factory MeasureProgressGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeasureProgressGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MeasureProgressGetRequest clone() => MeasureProgressGetRequest()..mergeFromMessage(this);
  MeasureProgressGetRequest copyWith(void Function(MeasureProgressGetRequest) updates) => super.copyWith((message) => updates(message as MeasureProgressGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MeasureProgressGetRequest create() => MeasureProgressGetRequest._();
  MeasureProgressGetRequest createEmptyInstance() => create();
  static $pb.PbList<MeasureProgressGetRequest> createRepeated() => $pb.PbList<MeasureProgressGetRequest>();
  static MeasureProgressGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static MeasureProgressGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get measureId => $_getS(1, '');
  set measureId($core.String v) { $_setString(1, v); }
  $core.bool hasMeasureId() => $_has(1);
  void clearMeasureId() => clearField(2);

  $core.bool get withMeasure => $_get(2, false);
  set withMeasure($core.bool v) { $_setBool(2, v); }
  $core.bool hasWithMeasure() => $_has(2);
  void clearWithMeasure() => clearField(3);
}

