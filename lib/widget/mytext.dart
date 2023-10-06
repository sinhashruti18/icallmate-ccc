// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  late String text;
  MyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }
}
