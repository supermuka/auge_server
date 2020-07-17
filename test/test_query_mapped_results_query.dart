import 'package:test/test.dart';
import 'package:postgres/postgres.dart';
import 'package:auge_server/src/util/db_connection.dart';

void main() {

  PostgreSQLConnection connection;

  setUp(() async {
    connection = await AugeConnection.getConnection();
  } );

  tearDown(() async {});

  group('Test Performance', () {
    String queryStatement = "SELECT o.id id_user," //0
        " o.version, " //1
        " o.name," //2
        " o.description," //3
        " o.start_date," //4
        " o.end_date," //5
        " o.archived," //6
        " o.leader_user_id," //7
        " o.aligned_to_objective_id," //8
    /*   " objective.organization_id,"  */ //9
        " o.group_id," //9
        " u.name"
        " FROM objective.objectives as o"
        " JOIN general.users u ON u.id = o.leader_user_id";

    test('Query List Results.', () async {
      DateTime start = DateTime.now();
      List<List> results;

      results = await (connection).query(
          queryStatement);

      for (var row in results) {
        var c0 = row[0];
        print(c0);
      /*  var c1 = row[1];
        var c2 = row[2];
        var c3 = row[3];
        var c4 = row[4];
        var c5 = row[5];
        var c6 = row[6];
        var c7 = row[7];
        var c8 = row[8];*/
      }
      DateTime end = DateTime.now();
      print('.query ${start} ${end} ${end.difference(start)}');
    });

    test('Query List Map Results.', () async {
      DateTime start = DateTime.now();

      List<Map<String, Map<String, dynamic>>> results;

      results = await (connection).mappedResultsQuery(
          queryStatement);

      for (var row in results) {
     //   row.keys.forEach((f) => print(f));

        var c0 = row['objectives']['id_user'];
        print(c0);
    /*    var c1 = row['objectives']['name'];
        var c2 = row['objectives']['description'];
        var c3 = row['objectives']['start_date'];
        var c4 = row['objectives']['end_date'];
        var c5 = row['objectives']['archived'];
        var c6 = row['objectives']['leader_user_id'];
        var c7 = row['objectives']['aligned_to_objective_id'];
        var c8 = row['objectives']['group_id'];*/

      }
      DateTime end = DateTime.now();
      print('.mappedResultsQuery ${start} ${end} ${end.difference(start)}');
    });
  });
}