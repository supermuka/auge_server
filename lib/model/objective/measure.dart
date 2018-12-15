// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:convert';

import 'package:auge_server/model/model_base.dart';
import 'package:auge_server/model/history_item.dart';

/// Domain model class to represent an measure
class Measure implements Base {

  // Base - implements
  String id;
  int version;
  bool isDeleted;

  // History
  static const lastHistoryItemField = 'lastHistoryItem';
  HistoryItem lastHistoryItem;

  // Specific
  static const nameField = 'name';
  String name;
  static const descriptionField = 'description';
  String description;
  static const metricField = 'metric';
  String metric;
  static const decimalsNumberField = 'decimalsNumber';
  int decimalsNumber;
  static const startValueField = 'startValue';
  double startValue;
  static const endValueField = 'endValue';
  double endValue;
  static const measureUnitField = 'measureUnit';
  MeasureUnit measureUnit;

  // Transient
  static const currentValueField = 'currentValue';
  double currentValue; // field calculeted on measureProgress

  List<MeasureProgress> measureProgress;

  Measure() {
    lastHistoryItem = HistoryItem();
    measureUnit = MeasureUnit();
  }

  // NumberFormat _numberFormat;
  double get minValue => startValue == null || endValue == null ? null : startValue <= endValue ? num.tryParse(startValue.toStringAsFixed(decimalsNumber ?? 0)) : num.tryParse(endValue.toStringAsFixed(decimalsNumber ?? 0));
  set minValue(double value) => startValue <= endValue ? startValue = value : endValue = value;

  double get maxValue => startValue == null || endValue == null ? null : startValue <= endValue ? num.tryParse(endValue.toStringAsFixed(decimalsNumber ?? 0)) : num.tryParse(startValue.toStringAsFixed(decimalsNumber ?? 0));
  set maxValue(double value) => startValue <= endValue ? endValue = value: startValue = value;

  double get stepValue => decimalsNumber == null || decimalsNumber == 0 ? 1 : num.tryParse('.'.padRight(decimalsNumber,'0') + '1');

  double get valueRelatedMinMax => startValue == null ? null : endValue == null ? null : currentValue == null ? startValue <= endValue ? startValue : endValue : startValue <= endValue ? num.tryParse(currentValue.toStringAsFixed(decimalsNumber ?? 0)) : num.tryParse((startValue + endValue - currentValue).toStringAsFixed(decimalsNumber ?? 0));
  // set valueRelatedMinMax(double value) => startValue <= endValue ? currentValue = value : currentValue = startValue + endValue - value;

  int get progress {

    int _progress = 0;

    if (endValue != null && startValue != null) {
      double endMinusStartValue = (endValue - startValue);

      if (endMinusStartValue != null && endMinusStartValue != 0) {
        _progress =
            (((currentValue ?? startValue ?? 0) - (startValue ?? 0)) /
                endMinusStartValue * 100)
                ?.toInt();
      }
    }
    return _progress;
  }

  void cloneTo(Measure to) {
    to.name = this.name;
    to.id = this.id;
    to.description = this.description;
    to.metric = this.metric;
    to.decimalsNumber = this.decimalsNumber;
    to.startValue = this.startValue;
    to.endValue = this.endValue;
    to.currentValue = this.currentValue;
    if (this.measureUnit != null) {
      to.measureUnit = this.measureUnit.clone();
    }
  }

  Measure clone() {
    Measure to = new Measure();
    cloneTo(to);
    return to;
  }
}


class MeasureProgress implements Base {
  // Base - implements
  String id;
  int version;
  bool isDeleted;

  // Base - History - Transient
  static const lastHistoryItemField = 'lastHistoryItem';
  HistoryItem lastHistoryItem;

  // Specific
  static const dateField = 'date';
  DateTime date;
  static const currentValueField = 'current';
  double currentValue;
  static const commentField = 'comment';
  String comment;

  MeasureProgress() {
    lastHistoryItem = HistoryItem();
  }

  void cloneTo(MeasureProgress to) {
    to.id = this.id;
    to.date = this.date;
    to.currentValue = this.currentValue;
    to.comment = this.comment;
  }

  MeasureProgress clone() {
    MeasureProgress to = new MeasureProgress();
    cloneTo(to);
    return to;
  }
}

class MeasureUnitBase {
  String id;
}

class MeasureUnit implements MeasureUnitBase {

  static const idField = 'id';
  String id;

  static const symbolField = 'symbol';
  String symbol;
  static const nameField = 'name';
  String name;

  void cloneTo(MeasureUnit to) {
    to.id = this.id;
    to.name = this.name;
    to.symbol = this.symbol;
  }

  MeasureUnit clone() {
    MeasureUnit to = new MeasureUnit();
    cloneTo(to);
    return to;
  }
}


/// Facilities to [Measure] class
class MeasureFacilities {

  /// Delta diff between [current] and [previous].
  /// ids = A list from IDs changed.
  /// values =  Values (in user view) changed. ids and values are maintained in structure separately per performance reason (Json stored document strategy)
  static String differenceToJson(Measure current, Measure previous) {

    Map<String, Map<String, dynamic>> difference = Map();

    const idsKey = 'ids';
    const valuesKey = 'values';

    const currentDataChangedKey = 'current';
    const previousDataChangedKey = 'previous';

    difference[idsKey] = {};
    difference[valuesKey] = {};

    // String id;
    if (previous != null && current.id != previous.id) {
      difference[idsKey][Base.idField] = {currentDataChangedKey: current.id, previousDataChangedKey: previous.id};
    } else if (previous == null && current.id != null) {
      difference[Base.idField] = {currentDataChangedKey: current.id};
    }

    // String name;
    if (previous != null && current.name != previous.name) {
      difference[valuesKey][Measure.nameField] = {currentDataChangedKey: current.name, previousDataChangedKey: previous.name};
    } else if (previous == null && current.name != null) {
      difference[valuesKey][Measure.nameField] = {currentDataChangedKey: current.name};
    }

    // String description;
    if (previous != null && current.description != previous.description) {
      difference[valuesKey][Measure.descriptionField] = {currentDataChangedKey: current.description, previousDataChangedKey: previous.description};
    } else if (previous == null && current.description != null ) {
      difference[valuesKey][Measure.descriptionField] = {currentDataChangedKey: current.description};
    }

    // String metric;
    if (previous != null && current.metric != previous.metric) {
      difference[valuesKey][Measure.metricField] = {currentDataChangedKey: current.metric, previousDataChangedKey: previous.metric};
    } else if (previous == null && current.metric != null ) {
      difference[valuesKey][Measure.metricField] = {currentDataChangedKey: current.metric};
    }

    // MeasureUnit measureUnit - complex object - save id and specification name/description;

    if (previous != null && current.measureUnit.id != previous.measureUnit.id) {
      difference[idsKey][MeasureUnit.idField] = {currentDataChangedKey: current.measureUnit.id, previousDataChangedKey: previous.measureUnit.id};
      difference[valuesKey][Measure.measureUnitField] = {currentDataChangedKey: current.measureUnit.name, previousDataChangedKey: previous.measureUnit.name};
    } else if (previous == null && current.measureUnit != null ) {
      difference[idsKey][Measure.measureUnitField] = {currentDataChangedKey: current.measureUnit.id};
      difference[valuesKey][Measure.measureUnitField] = {currentDataChangedKey: current.measureUnit.name};
    }

    // int decimalsNumber;
    if (previous != null && current.decimalsNumber != previous.decimalsNumber) {
      difference[valuesKey][Measure.decimalsNumberField] = {currentDataChangedKey: current.decimalsNumber, previousDataChangedKey: previous.decimalsNumber};
    } else if (previous == null && current.decimalsNumber != null ) {
      difference[valuesKey][Measure.decimalsNumberField] = {currentDataChangedKey: current.decimalsNumber};
    }

    // double startValue;
    if (previous != null && current.startValue != previous.startValue) {
      difference[valuesKey][Measure.startValueField] = {currentDataChangedKey: current.startValue, previousDataChangedKey: previous.startValue};
    } else if (previous == null && current.startValue != null ) {
      difference[valuesKey][Measure.startValueField] = {currentDataChangedKey: current.startValue};
    }

    // double endValue;
    if (previous != null && current.endValue != previous.endValue) {
      difference[valuesKey][Measure.endValueField] = {currentDataChangedKey: current.endValue, previousDataChangedKey: previous.endValue};
    } else if (previous == null && current.endValue != null ) {
      difference[valuesKey][Measure.endValueField] = {currentDataChangedKey: current.endValue};
    }

    // double currentValue;
    if (previous != null && current.currentValue != previous.currentValue) {
      difference[valuesKey][Measure.endValueField] = {currentDataChangedKey: current.currentValue, previousDataChangedKey: previous.currentValue};
    } else if (previous == null && current.currentValue != null ) {
      difference[valuesKey][Measure.endValueField] = {currentDataChangedKey: current.currentValue};
    }

    //List<Measure> measures;
    return json.encode(difference);
  }

  static Map<String, dynamic> differenceToMap(String jsonDifference) {
    return json.decode(jsonDifference);
  }
}


/// Facilities to [MeasureProgress] class
class MeasureProgressFacilities {

  /// Delta diff between [current] and [previous].
  /// ids = A list from IDs changed.
  /// values =  Values (in user view) changed. ids and values are maintained in structure separately per performance reason (Json stored document strategy)
  static String differenceToJson(MeasureProgress current, MeasureProgress previous) {

    Map<String, Map<String, dynamic>> difference = Map();

    const idsKey = 'ids';
    const valuesKey = 'values';

    const currentDataChangedKey = 'current';
    const previousDataChangedKey = 'previous';

    difference[idsKey] = {};
    difference[valuesKey] = {};

    // String id;
    if (previous != null && current.id != previous.id) {
      difference[idsKey][Base.idField] = {currentDataChangedKey: current.id, previousDataChangedKey: previous.id};
    } else if (previous == null && current.id != null) {
      difference[Base.idField] = {currentDataChangedKey: current.id};
    }

    // String version;
    if (previous != null && current.version != previous.version) {
      difference[valuesKey][Base.versionField] = {currentDataChangedKey: current.version, previousDataChangedKey: previous.version};
    } else if (previous == null && current.version != null) {
      difference[valuesKey][Base.versionField] = {currentDataChangedKey: current.version};
    }

    // String description;
    if (previous != null && current.isDeleted != previous.isDeleted) {
      difference[valuesKey][Base.isDeletedField] = {currentDataChangedKey: current.isDeleted, previousDataChangedKey: previous.isDeleted};
    } else if (previous == null && current.isDeleted != null ) {
      difference[valuesKey][Base.isDeletedField] = {currentDataChangedKey: current.isDeleted};
    }

    // DateTime date;
    if (previous != null && current.date != previous.date) {
      difference[valuesKey][MeasureProgress.dateField] = {currentDataChangedKey: current.date, previousDataChangedKey: previous.date};
    } else if (previous == null && current.date != null ) {
      difference[valuesKey][MeasureProgress.dateField] = {currentDataChangedKey: current.date};
    }

    // double currentValue;
    if (previous != null && current.currentValue != previous.currentValue) {
      difference[valuesKey][MeasureProgress.currentValueField] = {currentDataChangedKey: current.currentValue, previousDataChangedKey: previous.currentValue};
    } else if (previous == null && current.currentValue != null ) {
      difference[valuesKey][MeasureProgress.currentValueField] = {currentDataChangedKey: current.currentValue};
    }

    // String comment;
    if (previous != null && current.comment != previous.comment) {
      difference[valuesKey][MeasureProgress.commentField] = {currentDataChangedKey: current.comment, previousDataChangedKey: previous.comment};
    } else if (previous == null && current.comment != null ) {
      difference[valuesKey][MeasureProgress.commentField] = {currentDataChangedKey: current.comment};
    }

    //List<Measure> measures;
    return json.encode(difference);
  }

  static Map<String, dynamic> differenceToMap(String jsonDifference) {
    return json.decode(jsonDifference);
  }


}

