///
//  Generated code. Do not modify.
//  source: objective/objective_measure.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'objective_measure.pb.dart' as $5;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'objective_measure.pb.dart';

class ObjectiveServiceClient extends $grpc.Client {
  static final _$getObjectives =
      $grpc.ClientMethod<$5.ObjectiveGetRequest, $5.ObjectivesResponse>(
          '/auge.protobuf.ObjectiveService/GetObjectives',
          ($5.ObjectiveGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.ObjectivesResponse.fromBuffer(value));
  static final _$getObjective =
      $grpc.ClientMethod<$5.ObjectiveGetRequest, $5.Objective>(
          '/auge.protobuf.ObjectiveService/GetObjective',
          ($5.ObjectiveGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.Objective.fromBuffer(value));
  static final _$createObjective =
      $grpc.ClientMethod<$5.ObjectiveRequest, $1.StringValue>(
          '/auge.protobuf.ObjectiveService/CreateObjective',
          ($5.ObjectiveRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateObjective =
      $grpc.ClientMethod<$5.ObjectiveRequest, $2.Empty>(
          '/auge.protobuf.ObjectiveService/UpdateObjective',
          ($5.ObjectiveRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteObjective =
      $grpc.ClientMethod<$5.ObjectiveDeleteRequest, $2.Empty>(
          '/auge.protobuf.ObjectiveService/DeleteObjective',
          ($5.ObjectiveDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  ObjectiveServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$5.ObjectivesResponse> getObjectives(
      $5.ObjectiveGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getObjectives, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$5.Objective> getObjective(
      $5.ObjectiveGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getObjective, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createObjective(
      $5.ObjectiveRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createObjective, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateObjective($5.ObjectiveRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateObjective, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteObjective(
      $5.ObjectiveDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteObjective, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class ObjectiveServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.ObjectiveService';

  ObjectiveServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$5.ObjectiveGetRequest, $5.ObjectivesResponse>(
            'GetObjectives',
            getObjectives_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.ObjectiveGetRequest.fromBuffer(value),
            ($5.ObjectivesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ObjectiveGetRequest, $5.Objective>(
        'GetObjective',
        getObjective_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.ObjectiveGetRequest.fromBuffer(value),
        ($5.Objective value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ObjectiveRequest, $1.StringValue>(
        'CreateObjective',
        createObjective_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ObjectiveRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ObjectiveRequest, $2.Empty>(
        'UpdateObjective',
        updateObjective_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ObjectiveRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ObjectiveDeleteRequest, $2.Empty>(
        'DeleteObjective',
        deleteObjective_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.ObjectiveDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$5.ObjectivesResponse> getObjectives_Pre($grpc.ServiceCall call,
      $async.Future<$5.ObjectiveGetRequest> request) async {
    return getObjectives(call, await request);
  }

  $async.Future<$5.Objective> getObjective_Pre($grpc.ServiceCall call,
      $async.Future<$5.ObjectiveGetRequest> request) async {
    return getObjective(call, await request);
  }

  $async.Future<$1.StringValue> createObjective_Pre($grpc.ServiceCall call,
      $async.Future<$5.ObjectiveRequest> request) async {
    return createObjective(call, await request);
  }

  $async.Future<$2.Empty> updateObjective_Pre($grpc.ServiceCall call,
      $async.Future<$5.ObjectiveRequest> request) async {
    return updateObjective(call, await request);
  }

  $async.Future<$2.Empty> deleteObjective_Pre($grpc.ServiceCall call,
      $async.Future<$5.ObjectiveDeleteRequest> request) async {
    return deleteObjective(call, await request);
  }

  $async.Future<$5.ObjectivesResponse> getObjectives(
      $grpc.ServiceCall call, $5.ObjectiveGetRequest request);
  $async.Future<$5.Objective> getObjective(
      $grpc.ServiceCall call, $5.ObjectiveGetRequest request);
  $async.Future<$1.StringValue> createObjective(
      $grpc.ServiceCall call, $5.ObjectiveRequest request);
  $async.Future<$2.Empty> updateObjective(
      $grpc.ServiceCall call, $5.ObjectiveRequest request);
  $async.Future<$2.Empty> deleteObjective(
      $grpc.ServiceCall call, $5.ObjectiveDeleteRequest request);
}

class MeasureServiceClient extends $grpc.Client {
  static final _$getMeasures =
      $grpc.ClientMethod<$5.MeasureGetRequest, $5.MeasuresResponse>(
          '/auge.protobuf.MeasureService/GetMeasures',
          ($5.MeasureGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.MeasuresResponse.fromBuffer(value));
  static final _$getMeasure =
      $grpc.ClientMethod<$5.MeasureGetRequest, $5.Measure>(
          '/auge.protobuf.MeasureService/GetMeasure',
          ($5.MeasureGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.Measure.fromBuffer(value));
  static final _$createMeasure =
      $grpc.ClientMethod<$5.MeasureRequest, $1.StringValue>(
          '/auge.protobuf.MeasureService/CreateMeasure',
          ($5.MeasureRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateMeasure =
      $grpc.ClientMethod<$5.MeasureRequest, $2.Empty>(
          '/auge.protobuf.MeasureService/UpdateMeasure',
          ($5.MeasureRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteMeasure =
      $grpc.ClientMethod<$5.MeasureDeleteRequest, $2.Empty>(
          '/auge.protobuf.MeasureService/DeleteMeasure',
          ($5.MeasureDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$getMeasureUnits =
      $grpc.ClientMethod<$2.Empty, $5.MeasureUnitsResponse>(
          '/auge.protobuf.MeasureService/GetMeasureUnits',
          ($2.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.MeasureUnitsResponse.fromBuffer(value));
  static final _$getMeasureProgresses = $grpc.ClientMethod<
          $5.MeasureProgressGetRequest, $5.MeasureProgressesResponse>(
      '/auge.protobuf.MeasureService/GetMeasureProgresses',
      ($5.MeasureProgressGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $5.MeasureProgressesResponse.fromBuffer(value));
  static final _$getMeasureProgress =
      $grpc.ClientMethod<$5.MeasureProgressGetRequest, $5.MeasureProgress>(
          '/auge.protobuf.MeasureService/GetMeasureProgress',
          ($5.MeasureProgressGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.MeasureProgress.fromBuffer(value));
  static final _$createMeasureProgress =
      $grpc.ClientMethod<$5.MeasureProgressRequest, $1.StringValue>(
          '/auge.protobuf.MeasureService/CreateMeasureProgress',
          ($5.MeasureProgressRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateMeasureProgress =
      $grpc.ClientMethod<$5.MeasureProgressRequest, $2.Empty>(
          '/auge.protobuf.MeasureService/UpdateMeasureProgress',
          ($5.MeasureProgressRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteMeasureProgress =
      $grpc.ClientMethod<$5.MeasureProgressDeleteRequest, $2.Empty>(
          '/auge.protobuf.MeasureService/DeleteMeasureProgress',
          ($5.MeasureProgressDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  MeasureServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$5.MeasuresResponse> getMeasures(
      $5.MeasureGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getMeasures, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$5.Measure> getMeasure($5.MeasureGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getMeasure, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createMeasure($5.MeasureRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createMeasure, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateMeasure($5.MeasureRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateMeasure, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteMeasure($5.MeasureDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteMeasure, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$5.MeasureUnitsResponse> getMeasureUnits(
      $2.Empty request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getMeasureUnits, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$5.MeasureProgressesResponse> getMeasureProgresses(
      $5.MeasureProgressGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getMeasureProgresses, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$5.MeasureProgress> getMeasureProgress(
      $5.MeasureProgressGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getMeasureProgress, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createMeasureProgress(
      $5.MeasureProgressRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createMeasureProgress, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateMeasureProgress(
      $5.MeasureProgressRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateMeasureProgress, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteMeasureProgress(
      $5.MeasureProgressDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteMeasureProgress, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class MeasureServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.MeasureService';

  MeasureServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.MeasureGetRequest, $5.MeasuresResponse>(
        'GetMeasures',
        getMeasures_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MeasureGetRequest.fromBuffer(value),
        ($5.MeasuresResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureGetRequest, $5.Measure>(
        'GetMeasure',
        getMeasure_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MeasureGetRequest.fromBuffer(value),
        ($5.Measure value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureRequest, $1.StringValue>(
        'CreateMeasure',
        createMeasure_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MeasureRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureRequest, $2.Empty>(
        'UpdateMeasure',
        updateMeasure_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MeasureRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureDeleteRequest, $2.Empty>(
        'DeleteMeasure',
        deleteMeasure_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.MeasureDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $5.MeasureUnitsResponse>(
        'GetMeasureUnits',
        getMeasureUnits_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($5.MeasureUnitsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureProgressGetRequest,
            $5.MeasureProgressesResponse>(
        'GetMeasureProgresses',
        getMeasureProgresses_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.MeasureProgressGetRequest.fromBuffer(value),
        ($5.MeasureProgressesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.MeasureProgressGetRequest, $5.MeasureProgress>(
            'GetMeasureProgress',
            getMeasureProgress_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.MeasureProgressGetRequest.fromBuffer(value),
            ($5.MeasureProgress value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureProgressRequest, $1.StringValue>(
        'CreateMeasureProgress',
        createMeasureProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.MeasureProgressRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureProgressRequest, $2.Empty>(
        'UpdateMeasureProgress',
        updateMeasureProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.MeasureProgressRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MeasureProgressDeleteRequest, $2.Empty>(
        'DeleteMeasureProgress',
        deleteMeasureProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.MeasureProgressDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$5.MeasuresResponse> getMeasures_Pre($grpc.ServiceCall call,
      $async.Future<$5.MeasureGetRequest> request) async {
    return getMeasures(call, await request);
  }

  $async.Future<$5.Measure> getMeasure_Pre($grpc.ServiceCall call,
      $async.Future<$5.MeasureGetRequest> request) async {
    return getMeasure(call, await request);
  }

  $async.Future<$1.StringValue> createMeasure_Pre(
      $grpc.ServiceCall call, $async.Future<$5.MeasureRequest> request) async {
    return createMeasure(call, await request);
  }

  $async.Future<$2.Empty> updateMeasure_Pre(
      $grpc.ServiceCall call, $async.Future<$5.MeasureRequest> request) async {
    return updateMeasure(call, await request);
  }

  $async.Future<$2.Empty> deleteMeasure_Pre($grpc.ServiceCall call,
      $async.Future<$5.MeasureDeleteRequest> request) async {
    return deleteMeasure(call, await request);
  }

  $async.Future<$5.MeasureUnitsResponse> getMeasureUnits_Pre(
      $grpc.ServiceCall call, $async.Future<$2.Empty> request) async {
    return getMeasureUnits(call, await request);
  }

  $async.Future<$5.MeasureProgressesResponse> getMeasureProgresses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.MeasureProgressGetRequest> request) async {
    return getMeasureProgresses(call, await request);
  }

  $async.Future<$5.MeasureProgress> getMeasureProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.MeasureProgressGetRequest> request) async {
    return getMeasureProgress(call, await request);
  }

  $async.Future<$1.StringValue> createMeasureProgress_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.MeasureProgressRequest> request) async {
    return createMeasureProgress(call, await request);
  }

  $async.Future<$2.Empty> updateMeasureProgress_Pre($grpc.ServiceCall call,
      $async.Future<$5.MeasureProgressRequest> request) async {
    return updateMeasureProgress(call, await request);
  }

  $async.Future<$2.Empty> deleteMeasureProgress_Pre($grpc.ServiceCall call,
      $async.Future<$5.MeasureProgressDeleteRequest> request) async {
    return deleteMeasureProgress(call, await request);
  }

  $async.Future<$5.MeasuresResponse> getMeasures(
      $grpc.ServiceCall call, $5.MeasureGetRequest request);
  $async.Future<$5.Measure> getMeasure(
      $grpc.ServiceCall call, $5.MeasureGetRequest request);
  $async.Future<$1.StringValue> createMeasure(
      $grpc.ServiceCall call, $5.MeasureRequest request);
  $async.Future<$2.Empty> updateMeasure(
      $grpc.ServiceCall call, $5.MeasureRequest request);
  $async.Future<$2.Empty> deleteMeasure(
      $grpc.ServiceCall call, $5.MeasureDeleteRequest request);
  $async.Future<$5.MeasureUnitsResponse> getMeasureUnits(
      $grpc.ServiceCall call, $2.Empty request);
  $async.Future<$5.MeasureProgressesResponse> getMeasureProgresses(
      $grpc.ServiceCall call, $5.MeasureProgressGetRequest request);
  $async.Future<$5.MeasureProgress> getMeasureProgress(
      $grpc.ServiceCall call, $5.MeasureProgressGetRequest request);
  $async.Future<$1.StringValue> createMeasureProgress(
      $grpc.ServiceCall call, $5.MeasureProgressRequest request);
  $async.Future<$2.Empty> updateMeasureProgress(
      $grpc.ServiceCall call, $5.MeasureProgressRequest request);
  $async.Future<$2.Empty> deleteMeasureProgress(
      $grpc.ServiceCall call, $5.MeasureProgressDeleteRequest request);
}
