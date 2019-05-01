// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'state.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/initiative/stage.pb.dart' as stage_pb;


/// Domain model class to represent an initiative stage (activies, bucket or swimlanes)
class Stage {
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

  // Define initiative state order
  static final String indexField = 'index';
  int index;

  stage_pb.Stage writeToProtoBuf() {
    stage_pb.Stage stagePb = stage_pb.Stage();

    if (this.id != null) stagePb.id = this.id;
    if (this.version != null) stagePb.version = this.version;
    if (this.name != null) stagePb.name = this.name;
    if (this.index != null) stagePb.index = this.index;

    if (this.state != null) stagePb.state = this.state.writeToProtoBuf();


    return stagePb;
  }

  readFromProtoBuf(stage_pb.Stage stagePb) {
    if (stagePb.hasId()) this.id = stagePb.id;
    if (stagePb.hasVersion()) this.version = stagePb.version;
    if (stagePb.hasName()) this.name = stagePb.name;
    if (stagePb.hasIndex()) this.index = stagePb.index;
    if (stagePb.hasState()) this.state = State()..readFromProtoBuf(stagePb.state);

  }

  static Map<String, dynamic> fromProtoBufToModelMap(stage_pb.Stage stagePb, [stage_pb.Stage deltaComparedToStagePb ]) {
    Map<String, dynamic> map = Map();

    if (stagePb.hasId() && (deltaComparedToStagePb == null || deltaComparedToStagePb.hasId() && stagePb.id != deltaComparedToStagePb.id)) map[Stage.idField] = stagePb.id;
    if (stagePb.hasVersion() && (deltaComparedToStagePb == null || deltaComparedToStagePb.hasVersion() &&  stagePb.version != deltaComparedToStagePb.version)) map[Stage.versionField] = stagePb.version;
    if (stagePb.hasName() && (deltaComparedToStagePb == null || deltaComparedToStagePb.hasName() && stagePb.name != deltaComparedToStagePb.name)) map[Stage.nameField] = stagePb.name;
    if (stagePb.hasIndex() && (deltaComparedToStagePb == null || deltaComparedToStagePb.hasIndex() && stagePb.index != deltaComparedToStagePb.index)) map[Stage.indexField] = stagePb.index;
    if (stagePb.hasState() && (deltaComparedToStagePb == null || deltaComparedToStagePb.hasState() && stagePb.state != deltaComparedToStagePb.state)) map[Stage.stateField] = State.fromProtoBufToModelMap(stagePb.state, deltaComparedToStagePb?.state);

    return map;
  }
}