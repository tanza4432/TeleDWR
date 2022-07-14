import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiverProvider with ChangeNotifier {
  List<StationModel> get dataRiver => _listUser;

  List<StationModel> _listUser = [
    //เก็บข้อมูลตอน Login เข้ามา Data ของผู้ใช้จะเก็บไว้ในนี้
  ];

  void addData(StationModel dataRiver) {
    _listUser.add(dataRiver);
    // if (_listUser.length == 0) {
    //   _listUser.add(dataRiver);
    // } else {
    //   for (var i in _listUser) {
    //     if (i.STN_ID != dataRiver.STN_ID) {
    //     }
    //   }
    // }
  }
}
