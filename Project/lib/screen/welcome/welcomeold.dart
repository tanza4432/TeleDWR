import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/OverViewPage.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class WelcomeOld extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeOld> {
  DateTime backbuttonpressedTime;

  List<StationModel> newdata = [];

  void GetData(BuildContext context) async {
    for (var i = 1; i < 4; i++) {
      List<StationModel> data = await getStationListTab(i, "1");
      for (StationModel result in data) {
        newdata.add(
          StationModel(
            STN_ID: result.STN_ID,
            STN_Name: result.STN_Name,
            RF: result.RF,
            WL: result.WL,
            BASINID: i,
            CURR_CCTV: result.CURR_CCTV,
            CURR_STATUS: result.CURR_STATUS,
          ),
        );
      }
      print(i);
    }
  }

  @override
  void initState() {
    GetData(context);
    print("สำเร็จ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/banner/banner01/background02.png'),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.8),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => MenuPage(
                            data: newdata,
                          )),
                );
              },
              child: Image(
                image: AssetImage('assets/banner/banner01/sign_in.png'),
                fit: BoxFit.cover,
                height: size.height * 0.11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
