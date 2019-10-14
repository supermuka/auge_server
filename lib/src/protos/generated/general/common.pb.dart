///
//  Generated code. Do not modify.
//  source: general/common.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $1;

class DateTimeGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DateTimeGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOB(1, 'isUtc')
    ..hasRequiredFields = false
  ;

  DateTimeGetRequest._() : super();
  factory DateTimeGetRequest() => create();
  factory DateTimeGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DateTimeGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DateTimeGetRequest clone() => DateTimeGetRequest()..mergeFromMessage(this);
  DateTimeGetRequest copyWith(void Function(DateTimeGetRequest) updates) => super.copyWith((message) => updates(message as DateTimeGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DateTimeGetRequest create() => DateTimeGetRequest._();
  DateTimeGetRequest createEmptyInstance() => create();
  static $pb.PbList<DateTimeGetRequest> createRepeated() => $pb.PbList<DateTimeGetRequest>();
  static DateTimeGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static DateTimeGetRequest _defaultInstance;

  $core.bool get isUtc => $_get(0, false);
  set isUtc($core.bool v) { $_setBool(0, v); }
  $core.bool hasIsUtc() => $_has(0);
  void clearIsUtc() => clearField(1);
}

class DateTimeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DateTimeResponse', package: const $pb.PackageName('auge.protobuf'))
    ..a<$1.Timestamp>(1, 'dateTime', $pb.PbFieldType.OM, $1.Timestamp.getDefault, $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  DateTimeResponse._() : super();
  factory DateTimeResponse() => create();
  factory DateTimeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DateTimeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DateTimeResponse clone() => DateTimeResponse()..mergeFromMessage(this);
  DateTimeResponse copyWith(void Function(DateTimeResponse) updates) => super.copyWith((message) => updates(message as DateTimeResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DateTimeResponse create() => DateTimeResponse._();
  DateTimeResponse createEmptyInstance() => create();
  static $pb.PbList<DateTimeResponse> createRepeated() => $pb.PbList<DateTimeResponse>();
  static DateTimeResponse getDefault() => _defaultInstance ??= create()..freeze();
  static DateTimeResponse _defaultInstance;

  $1.Timestamp get dateTime => $_getN(0);
  set dateTime($1.Timestamp v) { setField(1, v); }
  $core.bool hasDateTime() => $_has(0);
  void clearDateTime() => clearField(1);
}

