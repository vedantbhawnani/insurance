import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insurance/pages/alert_deletion.dart';
import 'package:intl/intl.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController policyController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Text> messageWigdets = [];
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Customers')
                    .where('User',
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .orderBy('Expiry Date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs;
                    for (var message in messages) {
                      final customerName = message['Name'];
                      final customerPolicy = message['Policy'];
                      final customerEmail = message['Email'];
                      final policyDate = message['Expiry Date'].toDate();
                      final String customerExpiry =
                          DateFormat.yMMMMd().format(policyDate);
                      final messageWigdet = Text(
                        'Name: $customerName\nEmail: $customerEmail\nPolicy: $customerPolicy \nExpiry: $customerExpiry\n',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      );
                      messageWigdets.add(messageWigdet);
                    }
                    return messageWigdets.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2.3),
                            child: Center(
                                child: Text(
                              "No entries found",
                              style: TextStyle(fontSize: 24),
                            )),
                          )
                        : Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 30),
                              // children: [...messageWigdets],
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                // return ListTile(title: messageWigdets[index], trailing: Icon(Icons.menu), onLongPress: () async {
                                //   var collection = FirebaseFirestore.instance.collection('Customers');
                                //   await collection.doc(snapshot.data!.docs[index].reference.id).delete();
                                // },);
                                final message = messageWigdets[index];
                                return custTiles(
                                    snapshot, index, message, context);
                              },
                            ),
                          );
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ]),
      ),
    );
  }

  Dismissible custTiles(
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
          int index,
          Text message,
          BuildContext context) =>
      Dismissible(
        direction: DismissDirection.horizontal,
        background: const ColoredBox(
          color: Colors.orange,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.edit, color: Colors.white),
            ),
          ),
        ),
        secondaryBackground: const ColoredBox(
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ),
        key: Key(snapshot.data!.docs[index]['Name']),
        child: ListTile(title: message),
        onDismissed: (direction) async {
          if (direction == DismissDirection.endToStart) {
            var collection = FirebaseFirestore.instance.collection('Customers');
            await collection
                .doc(snapshot.data!.docs[index].reference.id)
                .delete();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$message Removed')));
          }
        },
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.endToStart) {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDeletion(context);
              },
            );
            if (confirmed == false) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Deletion cancelled'),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  behavior: SnackBarBehavior.floating,
                  width: 280,
                  backgroundColor: Colors.blue[200]));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Deletion confirmed'),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                behavior: SnackBarBehavior.floating,
                width: 280,
                backgroundColor: Colors.red,
              ));
            }
            return confirmed;
          } else {
            nameController.text = snapshot.data!.docs[index]['Name'];
            emailController.text = snapshot.data!.docs[index]['Email'];
            policyController.text = snapshot.data!.docs[index]['Policy'];
            dateController.text =
                snapshot.data!.docs[index]['Expiry Date'].toDate().toString();
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    scrollable: true,
                    title: Text('Edit details'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                icon: Icon(Icons.account_box),
                              ),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                            ),
                            TextFormField(
                              controller: policyController,
                              decoration: InputDecoration(
                                labelText: 'Policy Name',
                                icon: Icon(Icons.policy_sharp),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () => _selectDate(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text("Policy Expiry Date"))
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            setState(() {
                              var collection = FirebaseFirestore.instance
                                  .collection('Customers');
                              collection
                                  .doc(snapshot.data!.docs[index].reference.id)
                                  .update({
                                'Name': nameController.text,
                                'Expiry Date': selectedDate,
                                'Email': emailController.text,
                                'Policy': policyController.text,
                                'User': FirebaseAuth.instance.currentUser?.uid,
                              });
                            });
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/customers');
                          })
                    ],
                  );
                });
          }
        },
      );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
