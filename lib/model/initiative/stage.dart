// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'state.dart';

/// Domain model class to represent an initiative stage (activies, bucket or swimlanes)

class StageBase {
  String id;
}

class Stage extends StageBase {
  String id;

  String name;
  State state;

  // Define initiative state order
  int index;

  void cloneTo(Stage to) {
    to.id = this.id;
    to.name = this.name;
    to.index = this.index;

    if (this.state != null) {
      to.state = this.state.clone();
    }
  }

  Stage clone() {
    Stage to = new Stage();
    cloneTo(to);
    return to;
  }
}