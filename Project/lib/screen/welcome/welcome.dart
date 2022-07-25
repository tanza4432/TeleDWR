import 'package:device_info_plus/device_info_plus.dart';
import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<StationModel> newdata = [];

  void SetSession() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    await FlutterSession().set('token', androidInfo.androidId);
    await FlutterSession().set('data', '');
  }

  void GetData(BuildContext context) async {
    for (var i = 1; i < 5; i++) {
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
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.8),
            Consumer<FavoriteRiver>(builder: (context, Data, _) {
              return GestureDetector(
                onTap: () async {
                  var data = await FlutterSession().get('data');
                  print(data);
                  // print(data[0].basinId);
                  // print(jsonDecode(data));
                  // json.decode(data);
                  // jsonDecode(data);
                  // if (data != '') {
                  //   try {
                  //     var objText = '{"stn_id": "bezkoder", "basinId": "30"}';
                  //     FavoriteData user =
                  //         FavoriteData.fromJson(jsonDecode(data));
                  //     print(user);
                  //   } catch (e) {
                  //     print(e);
                  //   }
                  // print(jsonDecode(data));
                  // List<dynamic> list = jsonDecode(data);
                  // List<dynamic> list = jsonDecode(receivedJson);
                  // FavoriteData fact = FavoriteData.fromJson(list[0]);
                  // for (FavoriteData i in data.cast()) {
                  //   print(i.stn_id);

                  //   // Data.addData(
                  //   //     FavoriteData(stn_id: i.stn_id, basinId: i.basinId));
                  // }
                  // }
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
