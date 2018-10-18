// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

//enum ColorParam { hue, saturation, lightness }

const _colorHue = 'hue';
const _colorSaturation = 'saturation';
const _colorLightness = 'lightness';

/// Domain model class to represent an initiative  phase (backlog, workflow, archive)
class State extends Object {
  String id;
  String name;
  // Define initiative state order
  int index;
  Map<String, int> color;



  String get colorHue => color[_colorHue].toString();

  String get colorSaturation => color[_colorSaturation].toString();

  String get colorLightness => color[_colorLightness].toString();

  State() {
    color = new Map();
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