// ignore_for_file: must_be_immutable, avoid_print, use_full_hex_values_for_flutter_colors

import 'dart:io';

import 'package:ccc_app/service/cls_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  MyAppbar({Key? key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    // Future<void> sendFileToWhatsApp(String fileName) async {
    //   final File file = await ClsLogs.getLogFile(fileName);
    //   if (file.existsSync()) {
    //     await ClsLogs.sendToWhatsApp(file.path);
    //   } else {
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: Text('File Not Found'),
    //         content: Text('The log file does not exist.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // }

    return AppBar(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xffE86024),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      title: Text(title!),
      backgroundColor: Color(0xffff137ca6),
      actions: [
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
                value: 0,
                child: TextButton(
                  child: Text(
                    "Send ErrorLog",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  onPressed: () {},
                )
                // Text("Send ErrorLog"),
                ),
            PopupMenuItem<int>(
                value: 1,
                child: TextButton(
                  child: Text(
                    "Send API HitLog",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  onPressed: () {
                    // ClsLogs.logApiHit('API Hit Event');
                  },
                )
                //  Text("Send API HitLog"),
                ),
            PopupMenuItem<int>(
                value: 2,
                child: TextButton(
                  child: Text(
                    "Send API SuccessLog",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  onPressed: () {},
                )

                // Text("Send API SuccessLog"),
                ),
            PopupMenuItem<int>(
                value: 3,
                child: TextButton(
                  child: Text(
                    "Send API FailureLog",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  onPressed: () {},
                )),
            // PopupMenuItem<int>(
            //   value: 4,
            //   child: TextButton(
            //     child:  Text(
            //       "Sign Out",
            //       style: TextStyle(fontSize: 14, color: Colors.black),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => LoginPage()),
            //       );
            // },
            // ),
            // ),
          ];
        }, onSelected: (value) {
          if (value == 0) {
            print("Send ErrorLog");
          } else if (value == 1) {
            ClsLogs.shareLogFile('API_HIT.txt');
            // sendFileToWhatsApp('API_HIT.txt');

            print("Send API HitLog");
          } else if (value == 2) {
            print("Send API SuccessLog");
          } else if (value == 3) {
            print("Send API FailureLog");
          }
        })
      ],
    );
  }
}
