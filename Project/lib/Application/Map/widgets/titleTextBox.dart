import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';

class TitleTextBoxMap extends StatelessWidget {
  TitleTextBoxMap({
    Key key,
    this.datamap,
    this.text,
  }) : super(key: key);

  String text;
  String datamap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text + datamap,
      style: DefaultStyleB(),
    );
  }
}
