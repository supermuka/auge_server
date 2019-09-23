// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// Class to send e-mail
class AugeMail {

  void send(List<AugeMailMessageTo> augeMailMessagesTo) async {

    if (augeMailMessagesTo.length == 0) return;

    String username = 'samuel.schwebel@levius.com.br';
    String password = 'xavuxgpvbkrywqcn'; // google app password ;

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    try {
      for (AugeMailMessageTo augeMailMessageTo in augeMailMessagesTo) {

        // Create our message.
        Message message = Message()
          ..from = Address(username, 'Auge - Levius')
          ..recipients.addAll(augeMailMessageTo.recipients)
        //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
        //   ..bccRecipients.add(Address('bccAddress@example.com'))
          ..subject = augeMailMessageTo.subject
        // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
          ..html = augeMailMessageTo.html;

        // Send the message
        //var sendReport = await connection.send(message);
        await connection.send(message);
        //print('Message sent: ' + sendReport.toString());
      }
    } on MailerException catch (e) {
      print('e-mail message not sent. ${e.toString()}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }

    } finally {
      // close the connection
      await connection.close();
    }
  }
}

class AugeMailMessageTo {
  final List<String> recipients;
  final String subject;
  final String html;

  AugeMailMessageTo(List<String> this.recipients, String this.subject, String this.html);


}
