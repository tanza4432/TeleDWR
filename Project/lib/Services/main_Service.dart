import 'dart:convert';
import 'package:dwr0001/Models/data_Model.dart';
import 'package:http/http.dart' as http;
import 'package:dwr0001/Models/station_model.dart';

// ignore: missing_return
List<StationModel> parseStation(String responseBody, String tab) {
  var parsed = [];
  switch (tab) {
    case "1":
      parsed = json.decode(responseBody.toString());
      return parsed
          .map<StationModel>((json) => StationModel.fromJson(json))
          .toList();
      break;
    case "2":
      parsed = json.decode(responseBody.toString());
      var result = parsed.where((status) =>
          (status["CURR_STATUS"] == "1" || status["CURR_STATUS"] == "2"));
      return result
          .map<StationModel>((json) => StationModel.fromJson(json))
          .toList();
      break;
    default:
      print("ไม่ตรงเงื่อนไข");
      break;
  }
}

Future<List<StationModel>> getStationListTab(var basinId, var tab) async {
  //final response = await http.get('http://192.168.1.2:8000/products.json');
  final String url = basinId == 1
      ? "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json"
      : basinId == 2
          ? "http://tele-salawin.dwr.go.th/webservice/webservice_sl_json"
          : basinId == 3
              ? "http://tele-kokkhong.dwr.go.th/webservice/webservice_kk_json"
              : basinId == 4
                  ? "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_Json"
                  : "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseStation(response.body, tab);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

Future<StationModel> getStation(String stn_id, int basinId) async {
  try {
    String url;
    if (basinId == 4) {
      url =
          "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_Json_id?stn_id=" +
              stn_id;
    } else {
      url =
          "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json_id?stn_id=" +
              stn_id;
    }
    //final String url = "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json";
    //https://localhost:44303/webservice/webservice_mk_json_id?stn_id=TC140805
    //final String url = "https://jsonplaceholder.typicode.com/todos/1";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final station = jsonDecode(response.body);
      return StationModel.fromJson(station);
    } else {
      throw Exception(
          'Failed load data with status code ${response.statusCode}');
    }
  } catch (e) {
    print(e);
  }
}

Future<StationModel> getStationData(String stn_id) async {
  //final String url ="http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json?stn_id=" + stn_id;
  final String url =
      "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_Data_json?stn_id=" +
          stn_id;
  //https://localhost:44303/webservice/webservice_mk_json_id?stn_id=TC140805
  //final String url = "https://jsonplaceholder.typicode.com/todos/1";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final station = jsonDecode(response.body);
    return StationModel.fromJson(station);
  } else {
    throw Exception();
  }
}

List<DataModelGet> parseData_(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed
      .map<DataModelGet>((json) => DataModelGet.fromJson(json))
      .toList();
}

Future<List<DataModelGet>> getStationData24H(String stn_id) async {
  //final String url ="http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json?stn_id=" + stn_id;
  final String url =
      "http://tele-kokkhong.dwr.go.th/webservice/getdata?station_ID=" + stn_id;
  //https://localhost:44303/webservice/webservice_mk_json_id?stn_id=TC140805
  //final String url = "https://jsonplaceholder.typicode.com/todos/1";
  final response = await http.get(Uri.parse(url));
  final parsed = json.decode(response.body);
  if (parsed.length == 0) {
    final String url =
        "https://tele-songkramhuailuang.dwr.go.th/webservice/getdata?station_id=TC140605";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed
          .map<DataModelGet>((json) => DataModelGet.fromJson(json))
          .toList();
    } else {
      throw Exception();
    }
  }
  if (response.statusCode == 200) {
    return parseData_(response.body);
  } else {
    throw Exception();
  }
}
