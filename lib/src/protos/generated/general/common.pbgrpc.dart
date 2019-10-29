///
//  Generated code. Do not modify.
//  source: general/common.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'common.pb.dart' as $0;
export 'common.pb.dart';

class CommonServiceClient extends $grpc.Client {
  static final _$getDateTime =
      $grpc.ClientMethod<$0.DateTimeGetRequest, $0.DateTimeResponse>(
          '/auge.protobuf.CommonService/GetDateTime',
          ($0.DateTimeGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DateTimeResponse.fromBuffer(value));

  CommonServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.DateTimeResponse> getDateTime(
      $0.DateTimeGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getDateTime, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class CommonServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.CommonService';

  CommonServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DateTimeGetRequest, $0.DateTimeResponse>(
        'GetDateTime',
        getDateTime_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DateTimeGetRequest.fromBuffer(value),
        ($0.DateTimeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.DateTimeResponse> getDateTime_Pre($grpc.ServiceCall call,
      $async.Future<$0.DateTimeGetRequest> request) async {
    return getDateTime(call, await request);
  }

  $async.Future<$0.DateTimeResponse> getDateTime(
      $grpc.ServiceCall call, $0.DateTimeGetRequest request);
}
