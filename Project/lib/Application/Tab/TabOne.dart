import 'package:dwr0001/Application/StationPage.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/BoxRain15M.dart';
import 'package:dwr0001/components/BoxRainDetail.dart';
import 'package:dwr0001/components/BoxWaterLevel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: must_be_immutable
class TabOne extends StatelessWidget {
  TabOne(this.stnId);
  var stnId;
  List<StationModel> resultOffline = [];
  bool check = false;

  String _title = 'ข้อมูลตรวจวัด';
  // _title = "สถานี : " + station.STN_Name
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    StationModel station;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white60, Colors.black],
          ),
          image: DecorationImage(
            image: AssetImage('assets/banner/banner02/background04.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Consumer<RiverProviderTabOne>(
            builder: (context, Data, _) => Column(
                  children: <Widget>[
                    CustomPaint(painter: CurvePainter()),
                    FutureBuilder<StationModel>(
                        future: getStation(stnId),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            if (Data.dataRiver.length != 0) {
                              for (var i in Data.dataRiver) {
                                if (i.STN_ID == stnId) {
                                  station = i;
                                  break;
                                }
                              }
                              if (station == null) {
                                return CircularProgressIndicator();
                              }
                            } else {
                              return CircularProgressIndicator();
                            }
                          }
                          if (snapshot.hasData) {
                            station = snapshot.data;
                          }
                          if (Data.dataRiver.length == 0) {
                            Data.addData(station);
                          } else {
                            for (var i in Data.dataRiver) {
                              if (i.STN_ID == station.STN_ID) {
                                check = true;
                                break;
                              }
                            }
                            if (check == false) {
                              Data.addData(station);
                            }
                          }
                          var CURR_Acc_Rain_15_M_ = "";
                          var CURR_Acc_Rain_30_M_ = "";
                          var CURR_Acc_Rain_60_M_ = "";
                          var CURR_Acc_Rain_1_d_ = "";
                          var CURR_Acc_Rain_12_H_ = "";
                          var CURR_Water_D_Level_MSL_ = "";
                          var CURR_FLOW_ = "";
                          if (station.RF == "") {
                            CURR_Acc_Rain_15_M_ = "n/a";
                            CURR_Acc_Rain_30_M_ = "n/a";
                            CURR_Acc_Rain_60_M_ = "n/a";
                            CURR_Acc_Rain_1_d_ = "n/a";
                            CURR_Acc_Rain_12_H_ = "n/a";
                          } else {
                            CURR_Acc_Rain_15_M_ = station.CURR_Acc_Rain_15_M;
                            CURR_Acc_Rain_30_M_ = station.CURR_Acc_Rain_30_M;
                            CURR_Acc_Rain_60_M_ = station.CURR_Acc_Rain_60_M;
                            CURR_Acc_Rain_1_d_ = station.CURR_Acc_Rain_1_D;
                            CURR_Acc_Rain_12_H_ = station.CURR_Acc_Rain_12_H;
                          }

                          if (station.WL == "") {
                            CURR_Water_D_Level_MSL_ = "-";
                            CURR_FLOW_ = "-";
                          } else {
                            CURR_Water_D_Level_MSL_ =
                                station.CURR_Water_D_Level_MSL;
                            CURR_FLOW_ = station.CURR_FLOW;
                          }
                          _title = "สถานี : " + stnId + " " + station.STN_Name;
                          double c_width =
                              MediaQuery.of(context).size.width * 0.95;
                          var _dateshow =
                              "วันที่บันทึกข้อมูล \n" + station.LAST_UPDATE;
                          return (Container(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(5.0),
                                      color: Colors.lightBlue[700],
                                      child: Column(children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined),
                                            Flexible(
                                                child: Text(
                                              _title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Kanit',
                                                  decoration:
                                                      TextDecoration.none),
                                            )),
                                          ],
                                        )
                                      ])),
                                  SizedBox(height: size.height * 0.04),
                                  Container(
                                    width: c_width,
                                    padding: EdgeInsets.all(3.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/TabOne/cloud.png'),
                                                width: size.width * 0.2,
                                              ),
                                              Text(
                                                _dateshow,
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 0,
                                                        color: Colors.black87,
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                      ),
                                                    ],
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(2),
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Kanit',
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        BoxRain15M(
                                            size: size,
                                            deviceWidth: deviceWidth,
                                            station: station),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BoxRainDetail(
                                          deviceWidth: deviceWidth,
                                          size: size,
                                          station: station,
                                          minute: "30 นาที",
                                        ),
                                        SizedBox(width: size.width * 0.05),
                                        BoxRainDetail(
                                          deviceWidth: deviceWidth,
                                          size: size,
                                          station: station,
                                          minute: "60 นาที",
                                        ),
                                        SizedBox(width: size.width * 0.05),
                                        BoxRainDetail(
                                          deviceWidth: deviceWidth,
                                          size: size,
                                          station: station,
                                          minute: "12 ชม.",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BoxWaterLevel(
                                              size: size,
                                              station: station,
                                              title: "ระดับน้ำ",
                                              text: "ม.รทก.",
                                            ),
                                            SizedBox(width: size.width * 0.05),
                                            BoxWaterLevel(
                                              size: size,
                                              station: station,
                                              title: "ปริมาณน้ำ",
                                              text: "ลบ.ม./วินาที",
                                            ),
                                          ]),
                                    ),
                                  )
                                ],
                              )));
                        }),
                  ],
                )),
      ),
    );
  }
}