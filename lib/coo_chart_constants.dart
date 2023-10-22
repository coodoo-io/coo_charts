import 'package:flutter/material.dart';

// Singleton für alle Konstanten in diesem Chart
class CooChartConstants {
  static final CooChartConstants _singleton = CooChartConstants._internal();

  factory CooChartConstants() {
    return _singleton;
  }

  CooChartConstants._internal();

  Color columnHighlightColor = Colors.grey.withOpacity(0.3);
  Color minMaxRangeColor = Colors.blueGrey;

  List<CooChartColorSchema> colorShemas = [
    CooChartColorSchema(
      dataPointColor: Colors.blue,
      dataPointHighlightColor: Colors.lightBlue,
    ),
    CooChartColorSchema(
      dataPointColor: Colors.green,
      dataPointHighlightColor: Colors.blueGrey,
    ),
    CooChartColorSchema(
      dataPointColor: Colors.deepPurple,
      dataPointHighlightColor: Colors.purple,
    ),
    CooChartColorSchema(
      dataPointColor: Colors.orange,
      dataPointHighlightColor: Colors.yellow,
    ),
  ];
}

class CooChartColorSchema {
  CooChartColorSchema({
    required this.dataPointColor,
    required this.dataPointHighlightColor,
  });

  final Color dataPointColor;
  final Color dataPointHighlightColor;
}
