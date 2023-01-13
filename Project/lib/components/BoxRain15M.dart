import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class BoxRain15M extends StatelessWidget {
  const BoxRain15M(
      {Key key,
      @required this.size,
      @required this.deviceWidth,
      @required this.station,
      @required this.color})
      : super(key: key);

  final Size size;
  final double deviceWidth;
  final String station;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FittedBox(
          child: Text(
            "ปริมาณน้ำฝนสะสม",
            style: TextStyle(
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                color: Colors.blue[900],
                fontWeight: FontWeight.normal,
                fontFamily: 'Kanit',
                decoration: TextDecoration.none),
          ),
        ),
        SizedBox(height: size.height * 0.005),
        Container(
          width: deviceWidth * 0.35,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[200], Colors.blue[500]]),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 3,
                offset: Offset(4, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue[300], Colors.blue[100]],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 3,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(1.0),
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          station,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: Colors.black87,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(5),
                              color: color,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Kanit',
                              decoration: TextDecoration.none),
                        ),
                        Text(
                          "มม.",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 0,
                                  color: Colors.black87,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.5),
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Kanit',
                              decoration: TextDecoration.none),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "15 นาที",
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 0,
                                    color: Colors.black87,
                                    offset: Offset(1.0, 1.0),
                                  ),
                                ],
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(1.5),
                                color: Colors.white30,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Kanit',
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
