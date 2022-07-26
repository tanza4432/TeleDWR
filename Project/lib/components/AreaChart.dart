import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChart extends StatefulWidget {
  var data;
  String stnid;
  String title;
  AreaChart({Key key, this.data, this.stnid, this.title}) : super(key: key);

  @override
  State<AreaChart> createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {
  List<RainChartData> _chartRainData;
  List<RainChartData> _chartWaterDData;
  List<RainChartData> _chartWaterFData;
  TooltipBehavior _tooltipBehavior;
  ZoomPanBehavior _zoomPanbehavior;

  @override
  void initState() {
    _chartRainData = getChartRainData();
    _chartWaterDData = getChartWaterDData();
    _chartWaterFData = getChartWaterFData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanbehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
        Container(
          width: double.infinity,
          height: size.height * 0.76,
          child: Scrollbar(
            isAlwaysShown: true,
            child: GridView.builder(
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return SafeArea(
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    backgroundColor: Colors.transparent,
                    zoomPanBehavior: _zoomPanbehavior,
                    title: ChartTitle(
                      text: index == 0
                          ? " กราฟแสดงปริมาณน้ำฝน (มม.) "
                          : index == 1
                              ? " กราฟแสดงระดับน้ำ (ม.รทก.) "
                              : " กราฟแสดงปริมาณน้ำ (ลบม. / วินาที) ",
                      textStyle: DefaultTitleB(),
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value} มม.',
                      interactiveTooltip: InteractiveTooltip(enable: false),
                    ),
                    primaryXAxis: CategoryAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    series: [
                      SplineSeries(
                        name: 'ปริมาณน้ำฝน',
                        dataSource: index == 0
                            ? _chartRainData
                            : index == 1
                                ? _chartWaterDData
                                : _chartWaterFData,
                        xValueMapper: (RainChartData rains, _) => rains.label,
                        yValueMapper: (RainChartData rains, _) => rains.rain,
                        // dataLabelSettings: DataLabelSettings(isVisible: true),
                        enableTooltip: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<RainChartData> getChartRainData() {
    List<RainChartData> rain = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      // print(widget.data[i].Rain_15_M);
      // if(widget.data[i].Rain_15_M ==)
      rain[i] = new RainChartData(
        double.parse(i.toString()),
        double.parse(widget.data[i].Rain_15_M),
        widget.data[i].Label,
      );
    }
    return rain;
  }

  List<RainChartData> getChartWaterDData() {
    List<RainChartData> waterD = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      // print(widget.data[i].Water_D);
      // if(widget.data[i].Water_D ==)
      waterD[i] = new RainChartData(
        double.parse(i.toString()),
        double.parse(widget.data[i].Water_D),
        widget.data[i].Label,
      );
    }
    return waterD;
  }

  List<RainChartData> getChartWaterFData() {
    List<RainChartData> waterF = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      // print(widget.data[i].Water_F);
      if (widget.data[i].Water_F == null) {
        waterF[i] = new RainChartData(
          double.parse(i.toString()),
          0.0,
          widget.data[i].Label,
        );
      } else {
        waterF[i] = new RainChartData(
          double.parse(i.toString()),
          double.parse(widget.data[i].Water_F),
          widget.data[i].Label,
        );
      }
      // // if(widget.data[i].Water_F ==)
    }
    return waterF;
  }
}

class RainChartData {
  RainChartData(this.day, this.rain, this.label);
  double day;
  double rain;
  String label;
}
