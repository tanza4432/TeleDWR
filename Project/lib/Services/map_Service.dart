import 'dart:convert';
import 'package:dwr0001/Models/map_Model.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:http/http.dart' as http;

Future<List<StationModel>> get_dataMap() async {
  // switch (basinId) {
  //   case 1:
  //     {
  //       url =
  //           "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;

  //   case 2:
  //     {
  //       url =
  //           "http://tele-salawin.dwr.go.th/webservice/webservice_sl_json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;
  //   case 3:
  //     {
  //       url =
  //           "http://tele-kokkhong.dwr.go.th/webservice/webservice_kk_json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;
  //   case 4:
  //     {
  //       url =
  //           "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_Json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;
  //   case 5:
  //     {
  //       url =
  //           "http://tele-bangpakong.dwr.go.th/webservice/webservice_bpk_Json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;
  //   case 6:
  //     {
  //       url =
  //           "https://tele-bangsaphan.dwr.go.th/webservice/webservice_bsp_Json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;
  //   case 7:
  //     {
  //       url =
  //           "https://tele-nakhonsri.dwr.go.th/webservice/webservice_nst_json_id?stn_id=" +
  //               stn_id;
  //     }
  //     break;
  // }
  // ส่ง Basin พร้อมกับข้อมูล

  final String url =
      "https://tele-songkramhuailuang.dwr.go.th/webservice/webservice_skh_Json";
  // "https://tele-nakhonsri.dwr.go.th/webservice/webservice_nst_json";

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
