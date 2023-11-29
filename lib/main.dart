// ignore_for_file: prefer_const_constructors, constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insurance/email.dart';
import 'package:insurance/pages/Customers.dart';
import 'package:insurance/pages/HomePage.dart';
import 'package:workmanager/workmanager.dart';

import 'pages/Splash.dart';
import 'pages/login/login.dart';
import 'pages/login/signUp.dart';

const fetchBackground = 'fetchBackground';
const my_task = "be.tramckrijte.workmanager.backgroundChecker";
const my_task_button = "be.tramckrijte.workmanager.button";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  await Workmanager().registerPeriodicTask(
    "1",
    my_task,
    frequency: Duration(hours: 1),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
    initialDelay: Duration(minutes: 10),
  );
  runApp(MainApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp();
    try {
      print(task);
      print('Running in background');
      switch (task) {
        case my_task:
          print('Running switch case ');
          DateTime now = DateTime.now();
          await FirebaseFirestore.instance
              .collection('Customers')
              .where('User', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .where('Expiry Date',
                  isGreaterThan: DateTime(now.year, now.month, now.day + 8),
                  isLessThan: DateTime(now.year, now.month, now.day + 15))
              .orderBy('Expiry Date', descending: true)
              .get()
              .then(
            (querySnapshot) async {
              print("Successfully completed");
              for (var docSnapshot in querySnapshot.docs) {
                // print(docSnapshot.data()['Name']);
                await email(
                  docSnapshot.data()['Email'],
                  docSnapshot.data()['Expiry Date'].toDate(),
                );
              }
            },
            onError: (e) => print("Error completing: $e"),
          );
          break;
      }
    } catch (err) {
      print(err.toString());
      return Future.value(false);
    }
    return Future.value(true);
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 70, 91, 161),
          primarySwatch: Colors.indigo),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color.fromARGB(255, 70, 91, 161),
          primarySwatch: Colors.indigo),
      // home: HomePage(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        // '/settings': (context) => Settings(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUp(),
        '/home': (context) => HomePage(),
        '/customers': (context) => Customers(),
      },
    );
  }
}
