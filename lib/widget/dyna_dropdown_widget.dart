// ignore_for_file: avoid_print

import 'package:ccc_app/service/dyna_api.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DynaDropdownWidget extends StatelessWidget {
  DynaDropdownWidget({Key? key}) : super(key: key);
  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
          color: Color.fromARGB(255, 1, 78, 136),
        )),
        margin: EdgeInsets.only(left: 10),
        child: DropdownButton(
          isExpanded: true,
          value: dropdownvalue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: LeadCustomFields.fieldText3_list.map((items) {
            return DropdownMenuItem(
              value: items['label'].toString(),
              child: Text(
                items['label'].toString(),
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            dropdownvalue = (newValue as String?)!;
            print("dropdown value = $dropdownvalue");
          },
        ),
        // DropdownButton(
        //     isExpanded: true,
        //     // Initial Value
        //     value: dropdownvalue,
        //     hint:  Text("Select Status"),

        //     // Down Arrow Icon
        //     icon:
        //          Icon(Icons.keyboard_arrow_down),

        //     // Array list of items
        //     items: data.map((items) {
        //       return DropdownMenuItem(
        //         value:
        //             items.ticketStatusName.toString(),
        //         child: Text(
        //           items.ticketStatusName.toString(),
        //         ),
        //       );
        //     }).toList(),
        //     onChanged: (newValue) {
        //       setState(() {
        //         dropdownvalue = newValue as String?;
        //       });
        //     }),
      ),
    );
  }
}
