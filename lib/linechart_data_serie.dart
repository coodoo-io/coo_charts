// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:coo_charts/linechart_data_point.dart';

class LinechartDataSeries {
  LinechartDataSeries({
    required this.dataPoints,
    this.label,
    this.showDataLine = true,
    this.showDataPoints = true,
    this.showDataLabels = false,
    this.showMinMaxArea = false,
    this.dataPointColor,
    this.dataPointHighlightColor,
    this.dataLineColor,
    this.minMaxAreaColor,
    this.dataLabelColor,
  });

  /// Die Datenpunkte, die den Line-Chart beschreiben
  final List<LineChartDataPoint> dataPoints;

  /// Titel der Datenreihe
  final String? label;

  /// Die Datenlinie soll angezeigt werden?
  final bool showDataLine;

  /// Die Datenpunkte sollen angezeigt werden?
  final bool showDataPoints;

  /// Sollen die data labels direkt auf dem Chart gezeichnet werden?
  final bool showDataLabels;

  /// Der Min/Max Bereich soll gezeichnet werden?
  final bool showMinMaxArea;

  /// Farben der Datenlinie, Punkte usw.
  final Color? dataPointColor;
  final Color? dataPointHighlightColor;
  final Color? dataLineColor;
  final Color? minMaxAreaColor;
  final Color? dataLabelColor;

  LinechartDataSeries copyWith({
    List<LineChartDataPoint>? dataPoints,
    String? label,
    bool? showDataLine,
    bool? showDataPoints,
    bool? showDataLabels,
    bool? showMinMaxArea,
    Color? dataPointColor,
    Color? dataPointHighlightColor,
    Color? dataLineColor,
    Color? minMaxAreaColor,
    Color? dataLabelColor,
  }) {
    return LinechartDataSeries(
      dataPoints: dataPoints ?? this.dataPoints,
      label: label ?? this.label,
      showDataLine: showDataLine ?? this.showDataLine,
      showDataPoints: showDataPoints ?? this.showDataPoints,
      showDataLabels: showDataLabels ?? this.showDataLabels,
      showMinMaxArea: showMinMaxArea ?? this.showMinMaxArea,
      dataPointColor: dataPointColor ?? this.dataPointColor,
      dataPointHighlightColor: dataPointHighlightColor ?? this.dataPointHighlightColor,
      dataLineColor: dataLineColor ?? this.dataLineColor,
      minMaxAreaColor: minMaxAreaColor ?? this.minMaxAreaColor,
      dataLabelColor: dataLabelColor ?? this.dataLabelColor,
    );
  }
}
