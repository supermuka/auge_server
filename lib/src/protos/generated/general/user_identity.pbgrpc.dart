///
//  Generated code. Do not modify.
//  source: general/user_identity.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'user_identity.pb.dart' as $4;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'user_identity.pb.dart';

class UserIdentityServiceClient extends $grpc.Client {
  static final _$getUserIdentities =
      $grpc.ClientMethod<$4.UserIdentityGetRequest, $4.UserIdentitiesResponse>(
          '/auge.protobuf.UserIdentityService/GetUserIdentities',
          ($4.UserIdentityGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.UserIdentitiesResponse.fromBuffer(value));
  static final _$getUserIdentity =
      $grpc.ClientMethod<$4.UserIdentityGetRequest, $4.UserIdentity>(
          '/auge.protobuf.UserIdentityService/GetUserIdentity',
          ($4.UserIdentityGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.UserIdentity.fromBuffer(value));
  static final _$createUserIdentity =
      $grpc.ClientMethod<$4.UserIdentityRequest, $1.StringValue>(
          '/auge.protobuf.UserIdentityService/CreateUserIdentity',
          ($4.UserIdentityRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateUserIdentity =
      $grpc.ClientMethod<$4.UserIdentityRequest, $2.Empty>(
          '/auge.protobuf.UserIdentityService/UpdateUserIdentity',
          ($4.UserIdentityRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteUserIdentity =
      $grpc.ClientMethod<$4.UserIdentityDeleteRequest, $2.Empty>(
          '/auge.protobuf.UserIdentityService/DeleteUserIdentity',
          ($4.UserIdentityDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  UserIdentityServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$4.UserIdentitiesResponse> getUserIdentities(
      $4.UserIdentityGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getUserIdentities, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$4.UserIdentity> getUserIdentity(
      $4.UserIdentityGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getUserIdentity, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createUserIdentity(
      $4.UserIdentityRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createUserIdentity, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateUserIdentity(
      $4.UserIdentityRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateUserIdentity, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteUserIdentity(
      $4.UserIdentityDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteUserIdentity, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class UserIdentityServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.UserIdentityService';

  UserIdentityServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.UserIdentityGetRequest,
            $4.UserIdentitiesResponse>(
        'GetUserIdentities',
        getUserIdentities_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserIdentityGetRequest.fromBuffer(value),
        ($4.UserIdentitiesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserIdentityGetRequest, $4.UserIdentity>(
        'GetUserIdentity',
        getUserIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserIdentityGetRequest.fromBuffer(value),
        ($4.UserIdentity value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserIdentityRequest, $1.StringValue>(
        'CreateUserIdentity',
        createUserIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserIdentityRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserIdentityRequest, $2.Empty>(
        'UpdateUserIdentity',
        updateUserIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserIdentityRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserIdentityDeleteRequest, $2.Empty>(
        'DeleteUserIdentity',
        deleteUserIdentity_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserIdentityDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$4.UserIdentitiesResponse> getUserIdentities_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.UserIdentityGetRequest> request) async {
    return getUserIdentities(call, await request);
  }

  $async.Future<$4.UserIdentity> getUserIdentity_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserIdentityGetRequest> request) async {
    return getUserIdentity(call, await request);
  }

  $async.Future<$1.StringValue> createUserIdentity_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserIdentityRequest> request) async {
    return createUserIdentity(call, await request);
  }

  $async.Future<$2.Empty> updateUserIdentity_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserIdentityRequest> request) async {
    return updateUserIdentity(call, await request);
  }

  $async.Future<$2.Empty> deleteUserIdentity_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserIdentityDeleteRequest> request) async {
    return deleteUserIdentity(call, await request);
  }

  $async.Future<$4.UserIdentitiesResponse> getUserIdentities(
      $grpc.ServiceCall call, $4.UserIdentityGetRequest request);
  $async.Future<$4.UserIdentity> getUserIdentity(
      $grpc.ServiceCall call, $4.UserIdentityGetRequest request);
  $async.Future<$1.StringValue> createUserIdentity(
      $grpc.ServiceCall call, $4.UserIdentityRequest request);
  $async.Future<$2.Empty> updateUserIdentity(
      $grpc.ServiceCall call, $4.UserIdentityRequest request);
  $async.Future<$2.Empty> deleteUserIdentity(
      $grpc.ServiceCall call, $4.UserIdentityDeleteRequest request);
}
