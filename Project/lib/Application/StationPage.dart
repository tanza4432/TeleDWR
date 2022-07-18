import 'dart:convert';
import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/Tab/TabFour.dart';
import 'package:dwr0001/Application/Tab/TabOne.dart';
import 'package:dwr0001/Application/Tab/TabThree.dart';
import 'package:dwr0001/Application/Tab/TabTwo.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/painting.dart' as painting;
import '../Models/data_Model.dart';

class StationPage extends StatelessWidget {
  final List<StationModel> data;
  final String stn_id;
  final int basinID;
  final String RF;
  final String WL;
  final String CCTV;
  StationPage(
      {this.stn_id, this.basinID, this.RF, this.WL, this.CCTV, this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: MyDisplayClass(stn_id, basinID, RF, WL, CCTV, data),
      ),
    );
  }
}

class MyDisplayClass extends StatelessWidget {
  MyDisplayClass(
      this.stnId, this.basinID, this.RF, this.WL, this.CCTV, this.data);
  List<StationModel> data;
  var stnId;
  var basinID;
  var RF;
  var WL;
  var CCTV;
  StationModel stationData;
  String _title = 'ข้อมูลตรวจวัด';
  // ignore: non_constant_identifier_names

  String get family => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.pending_actions_sharp),
              child: Text(
                "สถานี",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Tab(
              icon: Icon(Icons.table_rows_outlined),
              child: Text(
                "ตาราง",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Tab(
              icon: Icon(Icons.bar_chart_outlined),
              child: Text(
                "กราฟ",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Tab(
              icon: Icon(Icons.camera),
              child: Text(
                "CCTV",
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        title: Text(
          'TELEDWR-ข้อมูลตรวจวัด',
          style: DefaultTitleW(),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MenuPage(data: data)))
            // Navigator.pop(context)
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.lightBlue[600],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          painting.imageCache.clear();
          Navigator.of(context).pop(true);
          return new Future.value(true);
        },
        child: TabBarView(
          children: [
            Container(
              child: TabOne(stnId),
            ),
            Container(
              child: TabTwo(stnId),
            ),
            Container(
              child: TabThree(stnId),
            ),
            RefreshIndicator(
              // ignore: missing_return
              onRefresh: () {
                imageCache.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  var stationPage = StationPage(
                    stn_id: stnId,
                    basinID: basinID,
                  );
                  return stationPage;
                }));
              },
              child: TabFour(stnId, basinID, CCTV),
            ),
          ],
        ),
      ),
    );
  }
}

List<StationModel> parseStation(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed
      .map<StationModel>((json) => StationModel.fromJson(json))
      .toList();
}

Future<List<StationModel>> getStationList(basinID, String s) async {
  //final response = await http.get('http://192.168.1.2:8000/products.json');
  final String url =
      "http://tele-maeklong.dwr.go.th/webservice/webservice_mk_json";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseStation(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

loadData() async {}

List<StationModel> parseData(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed
      .map<StationModel>((json) => StationModel.fromJson(json))
      .toList();
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
