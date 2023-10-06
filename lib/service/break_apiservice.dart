// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';

import 'package:ccc_app/model/break_model.dart';
import 'package:ccc_app/service/cls_logs.dart';
import 'package:ccc_app/service/manual_lead_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'login_apiservice.dart';
import 'package:http/http.dart' as http;

class BreakService {
  static var value2;
  static String? break_name;

  static Future<List<BreakList>> fetchBreakList() async {
    // String endpoint;
    String endpoint = "${LoginService.cccIP}webresources/GetCCCUserBreak";
    print("endpoint= $endpoint");

    var headers = {"Content-type": "application/json"};
    var mybody = {
      "agentrowid": LoginService.agent_row_id,
      "ukey": LoginService.ukey,
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "date: ${DateTime.now()}\nmethod: fetchBreakList(),\nurl=$endpoint,\nbody:$mybody");

    try {
      Response response = await http.post(Uri.parse(endpoint),
          headers: headers,
          //     body: utf8.encode(json.encode(mybody)));
          body: json.encode(mybody));
      var message = json.decode(response.body);
      List? jsonResponse;

      if (message['value'] is String) {
        print("messd${message['value']}");
        value2 = message['value'];
        print("value=$value2");

        // handle string value of "value" key
      } else {
        jsonResponse = message['value'] ?? [];
        print("json= $jsonResponse");

        // handle JSON object or array value of "value" key
      }
      print("message=${message['value']}");
      print("mess= $message");
      print("${message['value']}");
      print("response=${response.body}");

      if (response.statusCode == 200) {
        ClsLogs.API_SUCCESS(
            "date:${DateTime.now()}\nmethod:fetchBreakList()\nurl=$endpoint,\nbody:$mybody",
            "response: ${response.body}");
        //&& message['status'] == "success"

        // final List result = jsonDecode(response.body)['obdcamplist'] ??

        // ignore: avoid_print
        print(response.body);

        return jsonResponse!.map(((e) => BreakList.fromJson(e))).toList();
      } else {
        print("failure");
        throw Exception();
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      ClsLogs.API_FAILURE(
          "date: ${DateTime.now()}\nmethod: fetchBreakList(),\nurl=$endpoint,\nbody:$mybody,\nException: $e");
      print(e);
      print("fail");
      rethrow;
    }
  }
  // static Future<List<BreakList>> fetchBreakList() async {
  //   String endpoint = "${LoginService.cccIP}/webresources/GetCCCUserBreak";

  //   var headers = {"Content-type": "application/json"};
  //   var mybody = {
  //     "agentrowid": LoginService.agent_row_id,
  //     "ukey": LoginService.ukey,
  //   };
  //   try {
  //     Response response = await http.post(Uri.parse(endpoint),
  //         headers: headers, body: json.encode(mybody));
  //     var message = json.decode(response.body);
  //     List jsonResponse = message['value'];

  //     print("message=$message");
  //     print(response.body);
  //     if (message['value'] is String) {
  //       print("messd${message['value']}");
  //       value2 = message['value'];
  //       print("value=$value2");

  //       // handle string value of "value" key
  //     } else {
  //       jsonResponse = message['value'] ?? [];
  //       print("json= $jsonResponse");

  //       // handle JSON object or array value of "value" key
  //     }

  //     // print("json response= $jsonResponse");

  //     if (response.statusCode == 200 && message['status'] == "success") {
  //       print(response.body);

  //       return jsonResponse.map(((e) => BreakList.fromJson(e))).toList();
  //     } else {
  //       throw Exception();
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  static Future setBreak(BuildContext context, var breakid) async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCSetAgentBreak";
    print("URL= $url");
    var mybody = {
      "agentrowid": LoginService.agent_row_id,
      "ukey": LoginService.ukey,
      "breakid": breakid ?? 0,
      "breaktype": 1,
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "date: ${DateTime.now()}\nmethod: setBreak(),\nurl=$url,\nbody:$mybody");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);

        if (response.statusCode == 200 && message['status'] == "Success") {
          print(response.statusCode == 200);
          print("url = $url");
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()}\nmethod:setBreak()\nurl=$url,\nbody:$mybody",
              "response: ${response.body}");

          print(response.body);
          CCCManualLead.alertDialog(context, message['value']);
        } else {
          CCCManualLead.alertDialog(context, message['value']);
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("cccip is null")));
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "date: ${DateTime.now()}\nmethod: setBreak(),\nurl=$url,\nbody:$mybody,\nException: $e");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  static Future releaseBreak(BuildContext context, var breakid) async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCSetAgentBreak";
    print("URL= $url");
    var mybody = {
      "agentrowid": LoginService.agent_row_id,
      "ukey": LoginService.ukey,
      "breakid": breakid ?? 0,
      "breaktype": 0,
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "date: ${DateTime.now()}\nmethod: releaseBreak(),\nurl=$url,\nbody:$mybody");

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
          CCCManualLead.alertDialog(context, message['value']);
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()}\nmethod:releaseBreak()\nurl=$url,\nbody:$mybody",
              "response: ${response.body}");

          print(response.body);
        } else {
          CCCManualLead.alertDialog(context, message['value']);
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("cccip is null")));
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "date: ${DateTime.now()}\nmethod: releaseBreak(),\nurl=$url,\nbody:$mybody,\nException: $e");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
}
