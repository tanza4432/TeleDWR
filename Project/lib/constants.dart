import 'package:flutter/material.dart';
import "package:latlong/latlong.dart";

Color titlebarColor = Color(0xFF42759A);
Color backgroundmainColor = Color(0xFFE2F3FF);

Color waveup1 = Color(0xFF28CBFF);
Color waveup2 = Color(0xFFE2F3FF);

Color backgroundmenu = Color(0xFF7484AC);

class ImgRiver {
  static String imgBasin1 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_1.png";
  static String imgBasin2 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_2.png";
  static String imgBasin3 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_3.png";
  static String imgBasin4 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_4.png";
  static String imgBasin5 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_5.png";
  static String imgBasin6 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_6.png";
  static String imgBasin7 =
      "https://tele-songkramhuailuang.dwr.go.th/image/BasinImg/river_7.png";
}

class ListRiver {
  static List<Map<String, dynamic>> items = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': "แม่กลอง",
      'page': 1,
      'latlng': LatLng(18.81356, 99.5735)
    },
    <String, dynamic>{
      'title': "สาละวิน",
      'page': 2,
      'latlng': LatLng(18.01885, 98.26535)
    },
    <String, dynamic>{
      'title': "กก\nและโขงเหนือ",
      'page': 3,
      'latlng': LatLng(19.61885, 99.76535)
    },
    <String, dynamic>{
      'title': "สงคราม\nและห้วยหลวง",
      'page': 4,
      'latlng': LatLng(17.9333616361, 103.306040861)
    },
    <String, dynamic>{
      'title': "บางปะกง",
      'page': 5,
      'latlng': LatLng(13.760186, 101.585212)
    },
    <String, dynamic>{
      'title': "บางสะพาน",
      'page': 6,
      'latlng': LatLng(11.300223, 99.452512)
    },
    <String, dynamic>{
      'title': "นครศรีธรรมราช",
      'page': 7,
      'latlng': LatLng(8.5530059, 99.8354578)
    },
  ];
}

TextStyle DefaultStyleW() {
  return TextStyle(
      color: Colors.white,
      fontFamily: 'Kanit',
      fontSize: 18.0,
      fontWeight: FontWeight.w200);
}

TextStyle DefaultStyleB() {
  return TextStyle(
    color: Colors.black,
    fontFamily: 'Kanit',
    fontSize: 18.0,
    fontWeight: FontWeight.w200,
  );
}

TextStyle favoriteStyle() {
  return TextStyle(
      color: Colors.black,
      fontFamily: 'Kanit',
      fontSize: 14.0,
      fontWeight: FontWeight.w200);
}

TextStyle SelectMenuStyle() {
  return TextStyle(
      color: Colors.black,
      fontFamily: 'Kanit',
      fontSize: 14.0,
      fontWeight: FontWeight.w200);
}

TextStyle DefaultTitleW() {
  return TextStyle(
      color: Colors.white,
      fontFamily: 'Kanit',
      fontSize: 22.0,
      fontWeight: FontWeight.w200);
}

TextStyle DetailTitleW() {
  return TextStyle(
      color: Colors.white,
      fontFamily: 'Kanit',
      fontSize: 12.0,
      fontWeight: FontWeight.w200);
}

TextStyle DefaultTitleB() {
  return TextStyle(
      color: Colors.black,
      fontFamily: 'Kanit',
      fontSize: 22.0,
      fontWeight: FontWeight.w200);
}

TextStyle DefaultChart() {
  return TextStyle(
      color: Colors.black,
      fontFamily: 'Kanit',
      fontSize: 16.0,
      fontWeight: FontWeight.w200);
}

TextStyle FavoriteStyle() {
  return TextStyle(
      color: Colors.black,
      fontFamily: 'Kanit',
      fontSize: 10.0,
      fontWeight: FontWeight.w200);
}

TextStyle NotificationStyle() {
  return TextStyle(
      color: Colors.black,
      fontFamily: 'Kanit',
      fontSize: 14.0,
      fontWeight: FontWeight.w200);
}

TextStyle DefaultStyleTextBoxMap() {
  return TextStyle(
    color: Colors.black,
    fontFamily: 'Kanit',
    fontSize: 12.0,
  );
}

TextStyle DefaultTitleStyleTextBoxMap() {
  return TextStyle(
    color: Colors.black,
    fontFamily: 'Kanit',
    fontSize: 14.0,
  );
}
