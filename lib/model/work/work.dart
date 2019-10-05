// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel
import "dart:collection";

import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/work/work_stage.dart';
import 'package:auge_server/model/work/work_item.dart';
import 'package:auge_server/model/general/group.dart';

import 'package:auge_server/model/objective/objective.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/work/work_work_item.pb.dart' as work_work_item_pb;

/// Domain model class to represent w work (action plan, projects)
class Work  {
  static final String className = 'Work';

  // Base
  static final String idField = 'id';
  String id;

  static final String versionField = 'version';
  int version;

  // Specific
  static final String nameField = 'name';
  String name;
  static final String descriptionField = 'description';
  String description;
  static final String workStagesField = 'workStages';
  List<WorkStage> workStages;
  static final String objectiveField = 'objective';
  Objective objective;
  static final String organizationField = 'organization';
  Organization organization;
  static final String groupField = 'group';
  Group group;
  static final String leaderField = 'leader';
  User leader;

  // Transient fields
  static final String workItemsField = 'workItems';
  List<WorkItem> workItems;

  Work() {
    workStages = new List<WorkStage>();
    workItems = new List<WorkItem>();
  }

  Map<State, int> get stateWorkItemsCount {
    Map<State, int> m = new Map();
   // Map<int, State> mSameState = SplayTreeMap(); // new Map();
    // Two item on list. First is the state object and the last the count number of workitems
    Map<int, List<dynamic>> mSameState = SplayTreeMap();
    List<dynamic> state;
    workItems.forEach( (key) {
      // Get a same object for all State objects with identical index. Used index as a key to sort
      state =  mSameState.putIfAbsent(key.workStage.state.index, () => [key.workStage.state, 0]);

      //
      state[1]++;

   //   m.putIfAbsent(state , () => 0);
   //   m.update(state, (i) => i + 1);
    });

    mSameState.forEach((k, v) => m.putIfAbsent(v.first, () => v.last));

    return m;

     //return m;
  }

  Map<WorkStage, int> get stageWorkItemsCount  {
    Map<WorkStage, int> m = new Map();
    Map<String, WorkStage> mSameStage =  Map();
    WorkStage stage;
    workItems.forEach( (key) {
      // Get a same object for all State objects with identical id
      stage =  mSameStage.putIfAbsent(key.workStage.id, () => key.workStage);

      m.putIfAbsent(stage, () => 0);
      m.update(stage, (i) => i + 1);
    });
    return m;
  }

  int get workItemsCount   {
    return workItems.length;
  }

  int get workItemsOverDueCount  {
    int n = 0;
    workItems.forEach((i) => i.isOverdue ? ++n : null);
    return n;
  }

  work_work_item_pb.Work writeToProtoBuf() {
    work_work_item_pb.Work workPb = work_work_item_pb.Work();

    if (this.id != null) workPb.id = this.id;
    if (this.version != null) workPb.version = this.version;
    if (this.name != null) workPb.name = this.name;
    if (this.description != null) workPb.description = this.description;

    if (this.objective != null) workPb.objective = this.objective.writeToProtoBuf();
    if (this.group != null) workPb.group = this.group.writeToProtoBuf();
    if (this.organization != null) workPb.organization = this.organization.writeToProtoBuf();
    if (this.leader != null) workPb.leader = this.leader.writeToProtoBuf();
    if (this.workItems != null && this.workItems.isNotEmpty) workPb.workItems.addAll(this.workItems.map((m) => m.writeToProtoBuf()));
    if (this.workStages != null && this.workStages.isNotEmpty) workPb.workStages.addAll(this.workStages.map((m) => m.writeToProtoBuf()));

    return workPb;
  }

  readFromProtoBuf(work_work_item_pb.Work workPb) {
    if (workPb.hasId()) this.id = workPb.id;
    if (workPb.hasVersion()) this.version = workPb.version;
    if (workPb.hasName()) this.name = workPb.name;
    if (workPb.hasDescription()) this.description = workPb.description;
    if (workPb.hasObjective()) this.objective = Objective()..readFromProtoBuf(workPb.objective);
    if (workPb.hasGroup()) this.group = Group()..readFromProtoBuf(workPb.group);
    if (workPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(workPb.organization);
    if (workPb.hasLeader()) this.leader = User()..readFromProtoBuf(workPb.leader);
    if (workPb.workItems.isNotEmpty) this.workItems = workPb.workItems.map((u) => WorkItem()..readFromProtoBuf(u)).toList();
    if (workPb.workStages.isNotEmpty) this.workStages = workPb.workStages.map((u) => WorkStage()..readFromProtoBuf(u)).toList();
  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_work_item_pb.Work workPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (workPb.hasId()) map[Work.idField] = workPb.id;
      if (workPb.hasName()) map[Work.nameField] = workPb.name;
    } else {
      if (workPb.hasId()) map[Work.idField] = workPb.id;
      if (workPb.hasVersion())
        map[Work.versionField] = workPb.version;
      if (workPb.hasName()) map[Work.nameField] = workPb.name;
      if (workPb.hasDescription())
        map[Work.descriptionField] = workPb.description;
      if (workPb.hasObjective()) map[Work.objectiveField] =
          Objective.fromProtoBufToModelMap(workPb.objective, onlyIdAndSpecificationForDepthFields, true);
      if (workPb.hasGroup()) map[Work.groupField] =
          Group.fromProtoBufToModelMap(workPb.group, onlyIdAndSpecificationForDepthFields, true);
      if (workPb.hasOrganization()) map[Work.organizationField] =
          Organization.fromProtoBufToModelMap(workPb.organization, onlyIdAndSpecificationForDepthFields, true);
      if (workPb.hasLeader()) map[Work.leaderField] =
          User.fromProtoBufToModelMap(workPb.leader, onlyIdAndSpecificationForDepthFields, true);
      if (workPb.workItems.isNotEmpty) map[Work.workItemsField] =
          workPb.workItems.map((wi) =>
              WorkItem.fromProtoBufToModelMap(wi, onlyIdAndSpecificationForDepthFields, true)).toList();
      if (workPb.workStages.isNotEmpty) map[Work.workStagesField] =
          workPb.workStages.map((s) => WorkStage.fromProtoBufToModelMap(s, onlyIdAndSpecificationForDepthFields, true))
              .toList();
    }
    return map;
  }
}
