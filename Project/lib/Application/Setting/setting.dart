import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Application/Setting/contact/contact.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/components/BoxAbout.dart';
import 'package:dwr0001/components/onwillpop.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final List<StationModel> data;
  SettingPage({Key key, this.data}) : super(key: key);

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
            'การตั้งค่า',
            style: DefaultTitleB(),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "เกี่ยวกับ",
                style: DefaultTitleB(),
              ),
              Divider(color: Colors.black38),
              BoxAbout(
                  title: "ติดต่อเรา",
                  icon: Icons.wifi_calling_3_outlined,
                  path: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactPage()),
                    );
                  }),
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
                          'เป็นแอปพลิเคชันสำหรับการติดตามสถานะการณ์ของน้ำฝนและน้ำท่า ประเทศไทย ตามลุ่มน้ำที่กำหนด มีการติดตามดูสถานการณ์น้ำผ่านกล้อง CCTV',
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
