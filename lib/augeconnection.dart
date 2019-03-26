// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.


import 'package:postgres/postgres.dart';

class AugeConnection {

  static PostgreSQLConnection _connection;

  static void createConnection() {
   // _connection = new PostgreSQLConnection(
   //     "35.231.201.73", 5432, "levius", username: "postgres", password: "admin@levius#2018");
    if (_connection == null || _connection.isClosed) {
      _connection = new PostgreSQLConnection(
          "localhost", 5432, "levius", username: "postgres",
          password: "admin@levius#2018");
      _connection.open();
    }
  }

  static Future<PostgreSQLConnection> getConnection() async {
    if (_connection == null || _connection.isClosed) {
      _connection = new PostgreSQLConnection(
          "localhost", 5432, "levius", username: "postgres",
          password: "admin@levius#2018");
      await _connection.open();
    }
    return _connection;
  }
}