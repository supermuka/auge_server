///
//  Generated code. Do not modify.
//  source: work/work_work_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'work_work_item.pb.dart' as $7;
import '../google/protobuf/wrappers.pb.dart' as $1;
import '../google/protobuf/empty.pb.dart' as $2;
export 'work_work_item.pb.dart';

class WorkServiceClient extends $grpc.Client {
  static final _$getWorks =
      $grpc.ClientMethod<$7.WorkGetRequest, $7.WorksResponse>(
          '/auge.protobuf.WorkService/GetWorks',
          ($7.WorkGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.WorksResponse.fromBuffer(value));
  static final _$getWork = $grpc.ClientMethod<$7.WorkGetRequest, $7.Work>(
      '/auge.protobuf.WorkService/GetWork',
      ($7.WorkGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.Work.fromBuffer(value));
  static final _$createWork =
      $grpc.ClientMethod<$7.WorkRequest, $1.StringValue>(
          '/auge.protobuf.WorkService/CreateWork',
          ($7.WorkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateWork = $grpc.ClientMethod<$7.WorkRequest, $2.Empty>(
      '/auge.protobuf.WorkService/UpdateWork',
      ($7.WorkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteWork =
      $grpc.ClientMethod<$7.WorkDeleteRequest, $2.Empty>(
          '/auge.protobuf.WorkService/DeleteWork',
          ($7.WorkDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  WorkServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$7.WorksResponse> getWorks($7.WorkGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getWorks, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$7.Work> getWork($7.WorkGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createWork($7.WorkRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateWork($7.WorkRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateWork, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteWork($7.WorkDeleteRequest request,
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
    $addMethod($grpc.ServiceMethod<$7.WorkGetRequest, $7.WorksResponse>(
        'GetWorks',
        getWorks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkGetRequest.fromBuffer(value),
        ($7.WorksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkGetRequest, $7.Work>(
        'GetWork',
        getWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkGetRequest.fromBuffer(value),
        ($7.Work value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkRequest, $1.StringValue>(
        'CreateWork',
        createWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkRequest, $2.Empty>(
        'UpdateWork',
        updateWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkDeleteRequest, $2.Empty>(
        'DeleteWork',
        deleteWork_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$7.WorksResponse> getWorks_Pre(
      $grpc.ServiceCall call, $async.Future<$7.WorkGetRequest> request) async {
    return getWorks(call, await request);
  }

  $async.Future<$7.Work> getWork_Pre(
      $grpc.ServiceCall call, $async.Future<$7.WorkGetRequest> request) async {
    return getWork(call, await request);
  }

  $async.Future<$1.StringValue> createWork_Pre(
      $grpc.ServiceCall call, $async.Future<$7.WorkRequest> request) async {
    return createWork(call, await request);
  }

  $async.Future<$2.Empty> updateWork_Pre(
      $grpc.ServiceCall call, $async.Future<$7.WorkRequest> request) async {
    return updateWork(call, await request);
  }

  $async.Future<$2.Empty> deleteWork_Pre($grpc.ServiceCall call,
      $async.Future<$7.WorkDeleteRequest> request) async {
    return deleteWork(call, await request);
  }

  $async.Future<$7.WorksResponse> getWorks(
      $grpc.ServiceCall call, $7.WorkGetRequest request);
  $async.Future<$7.Work> getWork(
      $grpc.ServiceCall call, $7.WorkGetRequest request);
  $async.Future<$1.StringValue> createWork(
      $grpc.ServiceCall call, $7.WorkRequest request);
  $async.Future<$2.Empty> updateWork(
      $grpc.ServiceCall call, $7.WorkRequest request);
  $async.Future<$2.Empty> deleteWork(
      $grpc.ServiceCall call, $7.WorkDeleteRequest request);
}

class WorkItemServiceClient extends $grpc.Client {
  static final _$getWorkItems =
      $grpc.ClientMethod<$7.WorkItemGetRequest, $7.WorkItemsResponse>(
          '/auge.protobuf.WorkItemService/GetWorkItems',
          ($7.WorkItemGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $7.WorkItemsResponse.fromBuffer(value));
  static final _$getWorkItem =
      $grpc.ClientMethod<$7.WorkItemGetRequest, $7.WorkItem>(
          '/auge.protobuf.WorkItemService/GetWorkItem',
          ($7.WorkItemGetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.WorkItem.fromBuffer(value));
  static final _$createWorkItem =
      $grpc.ClientMethod<$7.WorkItemRequest, $1.StringValue>(
          '/auge.protobuf.WorkItemService/CreateWorkItem',
          ($7.WorkItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value));
  static final _$updateWorkItem =
      $grpc.ClientMethod<$7.WorkItemRequest, $2.Empty>(
          '/auge.protobuf.WorkItemService/UpdateWorkItem',
          ($7.WorkItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$deleteWorkItem =
      $grpc.ClientMethod<$7.WorkItemDeleteRequest, $2.Empty>(
          '/auge.protobuf.WorkItemService/DeleteWorkItem',
          ($7.WorkItemDeleteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));
  static final _$getWorkItemAttachment = $grpc.ClientMethod<
          $7.WorkItemAttachmentGetRequest, $7.WorkItemAttachment>(
      '/auge.protobuf.WorkItemService/GetWorkItemAttachment',
      ($7.WorkItemAttachmentGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.WorkItemAttachment.fromBuffer(value));
  static final _$getWorkItemCheckItems = $grpc.ClientMethod<
          $7.WorkItemCheckItemGetRequest, $7.WorkItemCheckItemsResponse>(
      '/auge.protobuf.WorkItemService/GetWorkItemCheckItems',
      ($7.WorkItemCheckItemGetRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $7.WorkItemCheckItemsResponse.fromBuffer(value));

  WorkItemServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$7.WorkItemsResponse> getWorkItems(
      $7.WorkItemGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkItems, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$7.WorkItem> getWorkItem($7.WorkItemGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.StringValue> createWorkItem(
      $7.WorkItemRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> updateWorkItem($7.WorkItemRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.Empty> deleteWorkItem(
      $7.WorkItemDeleteRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$deleteWorkItem, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$7.WorkItemAttachment> getWorkItemAttachment(
      $7.WorkItemAttachmentGetRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getWorkItemAttachment, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$7.WorkItemCheckItemsResponse> getWorkItemCheckItems(
      $7.WorkItemCheckItemGetRequest request,
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
    $addMethod($grpc.ServiceMethod<$7.WorkItemGetRequest, $7.WorkItemsResponse>(
        'GetWorkItems',
        getWorkItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.WorkItemGetRequest.fromBuffer(value),
        ($7.WorkItemsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkItemGetRequest, $7.WorkItem>(
        'GetWorkItem',
        getWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.WorkItemGetRequest.fromBuffer(value),
        ($7.WorkItem value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkItemRequest, $1.StringValue>(
        'CreateWorkItem',
        createWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkItemRequest.fromBuffer(value),
        ($1.StringValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkItemRequest, $2.Empty>(
        'UpdateWorkItem',
        updateWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.WorkItemRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkItemDeleteRequest, $2.Empty>(
        'DeleteWorkItem',
        deleteWorkItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.WorkItemDeleteRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkItemAttachmentGetRequest,
            $7.WorkItemAttachment>(
        'GetWorkItemAttachment',
        getWorkItemAttachment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.WorkItemAttachmentGetRequest.fromBuffer(value),
        ($7.WorkItemAttachment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.WorkItemCheckItemGetRequest,
            $7.WorkItemCheckItemsResponse>(
        'GetWorkItemCheckItems',
        getWorkItemCheckItems_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.WorkItemCheckItemGetRequest.fromBuffer(value),
        ($7.WorkItemCheckItemsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.WorkItemsResponse> getWorkItems_Pre($grpc.ServiceCall call,
      $async.Future<$7.WorkItemGetRequest> request) async {
    return getWorkItems(call, await request);
  }

  $async.Future<$7.WorkItem> getWorkItem_Pre($grpc.ServiceCall call,
      $async.Future<$7.WorkItemGetRequest> request) async {
    return getWorkItem(call, await request);
  }

  $async.Future<$1.StringValue> createWorkItem_Pre(
      $grpc.ServiceCall call, $async.Future<$7.WorkItemRequest> request) async {
    return createWorkItem(call, await request);
  }

  $async.Future<$2.Empty> updateWorkItem_Pre(
      $grpc.ServiceCall call, $async.Future<$7.WorkItemRequest> request) async {
    return updateWorkItem(call, await request);
  }

  $async.Future<$2.Empty> deleteWorkItem_Pre($grpc.ServiceCall call,
      $async.Future<$7.WorkItemDeleteRequest> request) async {
    return deleteWorkItem(call, await request);
  }

  $async.Future<$7.WorkItemAttachment> getWorkItemAttachment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.WorkItemAttachmentGetRequest> request) async {
    return getWorkItemAttachment(call, await request);
  }

  $async.Future<$7.WorkItemCheckItemsResponse> getWorkItemCheckItems_Pre(
      $grpc.ServiceCall call,
      $async.Future<$7.WorkItemCheckItemGetRequest> request) async {
    return getWorkItemCheckItems(call, await request);
  }

  $async.Future<$7.WorkItemsResponse> getWorkItems(
      $grpc.ServiceCall call, $7.WorkItemGetRequest request);
  $async.Future<$7.WorkItem> getWorkItem(
      $grpc.ServiceCall call, $7.WorkItemGetRequest request);
  $async.Future<$1.StringValue> createWorkItem(
      $grpc.ServiceCall call, $7.WorkItemRequest request);
  $async.Future<$2.Empty> updateWorkItem(
      $grpc.ServiceCall call, $7.WorkItemRequest request);
  $async.Future<$2.Empty> deleteWorkItem(
      $grpc.ServiceCall call, $7.WorkItemDeleteRequest request);
  $async.Future<$7.WorkItemAttachment> getWorkItemAttachment(
      $grpc.ServiceCall call, $7.WorkItemAttachmentGetRequest request);
  $async.Future<$7.WorkItemCheckItemsResponse> getWorkItemCheckItems(
      $grpc.ServiceCall call, $7.WorkItemCheckItemGetRequest request);
}
