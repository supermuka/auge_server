// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:io';

import 'package:safe_config/safe_config.dart';

class AugeConfiguration extends Configuration {

  AugeConfiguration(String fileName) :
    super.fromFile(File(fileName));

  directory() {
    //print(Directory.current);
  }

  DatabaseConfiguration database;

}