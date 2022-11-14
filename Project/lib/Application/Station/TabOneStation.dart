import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:flutter/material.dart';
import '../StationPage.dart';
import 'dart:math' as math;

class TabOneStation extends StatelessWidget {
  final List<StationModel> data;
  var basinID;
  List<StationModel> newResult = [];
  TabOneStation(this.basinID, this.data);

  @override
  Widget build(BuildContext context) {
    print("Tab : " + basinID.toString());
    return FutureBuilder<List<StationModel>>(
      future: getStationListTab(basinID, "1"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<StationModel> station = snapshot.data;
          return resultData(station);
        } else if (snapshot.hasError) {
          for (var i = 0; i < data.length; i++) {
            if (data[i].BASINID == basinID) {
              newResult.add(
                StationModel(
                  STN_ID: data[i].STN_ID,
                  STN_Name: data[i].STN_Name,
                  RF: data[i].RF,
                  WL: data[i].WL,
                  BASINID: i,
                  CURR_CCTV: data[i].CURR_CCTV,
                  CURR_STATUS: data[i].CURR_STATUS,
                ),
              );
            }
          }
          final List<StationModel> station = newResult;
          return resultData(station);
        }
        return LoadingSquareCircle();
      },
    );
  }

  var rotate_change_history = Transform(
    alignment: Alignment.center,
    transform: Matrix4.rotationY(math.pi),
    child: Icon(
      Icons.change_history_rounded,
      size: 40,
    ),
  );

  ListView resultData(List<StationModel> station) {
    station.sort((a, b) => b.CURR_STATUS.compareTo(a.CURR_STATUS));
    return ListView.builder(
      itemCount: station.length,
      itemBuilder: (context, int i) {
        print(station[i].CURR_STATUS_WL);
        return Column(
          children: [
            Ink(
                child: new ListTile(
              leading: Container(
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 40.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 200),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        child: CircleAvatar(
                          radius: 0,
                          backgroundColor: Colors.greenAccent,
                        ),
                        backgroundColor: station[i].CURR_STATUS == "0"
                            ? Colors.green
                            : station[i].CURR_STATUS == "1"
                                ? Colors.yellow
                                : station[i].CURR_STATUS == "2"
                                    ? Colors.red
                                    : station[i].CURR_STATUS == "3"
                                        ? Colors.white
                                        : station[i].CURR_STATUS == "4"
                                            ? Colors.grey
                                            : station[i].CURR_STATUS == "5"
                                                ? Colors.black.withOpacity(0.8)
                                                : station[i].CURR_STATUS == "6"
                                                    ? Colors.yellow
                                                    : station[i].CURR_STATUS ==
                                                            "7"
                                                        ? Colors.red
                                                        : Colors.black
                                                            .withOpacity(0.8),
                      ),
                      Positioned(
                        bottom: station[i].CURR_STATUS_WL == "6" ||
                                station[i].CURR_STATUS_WL == "7"
                            ? null
                            : 0,
                        top: station[i].CURR_STATUS_WL == "6" ||
                                station[i].CURR_STATUS_WL == "7"
                            ? 0
                            : null,
                        child: Container(
                          child: station[i].CURR_STATUS_WL == "6" ||
                                  station[i].CURR_STATUS_WL == "7"
                              ? Transform.rotate(
                                  alignment: Alignment.center,
                                  angle: 180 * math.pi / 180,
                                  child: Icon(
                                    Icons.change_history_rounded,
                                    size: 40,
                                    shadows: <Shadow>[
                                      Shadow(
                                          color: Colors.black, blurRadius: 15.0)
                                    ],
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                )
                              : Icon(
                                  Icons.change_history_rounded,
                                  size: 40,
                                  shadows: <Shadow>[
                                    Shadow(
                                        color: Colors.black, blurRadius: 15.0)
                                  ],
                                  color: station[i].CURR_STATUS_WL == "0"
                                      ? Colors.green.withOpacity(0.8)
                                      : station[i].CURR_STATUS_WL == "1"
                                          ? Colors.yellow.withOpacity(0.8)
                                          : station[i].CURR_STATUS_WL == "2"
                                              ? Colors.red.withOpacity(0.8)
                                              : station[i].CURR_STATUS_WL == "3"
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : station[i].CURR_STATUS_WL ==
                                                          "4"
                                                      ? Colors.grey
                                                          .withOpacity(0.8)
                                                      : Colors.black
                                                          .withOpacity(0.8),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: new Text(
                station[i].STN_ID,
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Kanit',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: new Text(
                station[i].STN_Name,
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Kanit',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w200),
              ),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  Image.asset(
                    station[i].CURR_STATUS == "0"
                        ? 'assets/banner/bell/green.png'
                        : station[i].CURR_STATUS == "1"
                            ? "assets/banner/bell/yellow.png"
                            : station[i].CURR_STATUS == "2"
                                ? "assets/banner/bell/red.png"
                                : station[i].CURR_STATUS == "3"
                                    ? "assets/banner/bell/gray.png"
                                    : station[i].CURR_STATUS == "4"
                                        ? "assets/banner/bell/gray.png"
                                        : station[i].CURR_STATUS == "5"
                                            ? "assets/banner/bell/gray.png"
                                            : station[i].CURR_STATUS == "6"
                                                ? "assets/banner/bell/yellow.png"
                                                : station[i].CURR_STATUS == "7"
                                                    ? "assets/banner/bell/red.png"
                                                    : "assets/banner/bell/red.png",
                    height: 45,
                  ),
                  // icon-1

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_forward_ios),
                  ), // icon-2
                ],
              ),
              onTap: () {
                // await FlutterSession().set('river', basinID.toString());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StationPage(
                            stn_id: station[i].STN_ID,
                            basinID: basinID,
                            RF: station[i].RF,
                            WL: station[i].WL,
                            CCTV: station[i].CURR_CCTV,
                            data: data)));
              },
            )),
            new ListBody(
              children: <Widget>[],
            )
          ],
        );
      },
    );
  }
}
