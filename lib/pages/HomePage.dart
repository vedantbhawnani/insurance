// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../backgroundchecker.dart';

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


  //the birthday's date

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;



    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height / 5)),
            Padding(
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width / 100),
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
                  left: MediaQuery
                      .of(context)
                      .size
                      .width / 4,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width / 4,
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .height / 45,
                  top: MediaQuery
                      .of(context)
                      .size
                      .height / 45),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name of Customer')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height / 45,
              ),
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Phone No.')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height / 20,
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
                left: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 4,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height / 45,
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
                  left: MediaQuery
                      .of(context)
                      .size
                      .width / 4,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width / 4,
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .height / 45,
                ),
                child: ElevatedButton(onPressed: () {
                  // Change selectedDate format to include a user-specific time, either by letting them choose time or by inserting it as a fixed time after asking uncle.
                  selectedDate = _selectDate(context) as DateTime;

                  // setState() {
                  //   policyDate = DateTime(
                  //       selectedDate.year, selectedDate.month, selectedDate.day,
                  //       10, 0);
                  // }
                  },
                    child: Text("Policy Expiry Date"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    )
                )
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('Customers').add({
                    'Name': nameController.text,
                    'Expiry Date': selectedDate,
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
                child: Text('Save Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                )
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/customers');
                },
                child: Text('See all customer details')),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: (){
                // getDriverList(dates, mails);
                fetchdata();
              }, child: Text('Click to send mails.'),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
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
    return selectedDate;
  }
}