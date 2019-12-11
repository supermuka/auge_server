// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:auge_server/shared/common_utils.dart';

import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pbgrpc.dart';

class CommonService extends CommonServiceBase {

  // API
  @override
  Future<DateTimeResponse> getDateTime(ServiceCall call,
      DateTimeGetRequest dateTimeGetRequest) async {
    try {

      return DateTimeResponse()..dateTime = CommonUtils.timestampFromDateTime(dateTimeGetRequest.isUtc ? DateTime
          .now()
          .toUtc() : DateTime
          .now() );

//      return new DateTimeResponse()..dateTime = t;
    } catch (e) {
      print('${e.runtimeType}, ${e}');
      rethrow;
    }
  }
}

