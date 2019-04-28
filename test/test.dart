import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/general/user_test.pb.dart';

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

      userCurrent.userProfile = UserProfile()..image = '-XYZ-';


      Map<String, dynamic> userPreviousDiffMap = {};
      Map<String, dynamic> userCurrentDiffMap = {};
      Map<String, dynamic> userPreviousMap = userPrevious.writeToJsonMap();
      Map<String, dynamic> userCurrentMap = userCurrent.writeToJsonMap();

      print(userCurrent);
      print(userCurrent.writeToJson());
      print(userCurrent.writeToJsonMap());

      print(userCurrent.name);
      print(userCurrent.userProfile.runtimeType);
      print(userCurrent.info_.fieldInfo);
      print(userCurrent.info_.fieldInfo[1].type);
      print(userCurrent.info_.fieldInfo[1].isMapField);
      print(userCurrent.info_.fieldInfo[6].type);
      print(userCurrent.info_.toString());
      print(userCurrent.info_.byIndex);
      print(userCurrent.info_.messageName);
      print(userCurrent.info_.qualifiedMessageName);

    });
  });

}
