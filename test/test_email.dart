import 'package:test/test.dart';
import 'package:auge_server/src/util/mail.dart';

void main() {

  setUp(() {
  });

  // Role: superAdmin
  // Object: users
  group('Test eMail', () {

    test('Send Auge e-mail basic.', () {

      // SEND E-MAIL
      AugeMail().sendMessage(List()..add('samuel.schwebel@levius.com.br'), 'SUBJECT', '<p>HTML BODY</p>');
    //expect(() => AugeMail().send(eMails), returnsNormally);
    });

  });
}