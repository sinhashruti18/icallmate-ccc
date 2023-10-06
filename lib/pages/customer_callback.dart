// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, prefer_typing_uninitialized_variables, avoid_print, prefer_null_aware_operators, prefer__ructors, unnecessary_this, unused_field, non_ant_identifier_names, must_be_immutable, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:ccc_app/service/login_apiservice.dart';
import 'package:ccc_app/widget/myappbar.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../model/ccc_camplist_model.dart';
import '../model/followups_model.dart';
import '../widget/drawer_widget.dart';

class CustomerCallBackPage extends StatefulWidget {
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
  CustomerCallBackPage(
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
  State<CustomerCallBackPage> createState() => _CustomerCallBackPageState();
}

class _CustomerCallBackPageState extends State<CustomerCallBackPage> {
  DateTime _selectedDate = DateTime.now();
  var dateTime = DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now());
  var date;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool valuefirst = false;
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
        _func2 = getcallbacklist();

        // _func = fetchOBDcamplist();
      });
    });
  }

  var apidata;
  String title = "Admin";
  var record_message;

  Future<List<GetCccCampList>> getCCCCampList() async {
    String endpoint;
    endpoint = "${LoginService.cccIP}webresources/GetCCCCampList?";

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

    // print("ukey=${widget.ukey}");
    try {
      Response response = await http.post(Uri.parse(endpoint),
          headers: headers,
          //     body: utf8.encode(json.encode(mybody)));
          body: json.encode(mybody));
      var message = json.decode(response.body);
      List? jsonResponse;

      if (message['value'] is String) {
        print("messd${message['value']}");
        record_message = message['value'];

        // value2 = message['value'];
        print("value=$record_message");

        // handle string value of "value" key
      } else {
        jsonResponse = message['value']['ccccamplist'] ?? [];
        print("json= $jsonResponse");

        // handle JSON object or array value of "value" key
      }
      print("message=${message['value']}");
      print("mess= $message");
      print("${message['ccccamplist']}");
      print("response=${response.body}");

      if (response.statusCode == 200) {
        print(response.body);

        return jsonResponse!.map(((e) => GetCccCampList.fromJson(e))).toList();
      } else {
        print("failure");
        throw Exception();
      }
    } on Exception catch (e) {
      print(e);
      print("fail");

      rethrow;
    }
  }

  // Future<List<obd>> fetchOBDcamplist() async {
  //   String? endpoint;
  //   print("port= ${widget.port}");
  //   print("port= ${widget.obdpackage}");
  //   print("port= ${widget.obdserver}");

  //   if (widget.port == null && widget.obdpackage == null) {
  //     endpoint =
  //         // "http://${server.text}:${port.text}/${package_name.text}/webresources/getLogin";
  //         "${widget.http_request}://${widget.obdserver!}/webresources/GetOBDCampList?";
  //   } else if (widget.obdpackage == null) {
  //     endpoint =
  //         // "http://${server.text}:${port.text}/${package_name.text}/webresources/getLogin";
  //         "${widget.http_request}://${widget.obdserver!}:${widget.port!}/webresources/GetOBDCampList?";
  //   } else if (widget.port == null) {
  //     endpoint =
  //         "${widget.http_request}://${widget.obdserver!}/${widget.obdpackage!}/webresources/GetOBDCampList?";
  //   } else {
  //     endpoint =
  //         "${widget.http_request}://${widget.obdserver!}:${widget.port!}/${widget.obdpackage!}/webresources/GetOBDCampList?";
  //   }
  //   print("endpoint= $endpoint");
  //   // String endpoint =
  //   //     "http://${widget.obdserver!}:${widget.port!}/${widget.obdpackage!}/webresources/GetOBDCampList?";
  //   var headers = {"Content-type": "application/json"};
  //   var mybody = {
  //     "ukey": variables.ukey,
  //     //  widget.ukey,
  //     "fromdate": _selectedDate == null
  //         ? null
  //         : _selectedDate.toString().substring(0, 10)
  //   };
  //   print("body=$mybody");

  //   try {
  //     Response response = await http.post(Uri.parse(endpoint),
  //         headers: headers, body: json.encode(mybody));
  //     var message = json.decode(response.body);
  //     List jsonResponse = message['value']['obdcamplist'] ?? [];
  //     print("camp time${message['obdcamplist']}");
  //     print(response.body);
  //     print("jsonresponse= $jsonResponse");
  //     print("scheduled date time = ${message['datetime']}");

  //     if (response.statusCode == 200 && message['status'] == "success") {
  //       print(response.body);

  //       return jsonResponse.map(((e) => obd.fromMap(e))).toList();
  //     } else {
  //       throw Exception();
  //     }
  //   } on Exception catch (e) {

  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<List<obd>>? _func;
  Timer? timer;

  String? package1;
  String? port1;
  String? server1;
  String? ukey1;
  List? drawerlist;
  // List listToSearch = [
  //   {'name': 'Amir', 'class': 12},
  //   {'name': 'Raza', 'class': 11},
  //   {'name': 'Praksh', 'class': 10},
  //   {'name': 'Nikhil', 'class': 9},
  //   {'name': 'Sandeep', 'class': 8},
  //   {'name': 'Tazeem', 'class': 7},
  //   {'name': 'Najaf', 'class': 6},
  //   {'name': 'Izhar', 'class': 5},
  // ];
  Future<List<FollowUpsModel>>? _func2;
  Future<List<FollowUpsModel>> getcallbacklist() async {
    String uri = "${LoginService.cccIP}webresources/GetCCCCustCallBackList?";

    var headers = {"Content-type": "application/json"};
    print("uri=$uri");

    var requestBody = {
      "ukey": LoginService.ukey,
      "fromdate": _selectedDate.toString().substring(0, 10),
      "todate": _selectedDate.toString().substring(0, 10),
      "recordid": 0,
      "command": 1,
      "agent_phoneno": LoginService.mobile_no,
      "isundialedno": valuefirst,
      "isfirstrecord": true,
    };
    print("body= $requestBody");
    // "http://192.168.68.128:8081/iUnifyMate/getAgentTaskList?agentID=1006&campID=193&dateTime=2023-02-01:45:53&ticketId=202";
    final response = await http.post(Uri.parse(uri),
        headers: headers, body: utf8.encode(json.encode(requestBody)));

    if (response.statusCode == 200) {
      print("response call back= ${response.body}");
      // print("url = $uri");
      var mess = json.decode(response.body);
      List jsonResponse = mess['value'] ?? [];
      // print("resonse= ${response.body}");
      // print("json response $jsonResponse");
      return jsonResponse.map((e) => FollowUpsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  var selected;
  List? selectedList;

  Future<List<GetCccCampList>>? _func;

  @override
  void initState() {
    _func = getCCCCampList();
    print("valuee=$record_message");
    timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _func = getCCCCampList();
        print("after timer valuee=$record_message");
      });
    });

    // _func = fetchOBDcamplist();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          drawer: DrwaerWidget(),
          appBar: MyAppbar(
            title: "Customer CallBack",
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/triangle.jpg"),
                  repeat: ImageRepeat.repeat),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                // TitleWidget(title: "Manage OBD Campaigns"),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate =
                                  DateTime.now().subtract(Duration(days: 1));

                              // _func = fetchOBDcamplist();

                              print(dateTime);
                            });
                          },
                          child: Icon(Icons.arrow_back)),
                      GestureDetector(
                        onTap: () {
                          _presentDatePicker();
                          setState(() {});
                        },
                        child: Text(
                          _selectedDate == null
                              ? DateTime.now().toString().substring(0, 10)
                              : _selectedDate.toString().substring(0, 10),
                          style: TextStyle(
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
                                DateTime.now().add(Duration(days: 1));
                            if (_selectedDate.compareTo(DateTime.now()) > 0) {
                              _selectedDate = DateTime.now();
                            }

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
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Camapaign",
                          style: TextStyle(
                              color: Color.fromARGB(255, 109, 108, 108),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
                                      onChanged: (value) {
                                        if (value != null) {
                                          selected = value['leadid'].toString();
                                          _func2 = getcallbacklist();
                                        } else {
                                          selected = null;
                                        }
                                      },
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print(snapshot.hasError);
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator(
                                  color: Colors.blue,
                                );
                              })
                          : Expanded(
                              flex: 3,
                              child: CustomSearchableDropDown(
                                dropdownHintText: "Select Campaign",
                                menuHeight: 100,
                                items: [],
                                hint: "Select Campaign",
                                label: 'Select Campaign',
                                labelStyle: TextStyle(color: Colors.red),
                                decoration: BoxDecoration(),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                ),
                                dropDownMenuItems: [],
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Text(
                        'Show Undialed Only',
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: this.valuefirst,
                        onChanged: (bool? value) {
                          setState(() {
                            this.valuefirst = value!;
                            _func2 = getcallbacklist();
                          });
                        },
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
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Row(children: [
                    Expanded(
                      child: FittedBox(
                          child: SingleChildScrollView(
                              child: DataTable(
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                    (states) {
                                      return Color(0xffAAAAAA);
                                    },
                                  ),
                                  showCheckboxColumn: false,
                                  showBottomBorder: true,
                                  dividerThickness: 0.5,
                                  border: TableBorder.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  columnSpacing: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 158, 158, 158),
                                  )),

                                  // ignore: prefer__literals_to_create_immutables
                                  columns: const [
                            DataColumn(
                              label: Center(
                                  child: Text(
                                'Phone No',
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
                                  'Campaign',
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
                                'Try',
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
                                  'CB Time',
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
                                  rows: [
                            // Return the DataRow only if it's for today
                            // if (isToday) {}

                            DataRow(
                                // color: MaterialStateProperty
                                //     .resolveWith<Color>(
                                //         (Set<MaterialState> states) {
                                //   if (index % 2 == 0) {
                                //     return  Color.fromARGB(
                                //             255, 222, 220, 228)
                                //         .withOpacity(0.3);
                                //   }
                                //   return Colors.white;
                                // }),
                                // onSelectChanged: (bool? selected) {

                                // },
                                cells: [
                                  DataCell(Container(
                                    decoration: BoxDecoration(),
                                    width: 140,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )),
                                  DataCell(Center(
                                    child: Text(""),
                                    // var date_Time = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
                                    // var dat = DateFormat('yyyy-MM-dd').format(DateTime.now());
                                  )),
                                  DataCell(Center(
                                    child: Text(
                                      "",
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(Center(
                                      child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          ""))),
                                  DataCell(Container(
                                    width: 100,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                        child: Text(
                                      "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12),
                                    )),
                                  )),
                                ])
                          ])
                              // : DataRow(cells: [
                              //     DataCell(Container(
                              //       child: Text(""),
                              //     )),
                              //     DataCell(Container(
                              //       child: Text(""),
                              //     )),
                              //     DataCell(Container(
                              //       child: Text(""),
                              //     )),
                              //     DataCell(Container(
                              //       child: Text(""),
                              //     )),
                              //     DataCell(Container(
                              //       child: Text(""),
                              //     )),
                              //   ]);

                              )),
                    ),
                  ]),
                ),
              ],
            )),
          )
//                 FutureBuilder(
//                     future: _func,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         List<obd>? data = snapshot.data as List<obd>?;
//                         String sel =
//                             DateFormat('dd-MM-yyyy').format(_selectedDate);
//                         data!.removeWhere((element) =>
//                             element.datetime.substring(0, 10) != sel);

//                         // data!
//                         //     .where(
//                         //       (element) =>
//                         //           element.datetime.substring(0, 10) ==
//                         //           currentDate,
//                         //     )
//                         //     .toList();
//                         // data.where((element) => element.datetime==,)

//                         print("dateTime today = $dateTime");
//                         ////////////////
//                         return SizedBox(
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: FittedBox(
//                                   child: SingleChildScrollView(
//                                       child: DataTable(
//                                     headingRowColor:
//                                         MaterialStateColor.resolveWith(
//                                       (states) {
//                                         return  Color(0xffAAAAAA);
//                                       },
//                                     ),
//                                     showCheckboxColumn: false,
//                                     showBottomBorder: true,
//                                     dividerThickness: 0.5,
//                                     border: TableBorder.all(
//                                       width: 1,
//                                       color: Colors.white,
//                                     ),
//                                     columnSpacing: 10,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                       width: 1,
//                                       color:  Color.fromARGB(
//                                           255, 158, 158, 158),
//                                     )),

//                                     // ignore: prefer__literals_to_create_immutables
//                                     columns: [
//                                        DataColumn(
//                                         label: Center(
//                                             child: Text(
//                                           'Campaign Name',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white),
//                                         )),
//                                       ),
//                                        DataColumn(
//                                         label: Expanded(
//                                           child: Center(
//                                               child: Text(
//                                             'Time',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold),
//                                           )),
//                                         ),
//                                       ),
//                                        DataColumn(
//                                         label: Center(
//                                             child: Text(
//                                           'Approved',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         )),
//                                       ),
//                                        DataColumn(
//                                         label: Expanded(
//                                           child: Center(
//                                               child: Text(
//                                             'Type',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold),
//                                           )),
//                                         ),
//                                       ),
//                                        DataColumn(
//                                         label: Expanded(
//                                           child: Center(
//                                               child: Text(
//                                             'Status',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white),
//                                           )),
//                                         ),
//                                       ),
//                                     ],

//                                     rows: List.generate(data.length, (index) {
//                                       String rowDate =
//                                           data[index].datetime.substring(0, 10);
//                                       String sel = DateFormat('dd-MM-yyyy')
//                                           .format(_selectedDate);
//                                       // Check if the row date matches the current date
//                                       bool isToday = (rowDate == sel);

//                                       // Return the DataRow only if it's for today
//                                       // if (isToday) {}

//                                       return DataRow(
//                                           color: MaterialStateProperty
//                                               .resolveWith<Color>(
//                                                   (Set<MaterialState> states) {
//                                             if (index % 2 == 0) {
//                                               return  Color.fromARGB(
//                                                       255, 222, 220, 228)
//                                                   .withOpacity(0.3);
//                                             }
//                                             return Colors.white;
//                                           }),
//                                           onSelectChanged: (bool? selected) {
//                                             if (selected!) {
//                                               Navigator.of(context)
//                                                   .pushReplacement(
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               ManageOBDCamapaign(
//                                                                 productinfolist:
//                                                                     widget
//                                                                         .productinfolist,
//                                                                 leadid:
//                                                                     data[index]
//                                                                         .leadid,
//                                                                 lead_name: data[
//                                                                         index]
//                                                                     .leadname,
//                                                                 userid:
//                                                                     data[index]
//                                                                         .userid,
//                                                                 package: widget
//                                                                     .package_name,
//                                                                 port:
//                                                                     widget.port,
//                                                                 server: widget
//                                                                     .server,
//                                                                 ukey:
//                                                                     widget.ukey,
//                                                                 obdpackage: widget
//                                                                     .obdpackage,
//                                                                 obdserver: widget
//                                                                     .obdserver,
//                                                                 smspackage: widget
//                                                                     .smspackage,
//                                                                 smsserver: widget
//                                                                     .smsserver,
//                                                                 c2cserver: widget
//                                                                     .c2cserver,
//                                                                 c2cpackage: widget
//                                                                     .c2cpackage,
//                                                                 http_request: widget
//                                                                     .http_request,
//                                                               )));
//                                               print(
//                                                   "lead id== ${data[index].leadid}");
//                                               print(
//                                                   "response date == ${data[index].datetime.substring(0, 10)}");
//                                               print(
//                                                   "today date == $currentDate");

//                                               // DateTime dateTime = DateFormat(
//                                               //         'dd-MM-yyyy HH:mm:ss')
//                                               //     .parse(data[index]
//                                               //         .datetime);

// // Format the DateTime object to display only the time
//                                               String timeString = DateFormat(
//                                                       'h:mm a')
//                                                   .format(DateFormat(
//                                                           'dd-MM-yyyy HH:mm:ss')
//                                                       .parse(data[index]
//                                                           .datetime));

//                                               print(
//                                                   "timeString= $timeString"); // Output: 11:00 AM
//                                               print(
//                                                   "date format = ${data[index].datetime}");
//                                             }
//                                           },
//                                           cells: [
//                                             DataCell(Container(
//                                               decoration:  BoxDecoration(),
//                                               width: 140,
//                                               child: Text(
//                                                 textAlign: TextAlign.center,
//                                                 data[index].leadname == null
//                                                     ? ''
//                                                     : data[index].leadname,
//                                                 style:  TextStyle(
//                                                     color: Colors.black),
//                                               ),
//                                             )),
//                                             DataCell(Center(
//                                               child: Text(data[index]
//                                                           .datetime ==
//                                                       null
//                                                   ? ''
//                                                   : DateFormat('h:mm a').format(
//                                                       DateFormat(
//                                                               'dd-MM-yyyy HH:mm:ss')
//                                                           .parse(data[index]
//                                                               .datetime))),
//                                               // var date_Time = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
//                                               // var dat = DateFormat('yyyy-MM-dd').format(DateTime.now());
//                                             )),
//                                             DataCell(Center(
//                                               child: Text(
//                                                 "${data[index].approvedCount == null ? '' : data[index].approvedCount}",
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             )),
//                                             DataCell(Center(
//                                                 child: Text(
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     data[index].credittypeName ==
//                                                             null
//                                                         ? ''
//                                                         : data[index]
//                                                             .credittypeName
//                                                             .substring(0, 5)))),
//                                             DataCell(Container(
//                                               width: 100,
//                                               height: 20,
//                                               decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius
//                                                       .circular(10),
//                                                   color: data[index]
//                                                               .statusName ==
//                                                           'Finished'
//                                                       ?  Color(0xff19bf3e)
//                                                       : data[index]
//                                                                   .statusName ==
//                                                               'In-Progress'
//                                                           ?  Color(
//                                                               0xffffd500)
//                                                           : data[index]
//                                                                       .statusName ==
//                                                                   'not started'
//                                                               ?  Color(
//                                                                   0xffffffff)
//                                                               : data[index]
//                                                                           .statusName ==
//                                                                       'Credit Expired'
//                                                                   ?  Color(
//                                                                       0xfff00000)
//                                                                   : data[index]
//                                                                               .statusName ==
//                                                                           'upload failed'
//                                                                       ?  Color(
//                                                                           0xffe86024)
//                                                                       : data[index].statusName ==
//                                                                               'Paused'
//                                                                           ?  Color(
//                                                                               0xffA9A9A9)
//                                                                           : data[index].statusName == 'Lead Expired'
//                                                                               ?  Color(0xff8B4513)
//                                                                               :  Color(0xff708090)),
//                                               child: Center(
//                                                   child: Text(
//                                                 data[index].statusName == null
//                                                     ? ''
//                                                     : data[index].statusName,
//                                                 style:  TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                     fontSize: 12),
//                                               )),
//                                             )),
//                                           ]);
//                                       // : DataRow(cells: [
//                                       //     DataCell(Container(
//                                       //       child: Text(""),
//                                       //     )),
//                                       //     DataCell(Container(
//                                       //       child: Text(""),
//                                       //     )),
//                                       //     DataCell(Container(
//                                       //       child: Text(""),
//                                       //     )),
//                                       //     DataCell(Container(
//                                       //       child: Text(""),
//                                       //     )),
//                                       //     DataCell(Container(
//                                       //       child: Text(""),
//                                       //     )),
//                                       //   ]);
//                                     }).toList(),
//                                   )),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else if (snapshot.hasError) {
//                         print(snapshot.hasError);
//                         return Text("${snapshot.error}");
//                       }
//                       return  CircularProgressIndicator(
//                         color: Colors.blue,
//                       );
//                     })
          ),
    );
  }
}
