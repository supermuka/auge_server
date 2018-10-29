// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:convert';

import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/user.dart';

/// Domain model class to objective timeline
class TimelineItem {

  String id;
  DateTime dateTime;
  User user;

  // from enum SystemFunction
  int systemFunctionIndex;
  String className;
  String changedData;
  String comment;

  void cloneTo(TimelineItem to) {
    to.id = this.id;
    to.dateTime = this.dateTime;
    if (this.user != null) {
      to.user = this.user.clone();
    }
    to.systemFunctionIndex = this.systemFunctionIndex;
    to.className = this.className;
    to.changedData = this.changedData;
    to.comment = this.comment;
  }

  TimelineItem clone() {
    TimelineItem to = new TimelineItem();
    cloneTo(to);
    return to;
  }

  Map<String, dynamic> get changedDataToMap  {
     if (className == 'Objective') {
       return ObjectiveFacilities.differenceToMap(changedData);
     } else {
       return json.decode(changedData);
     }
  }
}
