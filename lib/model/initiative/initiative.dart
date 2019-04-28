// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/initiative/state.dart';
import 'package:auge_server/model/initiative/stage.dart';
import 'package:auge_server/model/initiative/work_item.dart';
import 'package:auge_server/model/general/group.dart';

import 'package:auge_server/model/objective/objective.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/initiative/initiative.pb.dart' as initiative_pb;

/// Domain model class to represent an initiative (action plan, projects)
class Initiative  {
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
  static final String stagesField = 'stages';
  List<Stage> stages;
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

  Initiative() {
    stages = new List<Stage>();
    workItems = new List<WorkItem>();
  }

  Map<State, int> get stateWorkItemsCount {
    Map<State, int> m = new Map();
    Map<String, State> mSameState = new Map();
    State state;
    workItems.forEach( (key) {
      // Get a same object for all State objects with identical id
      state =  mSameState.putIfAbsent(key.stage.state.id, () => key.stage.state);

      m.putIfAbsent(state , () => 0);
      m.update(state, (i) => i + 1);
    });
    return m;
  }

  Map<Stage, int> get stageWorkItemsCount  {
    Map<Stage, int> m = new Map();
    Map<String, Stage> mSameStage = new Map();
    Stage stage;
    workItems.forEach( (key) {
      // Get a same object for all State objects with identical id
      stage =  mSameStage.putIfAbsent(key.stage.id, () => key.stage);

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

  initiative_pb.Initiative writeToProtoBuf() {
    initiative_pb.Initiative initiativePb = initiative_pb.Initiative();

    if (this.id != null) initiativePb.id = this.id;
    if (this.version != null) initiativePb.version = this.version;
    if (this.name != null) initiativePb.name = this.name;
    if (this.description != null) initiativePb.description = this.description;

    if (this.objective != null) initiativePb.objective = this.objective.writeToProtoBuf();
    if (this.group != null) initiativePb.group = this.group.writeToProtoBuf();
    if (this.organization != null) initiativePb.organization = this.organization.writeToProtoBuf();
    if (this.leader != null) initiativePb.leader = this.leader.writeToProtoBuf();
    if (this.workItems != null && this.workItems.isNotEmpty) initiativePb.workItems.addAll(this.workItems.map((m) => m.writeToProtoBuf()));
    if (this.stages != null && this.stages.isNotEmpty) initiativePb.stages.addAll(this.stages.map((m) => m.writeToProtoBuf()));

    return initiativePb;
  }

  readFromProtoBuf(initiative_pb.Initiative initiativePb) {
    if (initiativePb.hasId()) this.id = initiativePb.id;
    if (initiativePb.hasVersion()) this.version = initiativePb.version;
    if (initiativePb.hasName()) this.name = initiativePb.name;
    if (initiativePb.hasDescription()) this.description = initiativePb.description;
    if (initiativePb.hasObjective()) this.objective = Objective()..readFromProtoBuf(initiativePb.objective);
    if (initiativePb.hasGroup()) this.group = Group()..readFromProtoBuf(initiativePb.group);
    if (initiativePb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(initiativePb.organization);
    if (initiativePb.hasLeader()) this.leader = User()..readFromProtoBuf(initiativePb.leader);
    if (initiativePb.workItems.isNotEmpty) this.workItems = initiativePb.workItems.map((u) => WorkItem()..readFromProtoBuf(u)).toList();
    if (initiativePb.stages.isNotEmpty) this.stages = initiativePb.stages.map((u) => Stage()..readFromProtoBuf(u)).toList();
  }

/*
  void cloneTo(Initiative to) {
    to.id = this.id;
    to.name = this.name;
    to.description = this.description;

    if (this.organization != null) {
      to.organization = this.organization.clone();
    }

    if (this.group != null) {
      to.group = this.group.clone();
    }

    if (this.leader != null) {
      to.leader = this.leader.clone();
    }

    if (this.objective != null) {
      to.objective = this.objective.clone();
    }

    if (this.stages != null && this.stages.length >= 0) {
      to.stages.clear();
      this.stages.forEach((s) =>
          to.stages.add(s.clone()));
    }

    if (this.workItems != null && this.workItems.length >= 0) {
      to.workItems.clear();
      this.workItems.forEach((wi) {
        to.workItems.add( wi.clone());
      });
    }

  }

  Initiative clone() {
    Initiative to = new Initiative();
    cloneTo(to);
    return to;
  }
*/

}