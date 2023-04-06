import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class AreaChart extends StatefulWidget {
  var data;
  String stnid;
  String title;
  String wl;
  String rf;
  AreaChart({
    Key key,
    this.data,
    this.stnid,
    this.title,
    this.wl,
    this.rf,
  }) : super(key: key);

  @override
  State<AreaChart> createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {
  TooltipBehavior _tooltipBehavior;
  ZoomPanBehavior _zoomPanbehavior;
  bool notFound = false;
  List<RainFieldTitleData> resultChart = [];

  @override
  void initState() {
    getChartRainData();
    getChartWaterDData();
    getChartWaterFData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanbehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.length == 0) {
      notFound = true;
    }
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            color: Colors.lightBlue[700],
            child: Row(
              children: [
                Icon(Icons.location_on_outlined),
                Flexible(
                  child: Text(
                    "สถานี : " + widget.stnid + " " + widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(2),
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Kanit',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          notFound
              ? Container(
                  height: size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่พบข้อมูล",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.black45),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: resultChart.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return SafeArea(
                      child: SfCartesianChart(
                        
                        tooltipBehavior: _tooltipBehavior,
                        backgroundColor: Colors.transparent,
                        zoomPanBehavior: _zoomPanbehavior,
                        title: ChartTitle(
                          text: resultChart[index].title,
                          textStyle: DefaultChart(),
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: resultChart[index].columnName ==
                                      "ระดับน้ำ" ||
                                  resultChart[index].columnName == "ปริมาณน้ำ"
                              ? 0.0
                              : double.parse((resultChart[index].min -
                                      (resultChart[index].max -
                                              resultChart[index].min) /
                                          5)
                                  .toStringAsFixed(2)),
                          maximum: resultChart[index].columnName ==
                                      "ระดับน้ำ" ||
                                  resultChart[index].columnName == "ปริมาณน้ำ"
                              ? double.parse((resultChart[index].max * 1.2)
                                  .toStringAsFixed(2))
                              : double.parse((resultChart[index].max +
                                      (resultChart[index].max -
                                              resultChart[index].min) /
                                          10)
                                  .toStringAsFixed(2)),
                          labelFormat:
                              resultChart[index].columnName == "ระดับน้ำ"
                                  ? "{value} ม.รทก."
                                  : resultChart[index].columnName == "ปริมาณน้ำ"
                                      ? "{value} ลบม./วินาที"
                                      : '{value} มม.',
                          interactiveTooltip: InteractiveTooltip(enable: false),
                          numberFormat: NumberFormat.currency(
                            locale: 'en_CH',
                            symbol: "",
                          ),
                        ),
                        primaryXAxis: CategoryAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          labelRotation: -90,
                          
                        ),
                        series: [
                          resultChart[index].columnName == "ปริมาณน้ำฝน"
                              ? ColumnSeries(
                                  name: 'ปริมาณน้ำฝน',
                                  dataSource: resultChart[index].data,
                                  xValueMapper: (RainChartData rains, _) =>
                                      rains.label,
                                  yValueMapper: (RainChartData rains, _) =>
                                      rains.rain,
                                  // dataLabelSettings: DataLabelSettings(
                                  //   isVisible: true,
                                  //   // labelPosition: CartesianChartPoint.middle
                                  // ),
                                )
                              : SplineAreaSeries(
                                  borderColor: Colors.blue,
                                  borderWidth: 2,
                                  gradient: LinearGradient(
                                      colors: <Color>[
                                        Colors.blue.withOpacity(0.6),
                                        Color.fromARGB(120, 60, 180, 209)
                                      ],
                                      stops: const <double>[
                                        0.4,
                                        0.8,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),

                                  name: resultChart[index].columnName,

                                  dataSource: resultChart[index].data,
                                  xValueMapper: (RainChartData rains, _) =>
                                      rains.label,
                                  yValueMapper: (RainChartData rains, _) =>
                                      rains.rain,
                                  // dataLabelSettings: DataLabelSettings(isVisible: true),
                                  enableTooltip: true,
                                ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  List<RainChartData> getChartRainData() {
    List<RainChartData> rain = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      // print(widget.data[i].Rain_15_M);
      // if(widget.data[i].Rain_15_M ==)
      rain[i] = new RainChartData(
        double.parse(i.toString()),
        double.parse(widget.data[i].Rain),
        widget.data[i].Label,
      );
    }
    RainChartData max =
        rain.reduce((curr, next) => curr.rain > next.rain ? curr : next);
    RainChartData min =
        rain.reduce((curr, next) => curr.rain < next.rain ? curr : next);
    if (widget.rf != "") {
      RainFieldTitleData result = RainFieldTitleData(
        rain,
        "กราฟแสดงปริมาณน้ำฝน (มม.)",
        "ปริมาณน้ำฝน",
        min.rain,
        max.rain,
      );
      resultChart.add(result);
    }
  }

  List<RainChartData> getChartWaterDData() {
    List<RainChartData> waterD = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      // print(widget.data[i].Water_D);
      // if(widget.data[i].Water_D ==)
      waterD[i] = new RainChartData(
        double.parse(i.toString()),
        double.parse(widget.data[i].Water),
        widget.data[i].Label,
      );
    }
    RainChartData max =
        waterD.reduce((curr, next) => curr.rain > next.rain ? curr : next);
    RainChartData min =
        waterD.reduce((curr, next) => curr.rain < next.rain ? curr : next);
    if (widget.wl != "") {
      RainFieldTitleData result = RainFieldTitleData(
        waterD,
        "กราฟแสดงระดับน้ำ (ม.รทก.)",
        "ระดับน้ำ",
        min.rain,
        max.rain,
      );
      resultChart.add(result);
    }
    return waterD;
  }

  List<RainChartData> getChartWaterFData() {
    List<RainChartData> waterF = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      // print(widget.data[i].Water_F);
      if (widget.data[i].Flow == null) {
        waterF[i] = new RainChartData(
          double.parse(i.toString()),
          0.0,
          widget.data[i].Label,
        );
      } else {
        waterF[i] = new RainChartData(
          double.parse(i.toString()),
          double.parse(widget.data[i].Flow),
          widget.data[i].Label,
        );
      }
    }
    RainChartData max =
        waterF.reduce((curr, next) => curr.rain > next.rain ? curr : next);
    RainChartData min =
        waterF.reduce((curr, next) => curr.rain < next.rain ? curr : next);
    if (widget.wl != "") {
      RainFieldTitleData result = RainFieldTitleData(
        waterF,
        "กราฟแสดงปริมาณน้ำ (ลบม. / วินาที)",
        "ปริมาณน้ำ",
        min.rain,
        max.rain,
      );
      resultChart.add(result);
    }
    return waterF;
  }
}

class RainFieldTitleData {
  RainFieldTitleData(
      this.data, this.title, this.columnName, this.min, this.max);
  List<RainChartData> data;
  String title;
  String columnName;
  double min;
  double max;
}

class RainChartData {
  RainChartData(this.number, this.rain, this.label);
  double number;
  double rain;
  String label;
}
