import 'package:dwr0001/Application/providers/river_provider.dart';
import 'package:dwr0001/Models/data_Model.dart';
import 'package:dwr0001/Services/main_Service.dart';
import 'package:dwr0001/components/AreaChart.dart';
import 'package:dwr0001/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TabThree extends StatelessWidget {
  TabThree(this.stnId, this.title, this.wl, this.rf);
  String title;
  String wl;
  String rf;
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
            // return AreaAndLineChart.withSampleData(data);
            return AreaChart(
              data: data,
              stnid: stnId,
              title: title,
              wl: wl,
              rf: rf,
            );
          } else if (snapshot.hasError) {
            for (var i in Data.dataRiver) {
              if (i.stnId == stnId) {
                data = i.data;
                // return AreaAndLineChart.withSampleData(data);
                return AreaChart(
                  data: data,
                  stnid: stnId,
                  title: title,
                  wl: wl,
                  rf: rf,
                );
              }
            }
            if (snapshot.data == null) {
              return LoadingSquareCircle();
            }
          }
          return LoadingSquareCircle();
        },
      ),
    );
  }
}
