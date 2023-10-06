// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DashboardBottomContainer extends StatelessWidget {
  String title, firstcount, secondcount, f1, s1;

  DashboardBottomContainer(
      {Key? key,
      required this.title,
      required this.firstcount,
      required this.secondcount,
      required this.f1,
      required this.s1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Color.fromARGB(255, 228, 224, 224),
              blurRadius: 25.0,
              // spreadRadius: 25,
              offset: Offset(
                2,
                0,
              ),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    f1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    firstcount,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 30,
                color: Color.fromARGB(255, 187, 185, 185),
              ),
              // Divider(
              //   thickness: 2,
              //   color: Colors.green,
              // ),
              Column(
                children: [
                  Text(
                    s1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    secondcount,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
