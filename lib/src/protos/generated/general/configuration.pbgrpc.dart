///
//  Generated code. Do not modify.
//  source: general/configuration.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'configuration.pb.dart' as $3;
import '../google/protobuf/wrappers.pb.dart' as $4;
import '../google/protobuf/empty.pb.dart' as $2;
export 'configuration.pb.dart';

class ConfigurationServiceClient extends $grpc.Client {
  static final _$getConfiguration =
      $grpc.ClientMethod<$3.ConfigurationGetRequest, $3.Configuration>(
          '/auge.protobuf.ConfigurationService/GetConfiguration',
          ($3.ConfigurationGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.Configuration.fromBuffer(value));
  static final _$createConfiguration =
      $grpc.ClientMethod<$3.ConfigurationRequest, $4.StringValue>(
          '/auge.protobuf.ConfigurationService/CreateConfiguration',
          ($3.ConfigurationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.StringValue.fromBuffer(value));
  static final _$updateConfiguration =
      $grpc.ClientMethod<$3.ConfigurationRequest, $2.Empty>(
          '/auge.protobuf.ConfigurationService/UpdateConfiguration',
          ($3.ConfigurationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$testDirectoryService =
      $grpc.ClientMethod<$3.ConfigurationRequest, $4.Int32Value>(
          '/auge.protobuf.ConfigurationService/TestDirectoryService',
          ($3.ConfigurationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.Int32Value.fromBuffer(value));

  ConfigurationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$3.Configuration> getConfiguration(
      $3.ConfigurationGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getConfiguration, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$4.StringValue> createConfiguration(
      $3.ConfigurationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createConfiguration, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateConfiguration(
      $3.ConfigurationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateConfiguration, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$4.Int32Value> testDirectoryService(
      $3.ConfigurationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$testDirectoryService, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class ConfigurationServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.ConfigurationService';

  ConfigurationServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$3.ConfigurationGetRequest, $3.Configuration>(
            'GetConfiguration',
            getConfiguration_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.ConfigurationGetRequest.fromBuffer(value),
            ($3.Configuration value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ConfigurationRequest, $4.StringValue>(
        'CreateConfiguration',
        createConfiguration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.ConfigurationRequest.fromBuffer(value),
        ($4.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ConfigurationRequest, $2.Empty>(
        'UpdateConfiguration',
        updateConfiguration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.ConfigurationRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ConfigurationRequest, $4.Int32Value>(
        'TestDirectoryService',
        testDirectoryService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.ConfigurationRequest.fromBuffer(value),
        ($4.Int32Value value) => value.writeToBuffer()));
  }

  $async.Future<$3.Configuration> getConfiguration_Pre($grpc.ServiceCall call,
      $async.Future<$3.ConfigurationGetRequest> request) async {
    return getConfiguration(call, await request);
  }

  $async.Future<$4.StringValue> createConfiguration_Pre($grpc.ServiceCall call,
      $async.Future<$3.ConfigurationRequest> request) async {
    return createConfiguration(call, await request);
  }

  $async.Future<$2.Empty> updateConfiguration_Pre($grpc.ServiceCall call,
      $async.Future<$3.ConfigurationRequest> request) async {
    return updateConfiguration(call, await request);
  }

  $async.Future<$4.Int32Value> testDirectoryService_Pre($grpc.ServiceCall call,
      $async.Future<$3.ConfigurationRequest> request) async {
    return testDirectoryService(call, await request);
  }

  $async.Future<$3.Configuration> getConfiguration(
      $grpc.ServiceCall call, $3.ConfigurationGetRequest request);
  $async.Future<$4.StringValue> createConfiguration(
      $grpc.ServiceCall call, $3.ConfigurationRequest request);
  $async.Future<$2.Empty> updateConfiguration(
      $grpc.ServiceCall call, $3.ConfigurationRequest request);
  $async.Future<$4.Int32Value> testDirectoryService(
      $grpc.ServiceCall call, $3.ConfigurationRequest request);
}
