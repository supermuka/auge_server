// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/initiative/stage.dart';
import 'package:auge_server/model/initiative/work_item_check_item.dart';
import 'package:auge_server/model/user.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Domain model class to represent an initiative item work (task, issue, feature, etc.)
class WorkItemBase {
  String id;
}

class WorkItem implements WorkItemBase {
  String id;

  String name;
  String description;
  DateTime dueDate;
  int completed;
  List<WorkItemCheckItem> checkItems;

  Stage stage;
  List<User> assignedTo;

  WorkItem() {
    initializeDateFormatting(Intl.defaultLocale);

    assignedTo = new List<User>();
    checkItems = new List<WorkItemCheckItem>();

  }

  bool get isOverdue {
    if (dueDate != null) {
      DateFormat formatador = new DateFormat('yMd');
      return ( formatador.format(dueDate).compareTo(formatador.format(new DateTime.now())) < 0 );
    } else {
      return false;
    }
  }

  void cloneTo(WorkItem to) {

    to.id = this.id;
    to.name = this.name;
    to.description = this.description;
    to.dueDate = this.dueDate;
    to.completed = this.completed;

    if (this.stage != null) {
      to.stage = this.stage.clone();
    }

    if (this.checkItems != null) {
      to.checkItems.clear();
      this.checkItems.forEach((ci) {
        to.checkItems.add(ci.clone());
      });
    }

    if (this.assignedTo != null) {
      to.assignedTo.clear();
      this.assignedTo.forEach((at) {
        to.assignedTo.add(at.clone());
      });
    }
  }

  WorkItem clone() {
    WorkItem to = new WorkItem();
    cloneTo(to);
    return to;
  }
}