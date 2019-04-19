// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:fixnum/fixnum.dart';

import 'package:auge_server/model/general/history_item.dart';
import 'package:auge_server/model/general/organization.dart';
import 'package:auge_server/model/general/user.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/general/group.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/objective/objective.pb.dart' as objective_pb;

/// Domain model class to represent an objective
class Objective {

  // Base
  static final String idField = 'Id';
  String id;
  int version;
  bool isDeleted;

  // Transient
  HistoryItem lastHistoryItem;

  // Specific
  static final String nameField = 'Name';
  String name;
  static final String descriptionField = 'Description';
  String description;
  static final String startDateField = 'Start Date';
  DateTime startDate;
  static final String endDateField = 'End Date';
  DateTime endDate;
  Organization organization;
  Group group;
  Objective alignedTo;
  static final String leaderField = 'Leader';
  User leader;
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

  objective_pb.Objective writeToProtoBuf() {
    objective_pb.Objective objectivePb = objective_pb.Objective();

    if (this.id != null) objectivePb.id = this.id;
    if (this.version != null) objectivePb.version = this.version;
    if (this.isDeleted != null) objectivePb.isDeleted = this.isDeleted;
    if (this.name != null) objectivePb.name = this.name;
    if (this.description != null) objectivePb.description = this.description;

    if (this.startDate != null) {
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.startDate.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      objectivePb.startDate = t;
    }

    if (this.endDate != null) {
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.endDate.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      objectivePb.endDate = t;
    }

    if (this.archived != null) objectivePb.archived = this.archived;
    if (this.organization != null) objectivePb.organization = this.organization.writeToProtoBuf();
    if (this.leader != null) objectivePb.leader = this.leader.writeToProtoBuf();

    return objectivePb;
  }

  readFromProtoBuf(objective_pb.Objective objectivePb) {
    if (objectivePb.hasId()) this.id = objectivePb.id;
    if (objectivePb.hasVersion()) this.version = objectivePb.version;
    if (objectivePb.hasIsDeleted()) this.isDeleted = objectivePb.isDeleted;
    if (objectivePb.hasName()) this.name = objectivePb.name;
    if (objectivePb.hasDescription()) this.description = objectivePb.description;
    if (objectivePb.hasArchived()) this.archived = objectivePb.archived;

    if (objectivePb.hasStartDate()) {
      this.startDate = DateTime.fromMicrosecondsSinceEpoch(objectivePb.startDate.seconds.toInt() * 1000000 + objectivePb.startDate.nanos ~/ 1000 );
    }

    if (objectivePb.hasEndDate()) {
      this.endDate = DateTime.fromMicrosecondsSinceEpoch(objectivePb.endDate.seconds.toInt() * 1000000 + objectivePb.endDate.nanos ~/ 1000 );
    }

    if (objectivePb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(objectivePb.organization);
    if (objectivePb.hasLeader()) this.leader = User()..readFromProtoBuf(objectivePb.leader);

  }
}

/// Facilities to [Objective] class
class ObjectiveFacilities {
  /// Delta diff between [current] and [previous] Objective.
  /// Like a document (json) idea, then just store user readly data, don't have IDs, FKs, etc.
  /// identification
  /// dataChanged
  ///
  /*
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
      difference[valuesKey][Objective.startDateField] = {currentDataChangedKey: current.startDate?.toIso8601String(), previousDataChangedKey: previous.startDate?.toIso8601String()};
    } else if (previous == null && current.startDate != null ) {
      difference[valuesKey][Objective.startDateField] = {currentDataChangedKey: current.startDate?.toIso8601String()};
    }

    //DateTime endDate;
    if (previous != null && current.endDate != previous.endDate) {
      difference[valuesKey][Objective.endDateField] = {currentDataChangedKey: current.endDate?.toIso8601String(), previousDataChangedKey: previous.endDate?.toIso8601String()};
    } else if (previous == null && current.endDate != null ) {
      difference[valuesKey][Objective.endDateField] = {currentDataChangedKey: current.endDate?.toIso8601String()};
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
  */
}