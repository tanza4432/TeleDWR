import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dwr0001/Models/station_model.dart';

Future<StationModel> getStation() async {
  final String url =
      "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json_id?stn_id=TC140805";
  //final String url = "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json";
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

// ignore: missing_return
List<StationModel> parseStation(String responseBody, String tab) {
  var parsed = [];
  switch (tab) {
    case "1":
      parsed = json.decode(responseBody);
      return parsed
          .map<StationModel>((json) => StationModel.fromJson(json))
          .toList();
      break;
    case "2":
      parsed = json.decode(responseBody);
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
              : "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseStation(response.body, tab);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
