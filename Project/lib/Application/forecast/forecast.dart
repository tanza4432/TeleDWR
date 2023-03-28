import 'package:dwr0001/Application/Menu.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForecastPage extends StatefulWidget {
  String URL;
  String title;

  ForecastPage({
    Key key,
    this.URL,
    this.title,
  }) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  WebViewController controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: DefaultTitleW(),
        ),
        backgroundColor: Colors.lightBlue[600],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.URL,
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     width: double.infinity,
      //     height: size.width * 9 / 16,
      //     child: WebView(
      //       javascriptMode: JavascriptMode.unrestricted,
      //       initialUrl: widget.URL,
      //     ),
      //   ),
      // ),
    );
  }
}
