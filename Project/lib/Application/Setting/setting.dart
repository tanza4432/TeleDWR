import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Models/station_model.dart';
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
    return Scaffold(
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
      body: Container(),
    );
  }
}
