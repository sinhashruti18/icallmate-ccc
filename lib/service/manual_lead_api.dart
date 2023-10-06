// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_null_comparison, deprecated_member_use

import 'dart:convert';

import 'package:ccc_app/pages/dyna_form.dart';
import 'package:ccc_app/service/cls_logs.dart';
import 'package:ccc_app/service/login_apiservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CCCManualLead {
  static Future<bool?> alertDialog(BuildContext context, String text) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          // title: Text(''),
          content: Text(
            text,
            style: TextStyle(
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

  static Future createCCCManualLead(
      BuildContext context, var dialnumber) async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CreateCCCManualLead?";
    print("URL= $url");
    List msisdnAgentno = [];
    msisdnAgentno.add(LoginService.mobile_no);
    print("agent= $msisdnAgentno");
    var mybody = {
      "ukey": LoginService.ukey,
      "msisdn_agentno": msisdnAgentno,
      "msisdn_dialtono": dialnumber,
      "agentrowid": LoginService.agent_row_id
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method: createCCCManualLead(),\nurl:$url,\nbody:$mybody,\ndate:${DateTime.now()}");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          await alertDialog(context, message['value']);
          ClsLogs.API_SUCCESS(
              "date: ${DateTime.now()},\nmethod:createCCCManualLead(),\nurl:$url,\nbody:$mybody",
              "response: $message");
          print(response.body);
        } else {
          print("message=${message['value']}");

          await alertDialog(context, message['value']);

          // ScaffoldMessenger.of(context).showSnackBar(
          //      SnackBar(content: Text("Invalid Credentials")));
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //      SnackBar(content: Text("Blank field not allowed")));
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      ClsLogs.API_FAILURE(
          "date:${DateTime.now()},\nmethod:createCCCManualLead(),\nurl=$url,\nbody=$mybody,\nException:$e");
      print('Error in userLogin(): $e');

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }
}
