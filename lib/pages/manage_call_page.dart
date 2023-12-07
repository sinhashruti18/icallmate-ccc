// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, prefer_typing_uninitialized_variables, avoid_print, prefer_null_aware_operators, use_build_context_synchronously, non_ant_identifier_names, depend_on_referenced_packages, unused_field, unused_local_variable, unnecessary_this

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ccc_app/model/previewlist_model.dart';
import 'package:ccc_app/pages/dyna_form.dart';
import 'package:ccc_app/service/alert_message.dart';
import 'package:ccc_app/service/cls_logs.dart';
import 'package:ccc_app/service/healthcheck_api.dart';
import 'package:ccc_app/service/message_alert.dart';
import 'package:ccc_app/widget/myappbar.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../model/ccc_camplist_model.dart';
import '../service/login_apiservice.dart';
import '../widget/drawer_widget.dart';
// import '../../model/model.dart';
// import 'manage_obd_campaign.dart';

// ignore: must_be_immutable
class ManageCallPage extends StatefulWidget {
  String? server,
      port,
      package_name,
      ukey,
      obdserver,
      obdpackage,
      smsserver,
      smspackage,
      c2cserver,
      http_request,
      c2cpackage;

  List? productinfolist;
  ManageCallPage(
      {Key? key,
      this.server,
      this.port,
      this.c2cserver,
      this.c2cpackage,
      this.package_name,
      this.obdpackage,
      this.obdserver,
      this.smsserver,
      this.smspackage,
      this.ukey,
      this.http_request,
      this.productinfolist})
      : super(key: key);

  @override
  State<ManageCallPage> createState() => _ManageCallPageState();
}

class _ManageCallPageState extends State<ManageCallPage> {
  DateTime _selectedDate = DateTime.now();
  var dateTime = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
  var date;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool valuefirst = false;
  late Position _currentPosition;
  late String _currentAddress;
  String? location;
  String? adminarea;

  String? street;

  String? sublocality;
  String? locality;
  String? country;
  double? lat;
  double? long;
  double? previous_lat;
  double? previous_long;
  bool ischecked = false;
  Position? currentPosition;
  Position? _previousPosition;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.

  // bool valuesecond = false;

  void _presentDatePicker() async {
    date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {}

      setState(() {
        _selectedDate = pickedDate!;
        print("selected date= $_selectedDate");
        _func = getCCCCampList();

        // _func = fetchOBDcamplist();
      });
    });
  }

  var apidata;
  String title = "Admin";
  bool check_btn = false;
  var record_message;

  Future<List<GetCccPreviewList>> getPreviewList() async {
    String uri = "${LoginService.cccIP}webresources/GetCCCPreviewList?";

    // Map<String, String> headers = {
    //   "Content-type": "application/json",
    //   "ukey": "${widget.ukey}",
    //   "authorization": "Bearer ${widget.auth}"
    // };
    // "http://192.168.68.128:8081/iUnifyMate/getAgentTaskList?agentID=${widget.agentID}&campID=${widget.campId}&dateTime=2023-02-01:45:53&ticketId=202";
    print("uri===$uri");
    var headers = {"Content-type": "application/json"};
    var requestBody = {
      "localleadid": selected,
      "recordid": recordid,
      "command": command,
      "agent_phoneno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
      "isundialedno": valuefirst,
      "isFirstRecord": true
    };
    print("body= $requestBody");
    ClsLogs.API_HIT(
        ",date:${DateTime.now()}\nmethod:getPreviewList(),\nurl:$uri,\nbody:$requestBody");
    // "http://192.168.68.128:8081/iUnifyMate/getAgentTaskList?agentID=1006&campID=193&dateTime=2023-02-01:45:53&ticketId=202";
    try {
      final response = await http.post(Uri.parse(uri),
          headers: headers, body: utf8.encode(json.encode(requestBody)));

      if (response.statusCode == 200) {
        print("response= ${response.body}");
        print("urlllll = $uri");
        var mess = json.decode(response.body);
        List jsonResponse = mess['value'] ?? [];
        print("resonse= ${response.body}");
        ClsLogs.API_SUCCESS(
            "date:${DateTime.now()},\nmethod:getPreviewList(),\nurl:$uri,\nbody:$requestBody\n",
            "response:$mess");

        print("json response $jsonResponse");
        return jsonResponse.map((e) => GetCccPreviewList.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ClsLogs.API_FAILURE(
          "method:getPreviewList(),\nurl:$uri,\nbody:$requestBody,\nException:$e\ndate:${DateTime.now()}");

      throw Exception(e);
    }
  }

  var isautodiallead, isincenabled;
  Future<List<GetCccCampList>> getCCCCampList() async {
    String endpoint = "${LoginService.cccIP}webresources/GetCCCCampList?";
    var headers = {"Content-type": "application/json"};
    var mybody = {
      "ukey": LoginService.ukey,
      "fromdate": _selectedDate.toString().substring(0, 10),
      "isagent": true,
      "agentno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
    };

    print("url= $endpoint");
    print("body=$mybody");
    ClsLogs.API_HIT(
        "method:getCCCCampList(),\nurl:$endpoint,\nbody:$mybody,date:${DateTime.now()}");

    try {
      Response response = await http.post(Uri.parse(endpoint),
          headers: headers, body: json.encode(mybody));

      var jsonResponse = json.decode(response.body);
      List<GetCccCampList> campList = [];

      if (jsonResponse['value'] is String) {
        print("messd${jsonResponse['value']}");
        record_message = jsonResponse['value'];
      } else {
        var cccamplist = jsonResponse['value']['ccccamplist'] ?? [];
        print("json= $cccamplist");
        print("isautodial= $isautodiallead");
        record_message = "";

        if (cccamplist.isNotEmpty) {
          campList = cccamplist
              .map<GetCccCampList>((e) => GetCccCampList.fromJson(e))
              .toList();
          var firstItem = cccamplist[0];
          isautodiallead = firstItem['isautodiallead'];
          isincenabled = firstItem['isinc_enable'];
          serviceno = firstItem['serviceno'];

          print("is auto dial= $isautodiallead");
          print("is inc-enable= $isincenabled");
          print("service number= $serviceno");

          // Use the value of `isAutoDialStarted` as needed
        }
      }

      print("response=${response.body}");
      if (response.statusCode == 200) {
        print(response.body);
        ClsLogs.API_SUCCESS(
            "date:${DateTime.now()},\nmethod:getCCCCampList(),\nurl:$endpoint,\nbody:$mybody\n",
            "response:${response.body}");

        return campList;
      } else {
        print("failure");
        throw Exception();
      }
    } catch (e) {
      print(e);
      print("fail");
      ClsLogs.API_FAILURE(
          "method:getCCCCampList(),\nurl:$endpoint,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");
      rethrow;
    }
  }

  var recordid = 0;
  var command = 1;

  var autodialMode = 1;
  Future SetCCCAutoDialingNo() async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCAutoDialingNo";
    print("URL= $url");
    var mybody = {
      "panel_leadid": selected,
      "mode": autodialMode,
      "agentno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method:SetCCCAutoDialingNo(),\nurl:$url,\nbody:$mybody,date:${DateTime.now()}");

    try {
      if (LoginService.cccIP != null) {
        // autodialMode = 1;
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print("messagingggg=${message['value']}");

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          check_btn = true;
          MessageAlert.alertDialog(context, message['value']);
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()},\nmethod:SetCCCAutoDialingNo(),\nurl:$url,\nbody:$mybody\n",
              "response:${response.body}");

          // total_dialed = message['total_dialed'];
          // total_unique_dialed = message['total_unique_dialed'];
          // total_contacted = message['total_contacted'];
          // total_notcontacted = message['total_notcontacted'];
          // total_uploaded = message['total_uploaded'];
          // total_unattempted = message['total_unattempted'];
          // avg_talktime = message['avg_talktime'];
          // avg_acwtime = message['avg_acwtime'];
          // total_acwtime = message['total_acwtime'];
          // total_breaktime = message['total_breaktime'];
          // total_talktime = message['total_talktime'];
          // nooffollowups = message['total_uploaded_followup'];
          // total_dialed_followup = message['total_dialed_followup'];
          // total_dialed_callback = message['total_dialed_callback'];
          // total_contacted_callback = message['total_contacted_callback'];

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
      ClsLogs.API_FAILURE(
          "method:SetCCCAutoDialingNo(),\nurl:$url,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  Future SetCCCStopAutoDialingNo() async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCAutoDialingNo";
    print("URL= $url");
    var mybody = {
      "panel_leadid": selected,
      "mode": 2,
      "agentno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method:SetCCCStopAutoDialingNo(),\nurl:$url,\nbody:$mybody,date:${DateTime.now()}");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print("messagingggg=${message['value']}");

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          check_btn = false;
          MessageAlert.alertDialog(context, message['value']);
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()},\nmethod:SetCCCStopAutoDialingNo(),\nurl:$url,\nbody:$mybody\n",
              "response:${response.body}");

          // total_dialed = message['total_dialed'];
          // total_unique_dialed = message['total_unique_dialed'];
          // total_contacted = message['total_contacted'];
          // total_notcontacted = message['total_notcontacted'];
          // total_uploaded = message['total_uploaded'];
          // total_unattempted = message['total_unattempted'];
          // avg_talktime = message['avg_talktime'];
          // avg_acwtime = message['avg_acwtime'];
          // total_acwtime = message['total_acwtime'];
          // total_breaktime = message['total_breaktime'];
          // total_talktime = message['total_talktime'];
          // nooffollowups = message['total_uploaded_followup'];
          // total_dialed_followup = message['total_dialed_followup'];
          // total_dialed_callback = message['total_dialed_callback'];
          // total_contacted_callback = message['total_contacted_callback'];

          print(response.body);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("cccip is null")));
      }
      throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "method:SetCCCStopAutoDialingNo(),\nurl:$url,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  Future getCCCPreviewList() async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/GetCCCPreviewList?";
    print("URL= $url");
    var mybody = {
      "localleadid": selected,
      "recordid": 2,
      "command": 1,
      "agent_phoneno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
      "isundialedno": valuefirst
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method:getCCCPreviewList(),\nurl:$url,\nbody:$mybody,date:${DateTime.now()}");
    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print("messagingggg=${message['value']}");

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          check_btn = false;
          MessageAlert.alertDialog(context, message['value']);
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()},\nmethod:getCCCPreviewList(),\nurl:$url,\nbody:$mybody\n",
              "response:${response.body}");

          // total_dialed = message['total_dialed'];
          // total_unique_dialed = message['total_unique_dialed'];
          // total_contacted = message['total_contacted'];
          // total_notcontacted = message['total_notcontacted'];
          // total_uploaded = message['total_uploaded'];
          // total_unattempted = message['total_unattempted'];
          // avg_talktime = message['avg_talktime'];
          // avg_acwtime = message['avg_acwtime'];
          // total_acwtime = message['total_acwtime'];
          // total_breaktime = message['total_breaktime'];
          // total_talktime = message['total_talktime'];
          // nooffollowups = message['total_uploaded_followup'];
          // total_dialed_followup = message['total_dialed_followup'];
          // total_dialed_callback = message['total_dialed_callback'];
          // total_contacted_callback = message['total_contacted_callback'];

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
      ClsLogs.API_FAILURE(
          "method:getCCCPreviewList(),\nurl:$url,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  var phoneid,
      dialToConnectrowid,
      calledno,
      platformleadid,
      mappingrowid,
      serviceno;
  Future CCCDialToConnect(var localeadid) async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print("itrackmate login positions= $userLocation");
    List<Placemark> placemarks = await placemarkFromCoordinates(
      userLocation.latitude,
      userLocation.longitude,
    );
    print("itrackmate login placemrk= $placemarks");
    if (placemarks.isNotEmpty) {
      street = "${placemarks[0].street},${placemarks[0].name}";
      sublocality =
          '${placemarks[0].subLocality},${placemarks[0].subAdministrativeArea},';
      locality =
          '${placemarks[0].locality},${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
      country = '${placemarks[0].country}';
      lat = userLocation.latitude;
      long = userLocation.longitude;
      print("$street,$sublocality,$locality");
    }
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCDialToConnect";
    print("URL= $url");
    var mybody;
    if (LoginService.enable_location == true) {
      mybody = {
        "ukey": LoginService.ukey,
        "uniquekey":
            "${LoginService.agent_row_id}$selected$phoneid$dialToConnectrowid",
        "serviceno": serviceno,
        "callerno": LoginService.mobile_no,
        "calledno": calledno,
        "credittype": "2",
        "referenceno":
            "${LoginService.first_name}${LoginService.last_name ?? ""}",
        "localleadid": selected,
        "platformleadid": platformleadid,
        "recordid": dialToConnectrowid,
        "ecp_recordid": dialToConnectrowid,
        "mappingrowid": mappingrowid,
        "phoneid": phoneid,
        "enable_prefix": LoginService.enable_prefix,
        "agent_prefix": LoginService.agent_prefix,
        "isinc_enable": false,
        "latitude": lat ?? 0.0,
        "longitude": long ?? 0.0,
        "location": "$street$locality$sublocality$country",
      };
    } else {
      mybody = {
        "ukey": LoginService.ukey,
        "uniquekey":
            "${LoginService.agent_row_id}$selected$phoneid$dialToConnectrowid",
        "serviceno": serviceno,
        "callerno": LoginService.mobile_no,
        "calledno": calledno,
        "credittype": "2",
        "referenceno":
            "${LoginService.first_name}${LoginService.last_name ?? ""}",
        "localleadid": selected,
        "platformleadid": platformleadid,
        "recordid": dialToConnectrowid,
        "ecp_recordid": dialToConnectrowid,
        "mappingrowid": mappingrowid,
        "phoneid": phoneid,
        "enable_prefix": LoginService.enable_prefix,
        "agent_prefix": LoginService.agent_prefix,
        "isinc_enable": isincenabled,
        // "latitude":  0.0,
        // "longitude": long ?? 0.0,
      };
    }

    print("body= $mybody");
    ClsLogs.API_HIT(
        "method: CCCDialToConnect(),\nurl:$url,\nbody:$mybody,\ndate:${DateTime.now()}");

    try {
      if (LoginService.cccIP != null) {
        var headers = {"Content-type": "application/json"};

        var response = await http.post(Uri.parse(url),
            headers: headers, body: utf8.encode(json.encode(mybody)));
        print("login api= $url");
        var message = json.decode(response.body);

        print('message:$message');
        print("messagingggg=${message['value']}");

        if (response.statusCode == 200 && message['status'] == "success") {
          print(response.statusCode == 200);
          print("url = $url");
          check_btn = false;
          MessageAlert.alertDialog(context, message['status']);
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     builder: (context) => CRMPage(
          //           localleadid: localeadid,
          //         )));

          ClsLogs.API_SUCCESS(
              "date: ${DateTime.now()},\nmethod:CCCDialToConnect(),\nurl:$url,\nbody:$mybody",
              "response: $message");

          // MessageAlert.alertDialog(context, message['value']);
          // total_dialed = message['total_dialed'];
          // total_unique_dialed = message['total_unique_dialed'];
          // total_contacted = message['total_contacted'];
          // total_notcontacted = message['total_notcontacted'];
          // total_uploaded = message['total_uploaded'];
          // total_unattempted = message['total_unattempted'];
          // avg_talktime = message['avg_talktime'];
          // avg_acwtime = message['avg_acwtime'];
          // total_acwtime = message['total_acwtime'];
          // total_breaktime = message['total_breaktime'];
          // total_talktime = message['total_talktime'];
          // nooffollowups = message['total_uploaded_followup'];
          // total_dialed_followup = message['total_dialed_followup'];
          // total_dialed_callback = message['total_dialed_callback'];
          // total_contacted_callback = message['total_contacted_callback'];

          print("respo=${response.body}");
        } else {
          MessageAlert.alertDialog(context, message['value']);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("cccip is null")));
      }
      // throw (Exception);
    } catch (e) {
      // Handle other exceptions
      print('Error in userLogin(): $e');
      ClsLogs.API_FAILURE(
          "date:${DateTime.now()},\nmethod:CCCDialToConnect(),\nurl=$url,\nbody=$mybody,\nException:$e");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      lat = _currentPosition.latitude;
      long = _currentPosition.longitude;

      // previous_lat = lat;
      // previous_long = long;

      print("latitude=$lat");
      print("longitude=$long");

      Placemark place = placemarks[0];
      if (mounted) {
        setState(() {
          street = '${place.street},${place.name}';
          sublocality = '${place.subLocality},${place.subAdministrativeArea},';
          locality =
              '${place.locality},${place.administrativeArea}, ${place.postalCode}';
          country = '${place.country}';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Timer? timer;

  String? package1;
  String? port1;
  String? server1;
  String? ukey1;
  List? drawerlist;
  List listToSearch = [
    {'name': 'Amir', 'class': 12},
    {'name': 'Raza', 'class': 11},
    {'name': 'Praksh', 'class': 10},
    {'name': 'Nikhil', 'class': 9},
    {'name': 'Sandeep', 'class': 8},
    {'name': 'Tazeem', 'class': 7},
    {'name': 'Najaf', 'class': 6},
    {'name': 'Izhar', 'class': 5},
  ];

  var selected;
  List? selectedList;
  Future<List<GetCccCampList>>? _func;
  Future<List<GetCccPreviewList>>? _func2;

  @override
  void initState() {
    _getCurrentLocation();

    print("selected=$selected");
    _func = getCCCCampList();
    print("valuee=$record_message");
    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _func = getCCCCampList();
          print("after timer valuee=$record_message");
        });
      }
    });
    Timer mytimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          check_btn;
          record_message;
          print("btn =$check_btn");
          print("message =$record_message");
        });
      }

      //code to run on every 5 seconds
    });
    if (mounted) {
      timer = Timer.periodic(
          const Duration(seconds: 10),
          (Timer t) => setState(() {
                _getCurrentLocation();
                print("street= $street,$locality,$sublocality,$country");
              }));
    }
    // _func = fetchOBDcamplist();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          drawer: DrwaerWidget(),
          appBar: MyAppbar(
            title: "Manage Call",
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/triangle.jpg"),
                  repeat: ImageRepeat.repeat),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                // TitleWidget(title: "Manage OBD Campaigns"),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = _selectedDate
                                  .subtract(const Duration(days: 1));
                              _func = getCCCCampList();

                              // _func = fetchOBDcamplist();

                              print(dateTime);
                            });
                          },
                          child: const Icon(Icons.arrow_back)),
                      GestureDetector(
                        onTap: () {
                          _presentDatePicker();
                          setState(() {});
                        },
                        child: Text(
                          _selectedDate == null
                              ? DateTime.now().toString().substring(0, 10)
                              : _selectedDate.toString().substring(0, 10),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(255, 129, 129, 129)),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     _presentDatePicker();
                      //   },
                      //   child:  Icon(
                      //     Icons.calendar_month,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          print("date== $dateTime");
                          setState(() {
                            _selectedDate =
                                _selectedDate.add(Duration(days: 1));
                            if (_selectedDate.compareTo(DateTime.now()) > 0) {
                              _selectedDate = DateTime.now();
                            }

                            _func = getCCCCampList();

                            // _func = fetchOBDcamplist();

                            print("time=$_selectedDate");

                            // dateTime =
                            //     DateFormat('yyyy-MM-dd').format(DateTime.now());
                          });

                          // if(dateTime >)
                          // if(dateTime > DateTime.now()
                          //         .subtract(Duration(days: 1))
                          //         .toString())
                          // // if (dateTime != DateTime.now()) {
                          // setState(() {
                          //   dateTime = da.add(Duration(days: 1)).toString();
                          // });
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Camapaign",
                          style: TextStyle(
                              color: Color.fromARGB(255, 109, 108, 108),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // record_message != "No Record Found"
                      //     ?
                      record_message != "No Record Found"
                          ? FutureBuilder(
                              future: _func,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<GetCccCampList> data =
                                      snapshot.data as List<GetCccCampList>;
                                  print("data=$data");
                                  return Expanded(
                                    flex: 3,
                                    child: CustomSearchableDropDown(
                                      dropdownHintText: "Select Campaign",
                                      menuHeight: 100,
                                      items: data,
                                      hint: "Select Campaign",
                                      label: 'Select Campaign',
                                      labelStyle:
                                          const TextStyle(color: Colors.red),
                                      decoration: const BoxDecoration(),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.all(0.0),
                                      ),
                                      dropDownMenuItems: data.map((item) {
                                        return item.leadname;
                                      }).toList(),
                                      onChanged: (dynamic value) {
                                        GetCccCampList selectedValue =
                                            value as GetCccCampList;

                                        print("value= $value");
                                        if (value != null) {
                                          setState(() {
                                            selected =
                                                selectedValue.leadid.toString();
                                            // getCCCPreviewList();
                                            _func2 = getPreviewList();
                                          });
                                          print("lead id= $selected");
                                          // getCCCagentCallDashBoard();
                                        } else {
                                          setState(() {
                                            selected = null;
                                          });
                                        }
                                      },
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print(snapshot.hasError);
                                  return Text("${snapshot.error}");
                                }
                                return const CircularProgressIndicator(
                                    color: Colors.blue);
                              },
                            )
                          : record_message == null
                              ? Expanded(
                                  flex: 3,
                                  child: CustomSearchableDropDown(
                                    dropdownHintText: "Select Campaign",
                                    menuHeight: 100,
                                    items: const [],
                                    hint: "Select Campaign",
                                    label: 'Select Campaign',
                                    labelStyle:
                                        const TextStyle(color: Colors.red),
                                    decoration: const BoxDecoration(),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                    dropDownMenuItems: const [],
                                    onChanged: (value) {
                                      if (value != null) {
                                        selected = value['class'].toString();
                                      } else {
                                        selected = null;
                                      }
                                    },
                                  ),
                                )
                              : Expanded(
                                  flex: 3,
                                  child: CustomSearchableDropDown(
                                    dropdownHintText: "Select Campaign",
                                    menuHeight: 100,
                                    items: const [],
                                    hint: "Select Campaign",
                                    label: 'Select Campaign',
                                    labelStyle:
                                        const TextStyle(color: Colors.red),
                                    decoration: const BoxDecoration(),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                    dropDownMenuItems: const [],
                                    onChanged: (value) {
                                      if (value != null) {
                                        selected = value['class'].toString();
                                      } else {
                                        selected = null;
                                      }
                                    },
                                  ),
                                )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // SizedBox(
                      //   width: 10,
                      // ),
                      const Text(
                        'Show Undialed Only',
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.greenAccent,
                            activeColor: Colors.red,
                            value: this.valuefirst,
                            onChanged: (bool? value) {
                              setState(() {
                                this.valuefirst = value!;
                                print("value= $value");
                                _func2 = getPreviewList();
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              isautodiallead == true
                                  ? check_btn == false
                                      ? SetCCCAutoDialingNo()
                                      : SetCCCStopAutoDialingNo()
                                  : print("Auto dial not enable");
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: isautodiallead == true
                                      ? const Color.fromARGB(255, 228, 67, 27)
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: check_btn == false
                                    ? const Text(
                                        "START",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )
                                    : const Text(
                                        "STOP",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      )
                      // Checkbox(
                      //   value: this.valuesecond,
                      //   onChanged: (bool value) {
                      //     setState(() {
                      //       this.valuesecond = value;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                selected != null
                    ? FutureBuilder(
                        future: _func2,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<GetCccPreviewList> data =
                                snapshot.data as List<GetCccPreviewList>;

                            return data.isNotEmpty
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          child: SingleChildScrollView(
                                              child: DataTable(
                                            showCheckboxColumn: false,
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                              (states) {
                                                return const Color(0xffAAAAAA);

                                                //  Color.fromARGB(
                                                //     255, 5, 1, 39);
                                              },
                                            ),
                                            showBottomBorder: true,
                                            dividerThickness: 0.5,
                                            border: TableBorder.all(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            columnSpacing: 15,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 158, 158, 158),
                                            )),
                                            columns: [
                                              DataColumn(
                                                label: Center(
                                                    child: Text(
                                                  '     Status',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                              ),
                                              DataColumn(
                                                label: Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    'Phone Number',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Center(
                                                    child: Text(
                                                  'Attempts',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                              DataColumn(
                                                label: Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    'Call Time',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    'Dial',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              ),
                                            ],
                                            rows: List.generate(
                                                data.length,
                                                (index) => DataRow(
                                                        color: MaterialStateProperty
                                                            .resolveWith<
                                                                Color>((Set<
                                                                    MaterialState>
                                                                states) {
                                                          // Even rows will have a grey color.
                                                          if (index % 2 == 0) {
                                                            return Color
                                                                    .fromARGB(
                                                                        255,
                                                                        222,
                                                                        220,
                                                                        228)
                                                                .withOpacity(
                                                                    0.3);
                                                          }
                                                          return Colors
                                                              .white; // Use default value for other states and odd rows.
                                                        }),
                                                        onSelectChanged:
                                                            (bool? selected) {
                                                          if (selected ==
                                                              true) {
                                                            // alertDialog(
                                                            //     context,
                                                            //     data[index]
                                                            //         .templateSms);
                                                          }
                                                        },
                                                        cells: [
                                                          DataCell(Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            width: 140,
                                                            child: Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              "${data[index].callStatus ?? ""}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          )),
                                                          DataCell(Center(
                                                            child: Text(
                                                                "${data[index].phoneno ?? ""}"),
                                                            // var date_Time = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
                                                            // var dat = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                                          )),
                                                          DataCell(Center(
                                                            child: Text(
                                                              "${data[index].retryattempt ?? ""}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                          DataCell(Center(
                                                              child: Text(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  "${data[index].cbtime ?? ""}"))),
                                                          DataCell(
                                                              GestureDetector(
                                                            onTap: () {
                                                              // if (LoginService
                                                              //         .isc2cenabled ==
                                                              //     true) {
                                                              if (HealthCheck
                                                                      .isundispose ==
                                                                  0) {
                                                                phoneid = data[
                                                                        index]
                                                                    .phoneid;
                                                                dialToConnectrowid =
                                                                    data[index]
                                                                        .dialtoconnectrowid;
                                                                platformleadid =
                                                                    data[index]
                                                                        .platformleadid;
                                                                mappingrowid =
                                                                    data[index]
                                                                        .mappingrowid;
                                                                calledno = data[
                                                                        index]
                                                                    .phoneno;

                                                                CCCDialToConnect(
                                                                    data[index]
                                                                        .panelLeadid);
                                                                // getCCCPreviewList();

                                                              } else {
                                                                AlertMessage
                                                                    .alertDialog(
                                                                        context,
                                                                        "Please dispose the UnDisposed Call first or wait for few seconds");
                                                              }
                                                              // } else {
                                                              //   print(
                                                              //       "c2c is not enable");
                                                              // }
                                                            },
                                                            child: Container(
                                                              width: 100,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                // color: data[index]
                                                                //             .statusName ==
                                                                //         'Finished'
                                                                //     ?  Color(0xff19bf3e)
                                                                //     : data[index]
                                                                //                 .statusName ==
                                                                //             'In-Progress'
                                                                //         ?  Color(
                                                                //             0xffffd500)
                                                                //         : data[index]
                                                                //                     .statusName ==
                                                                //                 'not started'
                                                                //             ?  Color(
                                                                //                 0xffffffff)
                                                                //             : data[index]
                                                                //                         .statusName ==
                                                                //                     'Credit Expired'
                                                                //                 ?  Color(
                                                                //                     0xfff00000)
                                                                //                 : data[index]
                                                                //                             .statusName ==
                                                                //                         'upload failed'
                                                                //                     ?  Color(
                                                                //                         0xffe86024)
                                                                //                     : data[index].statusName ==
                                                                //                             'Paused'
                                                                //                         ?  Color(
                                                                //                             0xffA9A9A9)
                                                                //                         : data[index].statusName == 'Lead Expired'
                                                                //                             ?  Color(0xff8B4513)
                                                                //                             :  Color(0xff708090)),
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                Icons.call,
                                                                size: 30,
                                                                color: isautodiallead ==
                                                                        false
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            228,
                                                                            58,
                                                                            28)
                                                                    : Colors
                                                                        .grey,
                                                              )),
                                                            ),
                                                          )),
                                                        ])).toList(),
                                          )),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text("No Record Found");
                          } else if (snapshot.hasError) {
                            print(snapshot.hasError);
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        })
                    : Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: SingleChildScrollView(
                                  child: DataTable(
                                      showCheckboxColumn: false,
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                        (states) {
                                          return Color(0xffAAAAAA);

                                          //  Color.fromARGB(
                                          //     255, 5, 1, 39);
                                        },
                                      ),
                                      showBottomBorder: true,
                                      dividerThickness: 0.5,
                                      border: TableBorder.all(
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      columnSpacing: 15,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                      )),
                                      columns: [
                                    DataColumn(
                                      label: Center(
                                          child: Text(
                                        '     Status',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Center(
                                            child: Text(
                                          'Phone Number',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Center(
                                          child: Text(
                                        'Attempts',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Center(
                                            child: Text(
                                          'Call Time',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Center(
                                            child: Text(
                                          'Dial',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ],
                                      rows: [])),
                            ),
                          ),
                        ],
                      )
              ],
            )),
          )),
    );
  }
}
