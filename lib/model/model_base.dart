// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/user.dart';

abstract class Base {
  String id;
  bool isDeleted;
}

class Audit {

  /// This filed it´s necessary to optimistic concurrency control
  int version;
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
}