// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'package:ccc_app/main.dart';
import 'package:ccc_app/service/login_apiservice.dart';
import 'package:ccc_app/service/setting.dart';
import 'package:ccc_app/widget/setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginId = TextEditingController();
  final passwordController = TextEditingController();
  final serperip = TextEditingController();
  final serverport = TextEditingController();
  final serverpackage = TextEditingController();

  late bool obscureText = true;
  void _togglePasswordStatus() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _showSettingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingsDialog(
          serverip_controller: serperip,
          serverport_controller: serverport,
          serverpackage_controller: serverpackage,
          onTap: () {
            _saveData();
            // Navigator.pop(context);
          },
        );
      },
    );
  }

  int? savedId; // To keep track of the saved record's id.

  void _saveData() async {
    String ip = serperip.text.trim();
    String port = serverport.text.trim();
    String package = serverpackage.text.trim();

    Map<String, dynamic> row = {
      'ip': ip,
      'port': port,
      'package': package,
    };

    if (savedId != null) {
      row['id'] = savedId; // Provide the id for updating the record.s
      int updatedRows = await DatabaseHelper.instance.update(row);
      print('Updated $updatedRows rows');
      Navigator.pop(context);
    } else {
      int id = await DatabaseHelper.instance.insert(row);
      print('Inserted row id: $id');
      setState(() {
        savedId = id; // Save the id of the newly inserted record.
      });
      Navigator.pop(context);
    }
  }

  // Future<void> _queryData() async {
  //   List<Map<String, dynamic>> queryRows =
  //       await DatabaseHelper.instance.queryAll();
  //   if (queryRows.isNotEmpty) {
  //     Map<String, dynamic> row = queryRows.first;
  //     setState(() {
  //       savedId = row['id']; // Save the id of the fetched record.
  //       serperip.text = row['ip'];
  //       serverport.text = row['port'];
  //       serverpackage.text = row['package'];
  //     });
  //   }
  // }
  Future<void> _queryData() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();

    if (queryRows.isNotEmpty) {
      Map<String, dynamic> row = queryRows.first;
      setState(() {
        savedId = row['id'];
        serperip.text = row['ip'];
        serverport.text = row['port'];
        serverpackage.text = row['package'];
      });
    } else {
      // Insert default values if no records are found in the database.
      String defaultIp = '192.168.68.25';
      String defaultPort = '8080';
      String defaultPackage = 'icallmate-ecp';

      Map<String, dynamic> defaultRow = {
        'ip': defaultIp,
        'port': defaultPort,
        'package': defaultPackage,
      };

      int id = await DatabaseHelper.instance.insert(defaultRow);
      print('Inserted row id: $id');
      setState(() {
        savedId = id;

        serperip.text = "192.168.68.25";
        serverport.text = "8080";
        serverpackage.text = "icallmate-ecp";
      });
    }
  }

  @override
  void initState() {
    _queryData();
    // LoginService.serverip = "125.17.101.174";
    // LoginService.serverport = "80";
    // LoginService.serverpackage = "iCallMate_APP";
    // serperip.text = "192.168.68.25";
    // serverport.text = "8080";
    // serverpackage.text = "icallmate-ecp";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xffE86024),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        automaticallyImplyLeading: false,
        title: Text("Cloud Contact Center"),
        backgroundColor: Color(0xff137CA6),
        actions: [
          PopupMenuButton(
              color: Colors.white,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: TextButton(
                      child: Text(
                        "Send ErrorLog",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  PopupMenuItem<int>(
                      value: 1,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Send API HitLog",
                            style: TextStyle(color: Colors.black),
                          ))),
                  PopupMenuItem<int>(
                      value: 2,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Send API SuccessLog",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                      // Text("Send API SuccessLog"),
                      ),
                  PopupMenuItem<int>(
                      value: 3,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Send API FailureLog",
                            style: TextStyle(color: Colors.black),
                          ))
                      // Text("Send API FailureLog"),
                      ),
                  PopupMenuItem<int>(
                    value: 4,
                    child: TextButton(
                        child: Text(
                          "Settings",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          _showSettingDialog(context);
                          // _showCupertinoDialog();
                        }),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  print("Send ErrorLog");
                } else if (value == 1) {
                  print("Send API HitLog");
                } else if (value == 2) {
                  print("Send API SuccessLog");
                } else if (value == 3) {
                  print("Send API FailureLog");
                } else if (value == 4) {
                  _showSettingDialog(context);
                  // _showCupertinoDialog();
                  print("Settings");
                }
              }),
        ],
      ),
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "images/triangle.jpg",
                  ),
                  repeat: ImageRepeat.repeat),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //  SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Text(
                        "Cloud Contact Center",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            color: Color(0xff137CA6),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 148, 142, 142)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          blurStyle: BlurStyle.normal,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(),
                            child: Image.asset("images/profile.png")),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: loginId,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 11, color: Colors.white),
                                hintText: "Login Id",
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Login ID',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 68, 67, 67),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            obscureText: obscureText,
                            controller: passwordController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Password',
                              hintStyle:
                                  TextStyle(fontSize: 11, color: Colors.white),
                              hintText: "password",
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                color: Color.fromARGB(255, 68, 67, 67),
                                onPressed: _togglePasswordStatus,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Variables.username = loginId.text;
                            Variables.password = passwordController.text;
                            LoginService.serverip = serperip.text;
                            LoginService.serverport = serverport.text;

                            LoginService.serverpackage = serverpackage.text;

                            LoginService.getPreLogin(
                                loginId, passwordController, context);

                            // Timer? timer;
                            Timer timer = Timer(Duration(seconds: 2), () {
                              setState(() {
                                LoginService.getLogin(
                                    loginId, passwordController, context);
                              });
                            });
                          },
                          child: Container(
                            height: 45,
                            width: 180,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffe86024),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer__literals_to_create_immutables
                              children: [
                                Center(
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Text(
                        //     "EncryptText : ${EncryptData.encrypted != null ? EncryptData.encrypted?.base64 : ''}"),
                        // Text("DecryptText : ${EncryptData.decrypted ?? ''}")
                      ],
                    ),
                  ),
                  LoginService.showprogress == true
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding:  EdgeInsets.all(20.0),
          //     child: Text(
          //       "v3.19t",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20,
          //           color: Color(0xff03527B)),
          //     ),
          //   ),
          // )
          // ColoredBox(color: Colors.black.withOpacity(0.5))
        ],
      ),
    );
  }
}
