// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

//import 'package:auge_shared/domain/general/unit_of_measurement.dart' as unit_of_measurement_m;

import 'package:grpc/grpc.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_shared/protos/generated/general/unit_of_measurement.pbgrpc.dart';

class UnitOfMeasurementService extends UnitOfMeasurementServiceBase {

  // API
  @override
  Future<UnitsOfMeasurementResponse> getUnitsOfMeasurement(ServiceCall call,
      Empty) async {
    UnitsOfMeasurementResponse unitsOfMeasurementResponse;
    unitsOfMeasurementResponse = UnitsOfMeasurementResponse()/*..webWorkAround = true*/
      ..unitsOfMeasurement.addAll(
          await querySelectUnitsOfMeasurement());
    return unitsOfMeasurementResponse;
  }


  // *** MEASURE UNITS ***
  // QUERY
  static final List<UnitOfMeasurement> unitsOfMeasurement = [UnitOfMeasurement()
  ..id = '33150116-f7d6-4cd3-97a5-dde573b5df60'
  ..symbol = 'i'
  ..name = 'index' // MeasureMessage.measureUnitLabel('Index')
  ,UnitOfMeasurement()
  ..id = 'fad0dc86-0124-4caa-9954-7526814efc3a'
  ..symbol = '\$'
  ..name = 'money' // MeasureMessage.measureUnitLabel('Money')
  ,UnitOfMeasurement()
  ..id = 'f748d3ad-b533-4a2d-b4ae-0ae1e255cf81'
  ..symbol = '%'
  ..name = 'percent' // MeasureMessage.measureUnitLabel('Percent')
  ,UnitOfMeasurement()
  ..id = '723f1387-d5da-44f7-8373-17de31921cae'
  ..symbol = 'u'
  ..name = 'unitary' // MeasureMessage.measureUnitLabel('Unitary')
  ,UnitOfMeasurement()
  ..id = '347488d9-9b25-4d8e-897d-958845763597'
  ..symbol = 'm'
  ..name = 'month' // MeasureMessage.measureUnitLabel('Unitary')
  ,UnitOfMeasurement()
  ..id = '819692ec-3640-4209-915a-4f3aee6d798e'
  ..symbol = 'd'
  ..name = 'day' // MeasureMessage.measureUnitLabel('Unitary')
  ,UnitOfMeasurement()
  ..id = '3ad31a95-bd08-48e0-80ab-0a9ee3c5e912'
  ..symbol = 'h'
  ..name = 'hour' // MeasureMessage.measureUnitLabel('Unitary')
  ];


  static Future<List<UnitOfMeasurement>> querySelectUnitsOfMeasurement({String id}) async {
    /*
    List<UnitOfMeasurement> unitsOfMeasurement = List();

    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = '33150116-f7d6-4cd3-97a5-dde573b5df60'
      ..symbol = 'i'
      ..name = 'index' // MeasureMessage.measureUnitLabel('Index')
    );
    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = 'fad0dc86-0124-4caa-9954-7526814efc3a'
      ..symbol = '\$'
      ..name = 'money' // MeasureMessage.measureUnitLabel('Money')
    );
    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = 'f748d3ad-b533-4a2d-b4ae-0ae1e255cf81'
      ..symbol = '%'
      ..name = 'percent' // MeasureMessage.measureUnitLabel('Percent')
    );
    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = '723f1387-d5da-44f7-8373-17de31921cae'
      ..symbol = 'u'
      ..name = 'unitary' // MeasureMessage.measureUnitLabel('Unitary')
    );
    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = '347488d9-9b25-4d8e-897d-958845763597'
      ..symbol = 'm'
      ..name = 'month' // MeasureMessage.measureUnitLabel('Unitary')
    );
    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = '819692ec-3640-4209-915a-4f3aee6d798e'
      ..symbol = 'd'
      ..name = 'day' // MeasureMessage.measureUnitLabel('Unitary')
    );
    unitsOfMeasurement.add(UnitOfMeasurement()
      ..id = '3ad31a95-bd08-48e0-80ab-0a9ee3c5e912'
      ..symbol = 'h'
      ..name = 'hour' // MeasureMessage.measureUnitLabel('Unitary')
    );
*/
    if (id == null) {
      return unitsOfMeasurement;
    } else {
      UnitOfMeasurement uom = unitsOfMeasurement.firstWhere((element) => element.id == id, orElse: () => null);
      return uom == null ? [] : [uom];
    }
    // return id == null ? unitsOfMeasurement : [unitsOfMeasurement.firstWhere((element) => element.id == id, orElse: () => null)];
  }
}
