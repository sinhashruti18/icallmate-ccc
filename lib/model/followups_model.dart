class FollowUpsModel {
  String? userId;
  int userRowId;
  int? senderRowId;
  String senderName;
  dynamic growlMessage;
  dynamic approveRemarks;
  int creditType;
  String? time;
  // DateTime? date;
  String date;
  dynamic approveDateTime;
  String campaignType;
  int loginUserRowId;
  int loginUserType;
  dynamic loginuserid;
  int activeindex;
  String comapanyName;
  String sampleTemplate;
  int operatorId;
  dynamic operatorName;
  int smscId;
  dynamic smscName;
  int platformId;
  int rowId;
  bool showApproved;
  bool showRejected;
  int sendersmscrowid;
  bool sendersmscapprove;
  int routerowid;
  int routeid;
  dynamic routename;
  int routesmscid;
  dynamic routesmscname;
  bool routesmscenable;
  int productid;
  int accountid;
  List<dynamic> listSelectedOperator;
  dynamic playFilePath;
  dynamic listApproveSelected;
  String dltsenderid;
  String dlttelemarketingid;
  String dltentityid;
  String uploadOutboxFileName;
  bool disableButton;
  bool validSmsc;
  bool validRoute;

  FollowUpsModel({
    this.userId,
    required this.userRowId,
    this.senderRowId,
    required this.senderName,
    this.growlMessage,
    this.approveRemarks,
    required this.creditType,
    required this.time,
    required this.date,
    // required this.date,
    this.approveDateTime,
    required this.campaignType,
    required this.loginUserRowId,
    required this.loginUserType,
    this.loginuserid,
    required this.activeindex,
    required this.comapanyName,
    required this.sampleTemplate,
    required this.operatorId,
    this.operatorName,
    required this.smscId,
    this.smscName,
    required this.platformId,
    required this.rowId,
    required this.showApproved,
    required this.showRejected,
    required this.sendersmscrowid,
    required this.sendersmscapprove,
    required this.routerowid,
    required this.routeid,
    this.routename,
    required this.routesmscid,
    this.routesmscname,
    required this.routesmscenable,
    required this.productid,
    required this.accountid,
    required this.listSelectedOperator,
    this.playFilePath,
    this.listApproveSelected,
    required this.dltsenderid,
    required this.dlttelemarketingid,
    required this.dltentityid,
    required this.uploadOutboxFileName,
    required this.disableButton,
    required this.validSmsc,
    required this.validRoute,
  });

  factory FollowUpsModel.fromJson(Map<String, dynamic> json) => FollowUpsModel(
        userId: json["userID"],
        userRowId: json["userRowID"],
        senderRowId: json["senderRowID"],
        senderName: json["senderName"],
        growlMessage: json["growlMessage"],
        approveRemarks: json["approveRemarks"],
        creditType: json["creditType"],
        time: json["time"],
        date: json["date"],
        // date: DateTime.parse(json["date"]),
        approveDateTime: json["approveDateTime"],
        campaignType: json["campaignType"],
        loginUserRowId: json["loginUserRowID"],
        loginUserType: json["loginUserType"],
        loginuserid: json["loginuserid"],
        activeindex: json["activeindex"],
        comapanyName: json["comapanyName"],
        sampleTemplate: json["sampleTemplate"],
        operatorId: json["operatorID"],
        operatorName: json["operatorName"],
        smscId: json["smscID"],
        smscName: json["smscName"],
        platformId: json["platformID"],
        rowId: json["rowID"],
        showApproved: json["showApproved"],
        showRejected: json["showRejected"],
        sendersmscrowid: json["sendersmscrowid"],
        sendersmscapprove: json["sendersmscapprove"],
        routerowid: json["routerowid"],
        routeid: json["routeid"],
        routename: json["routename"],
        routesmscid: json["routesmscid"],
        routesmscname: json["routesmscname"],
        routesmscenable: json["routesmscenable"],
        productid: json["productid"],
        accountid: json["accountid"],
        listSelectedOperator:
            List<dynamic>.from(json["listSelectedOperator"].map((x) => x)),
        playFilePath: json["playFilePath"],
        listApproveSelected: json["listApproveSelected"],
        dltsenderid: json["dltsenderid"],
        dlttelemarketingid: json["dlttelemarketingid"],
        dltentityid: json["dltentityid"],
        uploadOutboxFileName: json["uploadOutboxFileName"],
        disableButton: json["disableButton"],
        validSmsc: json["validSMSC"],
        validRoute: json["validRoute"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "userRowID": userRowId,
        "senderRowID": senderRowId,
        "senderName": senderName,
        "growlMessage": growlMessage,
        "approveRemarks": approveRemarks,
        "creditType": creditType,
        "time": time,
        "date": date,
        // "date":
        //     "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "approveDateTime": approveDateTime,
        "campaignType": campaignType,
        "loginUserRowID": loginUserRowId,
        "loginUserType": loginUserType,
        "loginuserid": loginuserid,
        "activeindex": activeindex,
        "comapanyName": comapanyName,
        "sampleTemplate": sampleTemplate,
        "operatorID": operatorId,
        "operatorName": operatorName,
        "smscID": smscId,
        "smscName": smscName,
        "platformID": platformId,
        "rowID": rowId,
        "showApproved": showApproved,
        "showRejected": showRejected,
        "sendersmscrowid": sendersmscrowid,
        "sendersmscapprove": sendersmscapprove,
        "routerowid": routerowid,
        "routeid": routeid,
        "routename": routename,
        "routesmscid": routesmscid,
        "routesmscname": routesmscname,
        "routesmscenable": routesmscenable,
        "productid": productid,
        "accountid": accountid,
        "listSelectedOperator":
            List<dynamic>.from(listSelectedOperator.map((x) => x)),
        "playFilePath": playFilePath,
        "listApproveSelected": listApproveSelected,
        "dltsenderid": dltsenderid,
        "dlttelemarketingid": dlttelemarketingid,
        "dltentityid": dltentityid,
        "uploadOutboxFileName": uploadOutboxFileName,
        "disableButton": disableButton,
        "validSMSC": validSmsc,
        "validRoute": validRoute,
      };
}
