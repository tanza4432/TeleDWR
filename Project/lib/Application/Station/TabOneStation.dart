import 'package:avatar_glow/avatar_glow.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:dwr0001/components/switchColor.dart';
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

  ListView resultData(List<StationModel> station) {
    // station.sort((a, b) => b.CURR_STATUS.compareTo(a.CURR_STATUS));
    return ListView.builder(
      shrinkWrap: true,
      itemCount: station.length,
      itemBuilder: (context, int i) {
        var lastUpdate = station[i].LAST_UPDATE.split(" ");
        var time = lastUpdate[1].split(":");
        return Column(
          children: [
            new ListTile(
              contentPadding: EdgeInsets.only(right: 0),
              leading: Container(
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 30.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 200),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      station[i].RF == "RF"
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
                                backgroundColor:
                                    swColor.switchColor(station[i].CURR_STATUS),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 18.0,
                            ),
                      station[i].WL == "WL"
                          ? Positioned(
                              bottom: station[i].CURR_STATUS_WL == "6" ||
                                      station[i].CURR_STATUS_WL == "7"
                                  ? null
                                  : 8,
                              top: station[i].CURR_STATUS_WL == "6" ||
                                      station[i].CURR_STATUS_WL == "7"
                                  ? 8
                                  : null,
                              child: Container(
                                child: station[i].CURR_STATUS_WL == "6" ||
                                        station[i].CURR_STATUS_WL == "7"
                                    ? CustomPaint(
                                        painter: TrianglePainter(
                                          strokeColor: station[i]
                                                      .CURR_STATUS_WL ==
                                                  "6"
                                              ? Color.fromARGB(
                                                  255, 240, 220, 40)
                                              : station[i].CURR_STATUS_WL == "7"
                                                  ? Color.fromARGB(
                                                      255, 183, 25, 14)
                                                  : swColor.switchColor(
                                                      station[i].CURR_STATUS),
                                          strokeWidth: 10,
                                          paintingStyle: PaintingStyle.fill,
                                          angle: 0,
                                        ),
                                        child: Container(
                                          height: 28,
                                          width: 30,
                                        ),
                                      )
                                    : CustomPaint(
                                        painter: TrianglePainter(
                                          strokeColor: station[i]
                                                      .CURR_STATUS_WL ==
                                                  "0"
                                              ? Color.fromARGB(255, 35, 119, 36)
                                              : station[i].CURR_STATUS_WL == "1"
                                                  ? Color.fromARGB(
                                                      255, 240, 220, 40)
                                                  : station[i].CURR_STATUS_WL ==
                                                          "2"
                                                      ? Colors.red
                                                      : station[i].CURR_STATUS_WL ==
                                                              "3"
                                                          ? station[i].CURR_STATUS ==
                                                                  "3"
                                                              ? Colors.grey
                                                              : Colors.white
                                                          : station[i].CURR_STATUS_WL ==
                                                                  "4"
                                                              ? station[i].CURR_STATUS ==
                                                                      "4"
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          200,
                                                                          200,
                                                                          200)
                                                                  : Colors.grey
                                                              : station[i].CURR_STATUS ==
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
                                          paintingStyle: station[i]
                                                      .CURR_STATUS_WL ==
                                                  "3"
                                              ? station[i].CURR_STATUS == "3"
                                                  ? PaintingStyle.stroke
                                                  : PaintingStyle.fill
                                              : station[i].CURR_STATUS_WL == "4"
                                                  ? station[i].CURR_STATUS ==
                                                          "4"
                                                      ? PaintingStyle.stroke
                                                      : PaintingStyle.fill
                                                  : station[i].CURR_STATUS_WL ==
                                                          "5"
                                                      ? station[i].CURR_STATUS ==
                                                              "5"
                                                          ? PaintingStyle.stroke
                                                          : PaintingStyle.fill
                                                      : PaintingStyle.fill,
                                          angle: 1,
                                        ),
                                        child: Container(
                                          height: 28,
                                          width: 30,
                                        ),
                                      ),
                              ),
                            )
                          : Container(),
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
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: new Text(
                station[i].STN_Name,
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Kanit',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
              trailing: Wrap(
                spacing: 2, // space between two icons
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            time[0] + ":" + time[1],
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Kanit',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Text(
                          lastUpdate[0],
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Kanit',
                            fontSize: 10.0,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    child: Icon(Icons.arrow_forward_ios),
                  ), // icon-2
                ],
              ),
              onTap: () {
                // await FlutterSession().set('river', basinID.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationPage(
                      stnId: station[i].STN_ID,
                      basinID: basinID,
                      RF: station[i].RF,
                      WL: station[i].WL,
                      CCTV: station[i].CURR_CCTV,
                      data: data,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double angle;

  TrianglePainter({
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
    this.paintingStyle = PaintingStyle.stroke,
    this.angle = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawShadow(
        getTrianglePath(size.width, size.height, angle), Colors.grey, 1, false);

    canvas.drawPath(getTrianglePath(size.width, size.height, angle), paint);
  }

  Path getTrianglePath(double x, double y, double angle) {
    if (angle == 0) {
      return Path()
        ..moveTo(0, 0)
        ..lineTo(x, 0)
        ..lineTo(x / 2, y)
        ..lineTo(0, 0);
    } else {
      return Path()
        ..moveTo(0, y)
        ..lineTo(x / 2, 0)
        ..lineTo(x, y)
        ..lineTo(0, y);
    }
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
