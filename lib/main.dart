// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insurance/pages/Customers.dart';
import 'package:insurance/pages/HomePage.dart';
import 'package:workmanager/workmanager.dart';

import 'email.dart';

import 'backgroundchecker.dart';
// import 'pages/Settings.dart';
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
    initialDelay: Duration(minutes: 2),
  );
  runApp(MainApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  print('in function');
  Workmanager().executeTask((task, inputData) async {
    try {
      print(task);
      switch (task) {
        case my_task:
          DateTime now = DateTime.now();
          DateTime today = DateTime(now.year, now.month, now.day, 10, 0);
          print(today);
          for (var date in expiryDates) {
            print(date);
            if (date.difference(today) == const Duration(days: 0)) {
              print(date);
              print('Match found!');
              // Update subject below!
              email('vedant.bhawnani@gmail.com', 'Test Check', date);
            }
          }
          break;
      }
    } catch (err) {
      print(err.toString());
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
