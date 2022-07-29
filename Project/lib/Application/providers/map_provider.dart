import 'package:flutter/material.dart';
import "package:latlong/latlong.dart";

class MapProvider with ChangeNotifier {
  List<LatLng> get dataPolygon => _listData;

  List<LatLng> _listData = [];

  void addData(LatLng dataPolygon) {
    _listData.add(dataPolygon);
  }
}
