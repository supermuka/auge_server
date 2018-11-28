// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:convert';

import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/user.dart';

/// Domain model class to objective timeline
class TimelineItemBase {
  String id;
}

class TimelineItem implements TimelineItemBase {

  String id;
  DateTime dateTime;
  User user;

  // from enum SystemFunction
  int systemFunctionIndex;
  String className;
  String changedData;
  String description;


  void cloneTo(TimelineItem to) {
    to.id = this.id;
    to.dateTime = this.dateTime;
    if (this.user != null) {
      to.user = this.user.clone();
    }
    to.systemFunctionIndex = this.systemFunctionIndex;
    to.className = this.className;
    to.changedData = this.changedData;
    to.description = this.description;
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

/// Related to [TimelineItem] data model
/// Define the [TimelineItem] essential attributes to exchange data between client and server on RPC
/// Used to POST and PUT
class TimelineItemMessage {

  String id;
  DateTime dateTime;
  String userId;

  // from enum SystemFunction
  int systemFunctionIndex;
  String className;
  String changedData;
  String description;
}

/// Facilities to [TimelineItem] class
class TimeLineItemFacilities {

  static TimelineItemMessage timelineItemMessageFrom(TimelineItem timeLineItem) {
    return new TimelineItemMessage()..id = timeLineItem.id
        ..dateTime = timeLineItem.dateTime
        ..userId = timeLineItem.user.id
        ..systemFunctionIndex = timeLineItem.systemFunctionIndex
        ..className = timeLineItem.className
        ..changedData = timeLineItem.changedData
        ..description = timeLineItem.description;

  }

}