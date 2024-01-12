import 'package:coo_charts/common/coo_chart_color_theme.dart';
import 'package:flutter/material.dart';

// Singleton für alle Konstanten in diesem Chart
class CooChartThemes {
  static final CooChartThemes _singleton = CooChartThemes._internal();

  factory CooChartThemes() {
    return _singleton;
  }

  CooChartThemes._internal();

  final defaultTheme = CooChartTheme(
    backgroundColor: Colors.white,
    chartBorderColor: Colors.grey.withOpacity(0.3),
    gridColor: Colors.grey.withOpacity(0.3),
    chartBackgroundColor: Colors.white,
    labelColor: Colors.grey,
    labelFontSize: 11,
    dataPointColor: Colors.blue,
    dataPointHighlightColor: Colors.lightBlue,
    columnHighlightColor: Colors.grey.withOpacity(0.3),
    barColor: Colors.blue,
    barColorHighlight: Colors.green,
    minMaxRangeColor: Colors.yellow,
  );

  List<CooChartTheme> getAll() {
    return [
      defaultTheme,
      CooChartTheme(
        backgroundColor: Colors.white,
        chartBorderColor: Colors.grey.withOpacity(0.3),
        gridColor: Colors.grey.withOpacity(0.3),
        chartBackgroundColor: Colors.white,
        labelColor: Colors.grey,
        labelFontSize: 11,
        dataPointColor: Colors.green,
        barColor: Colors.blue,
        barColorHighlight: Colors.blueGrey,
        dataPointHighlightColor: Colors.blueGrey,
        columnHighlightColor: Colors.grey.withOpacity(0.3),
        minMaxRangeColor: Colors.deepPurple,
      ),
      CooChartTheme(
        backgroundColor: Colors.white,
        chartBorderColor: Colors.grey.withOpacity(0.3),
        gridColor: Colors.grey.withOpacity(0.3),
        chartBackgroundColor: Colors.white,
        labelColor: Colors.grey,
        labelFontSize: 11,
        dataPointColor: Colors.deepPurple,
        barColor: Colors.blue,
        barColorHighlight: Colors.blueGrey,
        dataPointHighlightColor: Colors.purple,
        columnHighlightColor: Colors.grey.withOpacity(0.3),
        minMaxRangeColor: Colors.blueGrey,
      ),
      CooChartTheme(
        backgroundColor: Colors.white,
        chartBorderColor: Colors.grey.withOpacity(0.3),
        gridColor: Colors.grey.withOpacity(0.3),
        chartBackgroundColor: Colors.white,
        labelColor: Colors.grey,
        labelFontSize: 11,
        dataPointColor: Colors.orange,
        barColor: Colors.blue,
        barColorHighlight: Colors.blueGrey,
        dataPointHighlightColor: Colors.yellow,
        columnHighlightColor: Colors.grey.withOpacity(0.3),
        minMaxRangeColor: Colors.blueGrey,
      ),
    ];
  }
}
