import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmanager/workmanager.dart';
import 'email.dart';

void callbackDispatcher() {
  try {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case 'fetchBackground':
          DateTime now = DateTime.now();
          DateTime today = DateTime(now.year, now.month, now.day, 10, 0);

          var db = FirebaseFirestore.instance;
          db.collection("Customers").get().then(
                (querySnapshot) {
              print("Successfully completed");
              for (var docSnapshot in querySnapshot.docs) {
                // print('${docSnapshot.id} => ${docSnapshot.data()}');
                // getDriverList(docSnapshot.data()['Expiry Date'].toDate(), docSnapshot.data()['Email']);
                if (docSnapshot.data()['Expiry Date'].toDate().difference(
                    today) == Duration(days: 0)) {
                  // print(date);
                  print('Match found!');
                  email(docSnapshot.data()['Email'], 'from Automated checker');
                }
              }
            },
            onError: (e) => print("Error completing: $e"),
          );


          // print(date.difference(today));


          break;
      }
      return Future.value(true);
    });
    }
  catch (e) {
    print(e);
  }
}

fetchdata() async{
  var db = FirebaseFirestore.instance;
  db.collection("Customers").get().then(
        (querySnapshot) {
      // print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
          getDriverList(docSnapshot.data()['Expiry Date'].toDate(), docSnapshot.data()['Email']);
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

getDriverList(date, mail){
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day, 10, 0);
  // print(date.difference(today));
  print('Checking');
  if (date.difference(today) == Duration(days: 0)){
      print(date);
      print('Match found!');
      email(mail, 'from Button');
    }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to
      .difference(from)
      .inHours / 24).round();
}

