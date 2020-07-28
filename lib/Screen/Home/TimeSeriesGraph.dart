import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';

class lineChart extends StatefulWidget {
  @override
  _lineChartState createState() => _lineChartState();
}

class _lineChartState extends State<lineChart> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> line1 = createLine2();
    return Container(
      height: 400,
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedLineChart(
          AreaLineChart.fromDateTimeMaps([line1], [Colors.red.shade900], [''],
              gradients: [Pair(Color(0xff6B778D), Color(0xffFF6768))]),
        ), //Unique key to force animations
      ),
    );
  }
}

Map<DateTime, double> createLine2() {
  Map<DateTime, double> data = {};
  data[DateTime.now().subtract(Duration(minutes: 40))] = 13.0;
  data[DateTime.now().subtract(Duration(minutes: 30))] = 24.0;
  data[DateTime.now().subtract(Duration(minutes: 22))] = 39.0;
  data[DateTime.now().subtract(Duration(minutes: 20))] = 29.0;
  data[DateTime.now().subtract(Duration(minutes: 15))] = 27.0;
  data[DateTime.now().subtract(Duration(minutes: 12))] = 9.0;
  data[DateTime.now().subtract(Duration(minutes: 5))] = 35.0;
  return data;
}
