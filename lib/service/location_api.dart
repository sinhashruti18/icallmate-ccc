// ignore_for_file: unnecessary_null_comparison, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:ccc_app/service/cls_logs.dart';
import 'package:flutter/material.dart';

import 'login_apiservice.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static Future fetchLocation(BuildContext context, var date, double lat,
      double long, String location) async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/SetGISLocation?";
    print("URL= $url");
    var mybody = {
      "ukey": LoginService.ukey,
      "imeino": "356938035643809",
      "latitude": lat,
      "longitude": long,
      "location": location,
      "datetime": date.toString().substring(0, 10),
      "agentrowid": LoginService.agent_row_id,
      "userrowid": LoginService.userrowid
    };
    ClsLogs.API_HIT(
        "method:fetchLocation(),\nurl:$url,\nbody:$mybody,date:${DateTime.now()}");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        print("body= $mybody");

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()},\nmethod:locationFetch(),\nurl:$url,\nbody:$mybody\n",
              "response:$message");

          print(response.body);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${message['value']}")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("cccip is null")));
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in (): $e');
      ClsLogs.API_FAILURE(
          "method:fetchLocation(),\nurl:$url,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }
}
