// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:collection/collection.dart';

import 'package:fixnum/fixnum.dart';

import 'package:auge_server/model/initiative/stage.dart';
import 'package:auge_server/model/general/user.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/google/protobuf/timestamp.pb.dart';
import 'package:auge_server/src/protos/generated/initiative/work_item.pb.dart' as work_item_pb;

/// Domain model class to represent an initiative item work (task, issue, feature, etc.)
class WorkItem {
  // Base
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific
  static final String nameField = 'name';
  String name;
  static final String descriptionField = 'description';
  String description;
  static final String dueDateField = 'dueDate';
  DateTime dueDate;
  static final String completedField = 'completed';
  int completed;
  static final String checkItemsField = 'checkItems';
  List<WorkItemCheckItem> checkItems;
  static final String stageField = 'stage';
  Stage stage;
  static final String assignedToField = 'assignedTo';
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

  work_item_pb.WorkItem writeToProtoBuf() {
    work_item_pb.WorkItem workItemPb = work_item_pb.WorkItem();

    if (this.id != null) workItemPb.id = this.id;
    if (this.version != null) workItemPb.version = this.version;
    if (this.name != null) workItemPb.name = this.name;
    if (this.description != null) workItemPb.description = this.description;
    if (this.completed != null) workItemPb.completed = this.completed;

    if (this.dueDate != null) {
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.dueDate.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      workItemPb.dueDate = t;
    }

    if (this.stage != null) workItemPb.stage = this.stage.writeToProtoBuf();

    if (this.checkItems != null && this.checkItems.isNotEmpty) workItemPb.checkItems.addAll(this.checkItems.map((m) => m.writeToProtoBuf()));
    if (this.assignedTo != null && this.assignedTo.isNotEmpty) workItemPb.assignedTo.addAll(this.assignedTo.map((m) => m.writeToProtoBuf()));

    return workItemPb;
  }

  readFromProtoBuf(work_item_pb.WorkItem workItemPb) {
    if (workItemPb.hasId()) this.id = workItemPb.id;
    if (workItemPb.hasVersion()) this.version = workItemPb.version;
    if (workItemPb.hasName()) this.name = workItemPb.name;
    if (workItemPb.hasDescription()) this.description = workItemPb.description;
    if (workItemPb.hasCompleted()) this.completed = workItemPb.completed;
    if (workItemPb.hasStage()) this.stage = Stage()..readFromProtoBuf(workItemPb.stage);

    if (workItemPb.hasDueDate()) {
      this.dueDate = DateTime.fromMicrosecondsSinceEpoch(workItemPb.dueDate.seconds.toInt() * 1000000 + workItemPb.dueDate.nanos ~/ 1000 );
    }

    if (workItemPb.checkItems.isNotEmpty) this.checkItems = workItemPb.checkItems.map((u) => WorkItemCheckItem()..readFromProtoBuf(u)).toList();
    if (workItemPb.assignedTo.isNotEmpty) this.assignedTo = workItemPb.assignedTo.map((u) => User()..readFromProtoBuf(u)).toList();

  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_item_pb.WorkItem workItemPb, [work_item_pb.WorkItem deltaComparedToWorkItemPb ]) {
    Map<String, dynamic> map = Map();

    if (workItemPb.hasId() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasId() && workItemPb.id != deltaComparedToWorkItemPb.id)) map[WorkItem.idField] = workItemPb.id;
    if (workItemPb.hasVersion() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasVersion() &&  workItemPb.version != deltaComparedToWorkItemPb.version)) map[WorkItem.versionField] = workItemPb.version;
    if (workItemPb.hasName() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasName() && workItemPb.name != deltaComparedToWorkItemPb.name)) map[WorkItem.nameField] = workItemPb.name;
    if (workItemPb.hasDescription() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasDescription() && workItemPb.description != deltaComparedToWorkItemPb.description)) map[WorkItem.descriptionField] = workItemPb.description;
    if (workItemPb.hasCompleted() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasCompleted() && workItemPb.completed != deltaComparedToWorkItemPb.completed)) map[WorkItem.completedField] = workItemPb.completed;
    if (workItemPb.hasStage() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasStage() && workItemPb.stage != deltaComparedToWorkItemPb.stage)) map[WorkItem.stageField] = workItemPb.stage;
    if (workItemPb.hasDueDate() && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.hasDueDate() && workItemPb.dueDate != deltaComparedToWorkItemPb.dueDate)) map[WorkItem.dueDateField] = workItemPb.dueDate;

    if (workItemPb.checkItems.isNotEmpty && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.checkItems.isNotEmpty && !DeepCollectionEquality.unordered().equals(workItemPb.checkItems, deltaComparedToWorkItemPb.checkItems))) map[WorkItem.checkItemsField] = workItemPb.checkItems.map((ci) => WorkItemCheckItem.fromProtoBufToModelMap(ci)).toList();
    if (workItemPb.assignedTo.isNotEmpty && (deltaComparedToWorkItemPb == null || deltaComparedToWorkItemPb.assignedTo.isNotEmpty && !DeepCollectionEquality.unordered().equals(workItemPb.assignedTo, deltaComparedToWorkItemPb.assignedTo))) map[WorkItem.assignedToField] = workItemPb.assignedTo.map((at) => User.fromProtoBufToModelMap(at)).toList();

    return map;
  }
}

class WorkItemCheckItem {
  static const String idField = 'id';
  String id;
  static const String versionField = 'version';
  int version;
  static const String nameField = 'name';
  String name;
  static const String finishedField = 'finished';
  bool finished;

  // Define check item order
  static const String indexField = 'index';
  int index;

  work_item_pb.WorkItemCheckItem writeToProtoBuf() {
    work_item_pb.WorkItemCheckItem workItemCheckItemPb = work_item_pb.WorkItemCheckItem();

    if (this.id != null) workItemCheckItemPb.id = this.id;
    if (this.version != null) workItemCheckItemPb.version = this.version;
    if (this.name != null) workItemCheckItemPb.name = this.name;
    if (this.finished != null) workItemCheckItemPb.finished = this.finished;
    if (this.index != null) workItemCheckItemPb.index = this.index;

    return workItemCheckItemPb;
  }

  readFromProtoBuf(work_item_pb.WorkItemCheckItem workItemCheckItemPb) {
    if (workItemCheckItemPb.hasId()) this.id = workItemCheckItemPb.id;
    if (workItemCheckItemPb.hasName()) this.name = workItemCheckItemPb.name;
    if (workItemCheckItemPb.hasFinished()) this.finished = workItemCheckItemPb.finished;
    if (workItemCheckItemPb.hasIndex()) this.index = workItemCheckItemPb.index;
  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_item_pb.WorkItemCheckItem workItemCheckItemPb, [work_item_pb.WorkItemCheckItem deltaComparedToWorkItemCheckItemPb]) {
    Map<String, dynamic> map = Map();

    if (workItemCheckItemPb.hasId() && (deltaComparedToWorkItemCheckItemPb == null || deltaComparedToWorkItemCheckItemPb.hasId() && workItemCheckItemPb.id != deltaComparedToWorkItemCheckItemPb.id)) map[WorkItemCheckItem.idField] = workItemCheckItemPb.id;
    if (workItemCheckItemPb.hasVersion() && (deltaComparedToWorkItemCheckItemPb == null || deltaComparedToWorkItemCheckItemPb.hasVersion() &&  workItemCheckItemPb.version != deltaComparedToWorkItemCheckItemPb.version)) map[WorkItemCheckItem.versionField] = workItemCheckItemPb.version;
    if (workItemCheckItemPb.hasName() && (deltaComparedToWorkItemCheckItemPb == null || deltaComparedToWorkItemCheckItemPb.hasName() && workItemCheckItemPb.name != deltaComparedToWorkItemCheckItemPb.name)) map[WorkItemCheckItem.nameField] = workItemCheckItemPb.name;
    if (workItemCheckItemPb.hasFinished() && (deltaComparedToWorkItemCheckItemPb == null || deltaComparedToWorkItemCheckItemPb.hasFinished() && workItemCheckItemPb.finished != deltaComparedToWorkItemCheckItemPb.finished)) map[WorkItemCheckItem.finishedField] = workItemCheckItemPb.finished;
    if (workItemCheckItemPb.hasIndex() && (deltaComparedToWorkItemCheckItemPb == null || deltaComparedToWorkItemCheckItemPb.hasIndex() && workItemCheckItemPb.index != deltaComparedToWorkItemCheckItemPb.index)) map[WorkItemCheckItem.indexField] = workItemCheckItemPb.index;

    return map;
  }

}