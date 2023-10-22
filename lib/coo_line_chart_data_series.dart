// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/coo_line_chart_data_point.dart';
import 'package:coo_charts/data_point_label_pos.enum.dart';
import 'package:flutter/material.dart';

class CooLineChartDataSeries {
  CooLineChartDataSeries({
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
    this.dataPointLabelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.dataPointLabelPosition = DataPointLabelPos.top,
    this.dataPointLabelPadding = 0,
  });

  /// Die Datenpunkte, die den Line-Chart beschreiben
  final List<CooLineChartDataPoint> dataPoints;

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

  // Configure the text style of all data labels
  final TextStyle dataPointLabelTextStyle;

  // if true the label is printed above the data point, false below the datapoint
  final DataPointLabelPos dataPointLabelPosition;

  // Define the padding from the data point to the labels
  final int dataPointLabelPadding;

  CooLineChartDataSeries copyWith({
    List<CooLineChartDataPoint>? dataPoints,
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
    TextStyle? dataPointLabelTextStyle,
    DataPointLabelPos? dataPointLabelPosition,
  }) {
    return CooLineChartDataSeries(
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
      dataPointLabelTextStyle: dataPointLabelTextStyle ?? this.dataPointLabelTextStyle,
      dataPointLabelPosition: dataPointLabelPosition ?? this.dataPointLabelPosition,
    );
  }
}
