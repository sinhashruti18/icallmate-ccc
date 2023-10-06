// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe

import 'package:ccc_app/service/manual_lead_api.dart';
import 'package:ccc_app/widget/drawer_widget.dart';
import 'package:ccc_app/widget/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';

class ManualDialPage extends StatefulWidget {
  ManualDialPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualDialPage> createState() => _ManualDialPageState();
}

class _ManualDialPageState extends State<ManualDialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrwaerWidget(),
      appBar: MyAppbar(title: "Manual Dial"),
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 204, 202, 202)
            // image: DecorationImage(
            //     image: AssetImage("images/triangle.jpg"),
            //     repeat: ImageRepeat.repeat),
            ),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            SafeArea(
                child: DialPad(
                    buttonColor: Colors.black,
                    enableDtmf: true,
                    outputMask: "000 000-0000",
                    // hideSubtitle: false,
                    backspaceButtonIconColor: Colors.red,
                    buttonTextColor: Colors.white,
                    dialButtonColor: Colors.black,
                    // dialOutputTextColor:Colors.black
                    // dialOutputTextColor: Colors.black,
                    // keyPressed: (value){
                    //   print('$value was pressed');
                    // },
                    makeCall: (number) {
                      print(number);
                      List dialNum = [];
                      dialNum.add(number);

                      CCCManualLead.createCCCManualLead(context, dialNum);
                    })),
          ],
        ),
      ),
    );
  }
}
