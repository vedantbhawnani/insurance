import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'email.dart';

int min = 8;
int max = 15;
fetchdata() async {
  DateTime now = DateTime.now();
  var db = FirebaseFirestore.instance;
  db
      .collection("Customers")
      .where('User', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .where('Expiry Date',
          isGreaterThan: DateTime(now.year, now.month, now.day + 8),
          isLessThan: DateTime(now.year, now.month, now.day + 15))
      .orderBy('Expiry Date', descending: true)
      .get()
      .then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        email(
          docSnapshot.data()['Email'],
          docSnapshot.data()['Expiry Date'].toDate(),
        );
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
