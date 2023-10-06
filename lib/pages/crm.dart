import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CRMPagePrac extends StatefulWidget {
  const CRMPagePrac({Key? key}) : super(key: key);

  @override
  State<CRMPagePrac> createState() => _CRMPagePracState();
}

class _CRMPagePracState extends State<CRMPagePrac> {
  bool setCallback = false;
  bool markClosed = false;
  bool stopCampaign = false;
  int selectedValue = 0; // Initially, none selected
  List<TimeOptions> timeOptions = [
    TimeOptions(15, '15 Mins'),
    TimeOptions(30, '30 Mins'),
    TimeOptions(60, '1 Hour'),
    TimeOptions(120, '2 Hour'),
    TimeOptions(0, 'Others'),
  ];
  void handleRadioValueChange(int? value) {
    if (value != null) {
      setState(() {
        selectedValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Set Callback',
                    style: TextStyle(
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Checkbox(
                    checkColor: Colors.red,
                    activeColor: Colors.black,
                    value: setCallback,
                    onChanged: (bool? value) {
                      setState(() {
                        setCallback = value!;
                        print("value= $value");
                        // _func2 = getPreviewList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    'Mark as Closed',
                    style: TextStyle(
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Checkbox(
                    checkColor: Colors.red,
                    activeColor: Colors.black,
                    value: markClosed,
                    onChanged: (bool? value) {
                      setState(() {
                        markClosed = value!;
                        print("value= $value");
                        // _func2 = getPreviewList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    'Stop Campaign',
                    style: TextStyle(
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Checkbox(
                    checkColor: Colors.red,
                    activeColor: Colors.black,
                    value: stopCampaign,
                    onChanged: (bool? value) {
                      setState(() {
                        stopCampaign = value!;
                        print("value= $value");
                        // _func2 = getPreviewList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      "CB Time",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (TimeOptions option in timeOptions)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: option.value,
                            groupValue: selectedValue,
                            onChanged: handleRadioValueChange,
                          ),
                          Text(option.label),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class TimeOptions {
  final int value;
  final String label;

  TimeOptions(this.value, this.label);
}
