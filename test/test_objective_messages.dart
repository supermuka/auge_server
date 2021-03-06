import 'package:test/test.dart';

import 'package:auge_shared/protos/generated/objective/objective_measure.pb.dart' as objective_measure_pb;

import 'package:auge_shared/domain/general/unit_of_measurement.dart' as unit_of_measurement_m;
import 'package:auge_shared/domain/objective/objective.dart' as objective_m;
import 'package:auge_shared/domain/objective/measure.dart' as measure_m;

void main() {

  group('Test Objective Messages.', ()
  {
    setUp(() {

    });

    tearDown(() async {

    });

    group('OBJECTIVE.', () {

      objective_m.Objective model = objective_m.Objective();
      objective_measure_pb.Objective proto;

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.description = 'Description test';
        model.startDate = DateTime.now();
        model.endDate = DateTime.now();
        model.archived = false;
      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));

        expect(model.startDate, DateTime.fromMicrosecondsSinceEpoch(
            proto.startDate.seconds.toInt() * 1000000 +
                proto.startDate.nanos ~/ 1000));
        expect(model.archived, equals(proto.archived));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = objective_m.ObjectiveHelper.writeToProtoBuf(model);

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        Map<String, dynamic> cache;

        model = objective_m.ObjectiveHelper.readFromProtoBuf(proto, cache);

        callExcept();
      });
/*
      test('Call fromProtoBufToModelMap.', () async {
        Map<String, dynamic> m = objective_m.Objective.fromProtoBufToModelMap(proto);

        expect(m[objective_m.Objective.idField], equals(proto.id));
        expect(m[objective_m.Objective.versionField], equals(proto.version));
        expect(m[objective_m.Objective.nameField], equals(proto.name));
        expect(m[objective_m.Objective.descriptionField], equals(proto.description));
        expect(m[objective_m.Objective.startDateField], equals(proto.startDate));
        expect(m[objective_m.Objective.archivedField], equals(proto.archived));

      });
*/
    });

    group('MEASURE.', () {

      measure_m.Measure model = measure_m.Measure();
      objective_measure_pb.Measure proto;

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.description = 'Description test';
        model.currentValue = 1;
        model.metric = 'KG';
        model.endValue = 10;
        model.startValue = 0;
        model.decimalsNumber = 2;
        model.unitOfMeasurement = unit_of_measurement_m.UnitOfMeasurement()
          ..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'
          ..name = 'Description test'
          ..symbol = 'Kg';
        model.measureProgress.add(measure_m.MeasureProgress()
          ..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'
          ..version = 0
          ..currentValue = 1
          ..date = DateTime.now()
          ..comment = 'Comment Test');
      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));
        expect(model.currentValue, equals(proto.currentValue));
        expect(model.metric, equals(proto.metric));
        expect(model.endValue, equals(proto.endValue));
        expect(model.startValue, equals(proto.startValue));
        expect(model.decimalsNumber, equals(proto.decimalsNumber));
        expect(model.unitOfMeasurement.id, equals(proto.unitOfMeasurement.id));
        expect(model.unitOfMeasurement.name, equals(proto.unitOfMeasurement.name));
        expect(model.unitOfMeasurement.symbol, equals(proto.unitOfMeasurement.symbol));
        expect(model.measureProgress.first.id, equals(proto.measureProgress.first.id));
        expect(model.measureProgress.first.version, equals(proto.measureProgress.first.version));
        expect(model.measureProgress.first.currentValue, equals(proto.measureProgress.first.currentValue));
        expect(model.measureProgress.first.comment, equals(proto.measureProgress.first.comment));
        expect(model.measureProgress.first.date, equals(DateTime.fromMicrosecondsSinceEpoch(
            proto.measureProgress.first.date.seconds.toInt() * 1000000 +
                proto.measureProgress.first.date.nanos ~/ 1000)));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = measure_m.MeasureHelper.writeToProtoBuf(model);

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        Map<String, dynamic> cache;
        model = measure_m.Measure();
        model = measure_m.MeasureHelper.readFromProtoBuf(proto, cache);

        callExcept();
      });
/*
      test('Call fromProtoBufToModelMap.', () async {
        Map<String, dynamic> m = measure_m.Measure.fromProtoBufToModelMap(proto);

        expect(m[measure_m.Measure.idField], equals(proto.id));
        expect(m[measure_m.Measure.versionField], equals(proto.version));
        expect(m[measure_m.Measure.nameField], equals(proto.name));
        expect(m[measure_m.Measure.descriptionField], equals(proto.description));
        expect(m[measure_m.Measure.currentValueField], equals(proto.currentValue));
        expect(m[measure_m.Measure.metricField], equals(proto.metric));
        expect(m[measure_m.Measure.endValueField], equals(proto.endValue));
        expect(m[measure_m.Measure.startValueField], equals(proto.startValue));
        expect(m[measure_m.Measure.decimalsNumberField], equals(proto.decimalsNumber));
        expect(m[measure_m.Measure.unitOfMeasurementField][unit_of_measurement_m.UnitOfMeasurement.idField], equals(proto.unitOfMeasurement.id));
        expect(m[measure_m.Measure.unitOfMeasurementField][unit_of_measurement_m.UnitOfMeasurement.nameField], equals(proto.unitOfMeasurement.name));
        expect(m[measure_m.Measure.unitOfMeasurementField][unit_of_measurement_m.UnitOfMeasurement.symbolField], equals(proto.unitOfMeasurement.symbol));
        expect(m[measure_m.Measure.measureProgressField].first[measure_m.MeasureProgress.idField], equals(proto.measureProgress.first.id));
        expect(m[measure_m.Measure.measureProgressField].first[measure_m.MeasureProgress.versionField], equals(proto.measureProgress.first.version));
        expect(m[measure_m.Measure.measureProgressField].first[measure_m.MeasureProgress.currentValueField], equals(proto.measureProgress.first.currentValue));
        expect(m[measure_m.Measure.measureProgressField].first[measure_m.MeasureProgress.commentField], equals(proto.measureProgress.first.comment));
        expect(m[measure_m.Measure.measureProgressField].first[measure_m.MeasureProgress.dateField], equals(proto.measureProgress.first.date));
      });

 */
    });
  });
}