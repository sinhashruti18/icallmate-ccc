import 'package:ccc_app/service/dyna_api.dart';
import 'package:flutter/cupertino.dart';

import 'dyna_dropdown_widget.dart';
import 'mytext.dart';

import 'mytextfielddyna.dart';

class DynaWidget extends StatelessWidget {
  DynaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          LeadCustomFields.fieldText1 != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText1)),
                    LeadCustomFields.fieldText1_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText1,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText2 != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText2)),
                    LeadCustomFields.fieldText2_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText2,
                                  // controller: fld2,
                                ))),
                          )
                        : Container(),
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText3 != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText3)),
                    LeadCustomFields.fieldText3_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText3,
                                  // controller: fld2,
                                ))),
                          )
                        : DynaDropdownWidget()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText4_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText4)),
                    LeadCustomFields.fieldText4_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText4,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText5_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText5)),
                    LeadCustomFields.fieldText5_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText5,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          LeadCustomFields.fld_phoneno != null
              ? Row(
                  children: [
                    Container(
                        decoration: const BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fld_phoneno)),
                    LeadCustomFields.fld_phoneno_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fld_phoneno,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText6_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText6)),
                    LeadCustomFields.fieldText6_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText6,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText7_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText7)),
                    LeadCustomFields.fieldText7_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText7,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText8_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText8)),
                    LeadCustomFields.fieldText8_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText8,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText9_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText9)),
                    LeadCustomFields.fieldText9_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText9,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText10_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText10)),
                    LeadCustomFields.fieldText10_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText10,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText11_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText11)),
                    LeadCustomFields.fieldText11_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText11,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText12_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText12)),
                    LeadCustomFields.fieldText12_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText12,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText13_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText13)),
                    LeadCustomFields.fieldText13_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText13,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText14_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText14)),
                    LeadCustomFields.fieldText14_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText14,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText15_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText15)),
                    LeadCustomFields.fieldText15_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText15,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText16_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText16)),
                    LeadCustomFields.fieldText16_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText16,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText17_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText17)),
                    LeadCustomFields.fieldText17_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText17,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText18_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText18)),
                    LeadCustomFields.fieldText18_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText18,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText19_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText19)),
                    LeadCustomFields.fieldText19_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText19,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText20_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText20)),
                    LeadCustomFields.fieldText20_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText20,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          LeadCustomFields.fieldText21_value != null
              ? Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(),
                        width: 120,
                        child: MyText(text: LeadCustomFields.fieldText21)),
                    LeadCustomFields.fieldText21_value == 0
                        ? Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 1, 78, 136),
                                )),
                                margin: EdgeInsets.only(left: 10),
                                child: Center(
                                    child: MyTextFielddyna(
                                  hintText: LeadCustomFields.fieldText21,
                                  // controller: fld2,
                                ))),
                          )
                        : Container()
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
