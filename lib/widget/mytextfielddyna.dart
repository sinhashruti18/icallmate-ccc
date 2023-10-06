// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextFielddyna extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  String? initialvalue;
  MyTextFielddyna({Key? key, this.hintText, this.controller, this.initialvalue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialvalue,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 11),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          width: 0.5,
          color: Color.fromARGB(255, 1, 78, 136),
        )),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }
}
