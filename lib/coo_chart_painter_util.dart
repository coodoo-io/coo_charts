// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/chart_column_blocks.dart';
import 'package:coo_charts/chart_padding.enum.dart';
import 'package:coo_charts/coo_barchart_data_point.dart';
import 'package:coo_charts/coo_barchart_data_series.dart';
import 'package:coo_charts/coo_linechart_data_point.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/material.dart';

class CooChartPainterUtil {
  /// Draw the chart border.
  ///
  /// If [showFullRect] is set to false only the x-axis bottom and y-axis left will be printed.
  /// the flags [showYAxis] and [showXAxis] defines whether the axis (top and bottom, left and right)
  /// will be printed.
  ///
  /// Pos(x0,y0) ---------------------- Pos(x1,y0)
  ///     |                                 |
  ///     |                                 |
  ///     |                                 |
  ///     |                                 |
  ///     |                                 |
  /// Pos(x0,y1) ---------------------- Pos(x1,y1)
  static void drawAxis({
    required Canvas canvas,
    required Paint axisPaint,
    required ChartPadding padding,
    required double canvasWidth,
    required double canvasHeight,
    required bool showYAxis,
    required bool showXAxis,
    required bool showFullRect,
  }) {
    double x0 = padding.left.toDouble(); // Links erste X-Pos
    double x1 = canvasWidth - padding.right; // Rechts zweite X-Pos
    double y0 = padding.top.toDouble(); // Oben erste Y-Pos
    double y1 = canvasHeight - padding.bottom; // Unten zweite Y-Pos
    Offset posX0Y0 = Offset(x0, y0);
    Offset posX0Y1 = Offset(x0, y1);
    Offset posX1Y0 = Offset(x1, y0);
    Offset posX1Y1 = Offset(x1, y1);
    if (showXAxis) {
      // X-Achse unten
      canvas.drawLine(posX0Y1, posX1Y1, axisPaint);

      // auch die Gegenseite soll gezeichnet werden
      if (showFullRect) {
        // X-Achse oben
        canvas.drawLine(posX0Y0, posX1Y0, axisPaint);
      }
    }

    if (showYAxis) {
      // Y-Achse links
      canvas.drawLine(posX0Y0, posX0Y1, axisPaint);
      // auch die Gegenseite soll gezeichnet werden
      if (showFullRect) {
        canvas.drawLine(posX1Y0, posX1Y1, axisPaint);
      }
    }
  }

  /// Alle Chart-Punkte auf einen Wert zwischen 0.0 und 1.0 bringen. So wird später die Position
  /// relativ zur 100% Fläche berechnet.
  static List<double?> normalizeChartDataPoints(
      {required List<double?> linechartDataPoints,
      required double yAxisMinValue,
      required double yAxisMaxValue,
      required YAxisConfig yAxisConfig,
      required double minDataPointValue}) {
    if (linechartDataPoints.isEmpty) {
      return List.empty();
    }

    /// Falls es Werte im negativen Bereich gibt müssen diese Werte für die Normalisierung alle
    /// in den positiven Wertebereich gebracht werden.
    var minDataPointDiff = 0.0;
    if (yAxisMinValue < 0) {
      minDataPointDiff = yAxisMinValue.abs();
    }

    // Falls der kleinste Wert > 0 ist müssen alle Punkte um diesen Wert verringert werden.
    // Aber nur, wenn es nicht mit padding ausgespielt wird
    double valueOverZeroDiff = 0.0;
    if (!yAxisConfig.addValuePadding) {
      valueOverZeroDiff = minDataPointValue > 0 ? yAxisMinValue : 0;
    }

    var maxDataPoint =
        yAxisMaxValue + minDataPointDiff - valueOverZeroDiff; // negativen Ausgleich addieren, falls vorhanden

    final normalizedDataPoints = List<double?>.empty(growable: true);
    for (var i = 0; i < linechartDataPoints.length; i++) {
      double? dp = linechartDataPoints[i];
      if (dp != null) {
        dp += minDataPointDiff; // negativen Ausgleich addieren, falls vorhanden
        dp -= valueOverZeroDiff; // Diffenz zu 0 des kleinsten Punktes abziehen
        dp = maxDataPoint == 0 ? 0 : dp / maxDataPoint;
      }
      normalizedDataPoints.add(dp);
    }

    return normalizedDataPoints;
  }
}
