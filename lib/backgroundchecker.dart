import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'email.dart';

int min = 8;
int max = 15;
fetchdata() async {
  var db = FirebaseFirestore.instance;
  db
      .collection("Customers")
      .where('User', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then(
    (querySnapshot) {
      // print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        getDriverList(docSnapshot.data()['Expiry Date'].toDate(),
            docSnapshot.data()['Email']);
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

getDriverList(date, mail) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day, 10, 0);
  // print(date.difference(today));
  print('Checking');
  print((date.difference(today)));
  if (Duration(days: max) >= date.difference(today) &&
      date.difference(today) >= Duration(days: min)) {
    print('Match found!');
    email(mail, 'from Button', date);
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
