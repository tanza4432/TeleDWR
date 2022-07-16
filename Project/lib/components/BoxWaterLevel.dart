import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class BoxWaterLevel extends StatelessWidget {
  const BoxWaterLevel({
    Key key,
    @required this.size,
    @required this.station,
    @required this.title,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final StationModel station;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  color: Colors.blue[900],
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Kanit',
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.blue[500]]),
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
            child: Row(
              children: [
                new Image(
                  image: AssetImage('assets/TabOne/tide_Gray.png'),
                  width: size.width * 0.2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Column(
                          children: [
                            Text(
                              text == "ม.รทก."
                                  ? station.WL == ""
                                      ? "-"
                                      : station.CURR_Water_D_Level_MSL
                                  : text == "ลบ.ม./วินาที"
                                      ? station.CURR_FLOW
                                      : "-",
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Colors.black87,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.5),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                  decoration: TextDecoration.none),
                            ),
                            Text(
                              text,
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Colors.black87,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(1.5),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Kanit',
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
