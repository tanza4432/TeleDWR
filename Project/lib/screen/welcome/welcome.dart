import 'package:device_info_plus/device_info_plus.dart';
import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:dwr0001/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:dwr0001/Application/notification.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<StationModel> newdata = [];
  List<StationModel> Listnotify = [];
  int checkCallApi = 0;
  bool checkDevice = false;
  String _identifier = 'Unknown';
  // IOS = TRUE
  // ANDROID = FALSE

  void SetSession() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    await deviceInfoPlugin.androidInfo.onError((error, stackTrace) {
      checkDevice = true;
    });
    if (checkDevice == false) {
      print("Device : Android");
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      print("AndroidID : ${androidInfo.androidId}");
      print("board : ${androidInfo.board}");
      print("bootloader : ${androidInfo.bootloader}");
      print("Device : ${androidInfo.device}");
      print("display : ${androidInfo.display}");
      print("fingerprint : ${androidInfo.fingerprint}");
      print("HardWare : ${androidInfo.hardware}");
      print("host : ${androidInfo.host}");
      print("ID : ${androidInfo.id}");
      print("isPhysicalDevice : ${androidInfo.isPhysicalDevice}");
      print("manufacturer : ${androidInfo.manufacturer}");
      print("model : ${androidInfo.model}");
      print("product : ${androidInfo.product}");
      print("supported32BitAbis : ${androidInfo.supported32BitAbis}");
      print("supported64BitAbis : ${androidInfo.supported64BitAbis}");
      print("supportedAbis : ${androidInfo.supportedAbis}");
      print("systemFeatures : ${androidInfo.systemFeatures}");
      print("tags : ${androidInfo.tags}");
      print("type : ${androidInfo.type}");
      print("version : ${androidInfo.version.baseOS}");

      await FlutterSession().set('token', androidInfo.androidId);
    } else {
      print("Device : IOS");
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
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

  void getNotify() async {
    Listnotify = await getNotification();
    setState(() {});
  }

  @override
  void initState() {
    GetData(context);
    getNotify();
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
                                    notify: Listnotify,
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
            // Positioned(
            //   top: 50,
            //   child: TextButton(

            //     onPressed: () {
            //       NotiAlert.showBigTextNotification(
            //           title: "Test",
            //           body: "You long body",
            //           fln: flutterLocalNotificationsPlugin);
            //     },
            //     child: Text("Noti"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
