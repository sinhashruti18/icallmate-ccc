// ignore_for_file: sized_box_for_whitespace, use_full_hex_values_for_flutter_colors

import 'package:ccc_app/pages/customer_callback.dart';
import 'package:ccc_app/pages/followups_page.dart';
import 'package:ccc_app/pages/home_page.dart';
import 'package:ccc_app/pages/login_pages.dart';
import 'package:ccc_app/pages/manage_call_page.dart';
import 'package:ccc_app/service/login_apiservice.dart';
import 'package:ccc_app/widget/break_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/manual_dial_page.dart';

class DrwaerWidget extends StatefulWidget {
  DrwaerWidget({Key? key}) : super(key: key);

  @override
  State<DrwaerWidget> createState() => _DrwaerWidgetState();
}

class _DrwaerWidgetState extends State<DrwaerWidget> {
  bool isButtonClicked = false;
  void _showBreakDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return BreakAlertDialog(); // Show the BreakAlertDialog widget as the content
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFE86024),
                Color(0xFFFF9256),
              ],
            ),
          ),
          child: DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  // color: Color(0xff5C5EDD),
                  ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          child: Image.asset("images/account.png")),
                      Text(
                        "VoicenSMS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${LoginService.agent_name}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {
                              _showBreakDialog(context);
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xffff137ca6),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "BREAK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          leading: Container(
              decoration: BoxDecoration(),
              height: 30,
              color: isButtonClicked ? Colors.green : null,
              child: Image.asset("images/dash.png")),
          title: Text(
            "Agent Dashboard",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ManageCallPage()));
          },
          leading: Container(
              decoration: BoxDecoration(),
              height: 20,
              child: Image.asset("images/receiver.png")),
          title: Text(
            "Manage Calls",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ManualDialPage()));
          },
          leading: Container(
              decoration: BoxDecoration(),
              height: 25,
              child: Image.asset("images/mandial.png")),
          title: Text(
            "Manual Dial",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FollowUpsPage()));
          },
          leading:
              Container(height: 25, child: Image.asset("images/followups.png")),
          title: const Text(
            "Followups",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CustomerCallBackPage()));
          },
          leading:
              Container(height: 25, child: Image.asset("images/callback.png")),
          title: Text(
            "Customer Callback",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          thickness: 1,
        ),
        Padding(
          padding: EdgeInsets.only(left: 13),
          child: Text(
            "Other",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {},
          leading: Container(
              decoration: BoxDecoration(),
              height: 25,
              child: Image.asset("images/aboutus.png")),
          title: Text(
            "About Us",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.reload();
            prefs.remove('cccIp');
            prefs.remove('isenabelwsurl');
            prefs.remove('acpclusterwsurl');
            prefs.remove('agent_login_id');
            print("get user row id = ${LoginService.agent_login_id}");

            prefs.remove('agent_name');

            prefs.remove('mobile_no');
            prefs.remove('service_no');
            prefs.remove('ukey');
            prefs.remove('first_name');

            prefs.remove('last_name');

            prefs.remove('agent_row_id');
            prefs.remove('userrowid');
            prefs.remove('usertype');
            prefs.remove('enable_location');
            prefs.remove('enable_loc_loginlogout');

            prefs.remove('isc2cenabled');
            prefs.remove('enable_prefix');
            // String email = prefs.remove("email");
            // SharedPreferences preferences = await SharedPreferences.getInstance();
            //   preferences.reload();
            //   LoginService.cccIP = preferences.getString('cccIp')!;
            //   LoginService.isenabelwsurl = preferences.getBool('isenabelwsurl');
            //   LoginService.acpclusterwsurl = preferences.getString('acpclusterwsurl');
            // LoginService.agent_login_id = prefs.remove('agent_login_id');
            print("main login= ${LoginService.agent_login_id}");
            prefs.reload();
            // LoginService.agent_name = null;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
            // LoginService.saveLoginStatus(false);
          },
          leading: Icon(Icons.logout_sharp),
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
