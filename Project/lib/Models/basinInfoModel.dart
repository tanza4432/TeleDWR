import 'dart:convert';

List<BasinsInfoModel> basinsInfoModelFromJson(String str) =>
    List<BasinsInfoModel>.from(
        json.decode(str).map((x) => BasinsInfoModel.fromJson(x)));

String basinsInfoModelToJson(List<BasinsInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BasinsInfoModel {
  BasinsInfoModel({
    this.basinId,
    this.basinNameTh,
    this.basinNameEn,
    this.basinUrl,
    this.projectUrl,
    this.forecastUrl,
    this.notificationUrl,
  });

  String basinId;
  String basinNameTh;
  String basinNameEn;
  dynamic basinUrl;
  String projectUrl;
  String forecastUrl;
  String notificationUrl;

  factory BasinsInfoModel.fromJson(Map<String, dynamic> json) =>
      BasinsInfoModel(
        basinId: json["basinId"],
        basinNameTh: json["basinName_TH"],
        basinNameEn: json["basinName_EN"],
        basinUrl: json["Basin_URL"],
        projectUrl: json["Project_URL"],
        forecastUrl: json["Forecast_URL"],
        notificationUrl: json["Notification_URL"],
      );

  Map<String, dynamic> toJson() => {
        "basinId": basinId,
        "basinName_TH": basinNameTh,
        "basinName_EN": basinNameEn,
        "Basin_URL": basinUrl,
        "Project_URL": projectUrl,
        "Forecast_URL": forecastUrl,
        "Notification_URL": notificationUrl,
      };
}
