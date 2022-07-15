import 'package:dwr0001/Models/dataOffline_Model.dart';
import 'package:dwr0001/Models/data_Model.dart';
import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiverProviderTabOne with ChangeNotifier {
  List<StationModel> get dataRiver => _listData;

  List<StationModel> _listData = [];

  void addData(StationModel dataRiver) {
    _listData.add(dataRiver);
  }
}

class RiverProviderTabTwo with ChangeNotifier {
  List<dynamic> get dataRiver => _listData;

  List<dynamic> _listData = [];

  void addData(var dataRiver) {
    _listData.add(dataRiver);
  }
}
