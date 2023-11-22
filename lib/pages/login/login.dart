// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.7,
            ),
            Text(
              "Login Page",
              style: GoogleFonts.zeyada(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5,
                  vertical: MediaQuery.of(context).size.height / 40),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text('Password'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: nameController.text,
                          password: passwordController.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Wrong Password')));
                  }
                }
                FirebaseAuth.instance
                .authStateChanges()
                .listen((x) {
                  if (x == null){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Incorrect Password/Email')));
                  }
                  else {
                    Navigator.pushReplacementNamed(context, '/home');
                  }});
              },
              style: ElevatedButton.styleFrom(
                  elevation: 7,
                  minimumSize: Size(MediaQuery.of(context).size.width / 8,
                      MediaQuery.of(context).size.height / 30)),
              child: Text("Login"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text("New User? Sign Up")),
          ],
        ),
      ),
    );
  }
}
