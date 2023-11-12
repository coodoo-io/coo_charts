// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/common/data_point_label_pos.enum.dart';
import 'package:flutter/material.dart';

class CooBarChartDataSeries {
  CooBarChartDataSeries({
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
    this.barWidth,
    this.minBarWidth, // Not implemented yet
    this.maxBarWidth, // Not implemented yet
    this.barWidthPercentColumn, // Not implemented yet
    this.barHeight,
  });

  /// Die Datenpunkte, die den Line-Chart beschreiben
  final List<CooBarChartDataPoint> dataPoints;

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

  // Wie breit darf der Bar maximal sein?
  final int? barWidth;
  final int? minBarWidth;
  final int? maxBarWidth;
  final int? barWidthPercentColumn; // Wieviel Prozent der Column darf der Barchart breit sein?

  // Candle Stick Chart Add-On
  // TODO move to own chart type
  // Wenn gesetzt wird der Value als "Mittelpunkt" verwendet und diese höhe / 2 auf jeder Seite draufgerechnet
  final int? barHeight;

  // Configure the text style of all data labels
  final TextStyle dataPointLabelTextStyle;

  final DataPointLabelPos dataPointLabelPosition;

  // Define the padding from the data point to the labels
  final int dataPointLabelPadding;
}
