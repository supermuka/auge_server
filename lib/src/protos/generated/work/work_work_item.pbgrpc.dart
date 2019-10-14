///
//  Generated code. Do not modify.
//  source: work/work_work_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'work_work_item.pb.dart' as $8;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'work_work_item.pb.dart';

class WorkServiceClient extends $grpc.Client {
  static final _$getWorks =
      $grpc.ClientMethod<$8.WorkGetRequest, $8.WorksResponse>(
          '/auge.protobuf.WorkService/GetWorks',
          ($8.WorkGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $8.WorksResponse.fromBuffer(value));
  static final _$getWork = $grpc.ClientMethod<$8.WorkGetRequest, $8.Work>(
      '/auge.protobuf.WorkService/GetWork',
      ($8.WorkGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.Work.fromBuffer(value));
  static final _$createWork =
      $grpc.ClientMethod<$8.WorkRequest, $1.StringValue>(
          '/auge.protobuf.WorkService/CreateWork',
          ($8.WorkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateWork = $grpc.ClientMethod<$8.WorkRequest, $2.Empty>(
      '/auge.protobuf.WorkService/UpdateWork',
      ($8.WorkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteWork =
      $grpc.ClientMethod<$8.WorkDeleteRequest, $2.Empty>(
          '/auge.protobuf.WorkService/DeleteWork',
          ($8.WorkDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  WorkServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$8.WorksResponse> getWorks($8.WorkGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getWorks, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$8.Work> getWork($8.WorkGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createWork($8.WorkRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateWork($8.WorkRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteWork($8.WorkDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class WorkServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.WorkService';

  WorkServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.WorkGetRequest, $8.WorksResponse>(
        'GetWorks',
        getWorks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkGetRequest.fromBuffer(value),
        ($8.WorksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkGetRequest, $8.Work>(
        'GetWork',
        getWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkGetRequest.fromBuffer(value),
        ($8.Work value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkRequest, $1.StringValue>(
        'CreateWork',
        createWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkRequest, $2.Empty>(
        'UpdateWork',
        updateWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkDeleteRequest, $2.Empty>(
        'DeleteWork',
        deleteWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$8.WorksResponse> getWorks_Pre(
      $grpc.ServiceCall call, $async.Future<$8.WorkGetRequest> request) async {
    return getWorks(call, await request);
  }

  $async.Future<$8.Work> getWork_Pre(
      $grpc.ServiceCall call, $async.Future<$8.WorkGetRequest> request) async {
    return getWork(call, await request);
  }

  $async.Future<$1.StringValue> createWork_Pre(
      $grpc.ServiceCall call, $async.Future<$8.WorkRequest> request) async {
    return createWork(call, await request);
  }

  $async.Future<$2.Empty> updateWork_Pre(
      $grpc.ServiceCall call, $async.Future<$8.WorkRequest> request) async {
    return updateWork(call, await request);
  }

  $async.Future<$2.Empty> deleteWork_Pre($grpc.ServiceCall call,
      $async.Future<$8.WorkDeleteRequest> request) async {
    return deleteWork(call, await request);
  }

  $async.Future<$8.WorksResponse> getWorks(
      $grpc.ServiceCall call, $8.WorkGetRequest request);
  $async.Future<$8.Work> getWork(
      $grpc.ServiceCall call, $8.WorkGetRequest request);
  $async.Future<$1.StringValue> createWork(
      $grpc.ServiceCall call, $8.WorkRequest request);
  $async.Future<$2.Empty> updateWork(
      $grpc.ServiceCall call, $8.WorkRequest request);
  $async.Future<$2.Empty> deleteWork(
      $grpc.ServiceCall call, $8.WorkDeleteRequest request);
}

class WorkItemServiceClient extends $grpc.Client {
  static final _$getWorkItems =
      $grpc.ClientMethod<$8.WorkItemGetRequest, $8.WorkItemsResponse>(
          '/auge.protobuf.WorkItemService/GetWorkItems',
          ($8.WorkItemGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $8.WorkItemsResponse.fromBuffer(value));
  static final _$getWorkItem =
      $grpc.ClientMethod<$8.WorkItemGetRequest, $8.WorkItem>(
          '/auge.protobuf.WorkItemService/GetWorkItem',
          ($8.WorkItemGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $8.WorkItem.fromBuffer(value));
  static final _$createWorkItem =
      $grpc.ClientMethod<$8.WorkItemRequest, $1.StringValue>(
          '/auge.protobuf.WorkItemService/CreateWorkItem',
          ($8.WorkItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateWorkItem =
      $grpc.ClientMethod<$8.WorkItemRequest, $2.Empty>(
          '/auge.protobuf.WorkItemService/UpdateWorkItem',
          ($8.WorkItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteWorkItem =
      $grpc.ClientMethod<$8.WorkItemDeleteRequest, $2.Empty>(
          '/auge.protobuf.WorkItemService/DeleteWorkItem',
          ($8.WorkItemDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$getWorkItemCheckItems = $grpc.ClientMethod<
          $8.WorkItemCheckItemGetRequest, $8.WorkItemCheckItemsResponse>(
      '/auge.protobuf.WorkItemService/GetWorkItemCheckItems',
      ($8.WorkItemCheckItemGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $8.WorkItemCheckItemsResponse.fromBuffer(value));

  WorkItemServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$8.WorkItemsResponse> getWorkItems(
      $8.WorkItemGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkItems, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$8.WorkItem> getWorkItem($8.WorkItemGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createWorkItem(
      $8.WorkItemRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateWorkItem($8.WorkItemRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteWorkItem(
      $8.WorkItemDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$8.WorkItemCheckItemsResponse> getWorkItemCheckItems(
      $8.WorkItemCheckItemGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkItemCheckItems, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class WorkItemServiceBase extends $grpc.Service {
  $core.String get $name => 'auge.protobuf.WorkItemService';

  WorkItemServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.WorkItemGetRequest, $8.WorkItemsResponse>(
        'GetWorkItems',
        getWorkItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.WorkItemGetRequest.fromBuffer(value),
        ($8.WorkItemsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkItemGetRequest, $8.WorkItem>(
        'GetWorkItem',
        getWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.WorkItemGetRequest.fromBuffer(value),
        ($8.WorkItem value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkItemRequest, $1.StringValue>(
        'CreateWorkItem',
        createWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkItemRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkItemRequest, $2.Empty>(
        'UpdateWorkItem',
        updateWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.WorkItemRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkItemDeleteRequest, $2.Empty>(
        'DeleteWorkItem',
        deleteWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.WorkItemDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.WorkItemCheckItemGetRequest,
            $8.WorkItemCheckItemsResponse>(
        'GetWorkItemCheckItems',
        getWorkItemCheckItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.WorkItemCheckItemGetRequest.fromBuffer(value),
        ($8.WorkItemCheckItemsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$8.WorkItemsResponse> getWorkItems_Pre($grpc.ServiceCall call,
      $async.Future<$8.WorkItemGetRequest> request) async {
    return getWorkItems(call, await request);
  }

  $async.Future<$8.WorkItem> getWorkItem_Pre($grpc.ServiceCall call,
      $async.Future<$8.WorkItemGetRequest> request) async {
    return getWorkItem(call, await request);
  }

  $async.Future<$1.StringValue> createWorkItem_Pre(
      $grpc.ServiceCall call, $async.Future<$8.WorkItemRequest> request) async {
    return createWorkItem(call, await request);
  }

  $async.Future<$2.Empty> updateWorkItem_Pre(
      $grpc.ServiceCall call, $async.Future<$8.WorkItemRequest> request) async {
    return updateWorkItem(call, await request);
  }

  $async.Future<$2.Empty> deleteWorkItem_Pre($grpc.ServiceCall call,
      $async.Future<$8.WorkItemDeleteRequest> request) async {
    return deleteWorkItem(call, await request);
  }

  $async.Future<$8.WorkItemCheckItemsResponse> getWorkItemCheckItems_Pre(
      $grpc.ServiceCall call,
      $async.Future<$8.WorkItemCheckItemGetRequest> request) async {
    return getWorkItemCheckItems(call, await request);
  }

  $async.Future<$8.WorkItemsResponse> getWorkItems(
      $grpc.ServiceCall call, $8.WorkItemGetRequest request);
  $async.Future<$8.WorkItem> getWorkItem(
      $grpc.ServiceCall call, $8.WorkItemGetRequest request);
  $async.Future<$1.StringValue> createWorkItem(
      $grpc.ServiceCall call, $8.WorkItemRequest request);
  $async.Future<$2.Empty> updateWorkItem(
      $grpc.ServiceCall call, $8.WorkItemRequest request);
  $async.Future<$2.Empty> deleteWorkItem(
      $grpc.ServiceCall call, $8.WorkItemDeleteRequest request);
  $async.Future<$8.WorkItemCheckItemsResponse> getWorkItemCheckItems(
      $grpc.ServiceCall call, $8.WorkItemCheckItemGetRequest request);
}
