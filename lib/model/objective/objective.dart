// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:convert';

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
  User leader;
  List<Objective> alignedWithChildren;
  List<Measure> measures;

  List<TimelineItem> timeline;
  TimelineItem lastTimelineItem;

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
    to.lastTimelineItem = this.lastTimelineItem;
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

    if (this.leader != null) {
      to.leader = this.leader.clone();
    } else {
      to.leader = null;
    }

    if (this.alignedWithChildren != null && this.alignedWithChildren.length != 0) {
      to.alignedWithChildren.clear();
      this.alignedWithChildren.forEach((o) =>
          to.alignedWithChildren.add(o.clone()));
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
}

/// Related to [Objective] data model
/// Define the [Objective] essential attributes to exchange data between client and server on RPC
/// Used to POST and PUT
class ObjectiveMessage {
  String id;

  String name;
  String description;
  DateTime startDate;
  DateTime endDate;

  String organizationId;
  String groupId;
  String alignedToObjectiveId;
  String leaderId;

  TimelineItemMessage lastTimeLineItemMessage;
}

/// Facilities to [Objective] class
class ObjectiveFacilities {

  static ObjectiveMessage objectiveMessageFrom(Objective objective) {
    return new ObjectiveMessage()..id = objective.id
        ..name = objective.name
        ..description = objective.description
        ..startDate = objective.startDate
        ..endDate = objective.endDate
        ..organizationId = objective.organization.id
        ..groupId = objective.group.id
        ..alignedToObjectiveId = objective.alignedTo.id
        ..leaderId = objective.leader.id
        ..lastTimeLineItemMessage = TimeLineItemFacilities.timelineItemMessageFrom(objective.lastTimelineItem);
  }

  /// Delta diff between [current] and [previous] Objective.
  /// Like a document (json) idea, then just store user readly data, don't have IDs, FKs, etc.
  /// identification
  /// dataChanged
  static String differenceToJson(Objective current, Objective previous) {

    Map<String, Map<String, dynamic>> difference = Map();

    const identificationKey = 'identification';
    const changedDataKey = 'changedData';

    const idIdentificationKey = 'id';
    const nameIdentificationKey = 'name';

    const currentDataChangedKey = 'current';
    const previousDataChangedKey = 'previous';

    difference[identificationKey] = {idIdentificationKey: current.id};
    difference[identificationKey] = {nameIdentificationKey: current.name};

    // String name;
    if (previous != null && current.name != previous.name) {
      difference[changedDataKey] = {'name': {currentDataChangedKey: current.name, previousDataChangedKey: previous.name}};
    } else if (previous == null && current.name != null) {
      difference[changedDataKey] = {'name': {currentDataChangedKey: current.name}};
    }

    // String description;
    if (previous != null && current.description != previous.description) {
      difference[changedDataKey] =
      {'description': {currentDataChangedKey: current.description, previousDataChangedKey: previous.description}};
    } else if (previous == null && current.description != null ) {
      difference[changedDataKey] =
      {'description': {currentDataChangedKey: current.description}};
    }

    //DateTime startDate;
    if (previous != null && current.startDate != previous.startDate) {
      difference[changedDataKey] =
      {'startDate': {currentDataChangedKey: current.startDate.toString(), previousDataChangedKey: previous.startDate.toString()}};
    } else if (previous == null && current.startDate != null ) {
      difference[changedDataKey] =
      {'startDate': {currentDataChangedKey: current.startDate}};
    }

    //DateTime endDate;
    if (previous != null && current.endDate != previous.endDate) {
      difference[changedDataKey] =
      {'endDate': {currentDataChangedKey: current.endDate.toString(), previousDataChangedKey: previous.endDate.toString()}};
    } else if (previous == null && current.endDate != null ) {
      difference[changedDataKey] =
      {'endDate': {currentDataChangedKey: current.endDate.toString()}};
    }

    //Group group;
    if (previous != null && current.group?.id != previous.group?.id) {
      //difference['group.id'] =
      //{thisTerm: this.group?.id, compareToTerm: compareTo.group?.id};

      //Save just specitication.
      difference[changedDataKey] =
      {'group.name': {currentDataChangedKey: current.group?.name, previousDataChangedKey: previous.group?.name}};

    } else if (previous == null && current.group != null ) {
      difference[changedDataKey] =
      {'group.name': {currentDataChangedKey: current.group.name}};
    }

    //Objective alignedTo;
    if (previous != null && current.alignedTo.id != previous.alignedTo.id) {

      //Save just specitication.
      difference[changedDataKey] = {'alignedTo.name': {
        currentDataChangedKey: current.alignedTo.name,
        previousDataChangedKey: previous.alignedTo.name
      }};
    } else if (previous == null && current.alignedTo != null ) {

      difference[changedDataKey] = {'alignedTo.name': {
        currentDataChangedKey: current.alignedTo.name}};
    }

    //User leader;
    if (previous != null && current.leader.id != previous.leader.id) {

      difference[changedDataKey] =
      {'alignedTo.name': {currentDataChangedKey: current.leader.name, previousDataChangedKey: previous.leader.name}};
    } else if (previous == null && current.leader != null ) {

      difference[changedDataKey] =
      {'alignedTo.name': {currentDataChangedKey: current.leader.name}};
    }

    //List<Measure> measures;
    return json.encode(difference);
  }

  static Map<String, dynamic> differenceToMap(String jsonDifference) {
    return json.decode(jsonDifference, reviver: (k, v) {
      if (k == 'endDate' || k == 'startDate') {
        try {
          return Map()..[(v as Map).keys.first] = DateTime.parse((v as Map).values.first)
            ..[(v as Map).keys.last] = DateTime.parse((v as Map).values.last);
        } on FormatException {
          return v;
        }
      } else {
        return v;
      }
    });
  }
}
