import 'dart:async';

import 'package:ccc_app/service/dyna_api.dart';
import 'package:ccc_app/widget/dynawidget.dart';
import 'package:flutter/material.dart';

class DynaForm extends StatefulWidget {
  DynaForm({Key? key}) : super(key: key);

  @override
  State<DynaForm> createState() => _DynaFormState();
}

class _DynaFormState extends State<DynaForm> {
  Timer? timer;
  @override
  void initState() {
    LeadCustomFields.fetchDynaFields(0);

    timer = Timer(Duration(seconds: 4), () {
      setState(() {
        LeadCustomFields.fetchDynaFields(0);

        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynaWidget(),
    );
  }
}
