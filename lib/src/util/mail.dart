// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel.

import 'package:auge_shared/message/messages.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// Class to send e-mail
class AugeMail {

  String from = 'Auge | Levius';
  String username = 'samuel.schwebel@levius.com.br';
  String password = 'xavuxgpvbkrywqcn'; // google app password ;

  Future<bool> sendNotification(List<AugeMailMessageTo> augeMailMessagesTo) async {

    if (augeMailMessagesTo.length == 0) return false;

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
          ..from = Address(username, from)
          ..recipients.addAll(augeMailMessageTo.recipients)
        //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
        //   ..bccRecipients.add(Address('bccAddress@example.com'))
          ..subject = '${augeMailMessageTo.classNameDescription} ${augeMailMessageTo.description}'
        // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
          ..html = '<p>'
                  '${augeMailMessageTo.systemFunctionInPastDescription} ${augeMailMessageTo.classNameDescription} <strong>${augeMailMessageTo.description}</strong>.'
                  '</p>'
                  '<p style="font-size:small;color:#666;">'
                  '<span>__</span>'
                  '<br/>'
                  '${MailMsg.youIsReceivingThisEMailBecauseYouAreThe()} ${augeMailMessageTo.assignmentDescription} ${MailMsg.label(MailMsg.ofTheLabel)} ${augeMailMessageTo.classNameAssignmentDescription}.'
                  '<br/>'
                  '<a href="${augeMailMessageTo.urlOrigin ?? 'https://auge.levius.com.br/'}">${MailMsg.viewOrReplyIt()}</a>.'
                  '</p>';

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
      return false;
    } catch(ee) {
      print(ee);
      return false;
    }
    finally {
      // close the connection
      await connection.close();
    }
    return true;
  }

  Future<bool> sendMessage(List<String> recipients, String subject, String html) async {

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
  //  var connection = PersistentConnection(smtpServer);


    bool result = false;
    try {
        // Create our message.
        Message message = Message()
          ..from = Address(username, from)
          ..recipients.addAll(recipients)
        //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
        //   ..bccRecipients.add(Address('bccAddress@example.com'))
          ..subject = subject
        // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
          ..html = html;

        // Send the message
        //var sendReport = await connection.send(message);
        await send(message, smtpServer);
        //print('Message sent: ' + sendReport.toString());
        result = true;
    } on MailerException catch (e) {
      print('e-mail message not sent. ${e.toString()}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } catch(e) {
      print('e-mail message not sent. ${e.toString()}');
    }
    return result;
  }
}

class AugeMailMessageTo {
  final List<String> recipients;
  final String systemFunctionInPastDescription;
  final String classNameDescription;
  final String description;
  final String assignmentDescription;
  final String classNameAssignmentDescription;
  final String urlOrigin;

  // list e-mail recipients
  // Classname
  // function
  // description
  // attribution

  AugeMailMessageTo(this.recipients, this.systemFunctionInPastDescription, this.classNameDescription, this.description, this.assignmentDescription, this.classNameAssignmentDescription, this.urlOrigin);

}
