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
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import "package:latlong/latlong.dart";
import 'package:provider/provider.dart';
import 'package:dwr0001/components/switchColor.dart';

class MapPage extends StatefulWidget {
  final List<StationModel> data;

  MapPage({Key key, this.data}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  Set<Marker> _markers = {};
  List mark = [];
  List<StationModel> result = [];
  List<LatLng> polygon = [];
  List<SpeedDialChild> basinList = [];

  MapController _mapController = new MapController();

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.moveAndRotate(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation),
          0);
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Future<void> get_data() async {
    for (var i = 1; i < 8; i++) {
      List<StationModel> snapshots = await get_dataMap(i);
      if (snapshots != null) {
        basinList.add(
          SpeedDialChild(
            child: const Icon(Icons.reply_outlined, color: Colors.white),
            label: ListRiver.items[i - 1]['title'],
            labelStyle: DefaultStyleTextBoxMap(),
            backgroundColor: Colors.blueAccent,
            onTap: () {
              _animatedMapMove(ListRiver.items[i - 1]['latlng'], 8.5);
            },
          ),
        );

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
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                item.RF == "RF"
                                    ? Container(
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
                                          radius: 18.0,
                                          backgroundColor: swColor
                                              .switchColor(item.CURR_STATUS),
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 18.0,
                                      ),
                                item.WL == "WL"
                                    ? Container(
                                        child:
                                            item.CURR_STATUS_WL == "6" ||
                                                    item.CURR_STATUS_WL == "7"
                                                ? CustomPaint(
                                                    painter: TrianglePainter(
                                                      strokeColor: item
                                                                  .CURR_STATUS_WL ==
                                                              "6"
                                                          ? Color.fromARGB(
                                                              255, 240, 220, 40)
                                                          : item.CURR_STATUS_WL ==
                                                                  "7"
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  183,
                                                                  25,
                                                                  14)
                                                              : swColor
                                                                  .switchColor(item
                                                                      .CURR_STATUS),
                                                      strokeWidth: 10,
                                                      paintingStyle:
                                                          PaintingStyle.fill,
                                                      angle: 0,
                                                    ),
                                                    child: Container(
                                                      height: 20,
                                                      width: 18,
                                                    ),
                                                  )
                                                : CustomPaint(
                                                    painter: TrianglePainter(
                                                      strokeColor: item
                                                                  .CURR_STATUS_WL ==
                                                              "0"
                                                          ? Color.fromARGB(
                                                              255, 35, 119, 36)
                                                          : item.CURR_STATUS_WL ==
                                                                  "1"
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  240,
                                                                  220,
                                                                  40)
                                                              : item.CURR_STATUS_WL ==
                                                                      "2"
                                                                  ? Colors.red
                                                                  : item.CURR_STATUS_WL ==
                                                                          "3"
                                                                      ? item.CURR_STATUS ==
                                                                              "3"
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .white
                                                                      : item.CURR_STATUS_WL ==
                                                                              "4"
                                                                          ? item.CURR_STATUS == "4"
                                                                              ? Color.fromARGB(255, 200, 200, 200)
                                                                              : Colors.grey
                                                                          : item.CURR_STATUS == "5"
                                                                              ? Color.fromARGB(255, 108, 108, 108)
                                                                              : Colors.black,
                                                      strokeWidth: 1,
                                                      paintingStyle: item
                                                                  .CURR_STATUS_WL ==
                                                              "3"
                                                          ? item.CURR_STATUS ==
                                                                  "3"
                                                              ? PaintingStyle
                                                                  .stroke
                                                              : PaintingStyle
                                                                  .fill
                                                          : item.CURR_STATUS_WL ==
                                                                  "4"
                                                              ? item.CURR_STATUS ==
                                                                      "4"
                                                                  ? PaintingStyle
                                                                      .stroke
                                                                  : PaintingStyle
                                                                      .fill
                                                              : item.CURR_STATUS_WL ==
                                                                      "5"
                                                                  ? item.CURR_STATUS ==
                                                                          "5"
                                                                      ? PaintingStyle
                                                                          .stroke
                                                                      : PaintingStyle
                                                                          .fill
                                                                  : PaintingStyle
                                                                      .fill,
                                                      angle: 1,
                                                    ),
                                                    child: Container(
                                                      height: 20,
                                                      width: 18,
                                                    ),
                                                  ),
                                      )
                                    : Container(),
                                item.CURR_CCTV == "CCTV"
                                    ? Positioned(
                                        right: -5,
                                        top: 0,
                                        child: Container(
                                          child: Image.network(
                                            "https://tele-nakhonsri.dwr.go.th/image/TCAM.png",
                                            scale: 1.5,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        OnpressShow(item);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      }
      if (i == 1 && snapshots == null ||
          i == 2 && snapshots == null ||
          i == 3 && snapshots == null) {
        basinList.add(
          SpeedDialChild(
            child: const Icon(Icons.reply_outlined, color: Colors.white),
            label: ListRiver.items[i - 1]['title'],
            labelStyle: DefaultStyleTextBoxMap(),
            backgroundColor: Colors.blueAccent,
            onTap: () {
              _animatedMapMove(ListRiver.items[i - 1]['latlng'], 8.5);
            },
          ),
        );
      }
    }
  }

  Future<dynamic> OnpressShow(StationModel item) {
    Size size = MediaQuery.of(context).size;
    // print(jsonEncode(item));
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
            padding: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
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
                borderRadius: BorderRadius.circular(10),
              ),
              height: item.RF == "RF" && item.WL == "WL" ? 270 : 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    right: 2,
                    top: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.indigo[300],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.STN_ID,
                                  style: DefaultTitleStyleTextBoxMap(),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item.STN_Name,
                                  style: DefaultTitleStyleTextBoxMap(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        item.RF == "RF"
                            ? Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
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
                                          backgroundColor: swColor
                                              .switchColor(item.CURR_STATUS),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: swColor
                                            .switchColor(item.CURR_STATUS),
                                        child: Text(
                                          "สถานการณ์น้ำฝน : ${item.CURR_STATUS == "0" ? "ปกติ" : item.CURR_STATUS == "1" ? "เฝ้าระวัง" : item.CURR_STATUS == "2" ? "วิกฤต" : "ปกติ"}",
                                          style: TextStyle(
                                            color: item.CURR_STATUS == "5"
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'Kanit',
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        item.WL == "WL"
                            ? Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        width: 15,
                                        height: 10,
                                        child: item.CURR_STATUS_WL == "6" ||
                                                item.CURR_STATUS_WL == "7"
                                            ? CustomPaint(
                                                painter: TrianglePainter(
                                                  strokeColor: item
                                                              .CURR_STATUS_WL ==
                                                          "6"
                                                      ? Color.fromARGB(
                                                          255, 240, 220, 40)
                                                      : item.CURR_STATUS_WL ==
                                                              "7"
                                                          ? Color.fromARGB(
                                                              255, 183, 25, 14)
                                                          : swColor.switchColor(
                                                              item.CURR_STATUS),
                                                  strokeWidth: 2,
                                                  paintingStyle:
                                                      PaintingStyle.fill,
                                                  angle: 0,
                                                ),
                                                child: Container(
                                                  height: 10,
                                                  width: 2,
                                                ),
                                              )
                                            : CustomPaint(
                                                painter: TrianglePainter(
                                                  strokeColor:
                                                      swColor.switchColor(
                                                          item.CURR_STATUS_WL),
                                                  strokeWidth: 1,
                                                  paintingStyle: item
                                                              .CURR_STATUS_WL ==
                                                          "3"
                                                      ? item.CURR_STATUS == "3"
                                                          ? PaintingStyle.stroke
                                                          : PaintingStyle.fill
                                                      : item.CURR_STATUS_WL ==
                                                              "4"
                                                          ? item.CURR_STATUS ==
                                                                  "4"
                                                              ? PaintingStyle
                                                                  .stroke
                                                              : PaintingStyle
                                                                  .fill
                                                          : item.CURR_STATUS_WL ==
                                                                  "5"
                                                              ? item.CURR_STATUS ==
                                                                      "5"
                                                                  ? PaintingStyle
                                                                      .stroke
                                                                  : PaintingStyle
                                                                      .fill
                                                              : PaintingStyle
                                                                  .fill,
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
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: swColor
                                            .switchColor(item.CURR_STATUS_WL),
                                        child: Text(
                                          "สถานการณ์น้ำ : ${item.CURR_STATUS_WL == "0" ? "ปกติ" : item.CURR_STATUS_WL == "1" ? "เฝ้าระวังน้ำท่วม" : item.CURR_STATUS_WL == "2" ? "เตือนภัยน้ำท่วม" : item.CURR_STATUS_WL == "6" ? "เฝ้าระวังน้ำแล้ง" : item.CURR_STATUS_WL == "7" ? "เตือนภัยน้ำแล้ง" : "ปกติ"}",
                                          style: TextStyle(
                                            color: item.CURR_STATUS == "5" ||
                                                    item.CURR_STATUS_WL == "5"
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'Kanit',
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "วันเวลาของข้อมูลล่าสุด",
                                  style: DefaultStyleTextBoxMap(),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  item.LAST_UPDATE,
                                  style: DefaultStyleTextBoxMap(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        item.RF == "RF"
                            ? DetailSheet("ปริมาณน้ำฝน สะสม 15 นาที",
                                item.CURR_Acc_Rain_15_M, "มม")
                            : SizedBox(),
                        item.RF == "RF"
                            ? DetailSheet("ปริมาณน้ำฝน สะสม 1 ชม",
                                item.CURR_Acc_Rain_60_M, "มม")
                            : SizedBox(),
                        item.RF == "RF"
                            ? DetailSheet("ปริมาณน้ำฝน สะสม 12 ชม",
                                item.CURR_Acc_Rain_12_H, "มม")
                            : SizedBox(),
                        item.RF == "RF"
                            ? DetailSheet("ปริมาณน้ำฝน สะสม 1 วัน",
                                item.CURR_Acc_Rain_1_D, "มม")
                            : SizedBox(),
                        item.WL == "WL"
                            ? DetailSheet("ระดับน้ำ",
                                item.CURR_Water_D_Level_MSL, "ม.รทก.")
                            : SizedBox(),
                        item.WL == "WL"
                            ? DetailSheet("ปริมาณน้ำ",
                                item.CURR_Water_U_Level_MSL, "ลบ.ม./วินาที")
                            : SizedBox(),
                        item.WL == "WL"
                            ? DetailSheet(
                                "ปริมาณความจุลำน้ำ", "0.0%", "(น้ำน้อย)")
                            : SizedBox(),
                        // item.WL == "WL" && item.RF != "RF"
                        //     ? DetailSheet("", "", "")
                        //     : SizedBox(),
                        // item.WL == "WL" && item.RF != "RF"
                        //     ? DetailSheet("", "", "")
                        //     : SizedBox(),
                        // item.WL == "WL" && item.RF != "RF"
                        //     ? DetailSheet("", "", "")
                        //     : SizedBox(),
                        // item.WL == "WL" && item.RF != "RF"
                        //     ? DetailSheet("", "", "")
                        //     : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Expanded DetailSheet(String title, String data, String unit) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: DefaultStyleTextBoxMap(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data,
              style: DefaultStyleTextBoxMap(),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                unit,
                style: DefaultStyleTextBoxMap(),
              )),
        ],
      ),
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
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            centerTitle: true,
            title: Text(
              'แผนที่',
              style: DefaultTitleW(),
            ),
            backgroundColor: Colors.lightBlue[600],
          ),
          body: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              center:
                  // LatLng(17.1408165, 103.4063071),
                  // กรุงเทพ
                  LatLng(13.5654281, 101.4886013),
              zoom: 6,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              // PolygonLayerOptions(
              //   polygonCulling: true,
              //   polygons: [
              //     Polygon(
              //       points: polygon,
              //       color: Colors.yellow[600].withOpacity(0.4),
              //       borderStrokeWidth: 2,
              //       borderColor: Colors.brown,
              //     ),
              //   ],
              // ),
              MarkerLayerOptions(markers: _markers.toList()),
            ],
          ),

          // WidgetMap(markers: _markers, mapController: _mapController),
          floatingActionButton: SpeedDial(
            icon: Icons.water,
            backgroundColor: Colors.blue,
            children: basinList.map(
              (data) {
                return data;
              },
            ).toList(),
          ),

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
