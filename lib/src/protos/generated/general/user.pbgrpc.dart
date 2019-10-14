///
//  Generated code. Do not modify.
//  source: general/user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $3;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$getUsers =
      $grpc.ClientMethod<$3.UserGetRequest, $3.UsersResponse>(
          '/auge.protobuf.UserService/GetUsers',
          ($3.UserGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.UsersResponse.fromBuffer(value));
  static final _$getUser = $grpc.ClientMethod<$3.UserGetRequest, $3.User>(
      '/auge.protobuf.UserService/GetUser',
      ($3.UserGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.User.fromBuffer(value));
  static final _$createUser =
      $grpc.ClientMethod<$3.UserRequest, $1.StringValue>(
          '/auge.protobuf.UserService/CreateUser',
          ($3.UserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateUser = $grpc.ClientMethod<$3.UserRequest, $2.Empty>(
      '/auge.protobuf.UserService/UpdateUser',
      ($3.UserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteUser =
      $grpc.ClientMethod<$3.UserDeleteRequest, $2.Empty>(
          '/auge.protobuf.UserService/DeleteUser',
          ($3.UserDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$3.UsersResponse> getUsers($3.UserGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getUsers, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$3.User> getUser($3.UserGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createUser($3.UserRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateUser($3.UserRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteUser($3.UserDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.UserGetRequest, $3.UsersResponse>(
        'GetUsers',
        getUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UserGetRequest.fromBuffer(value),
        ($3.UsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UserGetRequest, $3.User>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UserGetRequest.fromBuffer(value),
        ($3.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UserRequest, $1.StringValue>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UserRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UserRequest, $2.Empty>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UserRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UserDeleteRequest, $2.Empty>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UserDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$3.UsersResponse> getUsers_Pre(
      $grpc.ServiceCall call, $async.Future<$3.UserGetRequest> request) async {
    return getUsers(call, await request);
  }

  $async.Future<$3.User> getUser_Pre(
      $grpc.ServiceCall call, $async.Future<$3.UserGetRequest> request) async {
    return getUser(call, await request);
  }

  $async.Future<$1.StringValue> createUser_Pre(
      $grpc.ServiceCall call, $async.Future<$3.UserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$2.Empty> updateUser_Pre(
      $grpc.ServiceCall call, $async.Future<$3.UserRequest> request) async {
    return updateUser(call, await request);
  }

  $async.Future<$2.Empty> deleteUser_Pre($grpc.ServiceCall call,
      $async.Future<$3.UserDeleteRequest> request) async {
    return deleteUser(call, await request);
  }

  $async.Future<$3.UsersResponse> getUsers(
      $grpc.ServiceCall call, $3.UserGetRequest request);
  $async.Future<$3.User> getUser(
      $grpc.ServiceCall call, $3.UserGetRequest request);
  $async.Future<$1.StringValue> createUser(
      $grpc.ServiceCall call, $3.UserRequest request);
  $async.Future<$2.Empty> updateUser(
      $grpc.ServiceCall call, $3.UserRequest request);
  $async.Future<$2.Empty> deleteUser(
      $grpc.ServiceCall call, $3.UserDeleteRequest request);
}
