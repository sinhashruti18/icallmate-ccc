// To parse this JSON data, do
//
//     final getCccCampList = getCccCampListFromJson(jsonString);

import 'dart:convert';

GetCccCampList getCccCampListFromJson(String str) =>
    GetCccCampList.fromJson(json.decode(str));

String getCccCampListToJson(GetCccCampList data) => json.encode(data.toJson());

class GetCccCampList {
  int autodialpacing;
  int isleadexpired;
  int rejectCount;
  int statusValue;
  int agentcampStatus;
  int dispgroupid;
  String userid;
  bool isautodiallead;
  String datetime;
  bool isopendialpad;
  bool enable;
  DateTime leadendDatetime;
  bool isincEnable;
  int retryattempts;
  String credittypename;
  String serviceno;
  bool iscampmask;
  int approvedCount;
  int credittype;
  int totalCount;
  String statusName;
  String leadname;
  int crmGroupid;
  bool isagentcampmask;
  String filename;
  String schddatetime;
  bool isautodialstarted;
  int leadid;

  GetCccCampList({
    required this.autodialpacing,
    required this.isleadexpired,
    required this.rejectCount,
    required this.statusValue,
    required this.agentcampStatus,
    required this.dispgroupid,
    required this.userid,
    required this.isautodiallead,
    required this.datetime,
    required this.isopendialpad,
    required this.enable,
    required this.leadendDatetime,
    required this.isincEnable,
    required this.retryattempts,
    required this.credittypename,
    required this.serviceno,
    required this.iscampmask,
    required this.approvedCount,
    required this.credittype,
    required this.totalCount,
    required this.statusName,
    required this.leadname,
    required this.crmGroupid,
    required this.isagentcampmask,
    required this.filename,
    required this.schddatetime,
    required this.isautodialstarted,
    required this.leadid,
  });

  factory GetCccCampList.fromJson(Map<String, dynamic> json) => GetCccCampList(
        autodialpacing: json["autodialpacing"],
        isleadexpired: json["isleadexpired"],
        rejectCount: json["reject_count"],
        statusValue: json["status_value"],
        agentcampStatus: json["agentcamp_status"],
        dispgroupid: json["dispgroupid"],
        userid: json["userid"],
        isautodiallead: json["isautodiallead"],
        datetime: json["datetime"],
        isopendialpad: json["isopendialpad"],
        enable: json["enable"],
        leadendDatetime: DateTime.parse(json["leadend_datetime"]),
        isincEnable: json["isinc_enable"],
        retryattempts: json["retryattempts"],
        credittypename: json["credittypename"],
        serviceno: json["serviceno"],
        iscampmask: json["iscampmask"],
        approvedCount: json["approved_count"],
        credittype: json["credittype"],
        totalCount: json["total_count"],
        statusName: json["status_name"],
        leadname: json["leadname"],
        crmGroupid: json["crm_groupid"],
        isagentcampmask: json["isagentcampmask"],
        filename: json["filename"],
        schddatetime: json["schddatetime"],
        isautodialstarted: json["isautodialstarted"],
        leadid: json["leadid"],
      );

  Map<String, dynamic> toJson() => {
        "autodialpacing": autodialpacing,
        "isleadexpired": isleadexpired,
        "reject_count": rejectCount,
        "status_value": statusValue,
        "agentcamp_status": agentcampStatus,
        "dispgroupid": dispgroupid,
        "userid": userid,
        "isautodiallead": isautodiallead,
        "datetime": datetime,
        "isopendialpad": isopendialpad,
        "enable": enable,
        "leadend_datetime": leadendDatetime.toIso8601String(),
        "isinc_enable": isincEnable,
        "retryattempts": retryattempts,
        "credittypename": credittypename,
        "serviceno": serviceno,
        "iscampmask": iscampmask,
        "approved_count": approvedCount,
        "credittype": credittype,
        "total_count": totalCount,
        "status_name": statusName,
        "leadname": leadname,
        "crm_groupid": crmGroupid,
        "isagentcampmask": isagentcampmask,
        "filename": filename,
        "schddatetime": schddatetime,
        "isautodialstarted": isautodialstarted,
        "leadid": leadid,
      };
}
