// ignore_for_file: avoid_print, prefer_collection_literals, sized_box_for_whitespace, non_ant_identifier_names

import 'package:ccc_app/model/break_model.dart';
import 'package:ccc_app/service/break_apiservice.dart';
import 'package:ccc_app/service/healthcheck_api.dart';
import 'package:flutter/material.dart';

class BreakAlertDialog extends StatefulWidget {
  BreakAlertDialog({Key? key}) : super(key: key);

  @override
  State<BreakAlertDialog> createState() => _BreakAlertDialogState();
}

class _BreakAlertDialogState extends State<BreakAlertDialog> {
  Future<List<BreakList>>? _func;
  int? break_v;
  int? breakid;
  @override
  void initState() {
    _func = BreakService.fetchBreakList();

    if (HealthCheck.breakname != 0) {
      breakid = HealthCheck.breakname;
      print("breakname not null=  $breakid");
    } else {
      print("breakname= ${HealthCheck.breakname}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: AlertDialog(
        title: const Text("Change State"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Break"),
                const SizedBox(
                  width: 20,
                ),
                BreakService.value2 == null
                    ? Expanded(
                        child: FutureBuilder(
                        future: _func,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<BreakList> data =
                                snapshot.data as List<BreakList>;

                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: BreakService.break_name,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: [
                                  DropdownMenuItem(
                                    value: "Select Break",
                                    child: Text(
                                      "Select Break",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  ...data.map((items) {
                                    return DropdownMenuItem(
                                      value: items.breakid.toString(),
                                      child: Text(
                                        items.breakname.toString(),
                                        maxLines: 1,
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    BreakService.break_name =
                                        value!; // No need for type conversion here
                                    // Convert the selected value to an int and assign to breakid
                                    breakid = int.tryParse(value);
                                    print(
                                        "dropdown value = ${BreakService.break_name}");
                                    print("Selected Break ID: $breakid");
                                  });
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        },
                      ))
                    : Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: BreakService.break_name,
                            items: [],
                            onChanged: (newValue) {
                              setState(() {
                                BreakService.break_name = newValue!;
                              });
                            },
                            hint: Text('Select Break'),
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      BreakService.releaseBreak(context, breakid);
                      // HealthCheck.breakname = 0;
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color(0xFFE86024),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "RELEASE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      BreakService.setBreak(context, breakid);
                      
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color(0xFFE86024),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "SET BREAK",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
