import 'dart:convert';

import 'package:flutter/foundation.dart';

class DataModel {
  final String CURR_Acc_Rain_15_M;
  final String CURR_Water_D_Level_MSL;
  final String CURR_Water_U_Level_MSL;
  final String CURR_FLOW;
  final String RF;
  final String WL;
  final String WF;
  final String LAST_UPDATE;

  DataModel({
    this.CURR_Acc_Rain_15_M,
    this.CURR_Water_D_Level_MSL,
    this.CURR_Water_U_Level_MSL,
    this.CURR_FLOW,
    this.RF,
    this.WL,
    this.WF,
    this.LAST_UPDATE,
  });

  factory DataModel.fromJson(final json) {
    return DataModel(
        CURR_Acc_Rain_15_M: json['CURR_Acc_Rain_15_M'],
        CURR_Water_D_Level_MSL: json['CURR_Water_D_Level_MSL'],
        CURR_Water_U_Level_MSL: json['CURR_Water_U_Level_MSL'],
        CURR_FLOW: json['CURR_FLOW'],
        RF: json['RF'],
        WL: json['WL'],
        WF: json['WF'],
        LAST_UPDATE: json['LAST_UPDATE']);
  }
}

List<DataModelGet> dataModelGetFromJson(String str) => List<DataModelGet>.from(
    json.decode(str).map((x) => DataModelGet.fromJson(x)));

String dataModelGetToJson(List<DataModelGet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModelGet {
  DataModelGet({
    this.Label,
    this.Rain,
    this.Water,
    this.Flow,
  });

  String Label;
  String Rain;
  String Water;
  String Flow;

  factory DataModelGet.fromJson(Map<String, dynamic> json) => DataModelGet(
        Label: json["Label"],
        Rain: json["Rain"],
        Water: json["Water"],
        Flow: json["Flow"],
      );

  Map<String, dynamic> toJson() => {
        "Label": Label,
        "Rain": Rain,
        "Water": Water,
        "Flow": Flow,
      };
}
