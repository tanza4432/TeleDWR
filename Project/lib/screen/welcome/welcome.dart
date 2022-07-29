import 'package:device_info_plus/device_info_plus.dart';
import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<StationModel> newdata = [];
  int checkCallApi = 0;

  void SetSession() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    await FlutterSession().set('token', androidInfo.androidId);
    // await FlutterSession().set('data', '');
  }

  void GetData(BuildContext context) async {
    for (var i = 1; i < 5; i++) {
      List<StationModel> data = await getStationListTab(i, "1");
      checkCallApi = i;
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
      if (checkCallApi == 4) {
        setState(() {});
      }
      print(i);
    }
  }

  @override
  void initState() {
    GetData(context);
    print("สำเร็จ");
    SetSession();
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
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                bottom: 100,
                child: checkCallApi == 4
                    ? Consumer<FavoriteRiver>(
                        builder: (context, Data, _) {
                          return GestureDetector(
                            onTap: () async {
                              var data = await FlutterSession().get('data');
                              if (data != null) {
                                for (var i in data) {
                                  Data.addData(i);
                                }
                              }
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MenuPage(
                                    data: newdata,
                                  ),
                                ),
                              );
                            },
                            child: Image(
                              image: AssetImage(
                                  'assets/banner/banner01/sign_in.png'),
                              fit: BoxFit.cover,
                              height: size.height * 0.11,
                            ),
                          );
                        },
                      )
                    : LoadingCubeGrid()),
          ],
        ),
      ),
    );
  }
}
