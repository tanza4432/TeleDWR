import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class TabFour extends StatefulWidget {
  TabFour(this.stnId, this.basinId, this.CCTV, this.title);
  var stnId;
  var basinId;
  var CCTV;
  var basinName;
  String title;

  @override
  State<TabFour> createState() => _TabFourState();
}

class _TabFourState extends State<TabFour> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.basinName = widget.basinId == 1
        ? "maeklong"
        : widget.basinId == 2
            ? "salawin"
            : widget.basinId == 3
                ? "kokkhong"
                : "kokkhong";
    if (widget.CCTV == "") {
      return Column(
        children: [
          TabTitleBar(stnId: widget.stnId, title: widget.title),
          Container(
            width: double.infinity,
            height: size.height * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Text(
                    "สถานีนี้ไม่มีข้อมูล CCTV",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        TabTitleBar(stnId: widget.stnId, title: widget.title),
        Container(
          width: double.infinity,
          height: size.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: <Widget>[
              Text(
                "ข้อมูลภาพ CCTV: " + widget.stnId,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Kanit', fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FullScreenWidget(
                          child: ClipRRect(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading1.gif',
                          image: ('http://tele-' +
                              widget.basinName +
                              '.dwr.go.th/image/' +
                              widget.stnId +
                              '/CCTV_image/Overview_1.jpg'),
                        ),
                      ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FullScreenWidget(
                      child: ClipRRect(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading1.gif',
                          image: ('http://tele-' +
                              widget.basinName +
                              '.dwr.go.th/image/' +
                              widget.stnId +
                              '/CCTV_image/Staff_1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}

class TabTitleBar extends StatelessWidget {
  const TabTitleBar({
    Key key,
    @required this.stnId,
    @required this.title,
  }) : super(key: key);

  final String stnId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.lightBlue[700],
      child: Row(
        children: [
          Icon(Icons.location_on_outlined),
          Flexible(
            child: Text(
              "สถานี : " + stnId + " " + title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'Kanit',
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
