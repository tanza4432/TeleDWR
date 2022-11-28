import 'package:flutter/material.dart';
import "package:latlong/latlong.dart";

Color titlebarColor = Color(0xFF42759A);
Color backgroundmainColor = Color(0xFFE2F3FF);

Color waveup1 = Color(0xFF28CBFF);
Color waveup2 = Color(0xFFE2F3FF);

Color backgroundmenu = Color(0xFF7484AC);

class ListRiver {
  static List<Map<String, dynamic>> items = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': "แม่กลอง",
      'page': 1,
      'latlng': LatLng(0.0, 0.0)
    },
    <String, dynamic>{
      'title': "สาละวิน",
      'page': 2,
      'latlng': LatLng(0.0, 0.0)
    },
    <String, dynamic>{
      'title': "กก\nและโขงเหนือ",
      'page': 3,
      'latlng': LatLng(0.0, 0.0)
    },
    <String, dynamic>{
      'title': "สงคราม\nและห้วยหลวง",
      'page': 4,
      'latlng': LatLng(0.0, 0.0)
    },
    <String, dynamic>{
      'title': "บางปะกง",
      'page': 5,
      'latlng': LatLng(0.0, 0.0)
    },
    <String, dynamic>{
      'title': "อำเภอบางสะพาน",
      'page': 6,
      'latlng': LatLng(0.0, 0.0)
    },
    <String, dynamic>{
      'title': "จังหวัด\nนครศรีธรรมราช",
      'page': 7,
      'latlng': LatLng(0.0, 0.0)
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
