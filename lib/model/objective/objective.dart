// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:convert';

import 'package:auge_server/model/model_base.dart';
import 'package:auge_server/model/history_item.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/group.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Domain model class to represent an objective
class Objective implements Base {

  // Base
  static const idField = 'id';
  String id;
  static const versionField = 'version';
  int version;
  static const isDeletedField = 'isDeleted';
  bool isDeleted;

  // Transient
  static const lastHistoryItemField = 'lastHistoryItem';
  HistoryItem lastHistoryItem;

  // Specific
  static const nameField = 'name';
  String name;
  static const descriptionField = 'description';
  String description;
  static const startDateField = 'startDate';
  DateTime startDate;
  static const endDateField = 'endDate';
  DateTime endDate;
  static const organizationField = 'organization';
  Organization organization;
  static const groupField = 'group';
  Group group;
  static const alignedToField = 'alignedTo';
  Objective alignedTo;
  static const leaderField = 'leader';
  User leader;
  static const archivedField = 'archived';
  bool archived;

  // Transients fields
  List<Objective> alignedWithChildren;
  List<Measure> measures;
  List<HistoryItem> history;

  Objective() {
    initializeDateFormatting(Intl.defaultLocale);

    lastHistoryItem = HistoryItem();
    alignedWithChildren = List<Objective>();
    measures = List<Measure>();
    history = List<HistoryItem>();
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
    to.lastHistoryItem = this.lastHistoryItem;
    to.archived = this.archived;
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

    if (this.history != null && this.history.length != 0) {
      to.history.clear();
      this.history.forEach((o) =>
          to.history.add(o));
    }
  }

  Objective clone() {
    Objective to = new Objective();
    cloneTo(to);
    return to;
  }
}

/*
/// Related to [Objective] data model
/// Define the [Objective] essential attributes to exchange data between client and server on RPC
/// Used to POST and PUT
class ObjectiveMessage {

  String id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;

  OrganizationBase organization;
  GroupBase group;
  ObjectiveBase alignedTo;
  UserBase leader;

  TimelineItemMessage lastTimelineItemMessage;

  // Transients fields
  // List<Objective> alignedWithChildren;
  // List<Measure> measures;
  // List<TimelineItem> timeline;

}
*/

/// Facilities to [Objective] class
class ObjectiveFacilities {
/*
  static ObjectiveMessage messageFrom(Objective objective) {
    return ObjectiveMessage()
      ..id = objective.id
      ..name = objective.name
      ..description = objective.description
      ..startDate = objective.startDate
      ..endDate = objective.endDate
      ..lastTimelineItemMessage = TimeLineItemFacilities.timelineItemMessageFrom(objective.lastTimelineItem)
      // Just id
      ..organization = OrganizationBase()..id = objective.organization.id
      ..group = GroupBase()..id = objective.group.id
      ..alignedTo = ObjectiveBase()..id = objective.alignedTo.id
      ..leader = UserBase()..id = objective.leader.id;

  }
  */

  /// Delta diff between [current] and [previous] Objective.
  /// Like a document (json) idea, then just store user readly data, don't have IDs, FKs, etc.
  /// identification
  /// dataChanged
  static String differenceToJson(Objective current, Objective previous) {

    Map<String, Map<String, dynamic>> difference = Map();

    const idsKey = 'ids';
    const valuesKey = 'values';

    const currentDataChangedKey = 'current';
    const previousDataChangedKey = 'previous';

    difference[idsKey] = {};
    difference[valuesKey] = {};

    // String id;
    if (previous != null  && current.id != previous.id) {
      difference[idsKey][Objective.idField] =  {currentDataChangedKey: current.id, previousDataChangedKey: previous.id};
    } else if (previous == null && current.id != null) {
      difference[idsKey][Objective.idField] = {currentDataChangedKey: current.id};
    }

    // String name;
    if (previous != null && current.name != previous.name) {
      difference[valuesKey][Objective.nameField] =  {currentDataChangedKey: current.name, previousDataChangedKey: previous.name};
    } else if (previous == null && current.name != null) {
      difference[valuesKey][Objective.nameField] = {currentDataChangedKey: current.name};
    }

    // String description;
    if (previous != null && current.description != previous.description) {
      difference[valuesKey][Objective.descriptionField] = {currentDataChangedKey: current.description, previousDataChangedKey: previous.description};
    } else if (previous == null && current.description != null ) {
      difference[valuesKey][Objective.descriptionField] = {currentDataChangedKey: current.description};
    }

    //DateTime startDate;
    if (previous != null && current.startDate != previous.startDate) {
      difference[valuesKey][Objective.startDateField] = {currentDataChangedKey: current.startDate.toIso8601String(), previousDataChangedKey: previous.startDate.toIso8601String()};
    } else if (previous == null && current.startDate != null ) {
      difference[valuesKey][Objective.startDateField] = {currentDataChangedKey: current.startDate.toIso8601String()};
    }

    //DateTime endDate;
    if (previous != null && current.endDate != previous.endDate) {
      difference[valuesKey][Objective.endDateField] = {currentDataChangedKey: current.endDate.toIso8601String(), previousDataChangedKey: previous.endDate.toIso8601String()};
    } else if (previous == null && current.endDate != null ) {
      difference[valuesKey][Objective.endDateField] = {currentDataChangedKey: current.endDate.toIso8601String()};
    }

    //Group group;
    if (previous != null && current.group?.id != previous.group?.id) {
      difference[valuesKey][Objective.groupField] = {currentDataChangedKey: current.group?.name, previousDataChangedKey: previous.group?.name};

    } else if (previous == null && current.group != null ) {
      difference[valuesKey][Objective.groupField] = {currentDataChangedKey: current.group.name};
    }

    //Objective alignedTo;
    if (previous != null && current.alignedTo?.id != previous.alignedTo?.id) {

      //Save just specitication.

      difference[valuesKey][Objective.alignedToField] = {
        currentDataChangedKey: current.alignedTo?.name,
        previousDataChangedKey: previous.alignedTo?.name
      };
    } else if (previous == null && current.alignedTo != null ) {

      difference[valuesKey][Objective.alignedToField] = {
        currentDataChangedKey: current.alignedTo.name};
    }

    //User leader;
    if (previous != null && current.leader?.id != previous.leader?.id) {

      difference[valuesKey][Objective.leaderField] = {currentDataChangedKey: current.leader?.name, previousDataChangedKey: previous.leader?.name};
    } else if (previous == null && current.leader != null ) {
      difference[valuesKey][Objective.leaderField] = {currentDataChangedKey: current.leader.name};
    }

    //List<Measure> measures;
    return json.encode(difference);
  }

  static Map<String, dynamic> differenceToMap(String jsonDifference) {
    return json.decode(jsonDifference, reviver: (k, v) {
      if (k == Objective.endDateField || k == Objective.startDateField) {
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