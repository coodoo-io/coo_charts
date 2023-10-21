// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/coo_barchart_data_point.dart';
import 'package:flutter/material.dart';

class CooBarchartDataSeries {
  CooBarchartDataSeries({
    required this.dataPoints,
    this.label,
    this.showDataLabels = false,
    this.showMinMaxLine = false,
    this.barColor,
    this.barHighlightColor,
    this.minMaxLineColor,
    this.dataPointLabelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    this.dataPointLabelPosition = DataPointLabelPos.top,
    this.dataPointLabelPadding = 0,
  });

  /// Die Datenpunkte, die den Line-Chart beschreiben
  final List<CooBarchartDataPoint> dataPoints;

  /// Titel der Datenreihe
  final String? label;

  /// Sollen die data labels direkt auf dem Chart gezeichnet werden?
  final bool showDataLabels;

  /// Der Min/Max Bereich soll gezeichnet werden?
  final bool showMinMaxLine;

  /// Farben der Datenlinie, Punkte usw.
  final Color? barColor;
  final Color? barHighlightColor;
  final Color? minMaxLineColor;

  // Configure the text style of all data labels
  final TextStyle dataPointLabelTextStyle;

  // if true the label is printed above the data point, false below the datapoint
  final DataPointLabelPos dataPointLabelPosition;

  // Define the padding from the data point to the labels
  final int dataPointLabelPadding;
}

// in wich direktction should the data point label be positioned
enum DataPointLabelPos {
  top,
  right,
  left,
  bottom,
}
