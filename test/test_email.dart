import 'package:test/test.dart';
import 'package:auge_server/src/util/mail.dart';

void main() {

  setUp(() {
  });

  // Role: superAdmin
  // Object: users
  group('Test eMail', () {

    test('Send Auge e-mail basic.', () async {

      // SEND E-MAIL
    //  AugeMail().sendMessage(List()..add('samuel.schwebel@levius.com.br'), 'SUBJECT', '<p>HTML BODY</p>');
   // expect(() => AugeMail().sendMessage(List()..add('samuel.schwebel@gmail.com'), 'SUBJECT - teste', '<h1>teste</h1><p>HTML BODY</p>'), returnsNormally);
      bool result = await AugeMail().sendMessage(List()..add('samuel.schwebel@gmail.com'), 'SUBJECT - teste', '<h1>teste</h1><p>HTML BODY</p>');

      expect(result != null && result, true);

    });

  });
}