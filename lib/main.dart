// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insurance/pages/Customers.dart';

import 'pages/HomePage.dart';
import 'pages/login/login.dart';
import 'pages/login/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // home: HomePage(),
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUp(),
        '/home': (context) => HomePage(),
        '/customers': (context) => Customers(),
      },
    );
  }
}
