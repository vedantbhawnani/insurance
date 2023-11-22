import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance/backgroundchecker.dart';

import 'Settings.dart';

class Settings extends StatefulWidget{
  const Settings ({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>{
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10)),
        // const Row(children: [
        //   Text('Change User Email: '),
        //   Expanded(child: TextField()),
        // ],),
        // ElevatedButton(onPressed: () {}, child: const Text('Save Email')),
        // const SizedBox(height: 40),
        // Text('Change Dates: '),
        // const SizedBox(height: 20),
        // Row(children: [
        //   Expanded(child: TextField(controller: minController, decoration: InputDecoration(labelText: 'Min days(current: 8)', border: OutlineInputBorder()),)),
        //   SizedBox(width: 40,),
        //   Expanded(child: TextField(controller: maxController, decoration: InputDecoration(labelText: 'Max days(current: 15)', border: OutlineInputBorder()),)),
        // ],),
        // ElevatedButton(onPressed: () {
        //   setState(() {
        //   //   Update min and max in email.
        //   });
        // }, child: const Text('Save Dates')), 
        const SizedBox(height: 40),
        ElevatedButton(onPressed: () async {
          await FirebaseAuth.instance.signOut();
}, child: const Text('Log Out'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),

    ],),
    );
  }
}
