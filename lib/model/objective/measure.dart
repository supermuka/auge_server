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
  /*
  int get decimalsNumber => _decimalsNumber;
  set decimalsNumber(int decimalsNumber) {
    _decimalsNumber = decimalsNumber;
    // _numberFormat = NumberFormat('#,##0' + ((decimalsNumber != null && decimalsNumber > 0) ? '.' .padRight(decimalsNumber + 1, '0') : ''), 'en_US');
  }
  */

  double startValue;
  double endValue;
  double currentValue;

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