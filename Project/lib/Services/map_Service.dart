import 'dart:convert';
import 'package:dwr0001/Models/map_Model.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:http/http.dart' as http;

Future<List<StationModel>> get_dataMap() async {
  final String url =
      // "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_Json";
      "https://tele-nakhonsri.dwr.go.th/webservice/webservice_nst_json";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new StationModel.fromJson(data)).toList();
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

Future<MapModel> get_polygon() async {
  final String url =
      "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_get_geoData";

  // "http://tele-nakhonsri.dwr.go.th/webservice/webservice_nst_get_geodata";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return MapModel.fromJson(jsonDecode(response?.body));
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
