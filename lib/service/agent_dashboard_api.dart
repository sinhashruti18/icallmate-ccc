// ignore_for_file: avoid_print, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';

import 'package:ccc_app/model/ccc_camplist_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'login_apiservice.dart';
import 'package:http/http.dart' as http;

class AgentDashboardApi {
  static Future<List<GetCccCampList>> fetchCCCCamplist(
      var todate, var fromdate) async {
    String? endpoint;
    endpoint = "${LoginService.cccIP}/webresources/GetCCCCampList?";

    print("endpoint= $endpoint");

    var headers = {"Content-type": "application/json"};
    var mybody = {
      "ukey": LoginService.ukey,
      "fromdate": fromdate.toString().substring(0, 10),
      "todate": todate.toString().substring(0, 10),
      "isagent": true,
      "agentno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
    };
    print("body=$mybody");
    // ClsLogs.API_HIT(
    //     "Method:fetchOBDcamplist()\nurl:$endpoint\nbody:$mybody\ndate:${DateTime.now()}");
    try {
      Response response = await http.post(Uri.parse(endpoint),
          headers: headers, body: json.encode(mybody));
      var message = json.decode(response.body);
      List jsonResponse = message['value']['ccccamplist'] ?? [];
      print("camp time${message['ccccamplist']}");
      print(response.body);
      print("jsonresponse= $jsonResponse");
      print("scheduled date time = ${message['datetime']}");

      if (response.statusCode == 200 && message['status'] == "success") {
        print(response.body);
        // ClsLogs.API_SUCCESS("Method:fetchOBDcamplist()\nurl:$endpoint",
        //     "response:${response.body}\ndate:${DateTime.now()}");

        return jsonResponse.map(((e) => GetCccCampList.fromJson(e))).toList();
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      // ClsLogs.API_FAILURE(
      //     "Method:fetchOBDcamplist()\nurl:$endpoint\nresponse:$e\ndate:${DateTime.now()}");

      print(e);
      rethrow;
    }
  }

  static Future<List<GetCccCampList>> getCCCAgentCallDashBoard(
      var todate, var fromdate) async {
    String? endpoint;
    endpoint = "${LoginService.cccIP}/webresources/GetCCCCampList?";

    print("endpoint= $endpoint");

    var headers = {"Content-type": "application/json"};
    var mybody = {
      "ukey": LoginService.ukey,
      "fromdate": fromdate.toString().substring(0, 10),
      "todate": todate.toString().substring(0, 10),
      "isagent": true,
      "agentno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
    };
    print("body=$mybody");
    // ClsLogs.API_HIT(
    //     "Method:fetchOBDcamplist()\nurl:$endpoint\nbody:$mybody\ndate:${DateTime.now()}");
    try {
      Response response = await http.post(Uri.parse(endpoint),
          headers: headers, body: json.encode(mybody));
      var message = json.decode(response.body);
      List jsonResponse = message['value']['ccccamplist'] ?? [];
      print("camp time${message['ccccamplist']}");
      print(response.body);
      print("jsonresponse= $jsonResponse");
      print("scheduled date time = ${message['datetime']}");

      if (response.statusCode == 200 && message['status'] == "success") {
        print(response.body);
        // ClsLogs.API_SUCCESS("Method:fetchOBDcamplist()\nurl:$endpoint",
        //     "response:${response.body}\ndate:${DateTime.now()}");

        return jsonResponse.map(((e) => GetCccCampList.fromJson(e))).toList();
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      // ClsLogs.API_FAILURE(
      //     "Method:fetchOBDcamplist()\nurl:$endpoint\nresponse:$e\ndate:${DateTime.now()}");

      print(e);
      rethrow;
    }
  }

  static Future getCCCagentCallDashBoard(
      BuildContext context, var leadid, var fromdate) async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCAgentCallDashboard?";
    print("URL= $url");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};
        var mybody = {
          "panel_leadid": leadid,
          "agent_no": LoginService.mobile_no,
          "ukey": LoginService.ukey,
          "agentusertype": LoginService.user_type,
          "fromdate": fromdate.toString().substring(0, 10),
        };
        print("body= $mybody");

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);

        if (response.statusCode == 200 && message['status'] == "Success") {
          print(response.statusCode == 200);
          print("url = $url");

          print(response.body);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("cccip is null")));
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }
}
