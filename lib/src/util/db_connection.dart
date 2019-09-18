// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'dart:async';

import 'package:postgres/postgres.dart';

class AugeConnection {

  static PostgreSQLConnection _connection;

  /*
  static void createConnection() {
   // _connection = new PostgreSQLConnection(
   //     "35.231.201.73", 5432, "levius", username: "postgres", password: "admin@levius#2018");
    if (_connection == null || _connection.isClosed) {
      _connection = new PostgreSQLConnection(
         /* "localhost", 5432, "levius", username: "postgres", */
         /* "localhost", 5432, "auge", username: "postgres", */
        /* "host.docker.internal", 5432, "auge", username: "postgres", */
         "localhost", 5432, "auge", username: "postgres",
          password: "admin@levius#2018");
      _connection.open();
    }
  }
  */

  static Future<PostgreSQLConnection> getConnection() async {
    if (_connection == null || _connection.isClosed) {
      _connection = new PostgreSQLConnection(


           //"10.128.0.2", 5432, "auge", username: "postgres",
          // "localhost", 5432, "auge", username: "postgres",
         // Run on Windows
          "host.docker.internal", 5432, "auge", username: "postgres",

       // ip a
       // docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
       // link/ether 02:42:0d:15:9d:b3 brd ff:ff:ff:ff:ff:ff
       // inet 172.17.0.1/16
        // >>> FOI UTILIZADO PARA CONEXÃO PARA O BANCO DE DADOS <<<
       // br-9606efbd25aa: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state UP group default
       // link/ether 02:42:68:f0:33:ae brd ff:ff:ff:ff:ff:ff
       // inet 172.26.0.1/16
        // >>> FOI UTILIZADO PARA DEFINIR O RANGE NO /etc/postgresql/9.6/main/pg_hba.conf <<<

       //   "172.17.0.1", 5432, "auge", username: "postgres",
          password: "admin@levius#2018");
      await _connection.open();
    }
    return _connection;
  }
}