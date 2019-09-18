import 'package:test/test.dart';

import 'package:auge_server/src/util/mail.dart';


void main() {


  setUp(() {
  });

  // Role: superAdmin
  // Object: users
  group('Test eMail', () {

    test('Send Auge e-mail notifications.', () {
      // expect(AugeMail.sendEMail(), isTrue);
      expect(() => AugeMail().sendEMail(), returnsNormally);
    });
  });
}