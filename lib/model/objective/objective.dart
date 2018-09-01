// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/group.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Domain model class to represent an objective
class Objective {

  String id;

  String name;
  String description;
  DateTime startDate;
  DateTime endDate;

  Organization organization;
  Group group;
  Objective alignedTo;
  List<Objective> alignedWithChildren;
  User leader;

  List<Measure> measures;

  Objective() {
    initializeDateFormatting(Intl.defaultLocale);

    alignedWithChildren = new List<Objective>();
    measures = new List();
  }

  int get progress {

    double progress = 0.0;

    for (int i = 0;i < measures?.length;i++) {
      if ((measures[i]?.endValue ?? 0) - (measures[i]?.startValue ?? 0) != 00) {
        progress = progress +
            ((measures[i]?.currentValue ?? 0) - (measures[i]?.startValue ?? 0))  /  ((measures[i]?.endValue ?? 0) - (measures[i]?.startValue ?? 0));
      }
    }
    return measures.length == 0 ? 0 : ((progress * 100) / measures.length ).toInt();
  }

  void cloneTo(Objective to) {
    to.id = this.id;
    to.name = this.name;
    to.description = this.description;
    to.startDate = this.startDate;
    to.endDate = this.endDate;
    if (this.organization != null) {
      to.organization = this.organization.clone();
    }
    if (this.group != null) {
      to.group = this.group.clone();
    } else {
      to.group = null;
    }

    if (this.alignedTo != null) {
      to.alignedTo = this.alignedTo.clone();
    } else {
      to.alignedTo = null;
    }

    if (this.alignedWithChildren != null && this.alignedWithChildren.length != 0) {
      to.alignedWithChildren.clear();
      this.alignedWithChildren.forEach((o) =>
          to.alignedWithChildren.add(o.clone()));
    }

    if (this.leader != null) {
      to.leader = this.leader.clone();
    } else {
      to.leader = null;
    }
  }

  Objective clone() {
    Objective to = new Objective();
    cloneTo(to);
    return to;
  }
}