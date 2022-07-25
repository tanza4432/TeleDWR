import 'dart:convert';

import 'package:dwr0001/Models/station_model.dart';
import 'package:http/http.dart' as http;

Future<List<StationModel>> get_dataMap() async {
  final String url =
      "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_Json";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new StationModel.fromJson(data)).toList();
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
