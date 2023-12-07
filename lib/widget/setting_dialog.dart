// ignore_for_file: must_be_immutable, non_ant_identifier_names

import 'package:ccc_app/widget/mytext.dart';
import 'package:flutter/material.dart';

import 'mytextfield_widget.dart';

class SettingsDialog extends StatefulWidget {
  TextEditingController serverip_controller,
      serverport_controller,
      serverpackage_controller;
  Function() onTap;

  SettingsDialog(
      {Key? key,
      required this.serverip_controller,
      required this.serverport_controller,
      required this.serverpackage_controller,
      required this.onTap})
      : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          MyText(text: "Server"),
          MyTextField(
            hintText: "",
            controller: widget.serverip_controller,
          ),
          const SizedBox(
            height: 10,
          ),
          MyText(text: "Port"),
          MyTextField(
            hintText: "",
            controller: widget.serverport_controller,
          ),
          const SizedBox(
            height: 10,
          ),
          MyText(text: "Package Name"),
          MyTextField(
            hintText: "",
            controller: widget.serverpackage_controller,
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
      actions: <Widget>[
        Center(
            child: ElevatedButton(
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: widget.onTap))
      ],
    );
  }
}
