// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'login_apiservice.dart';

class LeadCustomFields {
  // TextField(0),
  //     Dropdown(1),
  //     CheckBox(2),
  //     RadioList(3),
  //     ListBox(4),
  //     TextArea(5),
  //     Editor(6),
  //     Calendar(7),
  //     MultiCheckBox(8),
  //     DataTable(9);
  // webresources/LeadCustomFields?

  static final String apiUrl =
      '${LoginService.cccIP}webresources/LeadCustomFields?';
  static const int campId = 193;

  static List<dynamic> fieldList = [];
  static var fieldText1,
      fieldText2,
      fieldText3,
      fieldText4,
      fieldText5,
      fieldText6,
      fieldText7,
      fieldText8,
      fieldText9,
      fieldText10,
      fieldText11,
      fieldText12,
      fieldText13,
      fieldText14,
      fieldText15,
      fieldText16,
      fieldText17,
      fieldText18,
      fieldText19,
      fieldText20,
      fieldText21,
      fieldText22,
      fieldText23,
      fieldText24,
      fieldText25,
      fieldText26,
      fieldText27,
      fieldText28,
      fieldText29,
      fieldText30,
      fld_phoneno;
  static var fieldText1_value,
      fieldText2_value,
      fieldText3_value,
      fieldText4_value,
      fieldText5_value,
      fieldText6_value,
      fieldText7_value,
      fieldText8_value,
      fieldText9_value,
      fieldText10_value,
      fieldText11_value,
      fieldText12_value,
      fieldText13_value,
      fieldText14_value,
      fieldText15_value,
      fieldText16_value,
      fieldText17_value,
      fieldText18_value,
      fieldText19_value,
      fieldText20_value,
      fieldText21_value,
      fieldText22_value,
      fieldText23_value,
      fieldText24_value,
      fieldText25_value,
      fieldText26_value,
      fieldText27_value,
      fieldText28_value,
      fieldText29_value,
      fieldText30_value,
      fld_phoneno_value;
  static List fieldText3_list = [];

  static Future<dynamic> fetchDynaFields(var localleadid) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({"localleadid": localleadid}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['value']['fld_fieldtext2'] != null) {
        fieldText2 = data['value']['fld_fieldtext2']['label'];
        fieldText2_value =
            data['value']['fld_fieldtext2']['controlType']['value'];
        print("fld2= $fieldText2");
        print("fld2= $fieldText2_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext1'] != null) {
        fieldText1 = data['value']['fld_fieldtext1']['label'];
        fieldText1_value =
            data['value']['fld_fieldtext1']['controlType']['value'];
        print("fld1= $fieldText1");
        print("fld1= $fieldText1_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_phoneno'] != null) {
        fld_phoneno = data['value']['fld_phoneno']['label'];
        fld_phoneno_value =
            data['value']['fld_phoneno']['controlType']['value'];
        print("fldpone= $fld_phoneno");
        print("fldphone= $fld_phoneno_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext3'] != null) {
        fieldText3 = data['value']['fld_fieldtext3']['label'];
        fieldText3_value =
            data['value']['fld_fieldtext3']['controlType']['value'];
        print("fld3= $fieldText3");
        print("fld3= $fieldText3_value");
        fieldText3_list = data['value']['fld_fieldtext3']['selectItems'];
        print("fld3= $fieldText3_list");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext4'] != null) {
        fieldText4 = data['value']['fld_fieldtext4']['label'];
        fieldText4_value =
            data['value']['fld_fieldtext4']['controlType']['value'];
        print("fld4= $fieldText4");
        print("fld4= $fieldText4_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext5'] != null) {
        fieldText5 = data['value']['fld_fieldtext5']['label'];
        fieldText5_value =
            data['value']['fld_fieldtext5']['controlType']['value'];
        print("fld5= $fieldText5");
        print("fld5= $fieldText5_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext6'] != null) {
        fieldText6 = data['value']['fld_fieldtext6']['label'];
        fieldText6_value =
            data['value']['fld_fieldtext6']['controlType']['value'];
        print("fld6= $fieldText6");
        print("fld6= $fieldText6_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext7'] != null) {
        fieldText7 = data['value']['fld_fieldtext7']['label'];
        fieldText7_value =
            data['value']['fld_fieldtext7']['controlType']['value'];
        print("fld7= $fieldText7");
        print("fld7= $fieldText7_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext8'] != null) {
        fieldText8 = data['value']['fld_fieldtext8']['label'];
        fieldText8_value =
            data['value']['fld_fieldtext8']['controlType']['value'];
        print("fld7= $fieldText8");
        print("fld7= $fieldText8_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext9'] != null) {
        fieldText9 = data['value']['fld_fieldtext9']['label'];
        fieldText9_value =
            data['value']['fld_fieldtext9']['controlType']['value'];
        print("fld7= $fieldText9");
        print("fld7= $fieldText9_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext10'] != null) {
        fieldText10 = data['value']['fld_fieldtext10']['label'];
        fieldText10_value =
            data['value']['fld_fieldtext10']['controlType']['value'];
        print("fld7= $fieldText10");
        print("fld7= $fieldText10_value");

        // Display fieldText7 in your UI
      }
      if (data['value']['fld_fieldtext11'] != null) {
        fieldText11 = data['value']['fld_fieldtext11']['label'];
        fieldText11_value =
            data['value']['fld_fieldtext11']['controlType']['value'];
        print("fld7= $fieldText11");
        print("fld7= $fieldText11_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext11']}");

        // return data;
      }
      if (data['value']['fld_fieldtext12'] != null) {
        fieldText12 = data['value']['fld_fieldtext12']['label'];
        fieldText12_value =
            data['value']['fld_fieldtext12']['controlType']['value'];
        print("fld7= $fieldText7");
        print("fld7= $fieldText7_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext12']}");

        // return data;
      }
      if (data['value']['fld_fieldtext13'] != null) {
        fieldText13 = data['value']['fld_fieldtext13']['label'];
        fieldText13_value =
            data['value']['fld_fieldtext13']['controlType']['value'];
        print("fld7= $fieldText13");
        print("fld7= $fieldText13_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext13']}");

        // return data;
      }
      if (data['value']['fld_fieldtext14'] != null) {
        fieldText14 = data['value']['fld_fieldtext14']['label'];
        fieldText14_value =
            data['value']['fld_fieldtext14']['controlType']['label'];
        print("fld7= $fieldText14");
        print("fld7= $fieldText14_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext14']}");

        // return data;
      }
      if (data['value']['fld_fieldtext15'] != null) {
        fieldText15 = data['value']['fld_fieldtext15']['label'];
        fieldText15_value =
            data['value']['fld_fieldtext15']['controlType']['label'];
        print("fld7= $fieldText15");
        print("fld7= $fieldText15_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext15']}");

        // return data;
      }
      if (data['value']['fld_fieldtext16'] != null) {
        fieldText16 = data['value']['fld_fieldtext16']['label'];
        fieldText16_value =
            data['value']['fld_fieldtext16']['controlType']['value'];
        print("fld7= $fieldText16");
        print("fld7= $fieldText16_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext16']}");

        // return data;
      }
      if (data['value']['fld_fieldtext17'] != null) {
        fieldText17 = data['value']['fld_fieldtext17']['label'];
        fieldText17_value =
            data['value']['fld_fieldtext17']['controlType']['value'];
        print("fld7= $fieldText17");
        print("fld7= $fieldText17_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext17']}");

        // return data;
      }
      if (data['value']['fld_fieldtext18'] != null) {
        fieldText18 = data['value']['fld_fieldtext18']['label'];
        fieldText18_value =
            data['value']['fld_fieldtext18']['controlType']['value'];
        print("fld7= $fieldText18");
        print("fld7= $fieldText18_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext18']}");

        // return data;
      }
      if (data['value']['fld_fieldtext19'] != null) {
        fieldText19 = data['value']['fld_fieldtext19']['label'];
        fieldText19_value =
            data['value']['fld_fieldtext19']['controlType']['value'];
        print("fld7= $fieldText19");
        print("fld7= $fieldText19_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext19']}");

        // return data;
      }
      if (data['value']['fld_fieldtext20'] != null) {
        fieldText20 = data['value']['fld_fieldtext20']['label'];
        fieldText20_value =
            data['value']['fld_fieldtext20']['controlType']['value'];
        print("fld7= $fieldText20");
        print("fld7= $fieldText20_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext20']}");

        // return data;
      }
      if (data['value']['fld_fieldtext21'] != null) {
        fieldText21 = data['value']['fld_fieldtext21']['label'];
        fieldText21_value =
            data['value']['fld_fieldtext21']['controlType']['value'];
        print("fld7= $fieldText21");
        print("fld7= $fieldText21_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext21']}");

        // return data;
      }
      if (data['value']['fld_fieldtext22'] != null) {
        fieldText22 = data['value']['fld_fieldtext22']['label'];
        fieldText22_value =
            data['value']['fld_fieldtext22']['controlType']['value'];
        print("fld7= $fieldText22");
        print("fld7= $fieldText22_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext22']}");

        // return data;
      }
      if (data['value']['fld_fieldtext23'] != null) {
        fieldText23 = data['value']['fld_fieldtext23']['label'];
        fieldText23_value =
            data['value']['fld_fieldtext23']['controlType']['value'];
        print("fld7= $fieldText23");
        print("fld7= $fieldText23_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext23']}");

        // return data;
      }
      if (data['value']['fld_fieldtext24'] != null) {
        fieldText24 = data['value']['fld_fieldtext24']['label'];
        fieldText24_value =
            data['value']['fld_fieldtext24']['controlType']['value'];
        print("fld7= $fieldText24");
        print("fld7= $fieldText24_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext24']}");

        // return data;
      } else {
        throw Exception('Failed to load fields');
      }
      if (data['value']['fld_fieldtext25'] != null) {
        fieldText25 = data['value']['fld_fieldtext25']['label'];
        fieldText25_value =
            data['value']['fld_fieldtext25']['controlType']['value'];
        print("fld7= $fieldText25");
        print("fld7= $fieldText25_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext25']}");

        // return data;
      } else {
        throw Exception('Failed to load fields');
      }
      if (data['value']['fld_fieldtext26'] != null) {
        fieldText26 = data['value']['fld_fieldtext26']['label'];
        fieldText26_value =
            data['value']['fld_fieldtext26']['controlType']['value'];
        print("fld7= $fieldText26");
        print("fld7= $fieldText26_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext26']}");

        // return data;
      } else {
        throw Exception('Failed to load fields');
      }
      if (data['value']['fld_fieldtext27'] != null) {
        fieldText27 = data['value']['fld_fieldtext27']['label'];
        fieldText27_value =
            data['value']['fld_fieldtext27']['controlType']['value'];
        print("fld7= $fieldText27");
        print("fld7= $fieldText27_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext24']}");

        // return data;
      } else {
        throw Exception('Failed to load fields');
      }
      if (data['value']['fld_fieldtext28'] != null) {
        fieldText28 = data['value']['fld_fieldtext28']['label'];
        fieldText28_value =
            data['value']['fld_fieldtext28']['controlType']['value'];
        print("fld= $fieldText28");
        print("fld7= $fieldText28_value");

        // Display fieldText7 in your UI

        print("data=${data['value']['fld_fieldtext24']}");

        // return data;
      } else {
        throw Exception('Failed to load fields');
      }
    }
  }
}
