// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:intl/intl.dart';

/// Domain model class to represent an measure
class Measure {

  String id;

  String name;
  String description;
  String metric;
  MeasureUnit measureUnit;
  int decimalsNumber;
  double startValue;
  double endValue;
  double currentValue;

  Measure() {
    decimalsNumber = 0; // default
  }

  double get minValue => startValue == null ? null : endValue == null ? endValue : startValue <= endValue ? startValue : endValue;
  set minValue(double value) => startValue <= endValue ? startValue = value : endValue = value;

  double get maxValue => startValue == null ? null : endValue == null ? endValue : startValue <= endValue ? endValue : startValue;
  set maxValue(double value) => startValue <= endValue ? endValue = value: startValue = value;

  double get valueRelatedMinMax => startValue == null ? null : endValue == null ? endValue : currentValue == null ? null : startValue <= endValue ? currentValue : startValue + endValue - currentValue;
 // set valueRelatedMinMax(double value) => startValue <= endValue ? currentValue = value : currentValue = startValue + endValue - value;

  num get progress {

    num progress = 0;
    if (endValue != null || startValue != null) {
      num endMinusStartValue = (endValue - startValue);

      if (endMinusStartValue != null && endMinusStartValue != 0) {
        progress =
            (((currentValue ?? 0) - (startValue ?? 0)) /
                endMinusStartValue * 100)
                ?.toInt();
      }
    }
    return progress;
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

class MeasureUnit {

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