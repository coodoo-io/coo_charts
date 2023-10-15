// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/linechart_painter.dart';
import 'package:flutter/material.dart';

class CooChartPainter {
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
}
