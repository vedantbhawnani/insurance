// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController policyController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5)),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
              child: Text(
                'Customer Details',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black54,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                  bottom: MediaQuery.of(context).size.height / 45,
                  top: MediaQuery.of(context).size.height / 45),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name of Customer')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.height / 45,
              ),
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Phone No.')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.height / 20,
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Email')),
              ),
            ),
            Text(
              'Policy Details',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black54,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.height / 45,
              ),
              child: TextField(
                controller: policyController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name of Policy')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.height / 45,
              ),
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Date of expiry')),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('Customers').add({
                    'Name': nameController.text,
                    'Expiry Date': dateController.text,
                    'Phone No.': numberController.text,
                    'Email': emailController.text,
                    'Policy': policyController.text,
                  });
                  setState(() {
                    nameController.text = "";
                    dateController.text = "";
                    emailController.text = "";
                    policyController.text = "";
                    numberController.text = "";
                  });
                },
                child: Text('Save Data')),
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/customers');
                },
                child: Text('See all customer details')),
          ],
        ),
      ),
    );
  }
}
