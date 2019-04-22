import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/general/user.pb.dart';

void main() {

  group('Test', () {


    setUp(() {

    });

    test('Field userProfile is not null', () {
      User userPrevious = new User();
      userPrevious.id = 'f9ea90d6-79ab-42c2-b238-0323c4b20a78';


      User userCurrent = new User();
      userCurrent.id = 'f9ea90d6-79ab-42c2-b238-0323c4b20a78';
      userCurrent.version = 123;
      userCurrent.name = 'XXXXX';


      Map<String, dynamic> userPreviousDiffMap = {};
      Map<String, dynamic> userCurrentDiffMap = {};
      Map<String, dynamic> userPreviousMap = userPrevious.writeToJsonMap();
      Map<String, dynamic> userCurrentMap = userCurrent.writeToJsonMap();

      userPreviousMap.forEach((k, v) {
        if (userPreviousMap[k] != userCurrentMap[k]) {
          userCurrentDiffMap[k] = userCurrentMap[k];
          userPreviousDiffMap[k] = userPreviousMap[k];
        }
      });

      userCurrentMap.forEach((k, v) {
        if (userPreviousMap[k] != userCurrentMap[k]) {
          userCurrentDiffMap[k] = userCurrentMap[k];
          userPreviousDiffMap[k] = userPreviousMap[k];
        }
      });

      print(userCurrentDiffMap);
      print(userPreviousDiffMap);


      //expect(user.id, isNotNull);
    });
  });

}
