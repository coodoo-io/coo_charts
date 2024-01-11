import 'package:flutter/material.dart';

List<CooChartColorSchema> colorShemas = [
  CooChartColorSchema(
    dataPointColor: Colors.blue,
    dataPointHighlightColor: Colors.lightBlue,
    gridColor: Colors.grey.withOpacity(0.7),
    columnHighlightColor: Colors.grey.withOpacity(0.3),
    minMaxRangeColor: Colors.blueGrey,
  ),
  CooChartColorSchema(
    dataPointColor: Colors.green,
    dataPointHighlightColor: Colors.blueGrey,
    gridColor: Colors.grey.withOpacity(0.7),
    columnHighlightColor: Colors.grey.withOpacity(0.3),
    minMaxRangeColor: Colors.blueGrey,
  ),
  CooChartColorSchema(
    dataPointColor: Colors.deepPurple,
    dataPointHighlightColor: Colors.purple,
    gridColor: Colors.grey.withOpacity(0.7),
    columnHighlightColor: Colors.grey.withOpacity(0.3),
    minMaxRangeColor: Colors.blueGrey,
  ),
  CooChartColorSchema(
    dataPointColor: Colors.orange,
    dataPointHighlightColor: Colors.yellow,
    gridColor: Colors.grey.withOpacity(0.7),
    columnHighlightColor: Colors.grey.withOpacity(0.3),
    minMaxRangeColor: Colors.blueGrey,
  ),
];

// Singleton für alle Konstanten in diesem Chart
class CooChartConstants {
  static final CooChartConstants _singleton = CooChartConstants._internal(colorShemas[0]);

  factory CooChartConstants() {
    return _singleton;
  }

  CooChartConstants._internal(this.colorSchema);

  CooChartColorSchema colorSchema;

  selectColorSchema(int number) {
    colorSchema = colorShemas[number];
  }
}

class CooChartColorSchema {
  CooChartColorSchema({
    required this.dataPointColor,
    required this.dataPointHighlightColor,
    required this.gridColor,
    required this.columnHighlightColor,
    required this.minMaxRangeColor,
  });

  final Color dataPointColor;
  final Color dataPointHighlightColor;
  final Color gridColor;
  final Color columnHighlightColor;
  final Color minMaxRangeColor;
}
