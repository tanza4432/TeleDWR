import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class BoxRainDetail extends StatelessWidget {
  const BoxRainDetail({
    Key key,
    @required this.deviceWidth,
    @required this.size,
    @required this.station,
    @required this.minute,
  }) : super(key: key);

  final double deviceWidth;
  final Size size;
  final StationModel station;
  final String minute;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.25,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[200], Colors.blue[600]]),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 3,
            offset: Offset(4, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          new Image(
            image: AssetImage('assets/TabOne/hailstorm_Gray.png'),
            width: size.width * 0.1,
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white.withOpacity(0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    minute == "30 นาที"
                        ? station.CURR_Acc_Rain_30_M
                        : minute == "60 นาที"
                            ? station.CURR_Acc_Rain_60_M
                            : minute == "12 ชม."
                                ? station.CURR_Acc_Rain_12_H
                                : 0.0,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black87,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                        fontSize: ResponsiveFlutter.of(context).fontSize(3),
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Kanit',
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    " มม.",
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 0,
                            color: Colors.black87,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                        fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Kanit',
                        decoration: TextDecoration.none),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      minute,
                      style: TextStyle(
                          shadows: [
                            Shadow(
                              blurRadius: 0,
                              color: Colors.black87,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                          color: Colors.white30,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Kanit',
                          decoration: TextDecoration.none),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
