import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/objective/objective.pb.dart' as objective_pb;
import 'package:auge_server/src/protos/generated/objective/measure.pb.dart' as measure_pb;

import 'package:auge_server/model/objective/objective.dart' as objective_m;
import 'package:auge_server/model/objective/measure.dart' as measure_m;

void main() {

  group('Test Objective Messages.', ()
  {
    setUp(() {

    });

    tearDown(() async {

    });

    group('OBJECTIVE.', () {

      objective_m.Objective model = objective_m.Objective();

      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.isDeleted = true;
      model.name = 'Name test';
      model.description = 'Description test';
      model.startDate = DateTime.now();
      model.endDate = DateTime.now();
      model.archived = false;

      objective_pb.Objective proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.isDeleted, equals(proto.isDeleted));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));

        expect(model.startDate, DateTime.fromMicrosecondsSinceEpoch(
            proto.startDate.seconds.toInt() * 1000000 +
                proto.startDate.nanos ~/ 1000));
        expect(model.archived, equals(proto.archived));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = objective_m.Objective();
        model.readFromProtoBuf(proto);

        callExcept();
      });
    });

    group('MEASURE.', () {

      measure_m.Measure model = measure_m.Measure();

      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.isDeleted = true;
      model.name = 'Name test';
      model.description = 'Description test';
      model.currentValue = 1;
      model.metric = 'KG';
      model.endValue = 10;
      model.startValue = 0;
      model.decimalsNumber = 2;
      model.measureUnit = measure_m.MeasureUnit()
        ..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'
        ..name = 'Description test'
        ..symbol = 'Kg';
      model.measureProgress.add(measure_m.MeasureProgress()
        ..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'
        ..version = 0
        ..isDeleted = false
        ..currentValue = 1
        ..date = DateTime.now()
        ..comment = 'Comment Test');

      measure_pb.Measure proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.isDeleted, equals(proto.isDeleted));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));
        expect(model.currentValue, equals(proto.currentValue));
        expect(model.metric, equals(proto.metric));
        expect(model.endValue, equals(proto.endValue));
        expect(model.startValue, equals(proto.startValue));
        expect(model.decimalsNumber, equals(proto.decimalsNumber));
        expect(model.measureUnit.id, equals(proto.measureUnit.id));
        expect(model.measureUnit.name, equals(proto.measureUnit.name));
        expect(model.measureUnit.symbol, equals(proto.measureUnit.symbol));
        expect(model.measureProgress.first.id, equals(proto.measureProgress.first.id));
        expect(model.measureProgress.first.version, equals(proto.measureProgress.first.version));
        expect(model.measureProgress.first.isDeleted, equals(proto.measureProgress.first.isDeleted));
        expect(model.measureProgress.first.currentValue, equals(proto.measureProgress.first.currentValue));
        expect(model.measureProgress.first.comment, equals(proto.measureProgress.first.comment));
        expect(model.measureProgress.first.date, equals(DateTime.fromMicrosecondsSinceEpoch(
            proto.measureProgress.first.date.seconds.toInt() * 1000000 +
                proto.measureProgress.first.date.nanos ~/ 1000)));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = measure_m.Measure();
        model.readFromProtoBuf(proto);

        callExcept();
      });
    });
  });
}