import 'package:charts_flutter/flutter.dart' as charts;

/// Bar chart example
import 'package:flutter/material.dart';

/// Example of a stacked bar chart with three series, each rendered with
/// different fill colors.
class StackedFillColorBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  StackedFillColorBarChart(this.seriesList, {this.animate});
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(seriesList,
        animate: animate,
        // Configure a stroke width to enable borders on the bars.
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.stacked, strokeWidthPx: 2.0),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
              color: charts.Color.transparent,
              // charts.Color(),
            ),
          ),
        ));
  }

  /// Create series list with multiple series

}

List<charts.Series<OrdinalSales, String>> createSampleData() {
  final desktopSalesData = [
    new OrdinalSales('3-5 yr', 5),
    new OrdinalSales('5-10 yr', 25),
    new OrdinalSales('10-15 yr', 100),
    new OrdinalSales('15-18 yr', 75),
    new OrdinalSales('19* yr', 75),
  ];

  final tableSalesData = [
    new OrdinalSales('3-5 yr', 25),
    new OrdinalSales('5-10 yr', 50),
    new OrdinalSales('10-15 yr', 10),
    new OrdinalSales('15-18 yr', 75),
    new OrdinalSales('19* yr', 75),
  ];

  final mobileSalesData = [
    new OrdinalSales('3-5 yr', 25),
    new OrdinalSales('5-10 yr', 50),
    new OrdinalSales('10-15 yr', 10),
    new OrdinalSales('15-18 yr', 75),
    new OrdinalSales('19* yr', 75),
  ];

  return [
    // Blue bars with a lighter center color.
    new charts.Series<OrdinalSales, String>(
      id: 'Desktop',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: desktopSalesData,
      colorFn: (_, __) => charts.Color.fromHex(code: "#6B778D"),
      fillColorFn: (_, __) => charts.Color.fromHex(code: "#6B778D"),
    ),
    // Solid red bars. Fill color will default to the series color if no
    // fillColorFn is configured.
    new charts.Series<OrdinalSales, String>(
      id: 'Tablet',
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: tableSalesData,
      colorFn: (_, __) => charts.Color.fromHex(code: "#FF6768"),
      fillColorFn: (_, __) => charts.Color.fromHex(code: "#FF6768"),
      domainFn: (OrdinalSales sales, _) => sales.year,
    ),
    // Hollow green bars.
    new charts.Series<OrdinalSales, String>(
      id: 'Mobile',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: mobileSalesData,
      colorFn: (_, __) => charts.Color.fromHex(code: "#263859"),
      fillColorFn: (_, __) => charts.Color.fromHex(code: "#263859"),
    ),
  ];
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
