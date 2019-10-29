///
//  Generated code. Do not modify.
//  source: work/work_work_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'work_stage.pb.dart' as $5;
import '../objective/objective_measure.pb.dart' as $6;
import '../general/organization.pb.dart' as $0;
import '../general/group.pb.dart' as $4;
import '../general/user.pb.dart' as $3;
import '../google/protobuf/timestamp.pb.dart' as $8;

class Work extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Work', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOS(4, 'description')
    ..pc<$5.WorkStage>(5, 'workStages', $pb.PbFieldType.PM, subBuilder: $5.WorkStage.create)
    ..pc<WorkItem>(6, 'workItems', $pb.PbFieldType.PM, subBuilder: WorkItem.create)
    ..aOM<$6.Objective>(7, 'objective', subBuilder: $6.Objective.create)
    ..aOM<$0.Organization>(8, 'organization', subBuilder: $0.Organization.create)
    ..aOM<$4.Group>(9, 'group', subBuilder: $4.Group.create)
    ..aOM<$3.User>(10, 'leader', subBuilder: $3.User.create)
    ..hasRequiredFields = false
  ;

  Work._() : super();
  factory Work() => create();
  factory Work.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Work.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Work clone() => Work()..mergeFromMessage(this);
  Work copyWith(void Function(Work) updates) => super.copyWith((message) => updates(message as Work));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Work create() => Work._();
  Work createEmptyInstance() => create();
  static $pb.PbList<Work> createRepeated() => $pb.PbList<Work>();
  @$core.pragma('dart2js:noInline')
  static Work getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Work>(create);
  static Work _defaultInstance;

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
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$5.WorkStage> get workStages => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<WorkItem> get workItems => $_getList(5);

  @$pb.TagNumber(7)
  $6.Objective get objective => $_getN(6);
  @$pb.TagNumber(7)
  set objective($6.Objective v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasObjective() => $_has(6);
  @$pb.TagNumber(7)
  void clearObjective() => clearField(7);
  @$pb.TagNumber(7)
  $6.Objective ensureObjective() => $_ensure(6);

  @$pb.TagNumber(8)
  $0.Organization get organization => $_getN(7);
  @$pb.TagNumber(8)
  set organization($0.Organization v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasOrganization() => $_has(7);
  @$pb.TagNumber(8)
  void clearOrganization() => clearField(8);
  @$pb.TagNumber(8)
  $0.Organization ensureOrganization() => $_ensure(7);

  @$pb.TagNumber(9)
  $4.Group get group => $_getN(8);
  @$pb.TagNumber(9)
  set group($4.Group v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasGroup() => $_has(8);
  @$pb.TagNumber(9)
  void clearGroup() => clearField(9);
  @$pb.TagNumber(9)
  $4.Group ensureGroup() => $_ensure(8);

  @$pb.TagNumber(10)
  $3.User get leader => $_getN(9);
  @$pb.TagNumber(10)
  set leader($3.User v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasLeader() => $_has(9);
  @$pb.TagNumber(10)
  void clearLeader() => clearField(10);
  @$pb.TagNumber(10)
  $3.User ensureLeader() => $_ensure(9);
}

class WorkRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<Work>(1, 'work', subBuilder: Work.create)
    ..aOS(2, 'authUserId')
    ..aOS(3, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  WorkRequest._() : super();
  factory WorkRequest() => create();
  factory WorkRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkRequest clone() => WorkRequest()..mergeFromMessage(this);
  WorkRequest copyWith(void Function(WorkRequest) updates) => super.copyWith((message) => updates(message as WorkRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkRequest create() => WorkRequest._();
  WorkRequest createEmptyInstance() => create();
  static $pb.PbList<WorkRequest> createRepeated() => $pb.PbList<WorkRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkRequest>(create);
  static WorkRequest _defaultInstance;

  @$pb.TagNumber(1)
  Work get work => $_getN(0);
  @$pb.TagNumber(1)
  set work(Work v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWork() => $_has(0);
  @$pb.TagNumber(1)
  void clearWork() => clearField(1);
  @$pb.TagNumber(1)
  Work ensureWork() => $_ensure(0);

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

class WorkDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkDeleteRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'workId')
    ..a<$core.int>(2, 'workVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  WorkDeleteRequest._() : super();
  factory WorkDeleteRequest() => create();
  factory WorkDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkDeleteRequest clone() => WorkDeleteRequest()..mergeFromMessage(this);
  WorkDeleteRequest copyWith(void Function(WorkDeleteRequest) updates) => super.copyWith((message) => updates(message as WorkDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkDeleteRequest create() => WorkDeleteRequest._();
  WorkDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<WorkDeleteRequest> createRepeated() => $pb.PbList<WorkDeleteRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkDeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkDeleteRequest>(create);
  static WorkDeleteRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get workVersion => $_getIZ(1);
  @$pb.TagNumber(2)
  set workVersion($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkVersion() => clearField(2);

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

class WorksResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorksResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<Work>(1, 'works', $pb.PbFieldType.PM, subBuilder: Work.create)
    ..hasRequiredFields = false
  ;

  WorksResponse._() : super();
  factory WorksResponse() => create();
  factory WorksResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorksResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorksResponse clone() => WorksResponse()..mergeFromMessage(this);
  WorksResponse copyWith(void Function(WorksResponse) updates) => super.copyWith((message) => updates(message as WorksResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorksResponse create() => WorksResponse._();
  WorksResponse createEmptyInstance() => create();
  static $pb.PbList<WorksResponse> createRepeated() => $pb.PbList<WorksResponse>();
  @$core.pragma('dart2js:noInline')
  static WorksResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorksResponse>(create);
  static WorksResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Work> get works => $_getList(0);
}

class WorkGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'organizationId')
    ..aOS(3, 'objectiveId')
    ..aOB(4, 'withWorkItems')
    ..aOB(5, 'withUserProfile')
    ..hasRequiredFields = false
  ;

  WorkGetRequest._() : super();
  factory WorkGetRequest() => create();
  factory WorkGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkGetRequest clone() => WorkGetRequest()..mergeFromMessage(this);
  WorkGetRequest copyWith(void Function(WorkGetRequest) updates) => super.copyWith((message) => updates(message as WorkGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkGetRequest create() => WorkGetRequest._();
  WorkGetRequest createEmptyInstance() => create();
  static $pb.PbList<WorkGetRequest> createRepeated() => $pb.PbList<WorkGetRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkGetRequest>(create);
  static WorkGetRequest _defaultInstance;

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
  $core.String get objectiveId => $_getSZ(2);
  @$pb.TagNumber(3)
  set objectiveId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasObjectiveId() => $_has(2);
  @$pb.TagNumber(3)
  void clearObjectiveId() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get withWorkItems => $_getBF(3);
  @$pb.TagNumber(4)
  set withWorkItems($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWithWorkItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearWithWorkItems() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get withUserProfile => $_getBF(4);
  @$pb.TagNumber(5)
  set withUserProfile($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWithUserProfile() => $_has(4);
  @$pb.TagNumber(5)
  void clearWithUserProfile() => clearField(5);
}

class WorkItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItem', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..aOS(4, 'description')
    ..aOM<$8.Timestamp>(5, 'dueDate', subBuilder: $8.Timestamp.create)
    ..a<$core.int>(6, 'completed', $pb.PbFieldType.O3)
    ..aOM<$5.WorkStage>(7, 'workStage', subBuilder: $5.WorkStage.create)
    ..pc<$3.User>(10, 'assignedTo', $pb.PbFieldType.PM, subBuilder: $3.User.create)
    ..pc<WorkItemCheckItem>(11, 'checkItems', $pb.PbFieldType.PM, subBuilder: WorkItemCheckItem.create)
    ..pc<WorkItemAttachment>(12, 'attachments', $pb.PbFieldType.PM, subBuilder: WorkItemAttachment.create)
    ..aOM<Work>(13, 'work', subBuilder: Work.create)
    ..hasRequiredFields = false
  ;

  WorkItem._() : super();
  factory WorkItem() => create();
  factory WorkItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItem clone() => WorkItem()..mergeFromMessage(this);
  WorkItem copyWith(void Function(WorkItem) updates) => super.copyWith((message) => updates(message as WorkItem));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItem create() => WorkItem._();
  WorkItem createEmptyInstance() => create();
  static $pb.PbList<WorkItem> createRepeated() => $pb.PbList<WorkItem>();
  @$core.pragma('dart2js:noInline')
  static WorkItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItem>(create);
  static WorkItem _defaultInstance;

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
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $8.Timestamp get dueDate => $_getN(4);
  @$pb.TagNumber(5)
  set dueDate($8.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDueDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearDueDate() => clearField(5);
  @$pb.TagNumber(5)
  $8.Timestamp ensureDueDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get completed => $_getIZ(5);
  @$pb.TagNumber(6)
  set completed($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompleted() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompleted() => clearField(6);

  @$pb.TagNumber(7)
  $5.WorkStage get workStage => $_getN(6);
  @$pb.TagNumber(7)
  set workStage($5.WorkStage v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasWorkStage() => $_has(6);
  @$pb.TagNumber(7)
  void clearWorkStage() => clearField(7);
  @$pb.TagNumber(7)
  $5.WorkStage ensureWorkStage() => $_ensure(6);

  @$pb.TagNumber(10)
  $core.List<$3.User> get assignedTo => $_getList(7);

  @$pb.TagNumber(11)
  $core.List<WorkItemCheckItem> get checkItems => $_getList(8);

  @$pb.TagNumber(12)
  $core.List<WorkItemAttachment> get attachments => $_getList(9);

  @$pb.TagNumber(13)
  Work get work => $_getN(10);
  @$pb.TagNumber(13)
  set work(Work v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasWork() => $_has(10);
  @$pb.TagNumber(13)
  void clearWork() => clearField(13);
  @$pb.TagNumber(13)
  Work ensureWork() => $_ensure(10);
}

class WorkItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOM<WorkItem>(1, 'workItem', subBuilder: WorkItem.create)
    ..aOS(2, 'workId')
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  WorkItemRequest._() : super();
  factory WorkItemRequest() => create();
  factory WorkItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemRequest clone() => WorkItemRequest()..mergeFromMessage(this);
  WorkItemRequest copyWith(void Function(WorkItemRequest) updates) => super.copyWith((message) => updates(message as WorkItemRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemRequest create() => WorkItemRequest._();
  WorkItemRequest createEmptyInstance() => create();
  static $pb.PbList<WorkItemRequest> createRepeated() => $pb.PbList<WorkItemRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemRequest>(create);
  static WorkItemRequest _defaultInstance;

  @$pb.TagNumber(1)
  WorkItem get workItem => $_getN(0);
  @$pb.TagNumber(1)
  set workItem(WorkItem v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkItem() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkItem() => clearField(1);
  @$pb.TagNumber(1)
  WorkItem ensureWorkItem() => $_ensure(0);

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

class WorkItemDeleteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemDeleteRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'workItemId')
    ..a<$core.int>(2, 'workItemVersion', $pb.PbFieldType.O3)
    ..aOS(3, 'authUserId')
    ..aOS(4, 'authOrganizationId')
    ..hasRequiredFields = false
  ;

  WorkItemDeleteRequest._() : super();
  factory WorkItemDeleteRequest() => create();
  factory WorkItemDeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemDeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemDeleteRequest clone() => WorkItemDeleteRequest()..mergeFromMessage(this);
  WorkItemDeleteRequest copyWith(void Function(WorkItemDeleteRequest) updates) => super.copyWith((message) => updates(message as WorkItemDeleteRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemDeleteRequest create() => WorkItemDeleteRequest._();
  WorkItemDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<WorkItemDeleteRequest> createRepeated() => $pb.PbList<WorkItemDeleteRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkItemDeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemDeleteRequest>(create);
  static WorkItemDeleteRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workItemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workItemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkItemId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get workItemVersion => $_getIZ(1);
  @$pb.TagNumber(2)
  set workItemVersion($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkItemVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkItemVersion() => clearField(2);

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

class WorkItemsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemsResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<WorkItem>(1, 'workItems', $pb.PbFieldType.PM, protoName: 'workItems', subBuilder: WorkItem.create)
    ..hasRequiredFields = false
  ;

  WorkItemsResponse._() : super();
  factory WorkItemsResponse() => create();
  factory WorkItemsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemsResponse clone() => WorkItemsResponse()..mergeFromMessage(this);
  WorkItemsResponse copyWith(void Function(WorkItemsResponse) updates) => super.copyWith((message) => updates(message as WorkItemsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemsResponse create() => WorkItemsResponse._();
  WorkItemsResponse createEmptyInstance() => create();
  static $pb.PbList<WorkItemsResponse> createRepeated() => $pb.PbList<WorkItemsResponse>();
  @$core.pragma('dart2js:noInline')
  static WorkItemsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemsResponse>(create);
  static WorkItemsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WorkItem> get workItems => $_getList(0);
}

class WorkItemGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'workId')
    ..aOB(3, 'withWork')
    ..hasRequiredFields = false
  ;

  WorkItemGetRequest._() : super();
  factory WorkItemGetRequest() => create();
  factory WorkItemGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemGetRequest clone() => WorkItemGetRequest()..mergeFromMessage(this);
  WorkItemGetRequest copyWith(void Function(WorkItemGetRequest) updates) => super.copyWith((message) => updates(message as WorkItemGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemGetRequest create() => WorkItemGetRequest._();
  WorkItemGetRequest createEmptyInstance() => create();
  static $pb.PbList<WorkItemGetRequest> createRepeated() => $pb.PbList<WorkItemGetRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkItemGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemGetRequest>(create);
  static WorkItemGetRequest _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.bool get withWork => $_getBF(2);
  @$pb.TagNumber(3)
  set withWork($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWithWork() => $_has(2);
  @$pb.TagNumber(3)
  void clearWithWork() => clearField(3);
}

class WorkItemAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemAttachment', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'name')
    ..aOS(3, 'type')
    ..aOS(4, 'content')
    ..hasRequiredFields = false
  ;

  WorkItemAttachment._() : super();
  factory WorkItemAttachment() => create();
  factory WorkItemAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemAttachment clone() => WorkItemAttachment()..mergeFromMessage(this);
  WorkItemAttachment copyWith(void Function(WorkItemAttachment) updates) => super.copyWith((message) => updates(message as WorkItemAttachment));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemAttachment create() => WorkItemAttachment._();
  WorkItemAttachment createEmptyInstance() => create();
  static $pb.PbList<WorkItemAttachment> createRepeated() => $pb.PbList<WorkItemAttachment>();
  @$core.pragma('dart2js:noInline')
  static WorkItemAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemAttachment>(create);
  static WorkItemAttachment _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => clearField(4);
}

class WorkItemAttachmentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemAttachmentsResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<WorkItemAttachment>(1, 'workItemAttachments', $pb.PbFieldType.PM, subBuilder: WorkItemAttachment.create)
    ..hasRequiredFields = false
  ;

  WorkItemAttachmentsResponse._() : super();
  factory WorkItemAttachmentsResponse() => create();
  factory WorkItemAttachmentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemAttachmentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemAttachmentsResponse clone() => WorkItemAttachmentsResponse()..mergeFromMessage(this);
  WorkItemAttachmentsResponse copyWith(void Function(WorkItemAttachmentsResponse) updates) => super.copyWith((message) => updates(message as WorkItemAttachmentsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemAttachmentsResponse create() => WorkItemAttachmentsResponse._();
  WorkItemAttachmentsResponse createEmptyInstance() => create();
  static $pb.PbList<WorkItemAttachmentsResponse> createRepeated() => $pb.PbList<WorkItemAttachmentsResponse>();
  @$core.pragma('dart2js:noInline')
  static WorkItemAttachmentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemAttachmentsResponse>(create);
  static WorkItemAttachmentsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WorkItemAttachment> get workItemAttachments => $_getList(0);
}

class WorkItemAttachmentGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemAttachmentGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'workItemId')
    ..aOB(3, 'withContent')
    ..hasRequiredFields = false
  ;

  WorkItemAttachmentGetRequest._() : super();
  factory WorkItemAttachmentGetRequest() => create();
  factory WorkItemAttachmentGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemAttachmentGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemAttachmentGetRequest clone() => WorkItemAttachmentGetRequest()..mergeFromMessage(this);
  WorkItemAttachmentGetRequest copyWith(void Function(WorkItemAttachmentGetRequest) updates) => super.copyWith((message) => updates(message as WorkItemAttachmentGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemAttachmentGetRequest create() => WorkItemAttachmentGetRequest._();
  WorkItemAttachmentGetRequest createEmptyInstance() => create();
  static $pb.PbList<WorkItemAttachmentGetRequest> createRepeated() => $pb.PbList<WorkItemAttachmentGetRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkItemAttachmentGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemAttachmentGetRequest>(create);
  static WorkItemAttachmentGetRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get workItemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set workItemId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkItemId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get withContent => $_getBF(2);
  @$pb.TagNumber(3)
  set withContent($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWithContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearWithContent() => clearField(3);
}

class WorkItemCheckItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemCheckItem', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'name')
    ..aOB(3, 'finished')
    ..a<$core.int>(4, 'index', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  WorkItemCheckItem._() : super();
  factory WorkItemCheckItem() => create();
  factory WorkItemCheckItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemCheckItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemCheckItem clone() => WorkItemCheckItem()..mergeFromMessage(this);
  WorkItemCheckItem copyWith(void Function(WorkItemCheckItem) updates) => super.copyWith((message) => updates(message as WorkItemCheckItem));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemCheckItem create() => WorkItemCheckItem._();
  WorkItemCheckItem createEmptyInstance() => create();
  static $pb.PbList<WorkItemCheckItem> createRepeated() => $pb.PbList<WorkItemCheckItem>();
  @$core.pragma('dart2js:noInline')
  static WorkItemCheckItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemCheckItem>(create);
  static WorkItemCheckItem _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get finished => $_getBF(2);
  @$pb.TagNumber(3)
  set finished($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFinished() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinished() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get index => $_getIZ(3);
  @$pb.TagNumber(4)
  set index($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearIndex() => clearField(4);
}

class WorkItemCheckItemsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemCheckItemsResponse', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..pc<WorkItemCheckItem>(1, 'workItemCheckItems', $pb.PbFieldType.PM, subBuilder: WorkItemCheckItem.create)
    ..hasRequiredFields = false
  ;

  WorkItemCheckItemsResponse._() : super();
  factory WorkItemCheckItemsResponse() => create();
  factory WorkItemCheckItemsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemCheckItemsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemCheckItemsResponse clone() => WorkItemCheckItemsResponse()..mergeFromMessage(this);
  WorkItemCheckItemsResponse copyWith(void Function(WorkItemCheckItemsResponse) updates) => super.copyWith((message) => updates(message as WorkItemCheckItemsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemCheckItemsResponse create() => WorkItemCheckItemsResponse._();
  WorkItemCheckItemsResponse createEmptyInstance() => create();
  static $pb.PbList<WorkItemCheckItemsResponse> createRepeated() => $pb.PbList<WorkItemCheckItemsResponse>();
  @$core.pragma('dart2js:noInline')
  static WorkItemCheckItemsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemCheckItemsResponse>(create);
  static WorkItemCheckItemsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WorkItemCheckItem> get workItemCheckItems => $_getList(0);
}

class WorkItemCheckItemGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkItemCheckItemGetRequest', package: const $pb.PackageName('auge.protobuf'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'workItemId')
    ..hasRequiredFields = false
  ;

  WorkItemCheckItemGetRequest._() : super();
  factory WorkItemCheckItemGetRequest() => create();
  factory WorkItemCheckItemGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkItemCheckItemGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkItemCheckItemGetRequest clone() => WorkItemCheckItemGetRequest()..mergeFromMessage(this);
  WorkItemCheckItemGetRequest copyWith(void Function(WorkItemCheckItemGetRequest) updates) => super.copyWith((message) => updates(message as WorkItemCheckItemGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkItemCheckItemGetRequest create() => WorkItemCheckItemGetRequest._();
  WorkItemCheckItemGetRequest createEmptyInstance() => create();
  static $pb.PbList<WorkItemCheckItemGetRequest> createRepeated() => $pb.PbList<WorkItemCheckItemGetRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkItemCheckItemGetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkItemCheckItemGetRequest>(create);
  static WorkItemCheckItemGetRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get workItemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set workItemId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWorkItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkItemId() => clearField(2);
}

