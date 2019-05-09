// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:fixnum/fixnum.dart';
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';

class CommonUtils {

  /// Return a Protobuf [Timestamp] from Dart [DateTime]
  static Timestamp timestampFromDateTime(DateTime dateTime) {
    if (dateTime == null) return null;
    Timestamp t = Timestamp();
    int microsecondsSinceEpoch = dateTime
        .microsecondsSinceEpoch;
    t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
    t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);

    return t;
  }

  /// Return a Dart [DateTime] from Protobuf [Timestamp]
  static DateTime dateTimeFromTimestamp(Timestamp timestamp) {
    if (timestamp == null) return null;
    return DateTime.fromMicrosecondsSinceEpoch(
        timestamp.seconds.toInt() * 1000000 +
            timestamp.nanos ~/ 1000);
  }
}