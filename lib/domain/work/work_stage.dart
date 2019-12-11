// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/work/work_stage.pb.dart' as work_stage_pb;

enum State {notStarted, inProgress, completed}

/// Domain model class to represent an work stage (activies, bucket or swimlanes)
class WorkStage {
  static final String className = 'WorkStage';

  // Base
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific
  static final String nameField = 'name';
  String name;
  static final String stateField = 'state';
  State state;

  // Define work state order
  static final String indexField = 'index';
  int index;

  WorkStage() {
  }

  work_stage_pb.WorkStage writeToProtoBuf() {
    work_stage_pb.WorkStage workStagePb = work_stage_pb.WorkStage();

    if (this.id != null) workStagePb.id = this.id;
    if (this.version != null) workStagePb.version = this.version;
    if (this.name != null) workStagePb.name = this.name;
    if (this.index != null) workStagePb.index = this.index;

    if (this.state != null) workStagePb.stateIndex = this.state.index;


    return workStagePb;
  }

  readFromProtoBuf(work_stage_pb.WorkStage workStagePb) {
    if (workStagePb.hasId()) this.id = workStagePb.id;
    if (workStagePb.hasVersion()) this.version = workStagePb.version;
    if (workStagePb.hasName()) this.name = workStagePb.name;
    if (workStagePb.hasIndex()) this.index = workStagePb.index;
    if (workStagePb.hasStateIndex()) this.state = State.values[workStagePb.stateIndex];

  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_stage_pb.WorkStage workStagePb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (workStagePb.hasId()) map[WorkStage.idField] = workStagePb.id;
      if (workStagePb.hasName()) map[WorkStage.nameField] = workStagePb.name;
    } else {
      if (workStagePb.hasId()) map[WorkStage.idField] = workStagePb.id;
      if (workStagePb.hasVersion()) map[WorkStage.versionField] = workStagePb.version;
      if (workStagePb.hasName()) map[WorkStage.nameField] = workStagePb.name;
      if (workStagePb.hasIndex()) map[WorkStage.indexField] = workStagePb.index;
      if (workStagePb.hasStateIndex()) map[WorkStage.stateField] = workStagePb.stateIndex;
    }
    return map;
  }
}