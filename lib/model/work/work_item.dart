// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/shared/common_utils.dart';

import 'package:auge_server/model/work/work.dart';
import 'package:auge_server/model/work/work_stage.dart';
import 'package:auge_server/model/general/user.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/work/work_work_item.pb.dart' as work_work_item_pb;

/// Domain model class to represent an work item work (task, issue, feature, etc.)
class WorkItem {
  static final String className = 'WorkItem';

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
  static final String workStageField = 'workStage';
  WorkStage workStage;
  static final String assignedToField = 'assignedTo';
  List<User> assignedTo;
  static final String attachmentsField = 'attachments';
  List<WorkItemAttachment> attachments;
  static final String workField = 'work';
  Work work;

  WorkItem() {
    initializeDateFormatting(Intl.defaultLocale);
    assignedTo = List<User>();
    checkItems = List<WorkItemCheckItem>();
    attachments = List<WorkItemAttachment>();
  }

  bool get isOverdue {
    if (dueDate != null) {
      DateFormat formater = new DateFormat('yMd');
      return ( formater.format(dueDate).compareTo(formater.format(new DateTime.now())) < 0 );
    } else {
      return false;
    }
  }

  work_work_item_pb.WorkItem writeToProtoBuf() {
    work_work_item_pb.WorkItem workItemPb = work_work_item_pb.WorkItem();

    if (this.id != null) workItemPb.id = this.id;
    if (this.version != null) workItemPb.version = this.version;
    if (this.name != null) workItemPb.name = this.name;
    if (this.description != null) workItemPb.description = this.description;
    if (this.completed != null) workItemPb.completed = this.completed;

    if (this.dueDate != null) workItemPb.dueDate = CommonUtils.timestampFromDateTime(this.dueDate); /*{
      Timestamp t = Timestamp();
      int microsecondsSinceEpoch = this.dueDate.toUtc().microsecondsSinceEpoch;
      t.seconds = Int64(microsecondsSinceEpoch ~/ 1000000);
      t.nanos = ((microsecondsSinceEpoch % 1000000) * 1000);
      workItemPb.dueDate = t;
    }
    */

    if (this.workStage != null) workItemPb.workStage = this.workStage.writeToProtoBuf();
    if (this.attachments != null && this.attachments.isNotEmpty) workItemPb.attachments.addAll(this.attachments.map((m) => m.writeToProtoBuf()));
    if (this.checkItems != null && this.checkItems.isNotEmpty) workItemPb.checkItems.addAll(this.checkItems.map((m) => m.writeToProtoBuf()));
    if (this.assignedTo != null && this.assignedTo.isNotEmpty) workItemPb.assignedTo.addAll(this.assignedTo.map((m) => m.writeToProtoBuf()));
    if (this.work != null) workItemPb.work = this.work.writeToProtoBuf();
    return workItemPb;
  }

  readFromProtoBuf(work_work_item_pb.WorkItem workItemPb, Map<String, dynamic> cache) {
    if (workItemPb.hasId()) this.id = workItemPb.id;
    if (workItemPb.hasVersion()) this.version = workItemPb.version;
    if (workItemPb.hasName()) this.name = workItemPb.name;
    if (workItemPb.hasDescription()) this.description = workItemPb.description;
    if (workItemPb.hasCompleted()) this.completed = workItemPb.completed;
    if (workItemPb.hasWorkStage()) this.workStage = WorkStage()..readFromProtoBuf(workItemPb.workStage);

    // if (workItemPb.hasDueDate())  this.dueDate = CommonUtils.dateTimeFromTimestamp(workItemPb.dueDate);
    if (workItemPb.hasDueDate())  this.dueDate = workItemPb.dueDate.toDateTime();
    /*{
      this.dueDate = DateTime.fromMicrosecondsSinceEpoch(workItemPb.dueDate.seconds.toInt() * 1000000 + workItemPb.dueDate.nanos ~/ 1000 );
    }*/
    if (workItemPb.attachments.isNotEmpty) this.attachments = workItemPb.attachments.map((u) => WorkItemAttachment()..readFromProtoBuf(u)).toList(); // No need cache, it is a composite
    if (workItemPb.checkItems.isNotEmpty) this.checkItems = workItemPb.checkItems.map((c) => WorkItemCheckItem()..readFromProtoBuf(c)).toList(); // No need cache, it is a composite
    if (workItemPb.assignedTo.isNotEmpty) this.assignedTo = workItemPb.assignedTo.map((u) => cache.putIfAbsent('${WorkItem.assignedToField}${u.id}@${User.className}', () => User()..readFromProtoBuf(u, cache))).toList().cast<User>();
    if (workItemPb.hasWork()) this.work = cache.putIfAbsent('${WorkItem.workField}${workItemPb.work.id}@${Work.className}', () => Work()..readFromProtoBuf(workItemPb.work, cache));
  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_work_item_pb.WorkItem workItemPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (workItemPb.hasId()) map[WorkItem.idField] = workItemPb.id;
      if (workItemPb.hasName()) map[WorkItem.nameField] = workItemPb.name;
    } else {
      if (workItemPb.hasId()) map[WorkItem.idField] = workItemPb.id;
      if (workItemPb.hasVersion())
        map[WorkItem.versionField] = workItemPb.version;
      if (workItemPb.hasName()) map[WorkItem.nameField] = workItemPb.name;
      if (workItemPb.hasDescription())
        map[WorkItem.descriptionField] = workItemPb.description;
      if (workItemPb.hasCompleted())
        map[WorkItem.completedField] = workItemPb.completed;
      if (workItemPb.hasWorkStage()) map[WorkItem.workStageField] = WorkStage.fromProtoBufToModelMap(workItemPb.workStage);
      /*
      if (workItemPb.hasDueDate())
        map[WorkItem.dueDateField] = CommonUtils.dateTimeFromTimestamp(workItemPb.dueDate);
*/
      if (workItemPb.hasDueDate())
        map[WorkItem.dueDateField] = workItemPb.dueDate.toDateTime();

      if (workItemPb.attachments.isNotEmpty) map[WorkItem.attachmentsField] =
          workItemPb.attachments.map((ci) =>
              WorkItemAttachment.fromProtoBufToModelMap(ci, onlyIdAndSpecificationForDepthFields, true)).toList();
      if (workItemPb.checkItems.isNotEmpty) map[WorkItem.checkItemsField] =
          workItemPb.checkItems.map((ci) =>
              WorkItemCheckItem.fromProtoBufToModelMap(ci, onlyIdAndSpecificationForDepthFields, true)).toList();
      if (workItemPb.assignedTo.isNotEmpty) map[WorkItem.assignedToField] =
          workItemPb.assignedTo.map((at) =>
              User.fromProtoBufToModelMap(at, onlyIdAndSpecificationForDepthFields, true)).toList();
      if (workItemPb.hasWork()) map[WorkItem.workField] = Work.fromProtoBufToModelMap(workItemPb.work);
    }
    return map;
  }
}

class WorkItemAttachment {
  static const String idField = 'id';
  String id;
  static const String versionField = 'version';
  int version;
  static const String nameField = 'name';
  String name;
  static const String typeField = 'type';
  String type;
  static const String contentField = 'content';
  String content; // base64

  work_work_item_pb.WorkItemAttachment writeToProtoBuf() {
    work_work_item_pb.WorkItemAttachment workItemAttachmentPb = work_work_item_pb.WorkItemAttachment();

    if (this.id != null) workItemAttachmentPb.id = this.id;
    if (this.name != null) workItemAttachmentPb.name = this.name;
    if (this.type != null) workItemAttachmentPb.type = this.type;
    if (this.content != null) workItemAttachmentPb.content = this.content;

    return workItemAttachmentPb;
  }

  readFromProtoBuf(work_work_item_pb.WorkItemAttachment workItemAttachmentPb) {
    if (workItemAttachmentPb.hasId()) this.id = workItemAttachmentPb.id;
    if (workItemAttachmentPb.hasName()) this.name = workItemAttachmentPb.name;
    if (workItemAttachmentPb.hasType()) this.type = workItemAttachmentPb.type;
    if (workItemAttachmentPb.hasContent()) this.content = workItemAttachmentPb.content;
  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_work_item_pb.WorkItemAttachment workItemAttachmentPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (workItemAttachmentPb.hasId())
        map[WorkItemAttachment.idField] = workItemAttachmentPb.id;
      if (workItemAttachmentPb.hasName())
        map[WorkItemAttachment.nameField] = workItemAttachmentPb.name;
    } else {
      if (workItemAttachmentPb.hasId())
        map[WorkItemAttachment.idField] = workItemAttachmentPb.id;
      if (workItemAttachmentPb.hasName())
        map[WorkItemAttachment.nameField] = workItemAttachmentPb.name;
      if (workItemAttachmentPb.hasType())
        map[WorkItemAttachment.typeField] = workItemAttachmentPb.type;
      if (workItemAttachmentPb.hasContent())
        map[WorkItemAttachment.contentField] = workItemAttachmentPb.content;

    }
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

  work_work_item_pb.WorkItemCheckItem writeToProtoBuf() {
    work_work_item_pb.WorkItemCheckItem workItemCheckItemPb = work_work_item_pb.WorkItemCheckItem();

    if (this.id != null) workItemCheckItemPb.id = this.id;
    if (this.name != null) workItemCheckItemPb.name = this.name;
    if (this.finished != null) workItemCheckItemPb.finished = this.finished;
    if (this.index != null) workItemCheckItemPb.index = this.index;

    return workItemCheckItemPb;
  }

  readFromProtoBuf(work_work_item_pb.WorkItemCheckItem workItemCheckItemPb) {
    if (workItemCheckItemPb.hasId()) this.id = workItemCheckItemPb.id;
    if (workItemCheckItemPb.hasName()) this.name = workItemCheckItemPb.name;
    if (workItemCheckItemPb.hasFinished()) this.finished = workItemCheckItemPb.finished;
    if (workItemCheckItemPb.hasIndex()) this.index = workItemCheckItemPb.index;
  }

  static Map<String, dynamic> fromProtoBufToModelMap(work_work_item_pb.WorkItemCheckItem workItemCheckItemPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (workItemCheckItemPb.hasId())
        map[WorkItemCheckItem.idField] = workItemCheckItemPb.id;
      if (workItemCheckItemPb.hasName())
        map[WorkItemCheckItem.nameField] = workItemCheckItemPb.name;
    } else {
      if (workItemCheckItemPb.hasId())
        map[WorkItemCheckItem.idField] = workItemCheckItemPb.id;
      if (workItemCheckItemPb.hasName())
        map[WorkItemCheckItem.nameField] = workItemCheckItemPb.name;
      if (workItemCheckItemPb.hasFinished())
        map[WorkItemCheckItem.finishedField] = workItemCheckItemPb.finished;
      if (workItemCheckItemPb.hasIndex())
        map[WorkItemCheckItem.indexField] = workItemCheckItemPb.index;
    }
    return map;
  }
}