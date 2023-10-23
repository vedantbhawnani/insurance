// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.7,
          ),
          Text(
            "SignUp",
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
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: nameController.text,
                  password: passwordController.text,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
              Navigator.pushNamed(context, '/home');
            },
            child: Text("SignUp"),
            style: ElevatedButton.styleFrom(
                elevation: 7,
                minimumSize: Size(MediaQuery.of(context).size.width / 8,
                    MediaQuery.of(context).size.height / 30)),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Already a user? Sign in")),
        ],
      ),
    );
  }
}
