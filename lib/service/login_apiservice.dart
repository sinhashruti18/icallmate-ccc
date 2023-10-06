// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables, non_ant_identifier_names

import 'dart:convert';

import 'package:ccc_app/main.dart';
import 'package:ccc_app/service/cls_logs.dart';
import 'package:ccc_app/service/encryption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';

class LoginService {
  static String? serverip, serverport, serverpackage, agent_login_id, mobile_no;
  static String? first_name,
      last_name,
      agent_prefix,
      ukey,
      service_no,
      acpclusterwsurl,
      agent_name;

  static String? cccIP;
  static int? agent_row_id, userrowid, user_type;

  static bool? isenabelwsurl,
      enable_location,
      isc2cenabled,
      enable_loc_loginlogout,
      showprogress,
      enable_prefix;
  // static Future<void> saveLoginStatus(bool isLoggedIn) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', isLoggedIn);
  // }

  // static Future<bool> getLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isLoggedIn') ?? false;
  // }

  static Future getPreLogin(TextEditingController loginId,
      TextEditingController password, BuildContext context) async {
    String? url;
    String encryptedPassword = Encryptor.encrypt(password.text);
    print("encrypted= $encryptedPassword");

    if (serverip!.isNotEmpty &&
        serverport!.isNotEmpty &&
        serverpackage!.isNotEmpty) {
      url =
          "http://$serverip:$serverport/$serverpackage/webresources/getPreLogin";
      print("url1=$url");
    } else if (serverport!.isEmpty && serverpackage!.isEmpty) {
      url = "http://$serverip/webresources/getPreLogin";
      print("url2=$url");
    } else if (serverpackage!.isEmpty) {
      url = "http://$serverip:$serverport/webresources/getPreLogin";
      print("url3=$url");
    } else if (serverport!.isEmpty) {
      url = "http://$serverip/webresources/getPreLogin";
      print("url4=$url");
    } else {}
    var mybody = {
      "userid": loginId.text,
      "password": encryptedPassword,
      "appversion": "APP-V3.23t"
    };
    print("body= $mybody");

    ClsLogs.API_HIT(
        "method : getpreLogin(),\nurl= $url,\nbody=$mybody,\ndate= ${DateTime.now()}");

    print("URL= $url");
    // ClsLogs.logApiHit("url=$url");
    try {
      if (loginId.text.isNotEmpty && password.text.isNotEmpty) {
        var headers = {"Content-type": "application/json"};
        showprogress = true;

        var response = await http.post(Uri.parse(url!),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print("product info = ${message['productinfo']}");
        var pro = message['productinfo'].replaceAll(';', ',');

        print("product info ${message['productinfo'] ?? ''}");
        isenabelwsurl = message['isenabelwsurl'];
        acpclusterwsurl = message['acpclusterwsurl'];
        print("ws url enable= $isenabelwsurl");
        print("ws url = $acpclusterwsurl");

        List productinfolist = pro.split(',');
        var ind = productinfolist.indexOf("ContactCenter");
        var ind1 = ind + 1;
        cccIP = productinfolist[ind1];
        print("ccc=$cccIP");
        if (!cccIP!.endsWith("/")) {
          cccIP = ("${cccIP!}/");
          print("ccp ip with slash= $cccIP");
        }

        print(message['status']);

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          showprogress = true;
          print("ccc url= $cccIP");
          print(response.body);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //  pref.setBool("dialog", LoginService.dialog);
          preferences.setString('cccIp', cccIP!);
          preferences.setBool('isenabelwsurl', isenabelwsurl!);
          preferences.setString('acpclusterwsurl', acpclusterwsurl!);
          ClsLogs.API_SUCCESS(
              "method: getpreLogin(),\nurl= $url,\nbody: $mybody",
              "response:${response.body} ,\ndate:${DateTime.now()}");

          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Credentials")));
          showprogress = false;
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Blank field not allowed")));
        showprogress = false;
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "method: getPreLogin(),url: $url,body: $mybody,exception:$e,date:${DateTime.now()}");
      showprogress = false;

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  static Future getLogin(
    TextEditingController loginId,
    TextEditingController password,
    BuildContext context,
  ) async {
    String url;
    String encryptedPassword = Encryptor.encrypt(password.text);
    print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/getLogin";
    print("URL= $url");
    var mybody = {
      "userid": loginId.text,
      "password": encryptedPassword,
      "appversion": "APP-V3.23t"
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method : getLogin(),\nurl= $url,\nbody=$mybody,\ndate= ${DateTime.now()}");

    try {
      if (loginId.text.isNotEmpty && password.text.isNotEmpty) {
        var headers = {"Content-type": "application/json"};
        showprogress = true;

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);
        agent_login_id = message['agentloginid'];
        agent_row_id = message['agentrowid'];
        mobile_no = message['mobileno'];
        userrowid = message['userrowid'];
        user_type = message['agentusertype'];
        agent_name = message['firstname'];
        service_no = message['incserviceno'] ?? "";
        ukey = message['ukey'];
        enable_location = message['enable_location'];
        enable_loc_loginlogout = message['enable_loc_loginlogout'];
        isc2cenabled = message['isc2cenabled'];
        first_name = message['firstname'];
        last_name = message['lastname'];
        enable_prefix = message['enable_prefix'];
        agent_prefix = message['agent_prefix'];
        print("isc2cenabled= $isc2cenabled");

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          getCCCAgentAudit(loginId, password, context);
          showprogress = true;
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //  pref.setBool("dialog", LoginService.dialog);
          preferences.setString('agent_login_id', agent_login_id!);
          preferences.setString('agent_name', agent_name!);

          preferences.setString('mobile_no', mobile_no!);
          preferences.setString('service_no', service_no!);
          preferences.setString('ukey', ukey!);
          preferences.setString('first_name', first_name!);

          preferences.setString('last_name', last_name!);

          preferences.setInt('agent_row_id', agent_row_id!);
          preferences.setInt('userrowid', userrowid!);
          preferences.setInt('usertype', user_type!);
          preferences.setBool('enable_location', enable_location!);
          preferences.setBool(
              'enable_loc_loginlogout', enable_loc_loginlogout!);

          preferences.setBool('isc2cenabled', isc2cenabled!);

          preferences.setBool('enable_prefix', enable_prefix!);

          // await saveLoginStatus(true);

          print("url = $url");
          ClsLogs.API_SUCCESS("method: getLogin(),\nurl= $url,\nbody: $mybody",
              "response:${response.body} ,\ndate:${DateTime.now()}");

          print(response.body);
        } else {
          showprogress = false;
          // ScaffoldMessenger.of(context).showSnackBar(
          //      SnackBar(content: Text("Invalid Credentials")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Blank field not allowed")));
        showprogress = false;
      }
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "method: getLogin(),\nurl: $url,\nbody: $mybody,\nexception:$e,\ndate:${DateTime.now()}");
      showprogress = false;

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  static Future getCCCAgentAudit(TextEditingController loginId,
      TextEditingController password, BuildContext context) async {
    String? url;
    String encryptedPassword = Encryptor.encrypt(password.text);
    print("encrypted= $encryptedPassword");

    url = "${cccIP}webresources/CCCAgentAudit";
    print("URL= $url");
    var mybody = {
      "agent_no": mobile_no,
      "agent_state": "1",
      "agent_rowid": agent_row_id,
      "userrowid": userrowid,
      "agent_loginid": agent_login_id,
      "appversion": "APP-V3.23t"
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method : getCCCAgentAudit(),\nurl= $url,\nbody=$mybody,\ndate= ${DateTime.now()}");

    try {
      if (loginId.text.isNotEmpty && password.text.isNotEmpty) {
        var headers = {"Content-type": "application/json"};
        showprogress = true;

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print(message['status']);

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          showprogress = false;

          print(response.body);
          ClsLogs.API_SUCCESS(
              "method: getCCCAgentAudit(),\nurl= $url,\nbody: $mybody",
              "response:${response.body} ,\ndate:${DateTime.now()}");

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //      SnackBar(content: Text("Invalid Credentials")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Blank field not allowed")));
        showprogress = false;
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "method: getCCCAgentAudit(),\nurl: $url,\nbody: $mybody,\nexception:$e,\ndate:${DateTime.now()}");
      showprogress = false;

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }
}
