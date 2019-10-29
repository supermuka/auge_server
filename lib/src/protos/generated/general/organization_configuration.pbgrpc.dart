///
//  Generated code. Do not modify.
//  source: general/organization_configuration.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'organization_configuration.pb.dart' as $3;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'organization_configuration.pb.dart';

class OrganizationConfigurationServiceClient extends $grpc.Client {
  static final _$getOrganizationConfiguration = $grpc.ClientMethod<
          $3.OrganizationConfigurationGetRequest, $3.OrganizationConfiguration>(
      '/auge.protobuf.OrganizationConfigurationService/GetOrganizationConfiguration',
      ($3.OrganizationConfigurationGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.OrganizationConfiguration.fromBuffer(value));
  static final _$createOrganizationConfiguration = $grpc.ClientMethod<
          $3.OrganizationConfigurationRequest, $1.StringValue>(
      '/auge.protobuf.OrganizationConfigurationService/CreateOrganizationConfiguration',
      ($3.OrganizationConfigurationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateOrganizationConfiguration = $grpc.ClientMethod<
          $3.OrganizationConfigurationRequest, $2.Empty>(
      '/auge.protobuf.OrganizationConfigurationService/UpdateOrganizationConfiguration',
      ($3.OrganizationConfigurationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  OrganizationConfigurationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$3.OrganizationConfiguration>
      getOrganizationConfiguration(
          $3.OrganizationConfigurationGetRequest request,
          {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getOrganizationConfiguration, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createOrganizationConfiguration(
      $3.OrganizationConfigurationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$createOrganizationConfiguration,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateOrganizationConfiguration(
      $3.OrganizationConfigurationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$updateOrganizationConfiguration,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class OrganizationConfigurationServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.OrganizationConfigurationService';

  OrganizationConfigurationServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.OrganizationConfigurationGetRequest,
            $3.OrganizationConfiguration>(
        'GetOrganizationConfiguration',
        getOrganizationConfiguration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.OrganizationConfigurationGetRequest.fromBuffer(value),
        ($3.OrganizationConfiguration value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.OrganizationConfigurationRequest,
            $1.StringValue>(
        'CreateOrganizationConfiguration',
        createOrganizationConfiguration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.OrganizationConfigurationRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.OrganizationConfigurationRequest, $2.Empty>(
            'UpdateOrganizationConfiguration',
            updateOrganizationConfiguration_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.OrganizationConfigurationRequest.fromBuffer(value),
            ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$3.OrganizationConfiguration> getOrganizationConfiguration_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationConfigurationGetRequest> request) async {
    return getOrganizationConfiguration(call, await request);
  }

  $async.Future<$1.StringValue> createOrganizationConfiguration_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationConfigurationRequest> request) async {
    return createOrganizationConfiguration(call, await request);
  }

  $async.Future<$2.Empty> updateOrganizationConfiguration_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.OrganizationConfigurationRequest> request) async {
    return updateOrganizationConfiguration(call, await request);
  }

  $async.Future<$3.OrganizationConfiguration> getOrganizationConfiguration(
      $grpc.ServiceCall call, $3.OrganizationConfigurationGetRequest request);
  $async.Future<$1.StringValue> createOrganizationConfiguration(
      $grpc.ServiceCall call, $3.OrganizationConfigurationRequest request);
  $async.Future<$2.Empty> updateOrganizationConfiguration(
      $grpc.ServiceCall call, $3.OrganizationConfigurationRequest request);
}
