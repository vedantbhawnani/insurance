// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../backgroundchecker.dart';
import '../main.dart';

List<DateTime> expiryDates = [];

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

  DateTime selectedDate = DateTime.now();
  bool text = true;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pushReplacementNamed(context, '/settings');
          //   },
          //   child: Icon(
          //     Icons.settings,
          //   ),
          //   style: ElevatedButton.styleFrom(
          //       backgroundColor: Theme.of(context).primaryColorDark),
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/customers');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark),
            child: Icon(Icons.person),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 22)),
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
            SizedBox(height: 15),
            Text(
              'Policy Expiry Date',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black54,
                fontSize: 15,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                  bottom: MediaQuery.of(context).size.height / 45,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      // Change selectedDate format to include a user-specific time, either by letting them choose time or by inserting it as a fixed time after asking uncle.
                      _selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 77, 90, 173),
                    ),
                    child: Text("Policy Expiry Date"))),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('Customers').add({
                    'Name': nameController.text,
                    'Expiry Date': selectedDate,
                    'Phone No.': numberController.text,
                    'Email': emailController.text,
                    'Policy': policyController.text,
                    'User': FirebaseAuth.instance.currentUser?.uid,
                  });
                  setState(() {
                    nameController.text = "";
                    dateController.text = "";
                    emailController.text = "";
                    policyController.text = "";
                    numberController.text = "";
                  });
                  expiryDates.add(selectedDate);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data Saved')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text('Save Data')),
            SizedBox(
              height: MediaQuery.of(context).size.width / 13,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: Platform.isAndroid
                    ? () {
                        Workmanager().registerPeriodicTask(
                          my_task,
                          my_task,
                        );
                      }
                    : null,
                child: Text("task Android")),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), padding: EdgeInsets.all(13)),
                    onPressed: () {
                      // getDriverList(dates, mails);
                      fetchdata();
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      // TextSpan(text: "Mail  ", style: TextStyle(fontSize: 18)),
                      WidgetSpan(child: Icon(Icons.mark_email_read, size: 28))
                    ]))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2010, 1),
        lastDate: DateTime(2030, 12),
        context: context);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
