import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


void email(String recipient, String subject, DateTime due) async {
  String username = 'ramehs.insurance23@gmail.com'; //Your Email;
  String password = 'jzqf egfl pzgl dyfk'; //Your Email's password;

  final smtpServer = gmail(username, password);
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add(recipient) //recipient email
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    // ..bccRecipients.add(Address()) //bcc Recipients emails
    ..subject = 'Renewal Notice' //subject of the email
    ..text = 'Gentle reminder regarding your Health/Motor Policy is falling due for renewal on ${due.day}/${due.month}/${due.year}'; //body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport'); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n$e'); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
}

