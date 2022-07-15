// // To parse this JSON data, do
// //
// //     final dataStnIdModelGet = dataStnIdModelGetFromJson(jsonString);

// import 'dart:convert';

// DataStnIdModelGet dataStnIdModelGetFromJson(String str) =>
//     DataStnIdModelGet.fromJson(json.decode(str));

// String dataStnIdModelGetToJson(DataStnIdModelGet data) =>
//     json.encode(data.toJson());

// class DataStnIdModelGet {
//   DataStnIdModelGet({
//     this.stnId,
//     this.data,
//   });

//   String stnId;
//   List<DataModelGet> data;

//   factory DataStnIdModelGet.fromJson(Map<String, dynamic> json) =>
//       DataStnIdModelGet(
//         stnId: json["stnId"],
//         data: List<DataModelGet>.from(
//             json["data"].map((x) => DataModelGet.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "stnId": stnId,
//         "data": List<DataModelGet>.from(data.map((x) => x.toJson())),
//       };
// }

// class DataModelGet {
//   DataModelGet({
//     this.Label,
//     this.Rain_15_M,
//     this.Water_D,
//     this.Water_F,
//   });

//   final String Label;
//   final String Rain_15_M;
//   final String Water_D;
//   final String Water_F;

//   factory DataModelGet.fromJson(Map<String, dynamic> json) => DataModelGet(
//         Label: json['Label'],
//         Rain_15_M: json['Rain'],
//         Water_D: json['Water'],
//         Water_F: json['FLOW'],
//       );

//   Map<String, dynamic> toJson() => {
//         "Label": Label,
//         "Rain": Rain_15_M,
//         "Water": Water_D,
//         "Flow": Water_F,
//       };
// }

// To parse this JSON data, do
//
//     final dataStnIdModelGet = dataStnIdModelGetFromJson(jsonString);

import 'dart:convert';

import 'package:dwr0001/Models/data_Model.dart';

DataStnIdModelGet dataStnIdModelGetFromJson(String str) =>
    DataStnIdModelGet.fromJson(json.decode(str));

String dataStnIdModelGetToJson(DataStnIdModelGet data) =>
    json.encode(data.toJson());

class DataStnIdModelGet {
  DataStnIdModelGet({
    this.stnId,
    this.data,
  });

  String stnId;
  List<dynamic> data;

  factory DataStnIdModelGet.fromJson(Map<String, dynamic> json) =>
      DataStnIdModelGet(
        stnId: json["stnId"],
        data: List<DataModelGet>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "stnId": stnId,
        "data": List<DataModelGet>.from(data.map((x) => x)),
      };
}
