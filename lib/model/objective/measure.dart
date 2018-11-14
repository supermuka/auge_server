// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:convert';

/// Domain model class to represent an measure
class MeasureBase {
  String id;
}

class Measure implements MeasureBase {

  String id;
  String name;
  String description;
  String metric;
  int decimalsNumber;
  double startValue;
  double endValue;
  double currentValue;

  MeasureUnit measureUnit;

  List<MeasureProgress> measureProgress;

 // NumberFormat _numberFormat;

  double get minValue => startValue == null ? null : endValue == null ? endValue : startValue <= endValue ? num.tryParse(startValue.toStringAsFixed(decimalsNumber ?? 0)) : num.tryParse(endValue.toStringAsFixed(decimalsNumber ?? 0));
  set minValue(double value) => startValue <= endValue ? startValue = value : endValue = value;

  double get maxValue => startValue == null ? null : endValue == null ? endValue : startValue <= endValue ? num.tryParse(endValue.toStringAsFixed(decimalsNumber ?? 0)) : num.tryParse(startValue.toStringAsFixed(decimalsNumber ?? 0));
  set maxValue(double value) => startValue <= endValue ? endValue = value: startValue = value;

  double get stepValue => decimalsNumber == null || decimalsNumber == 0 ? 1 : num.tryParse('.'.padRight(decimalsNumber,'0') + '1');

  double get valueRelatedMinMax => startValue == null ? null : endValue == null ? endValue : currentValue == null ? null : startValue <= endValue ? num.tryParse(currentValue.toStringAsFixed(decimalsNumber ?? 0)) : num.tryParse((startValue + endValue - currentValue).toStringAsFixed(decimalsNumber ?? 0));
  // set valueRelatedMinMax(double value) => startValue <= endValue ? currentValue = value : currentValue = startValue + endValue - value;

  /*
  String get startValueStr => startValue == null ? null : _numberFormat.format(startValue);
  set startValueStr(String startValueStr) {
    startValue = _numberFormat.parse(startValueStr);
  }

  String get endValueStr => endValue == null ? null : _numberFormat.format(endValue);
  set endValueStr(String endValueStr) {
    endValue = _numberFormat.parse(endValueStr);
  }

  String get currentValueStr => currentValue == null ? null : _numberFormat.format(currentValue);
  set currentValueStr(String currentValueStr) {
    currentValue = _numberFormat.parse(currentValueStr);
  }
  */

  int get progress {

    int _progress = 0;

    if (endValue != null && startValue != null) {
      double endMinusStartValue = (endValue - startValue);

      if (endMinusStartValue != null && endMinusStartValue != 0) {
        _progress =
            (((currentValue ?? 0) - (startValue ?? 0)) /
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

class MeasureProgressBase {
  String id;

}

class MeasureProgress implements MeasureProgressBase {
  String id;
  DateTime dateTime;
  double currentValue;
  String comment;

  void cloneTo(MeasureProgress to) {
    to.id = this.id;
    to.dateTime = this.dateTime;
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

class MeasureUnitPersistent implements MeasureUnitBase {
  String id;
}

class MeasureUnit implements MeasureUnitPersistent {

  String id;

  String symbol;
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
  /// Like a document (json) idea, then just store user readly data, don't have IDs, FKs, etc.
  /// identification
  /// dataChanged
  static String differenceToJson(Measure current, Measure previous) {

    Map<String, Map<String, dynamic>> difference = Map();

    const identificationKey = 'identification';
    const dataChangedKey = 'dataChanged';

    const idIdentificationKey = 'id';
    const nameIdentificationKey = 'name';

    const currentDataChangedKey = 'current';
    const previousDataChangedKey = 'previous';

    difference[identificationKey] = {idIdentificationKey: current.id};
    difference[identificationKey] = {nameIdentificationKey: current.name};

    // String name;
    if (previous != null && current.name != previous.name) {
      difference[dataChangedKey] = {'name': {currentDataChangedKey: current.name, previousDataChangedKey: previous.name}};
    } else if (previous == null && current.name != null) {
      difference[dataChangedKey] = {'name': {currentDataChangedKey: current.name}};
    }

    // String description;
    if (previous != null && current.description != previous.description) {
      difference[dataChangedKey] =
      {'description': {currentDataChangedKey: current.description, previousDataChangedKey: previous.description}};
    } else if (previous == null && current.description != null ) {
      difference[dataChangedKey] =
      {'description': {currentDataChangedKey: current.description}};
    }

    // String metric;
    if (previous != null && current.metric != previous.metric) {
      difference[dataChangedKey] =
      {'metric': {currentDataChangedKey: current.metric, previousDataChangedKey: previous.metric}};
    } else if (previous == null && current.metric != null ) {
      difference[dataChangedKey] =
      {'metric': {currentDataChangedKey: current.metric}};
    }

    // MeasureUnit measureUnit;
    if (previous != null && current.measureUnit.name != previous.measureUnit.name) {
      difference[dataChangedKey] =
      {'measureUnit.name': {currentDataChangedKey: current.measureUnit.name, previousDataChangedKey: previous.measureUnit.name}};
    } else if (previous == null && current.measureUnit.name != null ) {
      difference[dataChangedKey] =
      {'measureUnit.name': {currentDataChangedKey: current.measureUnit.name}};
    }

    // int decimalsNumber;
    if (previous != null && current.decimalsNumber != previous.decimalsNumber) {
      difference[dataChangedKey] =
      {'decimalsNumber': {currentDataChangedKey: current.decimalsNumber, previousDataChangedKey: previous.decimalsNumber}};
    } else if (previous == null && current.decimalsNumber != null ) {
      difference[dataChangedKey] =
      {'decimalsNumber': {currentDataChangedKey: current.decimalsNumber}};
    }

    // double startValue;
    if (previous != null && current.startValue != previous.startValue) {
      difference[dataChangedKey] =
      {'startValue': {currentDataChangedKey: current.startValue, previousDataChangedKey: previous.startValue}};
    } else if (previous == null && current.startValue != null ) {
      difference[dataChangedKey] =
      {'startValue': {currentDataChangedKey: current.startValue}};
    }

    // double endValue;
    if (previous != null && current.endValue != previous.endValue) {
      difference[dataChangedKey] =
      {'endValue': {currentDataChangedKey: current.endValue, previousDataChangedKey: previous.endValue}};
    } else if (previous == null && current.endValue != null ) {
      difference[dataChangedKey] =
      {'endValue': {currentDataChangedKey: current.endValue}};
    }

    // double currentValue;
    if (previous != null && current.currentValue != previous.currentValue) {
      difference[dataChangedKey] =
      {'currentValue': {currentDataChangedKey: current.currentValue, previousDataChangedKey: previous.currentValue}};
    } else if (previous == null && current.currentValue != null ) {
      difference[dataChangedKey] =
      {'currentValue': {currentDataChangedKey: current.currentValue}};
    }

    //List<Measure> measures;
    return json.encode(difference);
  }

  static Map<String, dynamic> differenceToMap(String jsonDifference) {
    return json.decode(jsonDifference);
  }
}
