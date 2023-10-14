import 'dart:ui';

import 'package:coo_charts/linechart_data_point.dart';

class LinechartDataSeries {
  LinechartDataSeries(
    this.label,
    this.dataPoints, {
    this.showDataLine = true,
    this.showDataPoints = true,
    this.showMinMaxArea = false,
    this.dataPointColor,
    this.dataPointHighlightColor,
    this.dataLineColor,
    this.dataLabelColor,
    this.minMaxAreaColor,
  });

  /// Titel der Datenreihe
  final String label;

  /// Die Datenpunkte, die den Line-Chart beschreiben
  final List<LineChartDataPoint> dataPoints;

  /// Die Datenlinie soll angezeigt werden?
  final bool showDataLine;

  /// Die Datenpunkte sollen angezeigt werden?
  final bool? showDataPoints;

  /// Der Min/Max Bereich soll gezeichnet werden?
  final bool showMinMaxArea;

  /// Farben der Datenlinie, Punkte usw.
  final Color? dataPointColor;
  final Color? dataPointHighlightColor;
  final Color? dataLineColor;
  final Color? minMaxAreaColor;
  final Color? dataLabelColor;
}
