// ignore_for_file: avoid_print, unnecessary_string_interpolations, unused_local_variable, unused_field, non_constant_identifier_names, use_build_context_synchronously, duplicate_ignore, deprecated_member_use, unused_element, avoid_function_literals_in_foreach_calls, depend_on_referenced_packages, duplicate_import, import_of_legacy_library_into_null_safe, must_be_immutable, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:ccc_app/service/login_apiservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import '../service/alert_message.dart';
import '../widget/mytext.dart';

class CRMPage extends StatefulWidget {
  var localleadid;
  CRMPage({Key? key, this.localleadid}) : super(key: key);

  @override
  _CRMPageState createState() => _CRMPageState();
}

class FieldText {
  final String fieldName;
  final String controlType;
  final String fld_FieldName;
  final List<dynamic> selectItems;
  final TextEditingController controller;
  final bool isEditable;
  final bool isUsed;
  final bool required;

  FieldText(
      {required this.fieldName,
      required this.controlType,
      required this.selectItems,
      required this.fld_FieldName,
      required this.isEditable,
      required this.isUsed,
      required this.required})
      : controller = TextEditingController();
}

class _CRMPageState extends State<CRMPage> {
  List<FieldText> fieldTexts = [];
  var dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // Future<List<StatusDropdownModel>>? _func2;

  bool check = false;
  Timer? _timer;

  @override
  void initState() {
    // if (Connection.port.isEmpty) {
    //   Connection.port = Variables.port;
    // }
    // if (Connection.serverIP.isEmpty) {
    //   Connection.serverIP = Variables.ip;
    // }

    // if (Connection.serverPackage.isEmpty) {
    //   Connection.serverPackage = Variables.package;
    // }

    // if (LoginService.agentId!.isEmpty) {
    //   LoginService.agentId = Variables.email;
    // }
    // if (LoginService.userid == 0) {
    //   LoginService.userid = Variables.userid;
    // }
    // if (LoginService.loginId!.isEmpty) {
    //   LoginService.loginId = Variables.loginid;
    // }
    // if (LoginService.mobile_no!.isEmpty) {
    //   LoginService.mobile_no = Variables.mobile;
    // }

    // if (LoginService.agentName!.isEmpty) {
    //   LoginService.agentName = Variables.agentname;
    // }

    print("long field6 = $lat");

    fetchData();
    Timer timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        if (widget.localleadid != null) {
          // downloadTask();
        } else {
          print("task id= ${widget.localleadid}");
        }

        // fieldtext6.text = "${currentPosition!.latitude}";

        // fieldtext7.text = "${currentPosition!.longitude}";
        print("long field6 = $lat");

        // CustDyna.fetchDynaFields(
        //     'https://192.168.68.128:8088/iTrackMate/getdynataskfield',
        //     LoginService.campId);

        setState(() {});
      });
    });

    super.initState();
  }

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
  late StreamSubscription<Position> _positionStream;
  List<Position> locations = <Position>[];

  DateTime now = DateTime.now();
  var date_Time = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
  var dat = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Future<void> updateTask() async {
  //   String uri = "";

  //   if (Connection.port.isEmpty && Connection.serverPackage.isEmpty) {
  //     uri = "${Connection.serverIP}/gettaskfield";
  //   } else if (Connection.port.isEmpty) {
  //     uri = "${Connection.serverIP}/${Connection.serverPackage}/gettaskfield";
  //   } else if (Connection.serverPackage.isEmpty) {
  //     uri = "${Connection.serverIP}:${Connection.port}/gettaskfield";
  //   } else {
  //     uri =
  //         "${Connection.serverIP}:${Connection.port}/${Connection.serverPackage}/gettaskfield";
  //   }
  //   print("uri=$uri");

  //   // String uri = "https://192.168.68.220:8084/iTrackMate/gettaskfield";
  //   print("uri= $uri");

  //   Map<String, dynamic> formValues = {};

  //   for (var fieldText in fieldTexts) {
  //     if (fieldText.controlType == 0) {
  //       formValues[fieldText.fld_FieldName.toLowerCase()] =
  //           fieldText.controller.text;
  //     } else if (fieldText.controlType == 1) {
  //       formValues[fieldText.fld_FieldName.toLowerCase()] =
  //           fieldText.controller.text;
  //     } else if (fieldText.controlType == 2) {
  //       formValues[fieldText.fld_FieldName.toLowerCase()] =
  //           fieldText.controller.text;
  //     }
  //   }

  //   var requestBody = {
  //     "userID":
  //         LoginService.userid == 0 ? Variables.userid : LoginService.userid,
  //     "taskID": widget.taskid ?? "",
  //     "mode": "2",
  //     "checkinID": Holder.number ?? 0,
  //     "agentID": LoginService.agentId ?? Variables.email,
  //     "insertdateime": dateTime,
  //     "updatedbyID": LoginService.loginId ?? Variables.loginid,
  //     "statusID": status_dropdown ?? 0
  //   };

  //   for (int i = 0; i < fieldTexts.length; i++) {
  //     var fieldName = fieldTexts[i].fld_FieldName.toLowerCase();
  //     if (formValues.containsKey(fieldName)) {
  //       requestBody[fieldName] = formValues[fieldName];
  //     } else {
  //       requestBody[fieldName] = '';
  //     }
  //   }

  //   print("uri= $uri");
  //   print("body= $requestBody");

  //   try {
  //     var headers = {"Content-type": "application/json"};

  //     final response = await http.post(
  //       Uri.parse(uri),
  //       headers: headers,
  //       body: utf8.encode(json.encode(requestBody)),
  //     );
  //     var message = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       print("response= ${response.body}");
  //       print("url = $uri");
  //       final json = jsonDecode(response.body);
  //       print("resonse= ${response.body}");
  //       print("message=$message");
  //       var status = message['status'];
  //       AlertMessage.alertDialog(context, message['value']);
  //       Timer timer = Timer(const Duration(seconds: 2), () {
  //         setState(() {
  //           Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) => MyTask(campId: LoginService.campId),
  //           ));
  //         });
  //       });

  //       print("status= $status");
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  // Future<void> downloadTask() async {
  //   String uri = "";

  //   if (Connection.port.isEmpty && Connection.serverPackage.isEmpty) {
  //     uri = "${Connection.serverIP}/gettaskfield";
  //   } else if (Connection.port.isEmpty) {
  //     uri = "${Connection.serverIP}/${Connection.serverPackage}/gettaskfield";
  //   } else if (Connection.serverPackage.isEmpty) {
  //     uri = "${Connection.serverIP}:${Connection.port}/gettaskfield";
  //   } else {
  //     uri =
  //         "${Connection.serverIP}:${Connection.port}/${Connection.serverPackage}/gettaskfield";
  //   }
  //   print("uri=$uri");

  //   // String uri = "https://192.168.68.220:8084/iTrackMate/gettaskfield";
  //   var requestBody = {
  //     "userID":
  //         LoginService.userid == 0 ? Variables.userid : LoginService.userid,
  //     "taskID": widget.taskid,
  //     "mode": "1"
  //   };
  //   print("body= $requestBody");
  //   print("uri= $uri");

  //   var headers = {"Content-type": "application/json"};

  //   final response = await http.post(Uri.parse(uri),
  //       headers: headers, body: utf8.encode(json.encode(requestBody)));
  //   var message = jsonDecode(response.body);
  //   print("${response.body}");

  //   if (response.statusCode == 200) {
  //     if (response.statusCode == 200) {
  //       var values = message['value'];
  //       print("values=$values");

  //       setState(() {
  //         for (var fieldText in fieldTexts) {
  //           var fieldName = fieldText.fld_FieldName.toLowerCase();
  //           print("fieldtext= $fieldName");

  //           if (values.containsKey(fieldName)) {
  //             fieldText.controller.text = values[fieldName];
  //           } else {
  //             fieldText.controller.text = '';
  //           }
  //         }
  //         if (message['value']['statusID'] != null) {
  //           status_dropdown = message['value']['statusID'];
  //         }
  //       });
  //     }

  //     var status = message['status'];
  //     print("status= $status");
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  void fetchData() async {
    final Uri url;

    url = Uri.parse("${LoginService.cccIP}webresources/LeadCustomFields?");
    print("uri=$url");

    // final url =
    //     Uri.parse('https://192.168.68.220:8084/iTrackMate/getdynataskfield');
    var headers = {"Content-type": "application/json"};

    print("uri= $url");
    final body = jsonEncode({"localleadid": widget.localleadid});
    print("request body= $body");

    var response =
        await http.post(url, headers: headers, body: utf8.encode(body));
    print("login api= $url");
    var message = json.decode(response.body);

    print('message:$message');
    print(message['status']);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("response= $jsonResponse[''value]");

      List<FieldText> texts = [];

      jsonResponse['value'][0].forEach((key, value) {
        texts.add(FieldText(
            fieldName: value['name'],
            controlType: value['ControlType'],
            selectItems: value['selectItems'],
            fld_FieldName: value['Fld_FieldName'],
            isEditable: value['isEditable'],
            required: value['required'],
            isUsed: value['isUsed']));
      });
      print("texts= $texts");
      setState(() {
        fieldTexts = texts;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  var dispID,
      cbDateTime,
      dialFromNo,
      isCBChecked,
      dialtoconnectrowid,
      platformid,
      isMarkAsClosed,
      undisposerow,
      dialtoconnectrecordid,
      isStopCamp,
      localleadID,
      PhoneId,
      dialtoconnectcustrecordid,
      assigntoid,
      dispRemarks,
      dialToNo;

  Future<void> callDispose() async {
    String uri =
        "${LoginService.cccIP}webresources/CCCDisposeCall?clientid=0&callid=0&dispid=$dispID&dispremarks=$dispRemarks&custremarks=NA&otherremarks=NA&cb=$isCBChecked&cbtime=$cbDateTime&cb_altno=&cb_altno_csv=&cb_refno=&cbassignedto=$assigntoid&nxtnumtype=&dncl=&agentid=$dialFromNo&dialtoconnectrowid=$dialtoconnectrowid&customerno=$dialToNo&recordid=$dialtoconnectrecordid&platformid=$platformid&agentrowid=${LoginService.agent_row_id}&ismarkedasclose=$isMarkAsClosed&ecp_recordid=$dialtoconnectcustrecordid&custrecordid=$dialtoconnectcustrecordid&undisposerowid=$undisposerow&stopcamp=$isStopCamp&uniquekey=${LoginService.agent_row_id}$localleadID$PhoneId$dialtoconnectrecordid";
    print("uri=$uri");

    // String uri = "https://192.168.68.220:8084/iTrackMate/gettaskfield";
    print("uri= $uri");

    var requestBody = {};

    print("uri= $uri");
    print("body= $requestBody");

    try {
      var headers = {"Content-type": "application/json"};

      final response = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: utf8.encode(json.encode(requestBody)),
      );
      var message = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("response= ${response.body}");
        print("url = $uri");
        final json = jsonDecode(response.body);
        print("resonse= ${response.body}");
        print("message=$message");
        var status = message['status'];
        AlertMessage.alertDialog(context, message['value']);
        // Timer timer = Timer(const Duration(seconds: 2), () {
        //   setState(() {
        //     Navigator.of(context).pushReplacement(MaterialPageRoute(
        //       builder: (context) => MyTask(campId: LoginService.campId),
        //     ));
        //   });
        // });

        print("status= $status");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget buildFieldText(int index) {
    if (index < fieldTexts.length) {
      final fieldText = fieldTexts[index];

      if (fieldText.controlType == 'TextField' && fieldText.isUsed == true) {
        // Textfield
        if (fieldText.fieldName.length > 50) {
          // Do something for fields with fieldName length greater than 50
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: const BoxDecoration(),
                          width: 120,
                          child: MyText(text: fieldText.fieldName ?? "")),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 34, 35, 36),
                        )),
                        margin: const EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: TextFormField(
                            enabled: fieldText.isEditable,
                            // inputFormatters: [
                            //        FilteringTextInputFormatter
                            //           .digitsOnly
                            //     ],
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 12),
                            controller: fieldText.controller ??
                                TextEditingController(), // Assign the controller or create a new one
                            decoration: const InputDecoration(
                                // labelText: fieldText.fieldName,
                                // labelStyle: const TextStyle(fontSize: 8)
                                // helperText: 'This field has more than 50 characters',
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: const BoxDecoration(),
                          width: 120,
                          child: MyText(text: fieldText.fieldName ?? "")),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 1, 78, 136),
                        )),
                        margin: const EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: TextFormField(
                            enabled: fieldText.isEditable,

                            style: const TextStyle(fontSize: 12),
                            controller: fieldText.controller ??
                                TextEditingController(), // Assign the controller or create a new one
                            decoration: const InputDecoration(
                                // labelText: fieldText.fieldName,
                                // labelStyle: const TextStyle(fontSize: 8),

                                // helperText: 'This field has more than 50 characters',
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      } else if (fieldText.controlType == 'TextArea' &&
          fieldText.isUsed == true) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(),
                    width: 120,
                    child: MyText(text: fieldText.fieldName ?? "")),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: const Color.fromARGB(255, 1, 78, 136),
                  )),
                  margin: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      maxLines:
                          null, // Setting maxLines to null or a value > 1 makes it a TextArea

                      enabled: fieldText.isEditable,
                      style: const TextStyle(fontSize: 14),
                      controller: fieldText.controller ??
                          TextEditingController(), // Assign the controller or create a new one
                      decoration: const InputDecoration(

                          // labelText: fieldText.fieldName,
                          // labelStyle: const TextStyle(fontSize: 8)
                          // helperText: 'This field has more than 50 characters',
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (fieldText.controlType == 'Dropdown' &&
          fieldText.isUsed == true) {
        final selectItems = fieldText.selectItems;
        final dropdownItems = selectItems
            .map((item) => DropdownMenuItem(
                  value: item['value'].toString(), // Convert value to string
                  child: Text(item['label']),
                ))
            .toList();
        // Dropdown
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(),
                        width: 120,
                        child: MyText(text: fieldText.fieldName ?? "")),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color.fromARGB(255, 1, 78, 136),
                      )),
                      margin: const EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonFormField<String>(
                          value: fieldText.controller.text.isNotEmpty
                              ? fieldText.controller.text
                              : null,
                          items: dropdownItems,
                          onChanged: (selectedValue) {
                            setState(() {
                              fieldText.controller.text = selectedValue!;
                              print(
                                  "field text controller- ${fieldText.controller.text}");
                            });
                          },
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          decoration: const InputDecoration(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff233743),

              // Color.fromARGB(255, 115, 172, 247),
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: const Color(0xff233743),

            // const Color(0xff5C5EDD),
            // title: const Text(
            //   "iTrackMate ",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: fieldTexts.length,
                  itemBuilder: (context, index) {
                    return buildFieldText(index);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // updateTask();
                  // _stopRecording();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff233743),

                    // const Color.fromARGB(255, 39, 28, 126),
                  ),
                  child: const Center(
                      child: Text(
                    "DISPOSE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // updateTask();
                  // _stopRecording();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff233743),

                    // const Color.fromARGB(255, 39, 28, 126),
                  ),
                  child: const Center(
                      child: Text(
                    "SAVE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // updateTask();
                  // _stopRecording();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff233743),

                    // const Color.fromARGB(255, 39, 28, 126),
                  ),
                  child: const Center(
                      child: Text(
                    "DIAL",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),

          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     updateTask();
          //   },
          //   child: Icon(Icons.save),
          // ),
        ),
      ),
    );
  }
}
