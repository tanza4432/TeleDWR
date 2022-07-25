import 'dart:convert';

import 'package:dwr0001/Models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

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

class FavoriteRiver with ChangeNotifier {
  List<String> get favorite => _listData;

  List<String> _listData = [];

  void addData(var favorite) async {
    _listData.add(favorite);
    String dataSession = jsonEncode(_listData);
    await FlutterSession().set('data', dataSession);
  }

  Future<void> removeData(var favorite) async {
    for (var i = 0; i < _listData.length; i++) {
      if (favorite == _listData[i]) {
        _listData.remove(favorite);
        String dataSession = jsonEncode(_listData);
        await FlutterSession().set('data', dataSession);
      }
    }
  }
}
