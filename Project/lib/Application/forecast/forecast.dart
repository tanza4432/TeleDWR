import 'dart:io';

import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForecastPage extends StatefulWidget {
  var basinID;
  final List<StationModel> data;

  ForecastPage({Key key, this.basinID, this.data}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuPage(data: widget.data)))
          },
        ),
        centerTitle: true,
        title: Text(
          'การคาดการณ์',
          style: DefaultTitleW(),
        ),
        backgroundColor: Colors.lightBlue[600],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.basinID == 3
            ? 'http://49.229.21.201/'
            : 'http://49.229.21.203/',
      ),
    );
  }
}
