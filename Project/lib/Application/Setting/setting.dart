import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/components/BoxAbout.dart';
import 'package:dwr0001/components/onwillpop.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  final List<StationModel> data;
  final List<StationModel> notify;
  SettingPage({Key key, this.data, this.notify}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MenuPage(
                    data: widget.data,
                  ),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            'เกี่ยวกับ',
            style: DefaultTitleB(),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                leading: Icon(
                  Icons.web_asset,
                  color: Colors.black,
                ),
                title: Text(
                  "เว็บไซต์",
                  style: DefaultStyleB(),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          BoxAbout(
                            title: "ลุ่มน้ำแม่กลอง",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-maeklong.dwr.go.th/home/Index_HOME");
                            },
                          ),
                          BoxAbout(
                            title: "ลุ่มน้ำสาละวิน",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-salawin.dwr.go.th/home/Index_HOME");
                            },
                          ),
                          BoxAbout(
                            title: "ลุ่มน้ำกกและโขงเหนือ",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-kokkhong.dwr.go.th/home/Index_HOME");
                            },
                          ),
                          BoxAbout(
                            title: "ลุ่มน้ำสงครามและห้วยหลวง",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-songkramhuailuang.dwr.go.th/home/Index_HOME");
                            },
                          ),
                          BoxAbout(
                            title: "ลุ่มน้ำบางปะกง",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-bangpakong.dwr.go.th/home/Index_HOME");
                            },
                          ),
                          BoxAbout(
                            title: "อำเภอบางสะพาน",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-bangsaphan.dwr.go.th/home/Index_HOME");
                            },
                          ),
                          BoxAbout(
                            title: "จังหวัดนครศรีธรรมราช",
                            icon: Icons.web_asset,
                            path: () {
                              launch(
                                  "https://tele-nakhonsri.dwr.go.th/home/Index_HOME");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              BoxAbout(
                title: "mekhala@dwr.mail.go.th",
                icon: Icons.email_outlined,
                path: () {
                  launch("mailto:mekhala@dwr.mail.go.th?subject="
                      "&body="
                      "");
                },
              ),
              // ExpansionTile(
              //   leading: Icon(
              //     Icons.wifi_calling_3_outlined,
              //     color: Colors.black,
              //   ),
              //   title: Text(
              //     "mekhala@dwr.mail.go.th",
              //     style: DefaultStyleB(),
              //   ),
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //       child: Align(
              //         alignment: Alignment.topLeft,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             BoxAbout(
              //               title: "เว็บไซต์",
              //               icon: Icons.web_asset,
              //               path: () {
              //                 launch("http://tele-kokkhong.dwr.go.th/");
              //               },
              //             ),
              //             BoxAbout(
              //               title: "อีเมล",
              //               icon: Icons.email_outlined,
              //               path: () {
              //                 launch("mailto:terkid1412@gmail.com?subject="
              //                     "&body="
              //                     "");
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              BoxAbout(
                title: "เกี่ยวกับ TeleDWR",
                icon: Icons.info_outline,
                path: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 150,
                        ),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          'เป็นแอปพลิเคชันสำหรับการติดตามสถานะการณ์ของน้ำฝนและน้ำท่า ประเทศไทย \nตามลุ่มน้ำที่กำหนด มีการติดตามดูสถานการณ์น้ำผ่านกล้อง CCTV',
                          textAlign: TextAlign.center,
                          style: DefaultStyleB(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
