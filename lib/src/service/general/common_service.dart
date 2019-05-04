// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';

import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pbgrpc.dart';

class CommonService extends CommonServiceBase {

  // API
  @override
  Future<DateTimeResponse> getDateTime(ServiceCall call,
      DateTimeGetRequest dateTimeGetRequest) async {
    try {

      Timestamp t = Timestamp();

      if (dateTimeGetRequest.isUtc) {
        int microsecondsSinceEpoch = DateTime
            .now()
            .toUtc()
            .microsecondsSinceEpoch;
        t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
        t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      }
      else {
        int microsecondsSinceEpoch = DateTime.now()
            .microsecondsSinceEpoch;
        t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
        t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      }
      return new DateTimeResponse()..dateTime = t;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }

  static MapDiff(Map<dynamic, dynamic> mapA, Map<dynamic, dynamic> mapB) {



  }
}