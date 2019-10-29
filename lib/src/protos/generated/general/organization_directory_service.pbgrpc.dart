///
//  Generated code. Do not modify.
//  source: general/organization_directory_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'organization_directory_service.pb.dart' as $3;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'organization_directory_service.pb.dart';

class OrganizationDirectoryServiceServiceClient extends $grpc.Client {
  static final _$getOrganizationDirectoryService = $grpc.ClientMethod<
          $3.OrganizationDirectoryServiceGetRequest,
          $3.OrganizationDirectoryService>(
      '/auge.protobuf.OrganizationDirectoryServiceService/GetOrganizationDirectoryService',
      ($3.OrganizationDirectoryServiceGetRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.OrganizationDirectoryService.fromBuffer(value));
  static final _$createOrganizationDirectoryService = $grpc.ClientMethod<
          $3.OrganizationDirectoryServiceRequest, $1.StringValue>(
      '/auge.protobuf.OrganizationDirectoryServiceService/CreateOrganizationDirectoryService',
      ($3.OrganizationDirectoryServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateOrganizationDirectoryService = $grpc.ClientMethod<
          $3.OrganizationDirectoryServiceRequest, $2.Empty>(
      '/auge.protobuf.OrganizationDirectoryServiceService/UpdateOrganizationDirectoryService',
      ($3.OrganizationDirectoryServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$testOrganizationDirectoryService = $grpc.ClientMethod<
          $3.OrganizationDirectoryServiceRequest, $1.Int32Value>(
      '/auge.protobuf.OrganizationDirectoryServiceService/TestOrganizationDirectoryService',
      ($3.OrganizationDirectoryServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Int32Value.fromBuffer(value));
  static final _$syncOrganizationDirectoryService = $grpc.ClientMethod<
          $3.OrganizationDirectoryServiceRequest, $1.Int32Value>(
      '/auge.protobuf.OrganizationDirectoryServiceService/SyncOrganizationDirectoryService',
      ($3.OrganizationDirectoryServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Int32Value.fromBuffer(value));

  OrganizationDirectoryServiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$3.OrganizationDirectoryService>
      getOrganizationDirectoryService(
          $3.OrganizationDirectoryServiceGetRequest request,
          {$grpc.CallOptions options}) {
    final call = $createCall(_$getOrganizationDirectoryService,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createOrganizationDirectoryService(
      $3.OrganizationDirectoryServiceRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$createOrganizationDirectoryService,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateOrganizationDirectoryService(
      $3.OrganizationDirectoryServiceRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$updateOrganizationDirectoryService,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.Int32Value> testOrganizationDirectoryService(
      $3.OrganizationDirectoryServiceRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$testOrganizationDirectoryService,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.Int32Value> syncOrganizationDirectoryService(
      $3.OrganizationDirectoryServiceRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$syncOrganizationDirectoryService,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class OrganizationDirectoryServiceServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.OrganizationDirectoryServiceService';

  OrganizationDirectoryServiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.OrganizationDirectoryServiceGetRequest,
            $3.OrganizationDirectoryService>(
        'GetOrganizationDirectoryService',
        getOrganizationDirectoryService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.OrganizationDirectoryServiceGetRequest.fromBuffer(value),
        ($3.OrganizationDirectoryService value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.OrganizationDirectoryServiceRequest,
            $1.StringValue>(
        'CreateOrganizationDirectoryService',
        createOrganizationDirectoryService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.OrganizationDirectoryServiceRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.OrganizationDirectoryServiceRequest, $2.Empty>(
            'UpdateOrganizationDirectoryService',
            updateOrganizationDirectoryService_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.OrganizationDirectoryServiceRequest.fromBuffer(value),
            ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.OrganizationDirectoryServiceRequest,
            $1.Int32Value>(
        'TestOrganizationDirectoryService',
        testOrganizationDirectoryService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.OrganizationDirectoryServiceRequest.fromBuffer(value),
        ($1.Int32Value value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.OrganizationDirectoryServiceRequest,
            $1.Int32Value>(
        'SyncOrganizationDirectoryService',
        syncOrganizationDirectoryService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.OrganizationDirectoryServiceRequest.fromBuffer(value),
        ($1.Int32Value value) => value.writeToBuffer()));
  }

  $async.Future<$3.OrganizationDirectoryService>
      getOrganizationDirectoryService_Pre(
          $grpc.ServiceCall call,
          $async.Future<$3.OrganizationDirectoryServiceGetRequest>
              request) async {
    return getOrganizationDirectoryService(call, await request);
  }

  $async.Future<$1.StringValue> createOrganizationDirectoryService_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationDirectoryServiceRequest> request) async {
    return createOrganizationDirectoryService(call, await request);
  }

  $async.Future<$2.Empty> updateOrganizationDirectoryService_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationDirectoryServiceRequest> request) async {
    return updateOrganizationDirectoryService(call, await request);
  }

  $async.Future<$1.Int32Value> testOrganizationDirectoryService_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationDirectoryServiceRequest> request) async {
    return testOrganizationDirectoryService(call, await request);
  }

  $async.Future<$1.Int32Value> syncOrganizationDirectoryService_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationDirectoryServiceRequest> request) async {
    return syncOrganizationDirectoryService(call, await request);
  }

  $async.Future<$3.OrganizationDirectoryService>
      getOrganizationDirectoryService($grpc.ServiceCall call,
          $3.OrganizationDirectoryServiceGetRequest request);
  $async.Future<$1.StringValue> createOrganizationDirectoryService(
      $grpc.ServiceCall call, $3.OrganizationDirectoryServiceRequest request);
  $async.Future<$2.Empty> updateOrganizationDirectoryService(
      $grpc.ServiceCall call, $3.OrganizationDirectoryServiceRequest request);
  $async.Future<$1.Int32Value> testOrganizationDirectoryService(
      $grpc.ServiceCall call, $3.OrganizationDirectoryServiceRequest request);
  $async.Future<$1.Int32Value> syncOrganizationDirectoryService(
      $grpc.ServiceCall call, $3.OrganizationDirectoryServiceRequest request);
}
