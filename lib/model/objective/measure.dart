// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:fixnum/fixnum.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/objective/measure.pb.dart' as measure_pb;

/// Domain model class to represent an measure
class Measure {

  // Base - implements
  static final String idField = 'Id';
  String id;
  int version;

  // History
  // HistoryItem lastHistoryItem;

  // Specific
  static final String nameField = 'Name';
  String name;
  static final String descriptionField = 'Description';
  String description;
  static final String metricField = 'Metric';
  String metric;
  static final String decimalsNumberField = 'Decimals Number';
  int decimalsNumber;
  static final String startValueField = 'Start Value';
  double startValue;
  static final String endValueField = 'End Value';
  double endValue;
  static final String measureUnitField = 'Unit';
  MeasureUnit measureUnit;

  // Transient
  static final String currentValueField = 'Current  Value';
  double currentValue; // field calculeted on measureProgress

  List<MeasureProgress> measureProgress;

  Measure() {
    // lastHistoryItem = HistoryItem();
    measureUnit = MeasureUnit();
    measureProgress = <MeasureProgress>[];
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

  measure_pb.Measure writeToProtoBuf() {
    measure_pb.Measure measurePb = measure_pb.Measure();

    if (this.id != null) measurePb.id = this.id;
    if (this.version != null) measurePb.version = this.version;
    if (this.name != null) measurePb.name = this.name;
    if (this.description != null) measurePb.description = this.description;

    if (this.metric != null) measurePb.metric = this.metric;

    if (this.decimalsNumber != null) measurePb.decimalsNumber = this.decimalsNumber;
    if (this.startValue != null) measurePb.startValue = this.startValue;
    if (this.endValue != null) measurePb.endValue = this.endValue;
    if (this.currentValue != null) measurePb.currentValue = this.currentValue;
    if (this.measureUnit != null) measurePb.measureUnit = this.measureUnit.writeToProtoBuf();

    if (this.measureProgress != null && this.measureProgress.isNotEmpty) measurePb.measureProgress.addAll(this.measureProgress.map((m) => m.writeToProtoBuf()));

    return measurePb;
  }

  readFromProtoBuf(measure_pb.Measure measurePb) {
    if (measurePb.hasId()) this.id = measurePb.id;
    if (measurePb.hasVersion()) this.version = measurePb.version;
    if (measurePb.hasName()) this.name = measurePb.name;
    if (measurePb.hasDescription()) this.description = measurePb.description;

    if (measurePb.hasMetric()) this.metric = measurePb.metric;
    if (measurePb.hasDecimalsNumber()) this.decimalsNumber = measurePb.decimalsNumber;
    if (measurePb.hasStartValue()) this.startValue = measurePb.startValue;
    if (measurePb.hasEndValue()) this.endValue = measurePb.endValue;
    if (measurePb.hasCurrentValue()) this.currentValue = measurePb.currentValue;
    if (measurePb.hasMeasureUnit()) this.measureUnit = MeasureUnit()..readFromProtoBuf(measurePb.measureUnit);
    if (measurePb.measureProgress.isNotEmpty) this.measureProgress = measurePb.measureProgress.map((u) => MeasureProgress()..readFromProtoBuf(u)).toList();
  }
}

class MeasureProgress {
  // Base - implements
  String id;
  int version;
  bool isDeleted;

  // Base - History - Transient
  // REFACTOR HistoryItem lastHistoryItem;

  // Specific
  DateTime date;
  double currentValue;
  String comment;

  MeasureProgress() {
   // lastHistoryItem = HistoryItem();
  }

  measure_pb.MeasureProgress writeToProtoBuf() {
    measure_pb.MeasureProgress measureProgressPb = measure_pb.MeasureProgress();

    if (this.id != null) measureProgressPb.id = this.id;
    if (this.version != null) measureProgressPb.version = this.version;

    if (this.date != null) {
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.date.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      measureProgressPb.date = t;
    }

    if (this.currentValue != null) measureProgressPb.currentValue = this.currentValue;
    if (this.comment != null) measureProgressPb.comment = this.comment;

    return measureProgressPb;
  }

  readFromProtoBuf(measure_pb.MeasureProgress measureProgressPb) {
    if (measureProgressPb.hasId()) this.id = measureProgressPb.id;
    if (measureProgressPb.hasVersion()) this.version = measureProgressPb.version;
    if (measureProgressPb.hasDate()) this.date =  DateTime.fromMicrosecondsSinceEpoch(measureProgressPb.date.seconds.toInt() * 1000000 + measureProgressPb.date.nanos ~/ 1000 );
    if (measureProgressPb.hasCurrentValue()) this.currentValue = measureProgressPb.currentValue;
    if (measureProgressPb.hasComment()) this.comment = measureProgressPb.comment;
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

class MeasureUnit {

  String id;
  String symbol;
  String name;

  measure_pb.MeasureUnit writeToProtoBuf() {
    measure_pb.MeasureUnit measureUnitPb = measure_pb.MeasureUnit();

    if (this.id != null) measureUnitPb.id = this.id;
    if (this.symbol != null) measureUnitPb.symbol = this.symbol;
    if (this.name != null) measureUnitPb.name = this.name;

    return measureUnitPb;
  }

  readFromProtoBuf(measure_pb.MeasureUnit measureUnitPb) {
    if (measureUnitPb.hasId()) this.id = measureUnitPb.id;
    if (measureUnitPb.hasSymbol()) this.symbol = measureUnitPb.symbol;
    if (measureUnitPb.hasName()) this.name = measureUnitPb.name;
  }

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
/*
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
      difference[idsKey][Measure.idField] = {currentDataChangedKey: current.id, previousDataChangedKey: previous.id};
    } else if (previous == null && current.id != null) {
      difference[Measure.idField] = {currentDataChangedKey: current.id};
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
      difference[idsKey][MeasureProgress.idField] = {currentDataChangedKey: current.id, previousDataChangedKey: previous.id};
    } else if (previous == null && current.id != null) {
      difference[MeasureProgress.idField] = {currentDataChangedKey: current.id};
    }

    // String version;
    if (previous != null && current.version != previous.version) {
      difference[valuesKey][MeasureProgress.versionField] = {currentDataChangedKey: current.version, previousDataChangedKey: previous.version};
    } else if (previous == null && current.version != null) {
      difference[valuesKey][MeasureProgress.versionField] = {currentDataChangedKey: current.version};
    }

    // String description;
    if (previous != null && current.isDeleted != previous.isDeleted) {
      difference[valuesKey][MeasureProgress.isDeletedField] = {currentDataChangedKey: current.isDeleted, previousDataChangedKey: previous.isDeleted};
    } else if (previous == null && current.isDeleted != null ) {
      difference[valuesKey][MeasureProgress.isDeletedField] = {currentDataChangedKey: current.isDeleted};
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
  */
}