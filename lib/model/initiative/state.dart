// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

//enum ColorParam { hue, saturation, lightness }

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/initiative/state.pb.dart' as state_pb;

const _colorHue = 'hue';
const _colorSaturation = 'saturation';
const _colorLightness = 'lightness';

/// Domain model class to represent an initiative  phase (backlog, workflow, archive)
class State {
  // Base
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific
  static final String nameField = 'name';
  String name;
  // Define initiative state order
  static final String indexField = 'index';
  int index;
  static final String colorField = 'color';
  Map<String, int> color;

  String get colorHue => color[_colorHue].toString();
  String get colorSaturation => color[_colorSaturation].toString();
  String get colorLightness => color[_colorLightness].toString();

  State() {
    color = new Map();
  }

  state_pb.State writeToProtoBuf() {
    state_pb.State statePb = state_pb.State();

    if (this.id != null) statePb.id = this.id;
    if (this.version != null) statePb.version = this.version;
    if (this.name != null) statePb.name = this.name;
    if (this.index != null) statePb.index = this.index;

    if (this.color != null) statePb.color.addAll(this.color);

    return statePb;
  }

  readFromProtoBuf(state_pb.State statePb) {
    if (statePb.hasId()) this.id = statePb.id;
    if (statePb.hasVersion()) this.version = statePb.version;
    if (statePb.hasName()) this.name = statePb.name;
    if (statePb.hasIndex()) this.index = statePb.index;
    if (statePb.color.isNotEmpty) this.color = statePb.color;

  }

  void cloneTo(State to) {
    to.id = this.id;
    to.name = this.name;
    to.index = this.index;
    if (this.color != null) {
      to.color = new Map.from(this.color);
    }
  }

  State clone() {
    State to = new State();
    cloneTo(to);
    return to;
  }
}