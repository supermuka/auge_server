// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/user.dart';

class Base {
  String id;
  bool isDeleted;
}

class Audit {

  /// This field values it's generated on server side
  static const createdAtField = 'createdAt';
  DateTime createdAt;
  static const createdByField = 'createdBy';
  User createdBy;
  /// This field values it's generated on server side
  static const updatedAtField = 'modifiedAt';
  DateTime updatedAt;
  static const updatedByField = 'modifiedBy';
  User updatedBy;
  /// This field values it's generated on server side
  static const deletedAtField = 'deletedAt';
  DateTime deletedAt;
  static const deletedByField = 'deletedBy';
  User deletedBy;
}