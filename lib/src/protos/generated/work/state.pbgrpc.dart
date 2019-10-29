///
//  Generated code. Do not modify.
//  source: work/state.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import '../google/protobuf/empty.pb.dart' as $0;
import 'state.pb.dart' as $1;
export 'state.pb.dart';

class StateServiceClient extends $grpc.Client {
  static final _$getStates = $grpc.ClientMethod<$0.Empty, $1.StatesResponse>(
      '/auge.protobuf.StateService/GetStates',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StatesResponse.fromBuffer(value));
  static final _$getState = $grpc.ClientMethod<$1.StateGetRequest, $1.State>(
      '/auge.protobuf.StateService/GetState',
      ($1.StateGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.State.fromBuffer(value));

  StateServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.StatesResponse> getStates($0.Empty request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getStates, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.State> getState($1.StateGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getState, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class StateServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.StateService';

  StateServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.StatesResponse>(
        'GetStates',
        getStates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.StatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.StateGetRequest, $1.State>(
        'GetState',
        getState_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.StateGetRequest.fromBuffer(value),
        ($1.State value) => value.writeToBuffer()));
  }

  $async.Future<$1.StatesResponse> getStates_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getStates(call, await request);
  }

  $async.Future<$1.State> getState_Pre(
      $grpc.ServiceCall call, $async.Future<$1.StateGetRequest> request) async {
    return getState(call, await request);
  }

  $async.Future<$1.StatesResponse> getStates(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.State> getState(
      $grpc.ServiceCall call, $1.StateGetRequest request);
}
