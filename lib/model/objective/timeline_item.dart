// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/user.dart';

/// Domain model class to objective timeline
class TimelineItem {

  String id;
  DateTime dateTime;
  User user;

  // from enum SystemFunction
  int systemFunctionIndex;
  String dataChanged;
  String comment;
}
