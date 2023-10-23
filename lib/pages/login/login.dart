// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Text("Login"),
            style: ElevatedButton.styleFrom(
                elevation: 7,
                minimumSize: Size(MediaQuery.of(context).size.width / 8,
                    MediaQuery.of(context).size.height / 30)),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text("New User? Sign Up")),
        ],
      ),
    );
  }
}
