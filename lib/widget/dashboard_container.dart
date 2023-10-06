// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget {
  String text, value;
  String image;
  DashboardContainer(
      {Key? key, required this.text, required this.image, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Color.fromARGB(255, 243, 243, 243),
              blurRadius: 25.0,
              // spreadRadius: 25,
              offset: Offset(
                2,
                0,
              ),
            )
          ]),
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(),
            child: Image(image: AssetImage(image))),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 1),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
