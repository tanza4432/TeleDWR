import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/data_Model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/AreaAndLineChart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../StationPage.dart';

// ignore: must_be_immutable
class TabThree extends StatelessWidget {
  TabThree(this.stnId);
  List<DataModelGet> resultOffline = [];
  bool check = false;
  var stnId;
  @override
  Widget build(BuildContext context) {
    List<DataModelGet> data = [];
    return Consumer<RiverProviderTabTwo>(
      builder: (context, Data, _) => FutureBuilder<List<DataModelGet>>(
        future: getStationData24H(stnId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            return AreaAndLineChart.withSampleData(data);
          } else if (snapshot.hasError) {
            for (var i in Data.dataRiver) {
              if (i.stnId == stnId) {
                data = i.data;
                return AreaAndLineChart.withSampleData(data);
              }
            }
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
