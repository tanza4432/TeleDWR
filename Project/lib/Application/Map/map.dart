import 'dart:convert';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Application/Map/widgets/detailTextBox.dart';
import 'package:dwr0001/Application/Map/widgets/titleTextBox.dart';
import 'package:dwr0001/Application/Map/widgets/widgetMap.dart';
import 'package:dwr0001/Application/Station/TabOneStation.dart';
import 'package:dwr0001/Application/StationPage.dart';
import 'package:dwr0001/Application/burgerMenu/burgermenu.dart';
import 'package:dwr0001/Application/providers/map_provider.dart';
import 'package:dwr0001/Models/map_Model.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/map_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:dwr0001/components/onwillpop.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'package:provider/provider.dart';
import 'package:dwr0001/components/switchColor.dart';

class MapPage extends StatefulWidget {
  final List<StationModel> data;
  final List<StationModel> notify;
  MapPage({Key key, this.data, this.notify}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  List mark = [];
  List result = [];
  List<LatLng> polygon = [];

  Future<void> get_data() async {
    for (var i = 1; i < 8; i++) {
      List<StationModel> snapshots = await get_dataMap(i);
      if (snapshots != null) {
        for (StationModel data in snapshots) {
          data.BASINID = i;
          result.add(data);
        }
        for (StationModel item in result) {
          setState(
            () {
              _markers.add(
                Marker(
                  width: 40,
                  height: 40,
                  point: LatLng(
                    double.parse(item.LAT),
                    double.parse(item.LON),
                  ),
                  builder: (ctx) => Container(
                    child: InkWell(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AvatarGlow(
                            glowColor: Colors.blue,
                            endRadius: 12.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 200),
                            child: CircleAvatar(
                              radius: 8.0,
                              child: CircleAvatar(
                                radius: 0,
                                backgroundColor: Colors.greenAccent,
                              ),
                              backgroundColor: item.CURR_STATUS == "0"
                                  ? Color.fromARGB(255, 35, 119, 60)
                                      .withOpacity(0.8)
                                  : item.CURR_STATUS == "1"
                                      ? Color.fromARGB(255, 240, 220, 60)
                                          .withOpacity(0.8)
                                      : item.CURR_STATUS == "2"
                                          ? Colors.red.withOpacity(0.8)
                                          : item.CURR_STATUS == "3"
                                              ? Colors.grey.withOpacity(0.8)
                                              : item.CURR_STATUS == "4"
                                                  ? Colors.grey.withOpacity(0.8)
                                                  : item.CURR_STATUS == "5"
                                                      ? Color.fromARGB(255, 108,
                                                              108, 108)
                                                          .withOpacity(0.8)
                                                      : item.CURR_STATUS == "6"
                                                          ? Color.fromARGB(255,
                                                                  240, 220, 40)
                                                              .withOpacity(0.8)
                                                          : item.CURR_STATUS ==
                                                                  "7"
                                                              ? Color.fromARGB(
                                                                      255,
                                                                      183,
                                                                      25,
                                                                      14)
                                                                  .withOpacity(
                                                                      0.8)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.8),
                            ),
                          ),
                          // Text(
                          //   item.CURR_Acc_Rain_1_D,
                          //   style: TextStyle(
                          //       color: item.CURR_STATUS == "3"
                          //           ? Colors.black
                          //           : Colors.white),
                          // ),
                        ],
                      ),
                      onTap: () {
                        OnpressShow(item);
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.location_on_outlined),
                    //   color: Color(0xff6200eee),
                    //   iconSize: 45.0,
                    //   onPressed: () {
                    //     OnpressShow(item);
                    //   },
                    // ),
                  ),
                ),
              );
            },
          );
        }
      }
    }
  }

  Future<dynamic> OnpressShow(StationModel item) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StationPage(
                  stnId: item.STN_ID,
                  basinID: item.BASINID,
                  RF: item.RF,
                  WL: item.WL,
                  CCTV: item.CURR_CCTV,
                  data: widget.data,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, bottom: 30),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 3,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5),
              ),
              // height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.STN_ID),
                      SizedBox(
                        width: 10,
                      ),
                      Text(item.STN_Name),
                    ],
                  ),
                  item.RF == "RF"
                      ? Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: Colors.grey,
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor:
                                      swColor.switchColor(item.CURR_STATUS),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                  "สถานการณ์น้ำฝน : ${item.CURR_STATUS == "0" ? "ปกติ" : item.CURR_STATUS == "1" ? "เฝ้าระวัง" : item.CURR_STATUS == "2" ? "วิกฤต" : "ปกติ"}"),
                            ),
                          ],
                        )
                      : Container(),
                  item.WL == "WL"
                      ? Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 2,
                                height: 10,
                                child: item.CURR_STATUS_WL == "6" ||
                                        item.CURR_STATUS_WL == "7"
                                    ? CustomPaint(
                                        painter: TrianglePainter(
                                          strokeColor:
                                              item.CURR_STATUS_WL == "6"
                                                  ? Color.fromARGB(
                                                      255, 240, 220, 40)
                                                  : item.CURR_STATUS_WL == "7"
                                                      ? Color.fromARGB(
                                                          255, 183, 25, 14)
                                                      : swColor.switchColor(
                                                          item.CURR_STATUS),
                                          strokeWidth: 2,
                                          paintingStyle: PaintingStyle.fill,
                                          angle: 0,
                                        ),
                                        child: Container(
                                          height: 10,
                                          width: 2,
                                        ),
                                      )
                                    : CustomPaint(
                                        painter: TrianglePainter(
                                          strokeColor: item.CURR_STATUS_WL ==
                                                  "0"
                                              ? Color.fromARGB(255, 35, 119, 36)
                                              : item.CURR_STATUS_WL == "1"
                                                  ? Color.fromARGB(
                                                      255, 240, 220, 40)
                                                  : item.CURR_STATUS_WL == "2"
                                                      ? Colors.red
                                                      : item.CURR_STATUS_WL ==
                                                              "3"
                                                          ? item.CURR_STATUS ==
                                                                  "3"
                                                              ? Colors.grey
                                                              : Colors.white
                                                          : item.CURR_STATUS_WL ==
                                                                  "4"
                                                              ? item.CURR_STATUS ==
                                                                      "4"
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          200,
                                                                          200,
                                                                          200)
                                                                  : Colors.grey
                                                              : item.CURR_STATUS ==
                                                                      "5"
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          108,
                                                                          108,
                                                                          108)
                                                                  : Colors
                                                                      .black,
                                          strokeWidth: 1,
                                          paintingStyle: item.CURR_STATUS_WL ==
                                                  "3"
                                              ? item.CURR_STATUS == "3"
                                                  ? PaintingStyle.stroke
                                                  : PaintingStyle.fill
                                              : item.CURR_STATUS_WL == "4"
                                                  ? item.CURR_STATUS == "4"
                                                      ? PaintingStyle.stroke
                                                      : PaintingStyle.fill
                                                  : item.CURR_STATUS_WL == "5"
                                                      ? item.CURR_STATUS == "5"
                                                          ? PaintingStyle.stroke
                                                          : PaintingStyle.fill
                                                      : PaintingStyle.fill,
                                          angle: 1,
                                        ),
                                        child: Container(
                                          height: 10,
                                          width: 2,
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    "สถานการณ์น้ำ : ${item.CURR_STATUS_WL == "0" ? "ปกติ" : item.CURR_STATUS_WL == "1" ? "เฝ้าระวังน้ำท่วม" : item.CURR_STATUS_WL == "2" ? "เตือนภัยน้ำท่วม" : item.CURR_STATUS_WL == "6" ? "เฝ้าระวังน้ำแล้ง" : item.CURR_STATUS_WL == "7" ? "เตือนภัยน้ำแล้ง" : "ปกติ"}"))
                          ],
                        )
                      : Container(),
                  DetailSheet("วันเวลาของข้อมูลล่าสุด", item.LAST_UPDATE, ""),
                  DetailSheet("ปริมาณน้ำฝน สะสม 15 นาที",
                      item.CURR_Acc_Rain_15_M, "มม"),
                  DetailSheet(
                      "ปริมาณน้ำฝน สะสม 1 ชม", item.CURR_Acc_Rain_60_M, "มม"),
                  DetailSheet(
                      "ปริมาณน้ำฝน สะสม 12 ขม", item.CURR_Acc_Rain_12_H, "มม"),
                  DetailSheet(
                      "ปริมาณน้ำฝน สะสม 1 วัน", item.CURR_Acc_Rain_1_D, "มม"),
                  DetailSheet(
                      "ระดับน้ำ", item.CURR_Water_D_Level_MSL, "ม.รทก."),
                  DetailSheet(
                      "ปริมาณน้ำ", item.CURR_Water_U_Level_MSL, "ลบ.ม./วิ"),
                  DetailSheet("ปริมาณความจุลำน้ำ", "0.0", "(น้ำน้อย)"),

                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Column(
                  //         children: [
                  //           item.RF == "RF"
                  //               ? Container(
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     shape: BoxShape.circle,
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                           blurRadius: 1,
                  //                           color: Colors.grey,
                  //                           spreadRadius: 1)
                  //                     ],
                  //                   ),
                  //                   child: CircleAvatar(
                  //                     radius: 18.0,
                  //                     backgroundColor:
                  //                         swColor.switchColor(item.CURR_STATUS),
                  //                   ),
                  //                 )
                  //               : CircleAvatar(
                  //                   backgroundColor: Colors.transparent,
                  //                   radius: 18.0,
                  //                 ),
                  //           item.WL == "WL"
                  //               ? Positioned(
                  //                   bottom: item.CURR_STATUS_WL == "6" ||
                  //                           item.CURR_STATUS_WL == "7"
                  //                       ? null
                  //                       : 8,
                  //                   top: item.CURR_STATUS_WL == "6" ||
                  //                           item.CURR_STATUS_WL == "7"
                  //                       ? 8
                  //                       : null,
                  //                   child: Container(
                  //                     child: item.CURR_STATUS_WL == "6" ||
                  //                             item.CURR_STATUS_WL == "7"
                  //                         ? CustomPaint(
                  //                             painter: TrianglePainter(
                  //                               strokeColor: item
                  //                                           .CURR_STATUS_WL ==
                  //                                       "6"
                  //                                   ? Color.fromARGB(
                  //                                       255, 240, 220, 40)
                  //                                   : item.CURR_STATUS_WL == "7"
                  //                                       ? Color.fromARGB(
                  //                                           255, 183, 25, 14)
                  //                                       : swColor.switchColor(
                  //                                           item.CURR_STATUS),
                  //                               strokeWidth: 10,
                  //                               paintingStyle:
                  //                                   PaintingStyle.fill,
                  //                               angle: 0,
                  //                             ),
                  //                             child: Container(
                  //                               height: 28,
                  //                               width: 30,
                  //                             ),
                  //                           )
                  //                         : CustomPaint(
                  //                             painter: TrianglePainter(
                  //                               strokeColor: item
                  //                                           .CURR_STATUS_WL ==
                  //                                       "0"
                  //                                   ? Color.fromARGB(
                  //                                       255, 35, 119, 36)
                  //                                   : item.CURR_STATUS_WL == "1"
                  //                                       ? Color.fromARGB(
                  //                                           255, 240, 220, 40)
                  //                                       : item.CURR_STATUS_WL ==
                  //                                               "2"
                  //                                           ? Colors.red
                  //                                           : item.CURR_STATUS_WL ==
                  //                                                   "3"
                  //                                               ? item.CURR_STATUS ==
                  //                                                       "3"
                  //                                                   ? Colors
                  //                                                       .grey
                  //                                                   : Colors
                  //                                                       .white
                  //                                               : item.CURR_STATUS_WL ==
                  //                                                       "4"
                  //                                                   ? item.CURR_STATUS ==
                  //                                                           "4"
                  //                                                       ? Color.fromARGB(
                  //                                                           255,
                  //                                                           200,
                  //                                                           200,
                  //                                                           200)
                  //                                                       : Colors
                  //                                                           .grey
                  //                                                   : item.CURR_STATUS ==
                  //                                                           "5"
                  //                                                       ? Color.fromARGB(
                  //                                                           255,
                  //                                                           108,
                  //                                                           108,
                  //                                                           108)
                  //                                                       : Colors
                  //                                                           .black,
                  //                               strokeWidth: 1,
                  //                               paintingStyle: item
                  //                                           .CURR_STATUS_WL ==
                  //                                       "3"
                  //                                   ? item.CURR_STATUS == "3"
                  //                                       ? PaintingStyle.stroke
                  //                                       : PaintingStyle.fill
                  //                                   : item.CURR_STATUS_WL == "4"
                  //                                       ? item.CURR_STATUS ==
                  //                                               "4"
                  //                                           ? PaintingStyle
                  //                                               .stroke
                  //                                           : PaintingStyle.fill
                  //                                       : item.CURR_STATUS_WL ==
                  //                                               "5"
                  //                                           ? item.CURR_STATUS ==
                  //                                                   "5"
                  //                                               ? PaintingStyle
                  //                                                   .stroke
                  //                                               : PaintingStyle
                  //                                                   .fill
                  //                                           : PaintingStyle
                  //                                               .fill,
                  //                               angle: 1,
                  //                             ),
                  //                             child: Container(
                  //                               height: 28,
                  //                               width: 30,
                  //                             ),
                  //                           ),
                  //                   ),
                  //                 )
                  //               : Container(),
                  //           Container(
                  //             child: Stack(
                  //               alignment: Alignment.center,
                  //               children: [
                  //                 AvatarGlow(
                  //                   glowColor: Colors.blue,
                  //                   endRadius: 40.0,
                  //                   duration: Duration(milliseconds: 2000),
                  //                   repeat: true,
                  //                   showTwoGlows: true,
                  //                   repeatPauseDuration:
                  //                       Duration(milliseconds: 200),
                  //                   child: CircleAvatar(
                  //                     radius: 18.0,
                  //                     child: CircleAvatar(
                  //                       radius: 0,
                  //                       backgroundColor: Colors.greenAccent,
                  //                     ),
                  //                     backgroundColor: item.CURR_STATUS == "0"
                  //                         ? Color.fromARGB(255, 35, 119, 36)
                  //                         : item.CURR_STATUS == "1"
                  //                             ? Color.fromARGB(
                  //                                 255, 240, 220, 40)
                  //                             : item.CURR_STATUS == "2"
                  //                                 ? Colors.red
                  //                                 : item.CURR_STATUS == "3"
                  //                                     ? Colors.grey
                  //                                     : item.CURR_STATUS == "4"
                  //                                         ? Colors.grey
                  //                                         : item.CURR_STATUS ==
                  //                                                 "5"
                  //                                             ? Color.fromARGB(
                  //                                                 255,
                  //                                                 108,
                  //                                                 108,
                  //                                                 108)
                  //                                             : item.CURR_STATUS ==
                  //                                                     "6"
                  //                                                 ? Color
                  //                                                     .fromARGB(
                  //                                                         255,
                  //                                                         240,
                  //                                                         220,
                  //                                                         40)
                  //                                                 : item.CURR_STATUS ==
                  //                                                         "7"
                  //                                                     ? Color.fromARGB(
                  //                                                         255,
                  //                                                         183,
                  //                                                         25,
                  //                                                         14)
                  //                                                     : Colors
                  //                                                         .black,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   item.CURR_Acc_Rain_1_D,
                  //                   style: TextStyle(
                  //                       color: item.CURR_STATUS == "3"
                  //                           ? Colors.black
                  //                           : Colors.white),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             child: Stack(
                  //               alignment: Alignment.center,
                  //               children: [
                  //                 AvatarGlow(
                  //                   glowColor: Colors.blue,
                  //                   endRadius: 40.0,
                  //                   duration: Duration(milliseconds: 2000),
                  //                   repeat: true,
                  //                   showTwoGlows: true,
                  //                   repeatPauseDuration:
                  //                       Duration(milliseconds: 200),
                  //                   child: CircleAvatar(
                  //                     radius: 18.0,
                  //                     child: CircleAvatar(
                  //                       radius: 0,
                  //                       backgroundColor: Colors.greenAccent,
                  //                     ),
                  //                     backgroundColor: item.CURR_STATUS == "0"
                  //                         ? Color.fromARGB(255, 35, 119, 36)
                  //                         : item.CURR_STATUS == "1"
                  //                             ? Color.fromARGB(
                  //                                 255, 240, 220, 40)
                  //                             : item.CURR_STATUS == "2"
                  //                                 ? Colors.red
                  //                                 : item.CURR_STATUS == "3"
                  //                                     ? Colors.grey
                  //                                     : item.CURR_STATUS == "4"
                  //                                         ? Colors.grey
                  //                                         : item.CURR_STATUS ==
                  //                                                 "5"
                  //                                             ? Color.fromARGB(
                  //                                                 255,
                  //                                                 108,
                  //                                                 108,
                  //                                                 108)
                  //                                             : item.CURR_STATUS ==
                  //                                                     "6"
                  //                                                 ? Color
                  //                                                     .fromARGB(
                  //                                                         255,
                  //                                                         240,
                  //                                                         220,
                  //                                                         40)
                  //                                                 : item.CURR_STATUS ==
                  //                                                         "7"
                  //                                                     ? Color.fromARGB(
                  //                                                         255,
                  //                                                         183,
                  //                                                         25,
                  //                                                         14)
                  //                                                     : Colors
                  //                                                         .black,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   item.CURR_Acc_Rain_1_D,
                  //                   style: TextStyle(
                  //                       color: item.CURR_STATUS == "3"
                  //                           ? Colors.black
                  //                           : Colors.white),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Expanded(
                  //         flex: 2,
                  //         child: Container(
                  //           width: size.width * 0.38,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               TitleTextBoxMap(
                  //                   text: "สถานี : ", datamap: item.STN_ID),
                  //               DetailTextBoxMap(
                  //                   text: "", datamap: item.STN_Name),
                  //               DetailTextBoxMap(
                  //                   text: "", datamap: item.LAST_UPDATE),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Stack(
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         alignment: Alignment.center,
                  //         children: [
                  //           Transform.rotate(
                  //             angle: 45 * pi / 180,
                  //             child: Container(
                  //               clipBehavior: Clip.antiAlias,
                  //               height: 30,
                  //               width: 30,
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                   width: 3,
                  //                   color: Colors.blue[800],
                  //                 ),
                  //                 borderRadius: BorderRadius.all(
                  //                   Radius.circular(6),
                  //                 ),
                  //                 color: Colors.blue[800],
                  //               ),
                  //             ),
                  //           ),
                  //           ClipPath(
                  //             clipBehavior: Clip.antiAlias,
                  //             child: Container(
                  //               height: 30 * sqrt2,
                  //               width: 30 * sqrt2,
                  //               child: Icon(
                  //                 Icons.turn_right,
                  //                 color: Colors.white,
                  //                 size: 20,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row DetailSheet(String title, String data, String unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 4,
          child: Text(title),
        ),
        Expanded(
          flex: 2,
          child: Text(data),
        ),
        Expanded(flex: 1, child: Text(unit)),
      ],
    );
  }

  void initState() {
    get_data();
    super.initState();
  }

  void dispose() {
    result = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Consumer<MapProvider>(
        builder: (context, MapP, _) => Scaffold(
            drawer: NavigationBurgerMenuWidget(data: widget.data),
            appBar: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              centerTitle: true,
              title: Text(
                'แผนที่',
                style: DefaultTitleW(),
              ),
              backgroundColor: Colors.lightBlue[600],
            ),
            body: WidgetMap(markers: _markers)
            // MapP.dataPolygon.length == 0
            //     ? FutureBuilder(
            //         future: get_polygon(),
            //         builder: (context, AsyncSnapshot snapshot) {
            //           MapModel result;
            //           if (snapshot?.connectionState != ConnectionState.done) {
            //             return LoadingSquareCircle();
            //           } else {
            //             result = snapshot.data;
            //             for (var a in result.features) {
            //               for (var i in a.geometry.coordinates[0][0]) {
            //                 MapP.addData(LatLng(i[1], i[0]));
            //                 polygon.add(
            //                   LatLng(i[1], i[0]),
            //                 );
            //               }
            //             }
            //           }
            //           return WidgetMap(polygon: polygon, markers: _markers);
            //         },
            //       )
            //     : Consumer<MapProvider>(
            //         builder: (context, MapS, _) {
            //           for (var i in MapS.dataPolygon) {
            //             polygon.add(
            //               LatLng(i.latitude, i.longitude),
            //             );
            //           }
            //           return WidgetMap(polygon: polygon, markers: _markers);
            //         },
            //       ),
            ),
      ),
    );
  }
}
