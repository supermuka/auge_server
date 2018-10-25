// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel



import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/objective/timeline_item.dart';
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
  List<TimelineItem> timeline;

  Objective() {
    initializeDateFormatting(Intl.defaultLocale);

    alignedWithChildren = List<Objective>();
    measures = List<Measure>();
    timeline = List<TimelineItem>();
  }

  int get progress {

    double sumMeasuresProgress = 0.0;
    int countMeasuresProgress = 0;
    for (int i = 0;i < measures?.length;i++) {
      if (measures[i].endValue != null && measures[i].startValue != null && measures[i].currentValue != null ) {
        double endMinusStart = measures[i].endValue - measures[i].startValue;
        if (endMinusStart != 0) {
          sumMeasuresProgress = sumMeasuresProgress +
              (measures[i].currentValue - measures[i].startValue) / endMinusStart;
          countMeasuresProgress++;
        }
      }
    }
    return (countMeasuresProgress != 0) ? (sumMeasuresProgress / countMeasuresProgress * 100).toInt() : 0;
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

    if (this.measures != null && this.measures.length != 0) {
      to.measures.clear();
      this.measures.forEach((o) =>
          to.measures.add(o.clone()));
    }

    if (this.timeline != null && this.timeline.length != 0) {
      to.timeline.clear();
      this.timeline.forEach((o) =>
          to.timeline.add(o.clone()));
    }

  }

  Objective clone() {
    Objective to = new Objective();
    cloneTo(to);
    return to;
  }

  Map<String, Map<String, dynamic>> differenceComparedTo(Objective compareTo, {String thisTerm, String compareToTerm}) {

    Map<String, Map<String, dynamic>> difference = Map();
    // String id;

    if (thisTerm == null) thisTerm = 'this';
    if (compareToTerm == null) compareToTerm = 'compareTo';

    // String name;
    if (compareTo != null && this.name != compareTo.name) {
      difference['name'] = {thisTerm: this.name, compareToTerm: compareTo.name};
    } else if (compareTo == null && this.name != null) {
      difference['name'] = {thisTerm: this.name};
    }

/*
    // String description;
    if (compareTo != null && this.description != compareTo.description) {
      difference['description'] =
      {thisTerm: this.description, compareToTerm: compareTo.description};
    } else if (compareTo == null && this.description != null ) {
      difference['description'] =
      {thisTerm: this.description};
    }

    //DateTime startDate;
    if (compareTo != null && this.startDate != compareTo?.startDate) {
      difference['startDate'] =
      {thisTerm: this.startDate, compareToTerm: compareTo?.startDate};
    } else if (compareTo == null && this.startDate != null ) {
      difference['startDate'] =
      {thisTerm: this.startDate};
    }

    //DateTime endDate;
    if (compareTo != null && this.endDate != compareTo?.endDate) {
      difference['endDate'] =
      {thisTerm: this.endDate, compareToTerm: compareTo?.endDate};
    } else if (compareTo == null && this.endDate != null ) {
      difference['endDate'] =
      {thisTerm: this.endDate};
    }

    //Organization organization;
    if (compareTo != null && this.organization?.id != compareTo.organization?.id) {
      difference['organization.id'] = {
        thisTerm: this.organization?.id,
        compareToTerm: compareTo.organization?.id
      };

      //+ name, to have a user readly specification
      difference['organization.name'] = {
        thisTerm: this.organization?.name,
        compareToTerm: compareTo.organization?.name
      };
    } else if (compareTo == null && this.organization != null ) {
      difference['organization.id'] = {
        thisTerm: this.organization.id};

      //+ name, to have a user readly specification
      difference['organization.name'] = {
        thisTerm: this.organization.name
      };
    }

    //Group group;
    if (compareTo != null && this.group?.id != compareTo.group?.id) {
      difference['group.id'] =
      {thisTerm: this.group?.id, compareToTerm: compareTo.group?.id};

      //+ name, to have a user readly specification
      difference['group.name'] =
      {thisTerm: this.group?.name, compareToTerm: compareTo.group?.name};
    } else if (compareTo == null && this.group != null ) {
      difference['group.id'] =
      {thisTerm: this.group.id};

      //+ name, to have a user readly specification
      difference['group.name'] =
      {thisTerm: this.group.name};
    }

    //Objective alignedTo;
    if (compareTo != null && this.alignedTo?.id != compareTo?.alignedTo?.id) {
      difference['alignedTo.id'] =
      {thisTerm: this.alignedTo?.id, compareToTerm: compareTo?.alignedTo?.id};

      //+ name, to have a user readly specification
      difference['alignedTo.name'] = {
        thisTerm: this.alignedTo?.name,
        compareToTerm: compareTo?.alignedTo?.name
      };
    } else if (compareTo == null && this.alignedTo != null ) {
      difference['alignedTo.id'] =
      {thisTerm: this.alignedTo?.id};

      //+ name, to have a user readly specification
      difference['alignedTo.name'] = {
        thisTerm: this.alignedTo?.name};
    }

    //User leader;
    if (compareTo != null && this.leader?.id != compareTo.leader?.id) {
      difference['leader.id'] =
      {thisTerm: this.leader?.id, compareToTerm: compareTo.leader?.id};

      //+ name, to have a user readly specification
      difference['leader.name'] =
      {thisTerm: this.leader?.name, compareToTerm: compareTo.leader?.name};
    } else if (compareTo == null && this.leader != null ) {
      difference['leader.id'] =
      {thisTerm: this.leader?.id};

      //+ name, to have a user readly specification
      difference['leader.name'] =
      {thisTerm: this.leader?.name};
    }


    //List<Measure> measures;
*/
    return difference;

  }




}