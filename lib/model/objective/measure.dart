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

  int get startValueInt => startValue?.toInt();
  set startValueInt(int value) => startValue = value?.toDouble();

  int get endValueInt => endValue?.toInt();
  set endValueInt(int value) => endValue = value?.toDouble();

  int get currentValueInt => currentValue?.toInt();
  set currentValueInt(int value) => currentValue = value?.toDouble();

  double get startValueDecimal => startValue == null ? null : double.parse(startValue.toStringAsFixed(decimalsNumber));
  set startValueDecimal(double value) => startValue = value;

  double get endValueDecimal => endValue == null ? null : double.parse(endValue.toStringAsFixed(decimalsNumber));
  set endValueDecimal(double value) => endValue = value;

  double get currentValueDecimal => currentValue == null ? null : double.parse(currentValue.toStringAsFixed(decimalsNumber));
  set currentValueDecimal(double value) => currentValue = value;

  int get progress {

    int progress = 0;
    if (endValueInt != null || startValueInt != null) {
      int endMinusStartValue = (endValueInt - startValueInt);

      if (endMinusStartValue != null && endMinusStartValue != 0) {
        progress =
            (((currentValueInt ?? 0) - (startValueInt ?? 0)) /
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