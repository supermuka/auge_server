///
//  Generated code. Do not modify.
//  source: general/user_access.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'user_access.pb.dart' as $4;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'user_access.pb.dart';

class UserAccessServiceClient extends $grpc.Client {
  static final _$getUserAccesses =
      $grpc.ClientMethod<$4.UserAccessGetRequest, $4.UserAccessesResponse>(
          '/auge.protobuf.UserAccessService/GetUserAccesses',
          ($4.UserAccessGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $4.UserAccessesResponse.fromBuffer(value));
  static final _$getUserAccess =
      $grpc.ClientMethod<$4.UserAccessGetRequest, $4.UserAccess>(
          '/auge.protobuf.UserAccessService/GetUserAccess',
          ($4.UserAccessGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.UserAccess.fromBuffer(value));
  static final _$createUserAccess =
      $grpc.ClientMethod<$4.UserAccessRequest, $1.StringValue>(
          '/auge.protobuf.UserAccessService/CreateUserAccess',
          ($4.UserAccessRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateUserAccess =
      $grpc.ClientMethod<$4.UserAccessRequest, $2.Empty>(
          '/auge.protobuf.UserAccessService/UpdateUserAccess',
          ($4.UserAccessRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteUserAccess =
      $grpc.ClientMethod<$4.UserAccessDeleteRequest, $2.Empty>(
          '/auge.protobuf.UserAccessService/DeleteUserAccess',
          ($4.UserAccessDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  UserAccessServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$4.UserAccessesResponse> getUserAccesses(
      $4.UserAccessGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getUserAccesses, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$4.UserAccess> getUserAccess(
      $4.UserAccessGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getUserAccess, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createUserAccess(
      $4.UserAccessRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createUserAccess, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateUserAccess($4.UserAccessRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateUserAccess, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteUserAccess(
      $4.UserAccessDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteUserAccess, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class UserAccessServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.UserAccessService';

  UserAccessServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$4.UserAccessGetRequest, $4.UserAccessesResponse>(
            'GetUserAccesses',
            getUserAccesses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $4.UserAccessGetRequest.fromBuffer(value),
            ($4.UserAccessesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserAccessGetRequest, $4.UserAccess>(
        'GetUserAccess',
        getUserAccess_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserAccessGetRequest.fromBuffer(value),
        ($4.UserAccess value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserAccessRequest, $1.StringValue>(
        'CreateUserAccess',
        createUserAccess_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.UserAccessRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserAccessRequest, $2.Empty>(
        'UpdateUserAccess',
        updateUserAccess_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.UserAccessRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserAccessDeleteRequest, $2.Empty>(
        'DeleteUserAccess',
        deleteUserAccess_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UserAccessDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$4.UserAccessesResponse> getUserAccesses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$4.UserAccessGetRequest> request) async {
    return getUserAccesses(call, await request);
  }

  $async.Future<$4.UserAccess> getUserAccess_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserAccessGetRequest> request) async {
    return getUserAccess(call, await request);
  }

  $async.Future<$1.StringValue> createUserAccess_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserAccessRequest> request) async {
    return createUserAccess(call, await request);
  }

  $async.Future<$2.Empty> updateUserAccess_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserAccessRequest> request) async {
    return updateUserAccess(call, await request);
  }

  $async.Future<$2.Empty> deleteUserAccess_Pre($grpc.ServiceCall call,
      $async.Future<$4.UserAccessDeleteRequest> request) async {
    return deleteUserAccess(call, await request);
  }

  $async.Future<$4.UserAccessesResponse> getUserAccesses(
      $grpc.ServiceCall call, $4.UserAccessGetRequest request);
  $async.Future<$4.UserAccess> getUserAccess(
      $grpc.ServiceCall call, $4.UserAccessGetRequest request);
  $async.Future<$1.StringValue> createUserAccess(
      $grpc.ServiceCall call, $4.UserAccessRequest request);
  $async.Future<$2.Empty> updateUserAccess(
      $grpc.ServiceCall call, $4.UserAccessRequest request);
  $async.Future<$2.Empty> deleteUserAccess(
      $grpc.ServiceCall call, $4.UserAccessDeleteRequest request);
}
