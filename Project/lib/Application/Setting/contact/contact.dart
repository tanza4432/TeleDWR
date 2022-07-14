import 'package:dwr0001/components/BoxAbout.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  State<ContactPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'ติดต่อเรา',
          style: DefaultTitleB(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxAbout(
              title: "เว็บไซต์",
              icon: Icons.web_asset,
              path: () {
                launch("http://tele-kokkhong.dwr.go.th/");
              },
            ),
            BoxAbout(
              title: "อีเมล",
              icon: Icons.email_outlined,
              path: () {
                launch("mailto:terkid1412@gmail.com?subject=" "&body=" "");
              },
            ),
          ],
        ),
      ),
    );
  }
}
