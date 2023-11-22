import 'package:flutter/material.dart';

AlertDialog AlertDeletion(BuildContext context) {
    return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  title: const Text('Are you sure you want to delete?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Yes', style: TextStyle(
                                        color: Colors.red,
                                      )),
                                    )
                                  ],
                                );
  }

