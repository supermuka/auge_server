import 'package:test/test.dart';

import 'package:auge_server/model/general/user.dart';

void main() {

  group('A group of tests to User domain class', () {
    User user;

    setUp(() {
      user = new User();
    });

    test('Field userProfile is not null', () {
      expect(user.userProfile, isNotNull);
    });
  });


}
