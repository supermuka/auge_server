// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// Class to send e-mail
class AugeMail {

  void sendEMail() async {
    print('sendEMail A');
    String username = 'samuel.schwebel@levius.com.br';
    String password = 'xavuxgpvbkrywqcn'; // google app password //'gl300977';
    print('sendEMail B');
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.
    print('sendEMail C');
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('samuel.schwebel@levius.com.br')
   //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
   //   ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    print('sendEMail D');
    try {
      print('sendEMail E');
      final sendReport = await send(message, smtpServer);
      print('sendEMail F');
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('sendEMail G');
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } on Exception catch (ee) {
      print('Problem 2: ${ee.toString()}');
    }
  }
}