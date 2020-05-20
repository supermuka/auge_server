import 'package:test/test.dart';
import 'package:mailer2/mailer.dart';

void main() {

  setUp(() {
  });

  // Role: superAdmin
  // Object: users
  group('Test eMail', () {

    test('Send Auge e-mail basic.', () async {

      // If you want to use an arbitrary SMTP server, go with `new SmtpOptions()`.
      // This class below is just for convenience. There are more similar classes available.
      var options = new GmailSmtpOptions()
        ..username = 'samuel.schwebel@levius.com.br'
        ..password = 'kegtbariprhileon';

      // Create our email transport.
      var emailTransport = new SmtpTransport(options);

      // Create our mail/envelope.
      var envelope = new Envelope()
        ..from = 'auge_notification@levius.com.br'
        ..recipients.add('samuel.schwebel@gmail.com')
        ..subject = 'Test Dart Mailer library :: ${new DateTime.now()}'
        ..text = 'This is the plain text'
        ..html = '<h1>Test</h1><p>Hey! Here\'s some HTML content</p>';

      // Email it.
      emailTransport
          .send(envelope)
          .then((envelope) => print('Email sent!'))
          .catchError((e) => print('Error occurred: $e'));

    });

  });
}