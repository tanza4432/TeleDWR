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
  List<RainChartData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        backgroundColor: Colors.transparent,
        title: ChartTitle(
          text: "กราฟแสดงปริมาณน้ำฝน (มม.)",
          textStyle: DefaultTitleB(),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value} มม.',
        ),
        series: <ChartSeries<RainChartData, dynamic>>[
          SplineSeries(
            name: 'ปริมาณน้ำฝน',
            // color: Colors.red,
            dataSource: _chartData,
            xValueMapper: (RainChartData rains, _) => rains.day,
            yValueMapper: (RainChartData rains, _) => rains.rain,
            // dataLabelMapper: (RainChartData rains, _) => rains.label,
            animationDuration: 6500,
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
  }

  List<RainChartData> getChartData() {
    List<RainChartData> rain = new List<RainChartData>(widget.data.length);
    for (var i = 0; i < widget.data.length; i++) {
      print(widget.data[i].Rain_15_M);
      // if(widget.data[i].Rain_15_M ==)
      rain[i] = new RainChartData(
        double.parse(i.toString()),
        double.parse(widget.data[i].Rain_15_M),
        widget.data[i].Label,
      );
    }
    return rain;
  }
}

class RainChartData {
  RainChartData(this.day, this.rain, this.label);
  final double day;
  final double rain;
  final String label;
}
