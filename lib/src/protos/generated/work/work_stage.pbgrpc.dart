///
//  Generated code. Do not modify.
//  source: work/work_stage.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'work_stage.pb.dart' as $0;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'work_stage.pb.dart';

class WorkStageServiceClient extends $grpc.Client {
  static final _$getWorkStages =
      $grpc.ClientMethod<$0.WorkStageGetRequest, $0.WorkStagesResponse>(
          '/auge.protobuf.WorkStageService/GetWorkStages',
          ($0.WorkStageGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WorkStagesResponse.fromBuffer(value));
  static final _$getWorkStage =
      $grpc.ClientMethod<$0.WorkStageGetRequest, $0.WorkStage>(
          '/auge.protobuf.WorkStageService/GetWorkStage',
          ($0.WorkStageGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.WorkStage.fromBuffer(value));
  static final _$createWorkStage =
      $grpc.ClientMethod<$0.WorkStageRequest, $1.StringValue>(
          '/auge.protobuf.WorkStageService/CreateWorkStage',
          ($0.WorkStageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateWorkStage =
      $grpc.ClientMethod<$0.WorkStageRequest, $2.Empty>(
          '/auge.protobuf.WorkStageService/UpdateWorkStage',
          ($0.WorkStageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteWorkStage =
      $grpc.ClientMethod<$0.WorkStageDeleteRequest, $2.Empty>(
          '/auge.protobuf.WorkStageService/DeleteWorkStage',
          ($0.WorkStageDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  WorkStageServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.WorkStagesResponse> getWorkStages(
      $0.WorkStageGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkStages, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.WorkStage> getWorkStage(
      $0.WorkStageGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkStage, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createWorkStage(
      $0.WorkStageRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createWorkStage, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateWorkStage($0.WorkStageRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateWorkStage, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteWorkStage(
      $0.WorkStageDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteWorkStage, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class WorkStageServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.WorkStageService';

  WorkStageServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.WorkStageGetRequest, $0.WorkStagesResponse>(
            'GetWorkStages',
            getWorkStages_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.WorkStageGetRequest.fromBuffer(value),
            ($0.WorkStagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkStageGetRequest, $0.WorkStage>(
        'GetWorkStage',
        getWorkStage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WorkStageGetRequest.fromBuffer(value),
        ($0.WorkStage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkStageRequest, $1.StringValue>(
        'CreateWorkStage',
        createWorkStage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkStageRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkStageRequest, $2.Empty>(
        'UpdateWorkStage',
        updateWorkStage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkStageRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkStageDeleteRequest, $2.Empty>(
        'DeleteWorkStage',
        deleteWorkStage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WorkStageDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.WorkStagesResponse> getWorkStages_Pre($grpc.ServiceCall call,
      $async.Future<$0.WorkStageGetRequest> request) async {
    return getWorkStages(call, await request);
  }

  $async.Future<$0.WorkStage> getWorkStage_Pre($grpc.ServiceCall call,
      $async.Future<$0.WorkStageGetRequest> request) async {
    return getWorkStage(call, await request);
  }

  $async.Future<$1.StringValue> createWorkStage_Pre($grpc.ServiceCall call,
      $async.Future<$0.WorkStageRequest> request) async {
    return createWorkStage(call, await request);
  }

  $async.Future<$2.Empty> updateWorkStage_Pre($grpc.ServiceCall call,
      $async.Future<$0.WorkStageRequest> request) async {
    return updateWorkStage(call, await request);
  }

  $async.Future<$2.Empty> deleteWorkStage_Pre($grpc.ServiceCall call,
      $async.Future<$0.WorkStageDeleteRequest> request) async {
    return deleteWorkStage(call, await request);
  }

  $async.Future<$0.WorkStagesResponse> getWorkStages(
      $grpc.ServiceCall call, $0.WorkStageGetRequest request);
  $async.Future<$0.WorkStage> getWorkStage(
      $grpc.ServiceCall call, $0.WorkStageGetRequest request);
  $async.Future<$1.StringValue> createWorkStage(
      $grpc.ServiceCall call, $0.WorkStageRequest request);
  $async.Future<$2.Empty> updateWorkStage(
      $grpc.ServiceCall call, $0.WorkStageRequest request);
  $async.Future<$2.Empty> deleteWorkStage(
      $grpc.ServiceCall call, $0.WorkStageDeleteRequest request);
}
