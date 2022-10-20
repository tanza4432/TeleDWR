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
  bool checkDevice = false;
  // IOS = TRUE
  // ANDROID = FALSE

  void SetSession() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    await deviceInfo.androidInfo.onError((error, stackTrace) {
      checkDevice = true;
    });
    if (checkDevice == false) {
      print("Device : Android");
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      await FlutterSession().set('token', androidInfo.androidId);
    } else {
      print("Device : IOS");
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      await FlutterSession().set('token', iosInfo.isPhysicalDevice);
    }
  }

  void GetData(BuildContext context) async {
    for (var i = 1; i < 8; i++) {
      List<StationModel> data = await getStationListTab(i, "1");
      checkCallApi = i;
      if (data != null) {
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
    setState(() {});
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
                child: checkCallApi == 7
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
