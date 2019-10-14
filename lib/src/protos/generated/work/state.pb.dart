///
//  Generated code. Do not modify.
//  source: work/state.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

class State extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('State', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'version', $pb.PbFieldType.O3)
    ..aOS(3, 'name')
    ..a<$core.int>(4, 'index', $pb.PbFieldType.O3)
    ..m<$core.String, $core.int>(5, 'color', 'State.ColorEntry',$pb.PbFieldType.OS, $pb.PbFieldType.O3, null, null, null , const $pb.PackageName('auge.protobuf'))
    ..hasRequiredFields = false
  ;

  State._() : super();
  factory State() => create();
  factory State.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory State.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  State clone() => State()..mergeFromMessage(this);
  State copyWith(void Function(State) updates) => super.copyWith((message) => updates(message as State));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static State create() => State._();
  State createEmptyInstance() => create();
  static $pb.PbList<State> createRepeated() => $pb.PbList<State>();
  static State getDefault() => _defaultInstance ??= create()..freeze();
  static State _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.int get version => $_get(1, 0);
  set version($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);

  $core.String get name => $_getS(2, '');
  set name($core.String v) { $_setString(2, v); }
  $core.bool hasName() => $_has(2);
  void clearName() => clearField(3);

  $core.int get index => $_get(3, 0);
  set index($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasIndex() => $_has(3);
  void clearIndex() => clearField(4);

  $core.Map<$core.String, $core.int> get color => $_getMap(4);
}

class StatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatesResponse', package: const $pb.PackageName('auge.protobuf'))
    ..pc<State>(1, 'states', $pb.PbFieldType.PM,State.create)
    ..hasRequiredFields = false
  ;

  StatesResponse._() : super();
  factory StatesResponse() => create();
  factory StatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StatesResponse clone() => StatesResponse()..mergeFromMessage(this);
  StatesResponse copyWith(void Function(StatesResponse) updates) => super.copyWith((message) => updates(message as StatesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatesResponse create() => StatesResponse._();
  StatesResponse createEmptyInstance() => create();
  static $pb.PbList<StatesResponse> createRepeated() => $pb.PbList<StatesResponse>();
  static StatesResponse getDefault() => _defaultInstance ??= create()..freeze();
  static StatesResponse _defaultInstance;

  $core.List<State> get states => $_getList(0);
}

class StateGetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StateGetRequest', package: const $pb.PackageName('auge.protobuf'))
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  StateGetRequest._() : super();
  factory StateGetRequest() => create();
  factory StateGetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StateGetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StateGetRequest clone() => StateGetRequest()..mergeFromMessage(this);
  StateGetRequest copyWith(void Function(StateGetRequest) updates) => super.copyWith((message) => updates(message as StateGetRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StateGetRequest create() => StateGetRequest._();
  StateGetRequest createEmptyInstance() => create();
  static $pb.PbList<StateGetRequest> createRepeated() => $pb.PbList<StateGetRequest>();
  static StateGetRequest getDefault() => _defaultInstance ??= create()..freeze();
  static StateGetRequest _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);
}

