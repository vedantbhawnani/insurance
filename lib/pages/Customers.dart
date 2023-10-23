import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Customers extends StatelessWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Customers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs;
                    List<Text> messageWigdets = [];
                    for (var message in messages) {
                      final customerName = message['Name'];
                      final customerPolicy = message['Policy'];
                      final customerExpiry = message['Expiry Date'];
                      final messageWigdet = Text(
                        'Name: $customerName\nPolicy: $customerPolicy \nExpiry: $customerExpiry\n',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      );
                      messageWigdets.add(messageWigdet);
                    }
                    return Expanded(
                      child: ListView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                        children: [...messageWigdets],
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
}
