// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MessageAlert {
  static Future<bool?> alertDialog(BuildContext context, String text) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          // title: Text(''),
          content: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context, true); // Return true when Ok is pressed
              },
            ),
          ],
        );
      },
    );
  }
}
