import 'package:dwr0001/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChart extends StatefulWidget {
  var data;
  AreaChart({Key key, this.data}) : super(key: key);

  @override
  State<AreaChart> createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {
  List<RainChartData> _chartRainData;
  List<RainChartData> _chartWaterDData;
  List<RainChartData> _chartWaterFData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartRainData = getChartRainData();
    _chartWaterDData = getChartWaterDData();
    _chartWaterFData = getChartWaterFData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: GridView.builder(
        itemCount: 3,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return SafeArea(
            child: SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              backgroundColor: Colors.transparent,
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
              ),
              series: <ChartSeries<RainChartData, dynamic>>[
                SplineSeries(
                  name: 'ปริมาณน้ำฝน',
                  // color: Colors.red,
                  dataSource: index == 0
                      ? _chartRainData
                      : index == 1
                          ? _chartWaterDData
                          : _chartWaterFData,
                  xValueMapper: (RainChartData rains, _) => rains.day,
                  yValueMapper: (RainChartData rains, _) => rains.rain,
                  dataLabelMapper: (RainChartData rains, _) => rains.label,
                  // animationDuration: 6500,
                  enableTooltip: true,
                ),
              ],
              // <ChartSeries>[
              //   AreaSeries<SalesData, double>(
              //     color: Colors.red,
              //     width: 6,
              //     dataSource: _chartData,
              //     xValueMapper: (SalesData sales, _) => sales.year,
              //     yValueMapper: (SalesData sales, _) => sales.sales,
              //   )
              // ],
            ),
          );
        },
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
  final double day;
  final double rain;
  final String label;
}
