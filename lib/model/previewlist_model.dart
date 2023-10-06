// To parse this JSON data, do
//
//     final getCccPreviewList = getCccPreviewListFromJson(jsonString);

import 'dart:convert';

GetCccPreviewList getCccPreviewListFromJson(String str) =>
    GetCccPreviewList.fromJson(json.decode(str));

String getCccPreviewListToJson(GetCccPreviewList data) =>
    json.encode(data.toJson());

class GetCccPreviewList {
  String phonenomasking;
  String imgname;
  int mappingrowid;
  int custmaxretry;
  int phoneid;
  bool isincomingcall;
  int custCalltype;
  int rowid;
  String callstatus;
  int disableDial;
  bool isopeninccall;
  bool callStatus;
  String dateTime;
  int leaddataCount;
  String custName;
  int dialtoconnectrowid;
  bool isdialed;
  String dialmode;
  String calltype;
  bool cb;
  int retryattempt;
  int setrowcolor;
  String cbtime;
  bool ismarkedasclose;
  String callState;
  bool isfollowup;
  String phoneno;
  int platformleadid;
  int recordid;
  String custcallState;
  String dialTime;
  int panelLeadid;

  GetCccPreviewList({
    required this.phonenomasking,
    required this.imgname,
    required this.mappingrowid,
    required this.custmaxretry,
    required this.phoneid,
    required this.isincomingcall,
    required this.custCalltype,
    required this.rowid,
    required this.callstatus,
    required this.disableDial,
    required this.isopeninccall,
    required this.callStatus,
    required this.dateTime,
    required this.leaddataCount,
    required this.custName,
    required this.dialtoconnectrowid,
    required this.isdialed,
    required this.dialmode,
    required this.calltype,
    required this.cb,
    required this.retryattempt,
    required this.setrowcolor,
    required this.cbtime,
    required this.ismarkedasclose,
    required this.callState,
    required this.isfollowup,
    required this.phoneno,
    required this.platformleadid,
    required this.recordid,
    required this.custcallState,
    required this.dialTime,
    required this.panelLeadid,
  });

  factory GetCccPreviewList.fromJson(Map<String, dynamic> json) =>
      GetCccPreviewList(
        phonenomasking: json["phonenomasking"],
        imgname: json["imgname"],
        mappingrowid: json["mappingrowid"],
        custmaxretry: json["custmaxretry"],
        phoneid: json["phoneid"],
        isincomingcall: json["isincomingcall"],
        custCalltype: json["cust_calltype"],
        rowid: json["rowid"],
        callstatus: json["callstatus"],
        disableDial: json["disable_dial"],
        isopeninccall: json["isopeninccall"],
        callStatus: json["call_status"],
        dateTime: json["date_time"],
        leaddataCount: json["leaddata_count"],
        custName: json["cust_name"],
        dialtoconnectrowid: json["dialtoconnectrowid"],
        isdialed: json["isdialed"],
        dialmode: json["dialmode"],
        calltype: json["calltype"],
        cb: json["cb"],
        retryattempt: json["retryattempt"],
        setrowcolor: json["setrowcolor"],
        cbtime: json["cbtime"],
        ismarkedasclose: json["ismarkedasclose"],
        callState: json["call_state"],
        isfollowup: json["isfollowup"],
        phoneno: json["phoneno"],
        platformleadid: json["platformleadid"],
        recordid: json["recordid"],
        custcallState: json["custcall_state"],
        dialTime: json["dial_time"],
        panelLeadid: json["panel_leadid"],
      );

  Map<String, dynamic> toJson() => {
        "phonenomasking": phonenomasking,
        "imgname": imgname,
        "mappingrowid": mappingrowid,
        "custmaxretry": custmaxretry,
        "phoneid": phoneid,
        "isincomingcall": isincomingcall,
        "cust_calltype": custCalltype,
        "rowid": rowid,
        "callstatus": callstatus,
        "disable_dial": disableDial,
        "isopeninccall": isopeninccall,
        "call_status": callStatus,
        "date_time": dateTime,
        "leaddata_count": leaddataCount,
        "cust_name": custName,
        "dialtoconnectrowid": dialtoconnectrowid,
        "isdialed": isdialed,
        "dialmode": dialmode,
        "calltype": calltype,
        "cb": cb,
        "retryattempt": retryattempt,
        "setrowcolor": setrowcolor,
        "cbtime": cbtime,
        "ismarkedasclose": ismarkedasclose,
        "call_state": callState,
        "isfollowup": isfollowup,
        "phoneno": phoneno,
        "platformleadid": platformleadid,
        "recordid": recordid,
        "custcall_state": custcallState,
        "dial_time": dialTime,
        "panel_leadid": panelLeadid,
      };
}
