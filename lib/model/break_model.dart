// To parse this JSON data, do
//
//     final breakList = breakListFromJson(jsonString);

// BreakList breakListFromJson(String str) => BreakList.fromJson(json.decode(str));

// String breakListToJson(BreakList data) => json.encode(data.toJson());

class BreakList {
  BreakList({
    required this.breakname,
    required this.breakid,
  });

  String breakname;
  int breakid;

  factory BreakList.fromJson(Map<String, dynamic> json) => BreakList(
        breakname: json["breakname"],
        breakid: json["breakid"],
      );

  Map<String, dynamic> toJson() => {
        "breakname": breakname,
        "breakid": breakid,
      };
}
