///
//  Generated code. Do not modify.
//  source: general/history_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'history_item.pb.dart' as $5;
export 'history_item.pb.dart';

class HistoryItemServiceClient extends $grpc.Client {
  static final _$getHistory =
      $grpc.ClientMethod<$5.HistoryItemGetRequest, $5.HistoryResponse>(
          '/auge.protobuf.HistoryItemService/GetHistory',
          ($5.HistoryItemGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $5.HistoryResponse.fromBuffer(value));

  HistoryItemServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$5.HistoryResponse> getHistory(
      $5.HistoryItemGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getHistory, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class HistoryItemServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.HistoryItemService';

  HistoryItemServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$5.HistoryItemGetRequest, $5.HistoryResponse>(
            'GetHistory',
            getHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.HistoryItemGetRequest.fromBuffer(value),
            ($5.HistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.HistoryResponse> getHistory_Pre($grpc.ServiceCall call,
      $async.Future<$5.HistoryItemGetRequest> request) async {
    return getHistory(call, await request);
  }

  $async.Future<$5.HistoryResponse> getHistory(
      $grpc.ServiceCall call, $5.HistoryItemGetRequest request);
}
