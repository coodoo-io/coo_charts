import 'dart:ui';

import 'package:flutter/material.dart';

// Singleton für alle Konstanten in diesem Chart
class CooChartConstants {
  static final CooChartConstants _singleton = CooChartConstants._internal();

  factory CooChartConstants() {
    return _singleton;
  }

  CooChartConstants._internal();

  Color columnHighlightColor = Colors.blue.withOpacity(0.3);
  List<CooChartColorSchema> colorShemas = [
    CooChartColorSchema(dataPointColor: Colors.blue, dataPointHighlightColor: Colors.lightBlue),
    CooChartColorSchema(dataPointColor: Colors.green, dataPointHighlightColor: Colors.blueGrey),
    CooChartColorSchema(dataPointColor: Colors.deepPurple, dataPointHighlightColor: Colors.purple),
    CooChartColorSchema(dataPointColor: Colors.yellow, dataPointHighlightColor: Colors.orange),
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
