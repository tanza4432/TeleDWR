import 'dart:convert';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Application/Map/widgets/detailTextBox.dart';
import 'package:dwr0001/Application/Map/widgets/titleTextBox.dart';
import 'package:dwr0001/Application/Map/widgets/widgetMap.dart';
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

class MapPage extends StatefulWidget {
  final List<StationModel> data;
  MapPage({Key key, this.data}) : super(key: key);

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
                            endRadius: 100.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 200),
                            child: CircleAvatar(
                              radius: 18.0,
                              child: CircleAvatar(
                                radius: 0,
                                backgroundColor: Colors.greenAccent,
                              ),
                              backgroundColor: item.CURR_STATUS == "0"
                                  ? Colors.green
                                  : item.CURR_STATUS == "1"
                                      ? Colors.green
                                      : item.CURR_STATUS == "2"
                                          ? Colors.green
                                          : item.CURR_STATUS == "3"
                                              ? Colors.white
                                              : item.CURR_STATUS == "4"
                                                  ? Colors.grey
                                                  : item.CURR_STATUS == "5"
                                                      ? Colors.black
                                                      : Colors.green,
                            ),
                          ),
                          Text(
                            item.CURR_Acc_Rain_1_D,
                            style: TextStyle(color: Colors.white),
                          ),
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
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AvatarGlow(
                            glowColor: Colors.blue,
                            endRadius: 40.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 200),
                            child: CircleAvatar(
                              radius: 18.0,
                              child: CircleAvatar(
                                radius: 0,
                                backgroundColor: Colors.greenAccent,
                              ),
                              backgroundColor: item.CURR_STATUS == "0"
                                  ? Colors.green
                                  : item.CURR_STATUS == "1"
                                      ? Colors.green
                                      : item.CURR_STATUS == "2"
                                          ? Colors.green
                                          : item.CURR_STATUS == "3"
                                              ? Colors.white
                                              : item.CURR_STATUS == "4"
                                                  ? Colors.grey
                                                  : item.CURR_STATUS == "5"
                                                      ? Colors.black
                                                      : Colors.green,
                            ),
                          ),
                          Text(
                            item.CURR_Acc_Rain_1_D,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: size.width * 0.38,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleTextBoxMap(
                                text: "สถานี : ", datamap: item.STN_ID),
                            DetailTextBoxMap(text: "", datamap: item.STN_Name),
                            DetailTextBoxMap(
                                text: "", datamap: item.LAST_UPDATE),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: 45 * pi / 180,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.blue[800],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                        ClipPath(
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            height: 30 * sqrt2,
                            width: 30 * sqrt2,
                            child: Icon(
                              Icons.turn_right,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void initState() {
    get_data();
    super.initState();
  }

  void dispose() {
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
