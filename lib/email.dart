import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void email(String recipient, String subject) async {
  String username = 'vedant.bhawnani@gmail.com'; //Your Email;
  String password = 'tmcs miew stty pvua'; //Your Email's password;

  final smtpServer = gmail(username, password);
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add(recipient) //recipient email
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    // ..bccRecipients.add(Address()) //bcc Recipients emails
    ..subject = '$subject :: 😀 :: ${DateTime.now()}' //subject of the email
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'; //body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n'+ e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
}