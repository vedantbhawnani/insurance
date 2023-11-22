import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'HomePage.dart';
import 'login/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser == null) {
        // user not logged ==> Login Screen
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      } else {
        // user already logged in ==> Home Screen
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SpinKitFadingFour(color: Color.fromARGB(255, 70, 91, 161)),
        ),
      ),
    );
  }
}
