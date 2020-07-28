import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class PointLineTimeSeriesChart extends StatefulWidget {
  final List<Series> seriesList;

  PointLineTimeSeriesChart({@required this.seriesList});
  @override
  _PointLineTimeSeriesChartState createState() =>
      _PointLineTimeSeriesChartState();
}

class _PointLineTimeSeriesChartState extends State<PointLineTimeSeriesChart> {
  DateTime _selectedDate;
  int _selectedValue;
//  double heightDeviceRelative = 0.3;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return SizedBox(
        height: getChartHeight(context, orientation),
        child: TimeSeriesChart(
          widget.seriesList,
          animate: true,
          defaultRenderer: LineRendererConfig(
            includeArea: true,
          ),
          dateTimeFactory: const charts.LocalDateTimeFactory(),
//              domainAxis: DateTimeAxisSpec(
//               tickFormatterSpec: AutoDateTimeTickFormatterSpec(
//                   hour: TimeFormatterSpec(
//                       format: 'yyy',
//                       transitionFormat: 'yyy'))
//                ),
          primaryMeasureAxis: charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
//                lineStyle: charts.LineStyleSpec(
////              color: charts.Color.transparent,
////              // charts.Color(),
////            ),
                ),
          ),
        ),
      );
    });
  }

  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (model.hasDatumSelection && selectedDatum.isNotEmpty) {
      setState(() {
        _selectedDate = model.selectedSeries.first
            .domainFn(model.selectedDatum.first.index);
        _selectedValue = model.selectedSeries.first
            .measureFn(model.selectedDatum.first.index);
      });
    }
  }

  double getChartHeight(BuildContext context, Orientation orientation) {
    double chartHeight = 300.0;
    // SizeConfig.screenHeight * heightDeviceRelative; // Relative size

    if (orientation == Orientation.portrait) {
      return chartHeight;
    } else {
      return chartHeight;
    }
  }
}

class MetricTrend {
  int targetProgressValue;
  String time;
  MetricTrend({this.targetProgressValue, this.time});
}

class GetTracker {
  List<MetricTrend> data = [
    MetricTrend(targetProgressValue: 1000, time: "2025-05-29T14:59:29.412717"),
    MetricTrend(targetProgressValue: 900, time: "2024-05-29T17:21:14.690870"),
    MetricTrend(targetProgressValue: 750, time: "2023-05-29T21:21:14.637437"),
    MetricTrend(targetProgressValue: 700, time: "2022-05-30T01:21:28.835976"),
    MetricTrend(targetProgressValue: 600, time: "2021-05-30T05:21:26.395308"),
    MetricTrend(targetProgressValue: 360, time: "2020-05-30T09:21:27.463247"),
    MetricTrend(targetProgressValue: 350, time: "2019-05-30T13:21:15.136145"),
    MetricTrend(targetProgressValue: 400, time: "2018-05-30T17:21:14.828711"),
    MetricTrend(targetProgressValue: 190, time: "2017-05-30T21:21:14.909268"),
    MetricTrend(targetProgressValue: 150, time: "2016-05-31T01:21:30.781702"),
    MetricTrend(targetProgressValue: 100, time: "2015-05-31T05:21:25.245801"),
  ];
}
