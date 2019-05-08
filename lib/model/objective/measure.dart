// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/objective/measure.pb.dart' as measure_pb;

/// Domain model class to represent an measure
class Measure {
  static final String className = 'Measure';

  // Base - implements
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // History
  // HistoryItem lastHistoryItem;

  // Specific
  static final String nameField = 'name';
  String name;
  static final String descriptionField = 'Description';
  String description;
  static final String metricField = 'metric';
  String metric;
  static final String decimalsNumberField = 'decimalsNumber';
  int decimalsNumber;
  static final String startValueField = 'startValue';
  double startValue;
  static final String endValueField = 'endValue';
  double endValue;
  static final String measureUnitField = 'unit';
  MeasureUnit measureUnit;

  // Transient
  static final String currentValueField = 'currentValue';
  double currentValue; // field calculeted on measureProgress
  static final String measureProgressField = 'measureProgress';
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

  static Map<String, dynamic> fromProtoBufToModelMap(measure_pb.Measure measurePb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (measurePb.hasId())
        map[Measure.idField] = measurePb.id;
      if (measurePb.hasName())
        map[Measure.nameField] = measurePb.name;
    } else {
      if (measurePb.hasId())
        map[Measure.idField] = measurePb.id;
      if (measurePb.hasVersion())
        map[Measure.versionField] = measurePb.version;
      if (measurePb.hasName())
        map[Measure.nameField] = measurePb.name;
      if (measurePb.hasDescription())
        map[Measure.descriptionField] = measurePb.description;
      if (measurePb.hasMetric())
        map[Measure.metricField] = measurePb.metric;
      if (measurePb.hasDecimalsNumber())
        map[Measure.decimalsNumberField] = measurePb.decimalsNumber;
      if (measurePb.hasStartValue())
        map[Measure.startValueField] = measurePb.startValue;
      if (measurePb.hasEndValue())
        map[Measure.endValueField] = measurePb.endValue;
      if (measurePb.hasCurrentValue())
        map[Measure.currentValueField] = measurePb.currentValue;
      if (measurePb.hasMeasureUnit())
        map[Measure.measureUnitField] = MeasureUnit.fromProtoBufToModelMap(
            measurePb.measureUnit, onlyIdAndSpecificationForDepthFields, true);
      if (measurePb.measureProgress.isNotEmpty)
        map[Measure.measureProgressField] =
            measurePb.measureProgress.map((mp) =>
                MeasureProgress.fromProtoBufToModelMap(mp, onlyIdAndSpecificationForDepthFields, true)).toList();
    }

    return map;
  }
}

class MeasureProgress {
  static final String className = 'MeasureProgress';

  // Base - implements
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;
  static final String isDeletedField = 'isDeleted';
  bool isDeleted;

  // Base - History - Transient
  // REFACTOR HistoryItem lastHistoryItem;

  // Specific
  static final String dateField = 'date';
  DateTime date;
  static final String currentValueField = 'currentValue';
  double currentValue;
  static final String commentField = 'comment';
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
      int microsecondsSinceEpoch = this.date
          .toUtc()
          .microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      measureProgressPb.date = t;
    }

    if (this.currentValue != null)
      measureProgressPb.currentValue = this.currentValue;
    if (this.comment != null) measureProgressPb.comment = this.comment;

    return measureProgressPb;
  }

  readFromProtoBuf(measure_pb.MeasureProgress measureProgressPb) {
    if (measureProgressPb.hasId()) this.id = measureProgressPb.id;
    if (measureProgressPb.hasVersion())
      this.version = measureProgressPb.version;
    if (measureProgressPb.hasDate()) this.date =
        DateTime.fromMicrosecondsSinceEpoch(
            measureProgressPb.date.seconds.toInt() * 1000000 +
                measureProgressPb.date.nanos ~/ 1000);
    if (measureProgressPb.hasCurrentValue())
      this.currentValue = measureProgressPb.currentValue;
    if (measureProgressPb.hasComment())
      this.comment = measureProgressPb.comment;
  }

  static Map<String, dynamic> fromProtoBufToModelMap(measure_pb.MeasureProgress measureProgressPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (measureProgressPb.hasId())
        map[MeasureProgress.idField] = measureProgressPb.id;
      if (measureProgressPb.hasComment())
        map[MeasureProgress.commentField] = measureProgressPb.comment;
    } else {
      if (measureProgressPb.hasId())
        map[MeasureProgress.idField] = measureProgressPb.id;
      if (measureProgressPb.hasVersion())
        map[MeasureProgress.versionField] = measureProgressPb.version;
      if (measureProgressPb.hasDate())
        map[MeasureProgress.dateField] = measureProgressPb.date;
      if (measureProgressPb.hasCurrentValue())
        map[MeasureProgress.currentValueField] = measureProgressPb.currentValue;
      if (measureProgressPb.hasComment())
        map[MeasureProgress.commentField] = measureProgressPb.comment;
    }
    return map;
  }
}

class MeasureUnit {
  static final String className = 'MeasureUnit';

  static const idField = 'id';
  String id;
  static const symbolField = 'symbol';
  String symbol;
  static const nameField = 'name';
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

  static Map<String, dynamic> fromProtoBufToModelMap(measure_pb.MeasureUnit measureUnitPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (measureUnitPb.hasId()) map[MeasureUnit.idField] = measureUnitPb.id;
      if (measureUnitPb.hasName())
        map[MeasureUnit.nameField] = measureUnitPb.name;
    } else {
      if (measureUnitPb.hasId()) map[MeasureUnit.idField] = measureUnitPb.id;
      if (measureUnitPb.hasSymbol())
        map[MeasureUnit.symbolField] = measureUnitPb.symbol;
      if (measureUnitPb.hasName())
        map[MeasureUnit.nameField] = measureUnitPb.name;
    }
    return map;
  }
}