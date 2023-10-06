// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:convert';

import 'package:ccc_app/service/cls_logs.dart';
import 'package:flutter/material.dart';

import 'login_apiservice.dart';
import 'package:http/http.dart' as http;

class HealthCheck {
  static var breakname;
  static var isundispose;
  static Future fetchHealthCheck(BuildContext context) async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/HealthCheck?";
    print("URL= $url");
    var mybody = {
      "serviceno": LoginService.service_no,
      "agentno": LoginService.mobile_no,
      "loginid": LoginService.agent_login_id,
      "agentname": LoginService.agent_name,
      "userrowid": LoginService.userrowid,
      "agentrowid": LoginService.agent_row_id,
      "appversion": "APP-V3.23t",
      "agentusertype": LoginService.user_type
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method:fetchHealthCheck(),\nurl:$url,\nbody:$mybody,\ndate: ${DateTime.now()}");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);

        isundispose = message['isundispose'];
        print("undispose = $isundispose");
        breakname = message['breakid'];
        print("undispose = $breakname");

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");

          print(response.body);
          ClsLogs.API_SUCCESS(
              "method:fetchHealthCheck(),\nurl:$url,\nbody:$mybody",
              "response:${response.body},date:${DateTime.now()}");
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("cccip is null")));
      }
      // throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in (): $e');
      ClsLogs.API_FAILURE(
          "method:fetchHealthCheck(),\nurl:$url,\nbody: $mybody,\nException:$e,date:${DateTime.now()}");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }
}
