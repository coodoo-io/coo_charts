import 'package:coo_charts/common/coo_chart_color_scheme.dart';
import 'package:flutter/material.dart';

// Singleton für alle Konstanten in diesem Chart
class CooChartConstants {
  static final CooChartConstants _singleton = CooChartConstants._internal();

  factory CooChartConstants() {
    return _singleton;
  }

  CooChartConstants._internal();

  final colorSchemeDefault = CooChartColorScheme(
    canvasBorderColor: Colors.grey.withOpacity(0.3),
    gridColor: Colors.grey.withOpacity(0.3),
    canvasBackgroundColor: Colors.white,
    dataPointColor: Colors.blue,
    dataPointHighlightColor: Colors.lightBlue,
    columnHighlightColor: Colors.grey.withOpacity(0.3),
    minMaxRangeColor: Colors.blueGrey,
  );

  List<CooChartColorScheme> getColorShemas() {
    return [
      colorSchemeDefault,
      CooChartColorScheme(
        canvasBorderColor: Colors.grey.withOpacity(0.3),
        gridColor: Colors.grey.withOpacity(0.3),
        canvasBackgroundColor: Colors.white,
        dataPointColor: Colors.green,
        dataPointHighlightColor: Colors.blueGrey,
        columnHighlightColor: Colors.grey.withOpacity(0.3),
        minMaxRangeColor: Colors.blueGrey,
      ),
      CooChartColorScheme(
        canvasBorderColor: Colors.grey.withOpacity(0.3),
        gridColor: Colors.grey.withOpacity(0.3),
        canvasBackgroundColor: Colors.white,
        dataPointColor: Colors.deepPurple,
        dataPointHighlightColor: Colors.purple,
        columnHighlightColor: Colors.grey.withOpacity(0.3),
        minMaxRangeColor: Colors.blueGrey,
      ),
      CooChartColorScheme(
        canvasBorderColor: Colors.grey.withOpacity(0.3),
        gridColor: Colors.grey.withOpacity(0.3),
        canvasBackgroundColor: Colors.white,
        dataPointColor: Colors.orange,
        dataPointHighlightColor: Colors.yellow,
        columnHighlightColor: Colors.grey.withOpacity(0.3),
        minMaxRangeColor: Colors.blueGrey,
      ),
    ];
  }
}
