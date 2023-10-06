// ignore_for_file: unused_element, avoid_print, prefer__ructors, unnecessary_null_comparison, use_full_hex_values_for_flutter_colors, unused_local_variable, use_build_context_synchronously, non_ant_identifier_names, unused_field, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:ccc_app/model/ccc_camplist_model.dart';
import 'package:ccc_app/service/location_api.dart';
import 'package:ccc_app/widget/dashboard_bottom_container.dart';
import 'package:ccc_app/widget/dashboard_container.dart';
import 'package:ccc_app/widget/drawer_widget.dart';
import 'package:ccc_app/widget/myappbar.dart';
import 'package:ccc_app/widget/topgrid.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import '../service/cls_logs.dart';
import '../service/login_apiservice.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<_ChartData>? data;
  // late TooltipBehavior _tooltip;
  int selectedContainerIndex = 0;
  String street = "";

  String sublocality = "";
  String locality = "";
  String country = "";
  double lat = 0.0;
  double long = 0.0;
  DateTime _selectedDate = DateTime.now();
  var date;
  DateTime todate = DateTime.now();
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
        todate = _selectedDate;
        print("selected date= $_selectedDate");
        _func = getCCCCampList();
      });
    });
  }

  void changeContainerColor(int index) {
    setState(() {
      selectedContainerIndex = index;
    });
  }

  String? selectedItem;
  List listToSearch = [
    // {'name': 'Amir', 'class': 12},
    // {'name': 'Raza', 'class': 11},
    // {'name': 'Praksh', 'class': 10},
    // {'name': 'Nikhil', 'class': 9},
    // {'name': 'Sandeep', 'class': 8},
    // {'name': 'Tazeem', 'class': 7},
    // {'name': 'Najaf', 'class': 6},
    // {'name': 'Izhar', 'class': 5},
    // {'name': 'Amir', 'class': 12},
    // {'name': 'Raza', 'class': 11},
    // {'name': 'Praksh', 'class': 10},
    // {'name': 'Nikhil', 'class': 9},
    // {'name': 'Sandeep', 'class': 8},
    // {'name': 'Tazeem', 'class': 7},
    // {'name': 'Najaf', 'class': 6},
    // {'name': 'Izhar', 'class': 5},
  ];

  String? selected;
  List? selectedList;

  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    // Add more items as needed
  ];
  bool check_datepicker = false;
  String record_message = "";
  List<_ChartData>? data;
  // late TooltipBehavior _tooltip;

  Future<List<GetCccCampList>> getCCCCampList() async {
    String endpoint;
    endpoint = "${LoginService.cccIP}webresources/GetCCCCampList?";

    var headers = {"Content-type": "application/json"};
    var mybody = {
      "ukey": LoginService.ukey,
      "fromdate": _selectedDate.toString().substring(0, 10),
      "todate": todate.toString().substring(0, 10),
      "isagent": true,
      "agentno": LoginService.mobile_no,
      "agentrowid": LoginService.agent_row_id,
    };
    print("url= $endpoint");
    print("body=$mybody");
    ClsLogs.API_HIT(
        "method:getCCCCampList(),\nurl:$endpoint,\nbody:$mybody,date:${DateTime.now()}");
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
        record_message = "";

        // handle JSON object or array value of "value" key
      }
      print("message=${message['value']}");
      print("mess= $message");
      print("${message['ccccamplist']}");
      print("response=${response.body}");

      if (response.statusCode == 200) {
        print(response.body);
        ClsLogs.API_SUCCESS(
            "date:${DateTime.now()},\nmethod:getCCCCampList(),\nurl:$endpoint,\nbody:$mybody\n",
            "response:${response.body}");

        return jsonResponse!.map(((e) => GetCccCampList.fromJson(e))).toList();
      } else {
        print("failure");
        throw Exception();
      }
    } on Exception catch (e) {
      print(e);
      ClsLogs.API_FAILURE(
          "method:getCCCCampList(),\nurl:$endpoint,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");
      print("fail");
      rethrow;
    }
  }

  int? total_unique_dialed,
      total_notcontacted,
      total_uploaded,
      total_unattempted,
      avg_talktime,
      avg_acwtime,
      total_acwtime,
      total_breaktime,
      total_talktime,
      nooffollowups,
      total_contacted_callback;
  var total_dialed,
      total_dialed_followup,
      total_contacted,
      total_dialed_callback;
  double? attempeted_bar, callback_bar, followup_bar, contacted_bar;
  Future getCCCagentCallDashBoard() async {
    String? url;
    // String encryptedPassword = Encryptor.encrypt(password.text);
    // print("encrypted= $encryptedPassword");

    url = "${LoginService.cccIP}webresources/CCCAgentCallDashboard?";
    print("URL= $url");
    var mybody = {
      "panel_leadid": selected,
      "agent_no": LoginService.mobile_no,
      "ukey": LoginService.ukey,
      "agentusertype": LoginService.user_type,
      "fromdate": _selectedDate.toString().substring(0, 10),
    };
    print("body= $mybody");
    ClsLogs.API_HIT(
        "method:getCCCagentCallDashBoard(),\nurl:$url,\nbody:$mybody,date:${DateTime.now()}");

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
          total_dialed = message['total_dialed'];
          attempeted_bar = double.parse(total_dialed.toString());

          total_unique_dialed = message['total_unique_dialed'];
          total_contacted = message['total_contacted'];
          contacted_bar = double.parse(total_contacted.toString());
          total_notcontacted = message['total_notcontacted'];
          total_uploaded = message['total_uploaded'];
          total_unattempted = message['total_unattempted'];
          avg_talktime = message['avg_talktime'];
          avg_acwtime = message['avg_acwtime'];
          total_acwtime = message['total_acwtime'];
          total_breaktime = message['total_breaktime'];
          total_talktime = message['total_talktime'];
          nooffollowups = message['total_uploaded_followup'];
          total_dialed_followup = message['total_dialed_followup'];
          total_dialed_callback = message['total_dialed_callback'];
          total_contacted_callback = message['total_contacted_callback'];
          double total_followup_bar = message['total_uploaded_followup'];
          attempeted_bar = double.parse(total_followup_bar.toString());

          double total_callback_bar = message['total_uploaded_callback'];
          attempeted_bar = double.parse(total_callback_bar.toString());
          ClsLogs.API_SUCCESS(
              "date:${DateTime.now()},\nmethod:getCCCagentCallDashBoard(),\nurl:$url,\nbody:$mybody\n",
              "response:${response.body}");

          print(response.body);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("")));
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
          "method:getCCCagentCallDashBoard(),\nurl:$url,\nbody:$mybody,\nException:$e\ndate:${DateTime.now()}");

      // ScaffoldMessenger.of(context)
      //     .showSnackBar( SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  locationfetch() async {
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
  }

  Future<List<GetCccCampList>>? _func;
  Timer? timer;

  @override
  void initState() {
    if (LoginService.enable_loc_loginlogout == true ||
        LoginService.enable_location == true) {
      _handleLocationPermission();
    }
    _func = getCCCCampList();
    print("valuee=$record_message");
    if (mounted) {
      timer = Timer(const Duration(seconds: 2), () {
        setState(() {
          _func = getCCCCampList();
          print("after timer valuee=$record_message");
        });
      });
    }

    if (LoginService.enable_location == true) {
      LocationService.fetchLocation(context, _selectedDate, lat, long,
          "$street,$locality,$sublocality,$country");
    } else {
      print("location is not enable");
    }
    // data = [
    //   _ChartData('Attempted:${total_dialed ?? 0.0}', total_dialed ?? 0.0),
    //   _ChartData('Contacted:${total_contacted ?? 0.0}', total_contacted ?? 0.0),
    //   _ChartData('Failure:${total_dialed_followup ?? 0.0}',
    //       total_dialed_followup ?? 0.0),
    //   _ChartData(
    //       'DND:${total_dialed_callback ?? 0.0}', total_dialed_callback ?? 0.0),
    // ];
    // print("submitted=$success_per");
    // print("pending=$pending_per");
    // print("failure=$failure_per");
    // print("dnd=$dnd_per");
    // _tooltip = TooltipBehavior(enable: true);
    if (mounted) {
      timer = Timer.periodic(Duration(seconds: 2), (timer) {
        setState(() {
          record_message;
          print("message =$record_message");
        });
        //code to run on every 5 seconds
      });
    }

    // data = [
    //   _ChartData('Success:20', 20 ?? 0.0),
    //   _ChartData('Failure:30', 30 ?? 0.0),
    //   _ChartData('DND:40', 40 ?? 0.0),
    // ];

    // _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrwaerWidget(),
        appBar: MyAppbar(
          title: "Agent Dashboard",
        ),
        // appBar: AppBar(
        //   backgroundColor:  Color(0xffff137ca6),
        // ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/triangle.jpg"),
                  repeat: ImageRepeat.repeat),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectedDate = DateTime.now();
                            changeContainerColor(0);
                            _func = getCCCCampList();
                          },
                          child: Container(
                            width: 90,
                            height: 35,
                            decoration: BoxDecoration(
                              color: selectedContainerIndex == 0
                                  ? Color(0xffff137ca6)
                                  : Color(0xffffe86024),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Today",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TopGridWidget(
                            text: 'Last 7 Days',
                            isSelected: selectedContainerIndex == 1,
                            onTap: () {
                              check_datepicker = false;

                              changeContainerColor(1);

                              _selectedDate =
                                  _selectedDate.subtract(Duration(days: 7));
                              _func = getCCCCampList();
                            }),
                        SizedBox(width: 5),
                        TopGridWidget(
                            text: 'Last 30 Days',
                            isSelected: selectedContainerIndex == 2,
                            onTap: () {
                              check_datepicker = false;

                              changeContainerColor(2);
                              _selectedDate =
                                  DateTime.now().subtract(Duration(days: 30));
                              _func = getCCCCampList();
                            }),
                        SizedBox(width: 5),
                        TopGridWidget(
                          text: 'Selected Day',
                          isSelected: selectedContainerIndex == 3,
                          onTap: () {
                            changeContainerColor(3);
                            check_datepicker = true;
                            _func = getCCCCampList();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  check_datepicker == true
                      ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDate = _selectedDate
                                          .subtract(Duration(days: 1));

                                      // _func = fetchOBDcamplist();
                                    });
                                    _func = getCCCCampList();
                                  },
                                  child: Icon(Icons.arrow_back)),
                              GestureDetector(
                                onTap: () {
                                  _presentDatePicker();
                                  setState(() {});
                                },
                                child: Text(
                                  _selectedDate == null
                                      ? DateTime.now()
                                          .toString()
                                          .substring(0, 10)
                                      : _selectedDate
                                          .toString()
                                          .substring(0, 10),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 129, 129, 129)),
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
                                  setState(() {
                                    _selectedDate =
                                        _selectedDate.add(Duration(days: 1));

                                    if (_selectedDate
                                            .compareTo(DateTime.now()) >
                                        0) {
                                      _selectedDate = DateTime.now();
                                    }

                                    // _func = fetchOBDcamplist();

                                    print("time=$_selectedDate");

                                    // dateTime =
                                    //     DateFormat('yyyy-MM-dd').format(DateTime.now());
                                  });
                                  _func = getCCCCampList();

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
                        )
                      : Container(),
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
                                            TextStyle(color: Colors.red),
                                        decoration: BoxDecoration(),
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                        ),
                                        dropDownMenuItems: data.map((item) {
                                          return item.leadname;
                                        }).toList(),
                                        onChanged: (dynamic value) {
                                          if (value != null) {
                                            GetCccCampList selectedValue =
                                                value as GetCccCampList;
                                            setState(() {
                                              selected = selectedValue.leadid
                                                  .toString();
                                            });
                                            print("lead id= $selected");
                                            getCCCagentCallDashBoard();
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
                                  return CircularProgressIndicator(
                                      color: Colors.blue);
                                },
                              )
                            : record_message == null
                                ? Expanded(
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
                        // Expanded(
                        //   flex: 3,
                        //   child: listToSearch.isEmpty
                        //       ? CustomSearchableDropDown(
                        //           dropdownHintText: "Select Campaign",
                        //           menuHeight: 100,
                        //           items: [],
                        //           hint: "Select Campaign",
                        //           label: 'Select Campaign',
                        //           labelStyle:
                        //                TextStyle(color: Colors.red),
                        //           decoration:  BoxDecoration(),
                        //           prefixIcon:  Padding(
                        //             padding: EdgeInsets.all(0.0),
                        //           ),
                        //           dropDownMenuItems: [],
                        //           onChanged: (value) {
                        //             if (value != null) {
                        //               selected = value['class'].toString();
                        //             } else {
                        //               selected = null;
                        //             }
                        //           },
                        //         )
                        //       : CustomSearchableDropDown(
                        //           dropdownHintText: "Select Campaign",
                        //           menuHeight: 100,
                        //           items: listToSearch,
                        //           hint: "Select Campaign",
                        //           label: 'Select Campaign',
                        //           labelStyle:
                        //                TextStyle(color: Colors.red),
                        //           decoration:  BoxDecoration(),
                        //           prefixIcon:  Padding(
                        //             padding: EdgeInsets.all(0.0),
                        //           ),
                        //           dropDownMenuItems: listToSearch.map((item) {
                        //             return item['name'];
                        //           }).toList(),
                        //           onChanged: (value) {
                        //             if (value != null) {
                        //               selected = value['class'].toString();
                        //             } else {
                        //               selected = null;
                        //             }
                        //           },
                        //         ),
                        // ),
                      ],
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DashboardContainer(
                          text: "Uploaded",
                          image: "images/uploaded.png",
                          value: "${total_uploaded ?? 0}",
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        DashboardContainer(
                          text: "Unique Dialed",
                          image: "images/unique_dialed.png",
                          value: "${total_unique_dialed ?? 0}",
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        DashboardContainer(
                          text: "Unattempted",
                          image: "images/unattempt.png",
                          value: "${total_unattempted ?? 0}",
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        DashboardContainer(
                          text: "Contacted",
                          image: "images/contacted2.png",
                          value: "${total_contacted ?? 0}",
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        DashboardContainer(
                          text: "Not Contacted",
                          image: "images/notcontacted.png",
                          value: "${total_notcontacted ?? 0}",
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Container(
                      decoration: BoxDecoration(),
                      width: 350,
                      height: 300,
                      child: Container(
                          decoration: BoxDecoration(),
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          child: chartToRun()),
                      //  SfCartesianChart(
                      //     primaryXAxis: CategoryAxis(),
                      //     tooltipBehavior: _tooltip,
                      //     series: <ChartSeries<_ChartData, String>>[
                      //       ColumnSeries<_ChartData, String>(
                      //         dataSource: data!,
                      //         xValueMapper: (_ChartData data, _) => data.x,
                      //         yValueMapper: (_ChartData data, _) => data.y,
                      //         name: 'Gold',
                      //         onCreateRenderer:
                      //             (ChartSeries<_ChartData, String> series) {
                      //           return _CustomColumnSeriesRenderer();
                      //         },
                      //       )
                      //     ])
                    ),
                  ),

                  // Padding(
                  //   padding:  EdgeInsets.only(top: 40),
                  //   child: Container(
                  //       width: 350,
                  //       height: 300,
                  //       decoration:  BoxDecoration(),
                  //       child: SfCartesianChart(
                  //           primaryXAxis: CategoryAxis(),
                  //           tooltipBehavior: _tooltip,
                  //           series: <ChartSeries<_ChartData, String>>[
                  //             ColumnSeries<_ChartData, String>(
                  //               dataSource: data!,
                  //               xValueMapper: (_ChartData data, _) => data.x,
                  //               yValueMapper: (_ChartData data, _) => data.y,
                  //               name: '',
                  //               onCreateRenderer:
                  //                   (ChartSeries<_ChartData, String> series) {
                  //                 return _CustomColumnSeriesRenderer();
                  //               },
                  //             )
                  //           ])),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: DashboardBottomContainer(
                          f1: "${nooffollowups ?? 0}",
                          s1: "${total_dialed_followup ?? 0}",
                          firstcount: 'FollowUps',
                          secondcount: 'Dialed',
                          title: 'FollowUps',
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: DashboardBottomContainer(
                          f1: '0',
                          s1: '0',
                          firstcount: 'Received',
                          secondcount: 'Answered',
                          title: 'Customer CallBack',
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = ChartOptions();

    xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
      options: chartOptions,
    );
    chartData = ChartData(
      dataRows: [
        [attempeted_bar ?? 0.0, 0.0, 0.0, 0.0],
        [0.0, contacted_bar ?? 0.0, 0.0, 0.0],

        [0.0, 0.0, followup_bar ?? 0.0, 0.0],

        [0.0, 0.0, 0.0, callback_bar ?? 0.0],

        // [0.0],
        // [0.0],
        // [0.0],
      ],
      xUserLabels: [
        'Attempted',
        'Contacted',
        'FollowUp',
        'CallBack',
      ],
      dataRowsLegends: ["", "", "", ""],
      chartOptions: chartOptions,
    );

    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

// class _ColumnCustomPainter extends ColumnSegment {
//   @override
//   int get currentSegmentIndex => super.currentSegmentIndex!;
//   @override
//   void onPaint(Canvas canvas) {
//     final List<LinearGradient> gradientList = <LinearGradient>[
//       LinearGradient(colors: <Color>[
//         Color(0xff137ca6),
//         Color(0xff137ca6),

//         // Color.fromARGB(255, 1, 129, 18),
//         // Color.fromARGB(255, 3, 248, 130)
//       ], stops: <double>[
//         0.2,
//         0.9
//       ]),
//       LinearGradient(colors: <Color>[
//         Color(0xffe86024),
//         Color(0xffe86024),

//         // Color.fromARGB(255, 253, 90, 98),
//         // Color.fromARGB(255, 243, 33, 33)
//       ], stops: <double>[
//         0.2,
//         0.9
//       ]),
//       LinearGradient(colors: <Color>[
//         Color(0xffd32f2f),
//         Color(0xffd32f2f),
//       ], stops: <double>[
//         0.2,
//         0.9
//       ]),
//       LinearGradient(colors: <Color>[
//         Color(0xff000000),
//         Color(0xff000000),
//       ], stops: <double>[
//         0.2,
//         0.9
//       ]),
//     ];

//     fillPaint!.shader =
//         gradientList[currentSegmentIndex].createShader(segmentRect.outerRect);

//     super.onPaint(canvas);
//   }
// }

// class _CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
//   _CustomColumnSeriesRenderer();
//   @override
//   ChartSegment createSegment() {
//     return _ColumnCustomPainter();
//   }
// }
