// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:coo_charts/chart_column_blocks.dart';
import 'package:coo_charts/chart_padding.enum.dart';
import 'package:coo_charts/chart_tab_info.dart';
import 'package:coo_charts/coo_barchart_data_point.dart';
import 'package:coo_charts/coo_barchart_data_series.dart';
import 'package:coo_charts/coo_chart_constants.dart';
import 'package:coo_charts/coo_chart_painter_util.dart';
import 'package:coo_charts/coo_chart_type.enum.dart';
import 'package:coo_charts/coo_linechart_data_point.dart';
import 'package:coo_charts/coo_linechart_data_series.dart';
import 'package:coo_charts/data_point_label_pos.enum.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/x_axis_value_type.enum.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CooChartPainter extends CustomPainter {
  CooChartPainter({
    required this.chartType,
    required this.linechartDataSeries,
    required this.barchartDataSeries,
    this.columnBlocks,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.curvedLine,
    required this.mousePosition,
    required this.chartTabInfo,
    required this.crosshair,
    required this.showGridHorizontal,
    required this.showGridVertical,
    required this.highlightMouseColumn,
    required this.highlightPoints,
    required this.highlightPointsVerticalLine,
    required this.highlightPointsHorizontalLine,
    required this.centerDataPointBetweenVerticalGrid,
    required this.xAxisConfig,
    required this.yAxisConfig,
    required this.padding,
    required this.columLegendsAssetImages,
    required this.columLegendsAssetSvgPictureInfos,
    this.onDataPointTabCallback,
  }) {
    chartWidth = canvasWidth - padding.left - padding.right;
    chartHeight = canvasHeight - padding.bottom - padding.top;

    _initializeValues();

    // Initialisierung anhand des übergebenen Datentyps.
    // Reihen die ein Datum als Wert haben werden anders bewerted
    switch (xAxisConfig.valueType) {
      case XAxisValueType.date:
      case XAxisValueType.datetime:
        _initializeDateTimeLineChartValues();

      default:
        _initializeNumberLineChartValues();
    }

    if (!centerDataPointBetweenVerticalGrid) {
      xSegmentWidth = chartWidth / (maxAbsoluteValueCount - 1);
    } else {
      xSegmentWidth = chartWidth / maxAbsoluteValueCount;
    }

    xSegementWidthHalf = xSegmentWidth / 2;
  }

  final CooChartType chartType;

  final List<CooLinechartDataSeries> linechartDataSeries;
  final List<CooBarchartDataSeries> barchartDataSeries;

  final ChartColumnBlocks? columnBlocks;
  final Map<String, ui.Image> columLegendsAssetImages;
  final Map<String, PictureInfo> columLegendsAssetSvgPictureInfos;

  final double canvasHeight;
  final double canvasWidth;
  final ChartPadding padding;

  final Offset? mousePosition; // Position des Mauszeigers - wird für das Fadenkreuz benötigt (interne Variable)
  final ChartTabInfo chartTabInfo;

  /// Externe Konfigurationsmöglichkeiten
  final bool curvedLine; // Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  final bool crosshair; // Soll ein Fadenkreuz angezeigt werden?
  final bool showGridHorizontal; // if true, grid horizontal lines are painted
  final bool showGridVertical; // if true, grid vertical lines are painted

  final bool highlightMouseColumn; // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  final bool highlightPoints; // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  final bool
      highlightPointsVerticalLine; // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  final bool
      highlightPointsHorizontalLine; // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.

  /// Die Konfiguration für X- und Y-Achse
  final YAxisConfig yAxisConfig;
  final XAxisConfig xAxisConfig;

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  final bool centerDataPointBetweenVerticalGrid;

  /// Padding des Canvas um das der Graph eingerückt ist.

  /// Werden im Constructor berechnet (canvasgrößte - padding)
  late double chartWidth;
  late double chartHeight;

  // Anzahl aller Datenpunkte auf der X-Achse Chartübergreifend
  int maxAbsoluteValueCount = 0;

  // Größten und kleinsten Wert merken
  double? maxDataPointValue; // Größter Wert aller Datenpunkte
  double? minDataPointValue; // Kleinster Wert aller Datenpunkte
  double? yAxisMaxValue; // Größter Wert auf der Y-Achsen-Skala
  double? yAxisMinValue; // Kleinster Wert auf der Y-AchsenSkale
  double yAxisSteps = 0.0; // globale Hilfsvariable zum Berechnen der Datenpunkte

  /// Alle zeitlichen Datenpunkte sortiert hintereinander
  List<DateTime> allDateTimeXAxisValues = [];

  // Abstand zwischen zwei Datenpunkte auf der X-Achse
  double xSegmentWidth = 0.0;
  double xSegementWidthHalf = 0.0; // Convenient var so it don't have to be calculated by all data points.

  Function(int, List<CooLinechartDataPoint>)? onDataPointTabCallback;

// Hält alle Punkte die zu einer Axe Vertikal liegen. Das rect bestimmt den Maus-Hover-Bereich
  int mouseInRectYIndex = -1; // In welchem Y-Index befindet sich die Maus gerade?

  // All sich auf diesem Index befindenden LineChart Datenpunkte
  // Die exakte Punkt (X,Y) eines LineChart DataPoint Objekts müsste man in Verbidung dises Objektes noch in einem
  // eigenen Objekt halten. Dann könnte man auch den nächstgelegenen Punkt zum Maus Pointer herausfinden
  final Map<int, List<CooLinechartDataPoint>> lineChartDataPointsByColumnIndex = {};
  final Map<int, List<CooBarchartDataPoint>> barChartDataPointsByColumnIndex = {};

  final Map<Rect, int> chartRectYPos = {}; // Merken welches Rect bei welcher Y-Pos liegt

  final Paint _gridPaint = Paint()
    ..color = Colors.grey.withOpacity(0.4)
    ..strokeWidth = 1;

  final Paint _highlightLinePaint = Paint()
    ..color = Colors.white.withOpacity(0.7)
    ..strokeWidth = 1;

  final Paint _axisPaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1;

  final Paint _backgroundRectPaint = Paint()
    ..color = Colors.blue.withOpacity(0)
    ..strokeWidth = 0;

  final Paint _backgroundRectHighlightPaint = Paint()
    ..color = Colors.blue.withOpacity(0.3)
    ..strokeWidth = 0;

  final Paint _mousePositionPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 1;

  final _linePaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final _lineAreaPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final Paint _pointPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 4
    ..style = PaintingStyle.fill;

  final Paint _pointPaintHighlight = Paint()
    ..color = Colors.yellow
    ..strokeWidth = 8
    ..style = PaintingStyle.fill;

  final TextPainter _axisLabelPainter = TextPainter(
    textAlign: TextAlign.left,
    textDirection: ui.TextDirection.ltr,
  );

  final TextPainter _dataLabelPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: ui.TextDirection.ltr,
  );

  final TextPainter _columLegendTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: ui.TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    /// Chart canvas size to draw on

    CooChartPainterUtil.drawAxis(
      canvas: canvas,
      padding: padding,
      axisPaint: _axisPaint,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      showYAxis: yAxisConfig.showAxis,
      showXAxis: xAxisConfig.showAxis,
      showFullRect: true,
    );

    // Berechnet die Spalten für alle Datenpunkte und setzt den Index welche Column für die
    // darüberliegende Maus gerade aktiv ist.
    _drawBackgroundRect(
      canvas: canvas,
      chartWidth: chartWidth,
      chartHeigt: chartHeight,
      mousePosition: mousePosition,
      linechartDataSeries: linechartDataSeries,
    );

    _drawXAxisLabelAndVerticalGridLine(
      canvas: canvas,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
    );

    _drawYAxisLabelAndHorizontalGridLine(
      canvas: canvas,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      linechartDataSeries: linechartDataSeries,
      showYAxisLables: yAxisConfig.showYAxisLables,
      columnBlocks: columnBlocks,
    );

    _drawColumnBottomBlocks(
      canvas: canvas,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      linechartDataSeries: linechartDataSeries,
      columnBlocks: columnBlocks,
    );

    if (chartType == CooChartType.line) {
      _drawDataLinechartDataPointsAndPath(
        canvas: canvas,
        chartWidth: chartWidth,
        chartHeigt: chartHeight,
        mousePosition: mousePosition,
        linechartDataSeries: linechartDataSeries,
        columnBlocks: columnBlocks,
        minDataPointValue: minDataPointValue!,
        yAxisConfig: yAxisConfig,
        yAxisMaxValue: yAxisMaxValue!,
        yAxisMinValue: yAxisMinValue!,
      );
    }
    if (chartType == CooChartType.bar) {
      _drawDataBarchartBars(
        barchartDataSeries: barchartDataSeries,
        canvas: canvas,
        chartWidth: chartWidth,
        chartHeigt: chartHeight,
        mousePosition: mousePosition,
        columnBlocks: columnBlocks,
        minDataPointValue: minDataPointValue!,
        yAxisConfig: yAxisConfig,
        yAxisMaxValue: yAxisMaxValue!,
        yAxisMinValue: yAxisMinValue!,
        padding: padding,
        xSegmentWidth: xSegmentWidth,
        xSegementWidthHalf: xSegementWidthHalf,
      );
    }

    if (crosshair) {
      _drawCrosshair(canvas: canvas, chartHeight: chartHeight, chartWidth: chartWidth, mousePosition: mousePosition);
    }
  }

  @override
  bool shouldRepaint(covariant CooChartPainter oldDelegate) {
    return mousePosition != oldDelegate.mousePosition;
  }

  void _drawDataLinechartDataPointsAndPath({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required Offset? mousePosition,
    required List<CooLinechartDataSeries> linechartDataSeries,
    required double yAxisMinValue,
    required double yAxisMaxValue,
    required YAxisConfig yAxisConfig,
    required double minDataPointValue,
    ChartColumnBlocks? columnBlocks,
  }) {
    final columnBottomDatasHeight = columnBlocks != null ? columnBlocks.bottomConfig.height.toDouble() : 0;
    // Die Segment-width muss über alle vorhandenen Datenpunkte aller Reihen berechnet werden.
    for (var i = 0; i < linechartDataSeries.length; i++) {
      CooLinechartDataSeries localLinechartDataSeries = linechartDataSeries[i];
      List<String?> dataSeriesLabels = List.empty(growable: true);
      List<double?> dataPointValues = localLinechartDataSeries.dataPoints.map((e) => e.value).toList();

      // Alle Punkte auf einen Bereich zwischen 0.0 und 1.0 bringen um sie in der Fläche relativ berechnen zu können
      List<double?> dataSeriesNormalizedValues = CooChartPainterUtil.normalizeChartDataPoints(
        linechartDataPoints: dataPointValues,
        minDataPointValue: minDataPointValue,
        yAxisMinValue: yAxisMinValue,
        yAxisMaxValue: yAxisMaxValue,
        yAxisConfig: yAxisConfig,
      );

      final segmentWidthCurve = xSegmentWidth / 3; // each datapoint segment width

      /// calculate datapoint positions
      var lineDataPoints = List<Offset?>.empty(growable: true);
      double lastX = 0;
      double lastY = 0;

      var lineChartDataPointsPath = Path();
      bool startPointAdded = false;
      dataPointsLoop:
      for (var i = 0; i < dataSeriesNormalizedValues.length; i++) {
        // Lables für den späteren plotten parsen
        CooLinechartDataPoint dataPoint = localLinechartDataSeries.dataPoints[i];
        if (localLinechartDataSeries.showDataLabels) {
          if (dataPoint.label != null) {
            dataSeriesLabels.add(dataPoint.label!.trim());
          } else if (dataPoint.value != null) {
            dataSeriesLabels.add(dataPoint.value.toString());
          } else {
            dataSeriesLabels.add(null);
          }
        }

        final dataValue = dataSeriesNormalizedValues[i];
        if (dataValue == null) {
          lineDataPoints.add(null);
          continue dataPointsLoop;
        }

        // Berechnen der Position zum Plotten der Linie
        double x;
        if (i == 0) {
          x = 0.0 + padding.left;
        } else {
          x = (i * xSegmentWidth) + padding.left;
        }
        if (centerDataPointBetweenVerticalGrid) {
          x += xSegementWidthHalf; // add center offset
        }

        final startYPos = canvasHeight - padding.top - padding.bottom - columnBottomDatasHeight;
        final y = startYPos - (dataValue * (startYPos)) + padding.top;

        if (!startPointAdded) {
          lineChartDataPointsPath.moveTo(x, y);
          startPointAdded = true;
        } else {
          if (curvedLine) {
            var x1 = lastX + (1 * segmentWidthCurve);
            var y1 = lastY;
            var x2 = lastX + (2 * segmentWidthCurve);
            var y2 = y;
            var x3 = lastX + (3 * segmentWidthCurve);
            var y3 = y;
            lineChartDataPointsPath.cubicTo(x1, y1, x2, y2, x3, y3);
          } else {
            lineChartDataPointsPath.lineTo(x, y);
          }
        }

        var chartPoint = Offset(x, y);
        lineDataPoints.add(chartPoint);

        lastX = x;
        lastY = y;
      }

      // Linechart Min- & Max-Area malen
      if (localLinechartDataSeries.showMinMaxArea) {
        _drawMinMaxDataPointArea(
          canvas: canvas,
          chartWidth: chartWidth,
          chartHeigt: chartHeigt,
          dataSeries: localLinechartDataSeries,
          minMaxPoints: localLinechartDataSeries.dataPoints,
          mousePosition: mousePosition,
          dataPointColumnLegendHeight: columnBottomDatasHeight,
        );
      }
      // Linechart Verbindungsline malen
      if (localLinechartDataSeries.showDataLine) {
        if (localLinechartDataSeries.dataLineColor != null) {
          _linePaint.color = localLinechartDataSeries.dataLineColor!;

          // Falls die Linefarbe angegeben wurde wird diese als default für die Datenpunkte, Highlight und Font gesetzt.
          _pointPaint.color = localLinechartDataSeries.dataLineColor!;
          _pointPaintHighlight.color = localLinechartDataSeries.dataLineColor!;
        }
        canvas.drawPath(
          lineChartDataPointsPath,
          _linePaint,
        );
      }

      if (localLinechartDataSeries.dataPointColor != null) {
        _pointPaint.color = localLinechartDataSeries.dataPointColor!;
      }
      if (localLinechartDataSeries.dataPointHighlightColor != null) {
        _pointPaintHighlight.color = localLinechartDataSeries.dataPointHighlightColor!;
      }

      // Linechart Datenpunkte malen und Punkt Highlighten, wenn maus Datenzeile trifft
      drawLineDataPointsLoop:
      for (var i = 0; i < lineDataPoints.length; i++) {
        Offset? dataPointOffset = lineDataPoints[i];
        if (dataPointOffset == null) {
          // gibt nichts zu sehen..
          continue drawLineDataPointsLoop;
        }

        // Wird der Punkt gerade mit der Maus angeklickt?
        if (highlightPoints && mouseInRectYIndex == i) {
          canvas.drawCircle(dataPointOffset, 8, _pointPaintHighlight);
        } else if (localLinechartDataSeries.showDataPoints) {
          canvas.drawCircle(dataPointOffset, 4, _pointPaint);
        }

        // Data Point Label malen
        if (localLinechartDataSeries.showDataLabels) {
          String? label = dataSeriesLabels[i];
          if (label != null) {
            _dataLabelPainter.text = TextSpan(text: label, style: localLinechartDataSeries.dataPointLabelTextStyle);
            _dataLabelPainter.layout();

            double xPosCenter;
            double yPos;
            switch (localLinechartDataSeries.dataPointLabelPosition) {
              case DataPointLabelPos.top:
                // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
                xPosCenter = (dataPointOffset.dx) - (_dataLabelPainter.width / 2);
                yPos = dataPointOffset.dy - 25 + (localLinechartDataSeries.dataPointLabelPadding * -1);
                break;
              case DataPointLabelPos.right:
                xPosCenter = (dataPointOffset.dx) + 10 + localLinechartDataSeries.dataPointLabelPadding;
                yPos = dataPointOffset.dy - (_dataLabelPainter.height / 2);
                break;
              case DataPointLabelPos.left:
                xPosCenter = (dataPointOffset.dx) - 30 + (localLinechartDataSeries.dataPointLabelPadding * -1);
                yPos = dataPointOffset.dy - (_dataLabelPainter.height / 2);
                break;
              case DataPointLabelPos.bottom:
                // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
                xPosCenter = (dataPointOffset.dx) - (_dataLabelPainter.width / 2);
                yPos = dataPointOffset.dy + 10 + localLinechartDataSeries.dataPointLabelPadding;
                break;
            }

            _dataLabelPainter.paint(canvas, Offset(xPosCenter, yPos));
          }
        }
      }
    }
  }

  void _drawDataBarchartBars({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required ChartPadding padding,
    required double xSegmentWidth,
    required double xSegementWidthHalf,
    required Offset? mousePosition,
    required double yAxisMinValue,
    required double yAxisMaxValue,
    required YAxisConfig yAxisConfig,
    required double minDataPointValue,
    required List<CooBarchartDataSeries> barchartDataSeries,
    ChartColumnBlocks? columnBlocks,
  }) {
    final columnBottomDatasHeight = columnBlocks != null ? columnBlocks.bottomConfig.height.toDouble() : 0;
    // Die Segment-width muss über alle vorhandenen Datenpunkte aller Reihen berechnet werden.
    for (var i = 0; i < barchartDataSeries.length; i++) {
      CooBarchartDataSeries localLinechartDataSeries = barchartDataSeries[i];
      List<String?> dataSeriesLabels = List.empty(growable: true);
      List<double?> dataPointValues = localLinechartDataSeries.dataPoints.map((e) => e.value).toList();

      // Alle Punkte auf einen Bereich zwischen 0.0 und 1.0 bringen um sie in der Fläche relativ berechnen zu können
      List<double?> dataSeriesNormalizedValues = CooChartPainterUtil.normalizeChartDataPoints(
        linechartDataPoints: dataPointValues,
        minDataPointValue: minDataPointValue,
        yAxisMinValue: yAxisMinValue,
        yAxisMaxValue: yAxisMaxValue,
        yAxisConfig: yAxisConfig,
      );

      final Color barColor = localLinechartDataSeries.barColor ?? CooChartConstants().colorShemas[i].dataPointColor;
      final Paint barPaint = Paint()
        ..color = barColor
        ..strokeWidth = 1;

      final Color barColorHighlight =
          localLinechartDataSeries.barColor ?? CooChartConstants().colorShemas[i].dataPointHighlightColor;
      final Paint barHightlightPaint = Paint()
        ..color = barColorHighlight
        ..strokeWidth = 1;

      dataPointsLoop:
      for (var i = 0; i < dataSeriesNormalizedValues.length; i++) {
        // Lables für den späteren plotten parsen
        CooBarchartDataPoint dataPoint = localLinechartDataSeries.dataPoints[i];
        if (localLinechartDataSeries.showDataLabels) {
          if (dataPoint.label != null) {
            dataSeriesLabels.add(dataPoint.label!.trim());
          } else if (dataPoint.value != null) {
            dataSeriesLabels.add(dataPoint.value.toString());
          } else {
            dataSeriesLabels.add(null);
          }
        }

        final dataValue = dataSeriesNormalizedValues[i];
        if (dataValue == null) {
          continue dataPointsLoop;
        }

        // Berechnen der Position zum Plotten der Linie
        double x;
        if (i == 0) {
          x = 0.0 + padding.left;
        } else {
          x = (i * xSegmentWidth) + padding.left;
        }
        if (centerDataPointBetweenVerticalGrid) {
          x += xSegementWidthHalf; // add center offset
        }
        final startYPos = canvasHeight - padding.top - padding.bottom - columnBottomDatasHeight;
        final y = startYPos - (dataValue * (startYPos)) + padding.top;

        /// Pos(x0,y0) - Pos(x1,y0)
        ///     |                |
        ///     |                |
        ///     |                |
        ///     |                |
        ///     |                |
        /// Pos(x0,y1)  -  Pos(x1,y1)
        double x0 = x - 10;
        double y0 = y;
        double x1 = x + 10;
        double y1 = startYPos + padding.top;

        var rect = Rect.fromPoints(Offset(x0, y0), Offset(x1, y1));

        bool mouseOverBarHiglight = false;
        if (mousePosition != null) {
          bool contains = rect.contains(Offset(mousePosition.dx, mousePosition.dy));
          mouseOverBarHiglight = contains && highlightMouseColumn;
        }

        if (mouseOverBarHiglight) {
          canvas.drawRect(rect, barPaint);
        } else {
          canvas.drawRect(rect, barPaint);
        }
      }
    }
  }

  void _drawMinMaxDataPointArea({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required Offset? mousePosition,
    required CooLinechartDataSeries dataSeries,
    required List<CooLinechartDataPoint> minMaxPoints,
    required dataPointColumnLegendHeight,
  }) {
    // Min- Max-Datenpunkte in eine Reihe bringen um eine Form zu bilden
    List<double?> minPoints = minMaxPoints.map((e) => e.minValue).toList();
    List<double?> maxPoints = minMaxPoints.map((e) => e.maxValue).toList();

    // Alle hintereinander ergibt das custom paint path die zweite reihe reversed,
    // damit es einen ordentlichen Kreis ergib

    List<double?> minPointsNormalized = CooChartPainterUtil.normalizeChartDataPoints(
      linechartDataPoints: minPoints,
      minDataPointValue: minDataPointValue!,
      yAxisMinValue: yAxisMinValue!,
      yAxisMaxValue: yAxisMaxValue!,
      yAxisConfig: yAxisConfig,
    );
    List<double?> maxPointsNormalized = CooChartPainterUtil.normalizeChartDataPoints(
      linechartDataPoints: maxPoints,
      minDataPointValue: minDataPointValue!,
      yAxisMinValue: yAxisMinValue!,
      yAxisMaxValue: yAxisMaxValue!,
      yAxisConfig: yAxisConfig,
    );

    final segmentWidthCurve = xSegmentWidth / 3; // each datapoint segment width

    /// calculate datapoint positions
    var lineDataPoints = List<Offset?>.empty(growable: true);
    double lastX = 0;
    double lastY = 0;

    var lineChartDataPointsPath = Path();
    bool startPointAdded = false;
    minValueLoop:
    for (var i = 0; i < minMaxPoints.length; i++) {
      final dataValue = minPointsNormalized[i];
      if (dataValue == null) {
        lineDataPoints.add(null);
        continue minValueLoop;
      }

      double x;
      if (i == 0) {
        x = 0.0 + padding.left;
      } else {
        x = (i * xSegmentWidth) + padding.left;
      }
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      final startYPos = canvasHeight - padding.top - padding.bottom - dataPointColumnLegendHeight;
      final y = startYPos - (dataValue * (startYPos)) + padding.top;

      if (!startPointAdded) {
        lineChartDataPointsPath.moveTo(x, y);
        startPointAdded = true;
      } else {
        if (curvedLine) {
          var x1 = lastX + (1 * segmentWidthCurve);
          var y1 = lastY;
          var x2 = lastX + (2 * segmentWidthCurve);
          var y2 = y;
          var x3 = lastX + (3 * segmentWidthCurve);
          var y3 = y;
          lineChartDataPointsPath.cubicTo(x1, y1, x2, y2, x3, y3);
        } else {
          lineChartDataPointsPath.lineTo(x, y);
        }
      }

      var chartPoint = Offset(x, y);
      lineDataPoints.add(chartPoint);

      lastX = x;
      lastY = y;
    }
    maxValueLoop:
    for (var i = minMaxPoints.length - 1; i >= 0; i--) {
      final dataValue = maxPointsNormalized[i];
      if (dataValue == null) {
        lineDataPoints.add(null);
        continue maxValueLoop;
      }

      double x;
      if (i == 0) {
        x = 0.0 + padding.left;
      } else {
        x = (i * xSegmentWidth) + padding.left;
      }
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      final startYPos = canvasHeight - padding.top - padding.bottom - dataPointColumnLegendHeight;
      final y = startYPos - (dataValue * (startYPos)) + padding.top;

      if (!startPointAdded) {
        lineChartDataPointsPath.moveTo(x, y);
        startPointAdded = true;
      } else {
        if (curvedLine) {
          var x1 = lastX + (1 * segmentWidthCurve);
          var y1 = lastY;
          var x2 = lastX + (2 * segmentWidthCurve);
          var y2 = y;
          var x3 = lastX + (3 * segmentWidthCurve);
          var y3 = y;
          lineChartDataPointsPath.cubicTo(x1, y1, x2, y2, x3, y3);
        } else {
          lineChartDataPointsPath.lineTo(x, y);
        }
      }

      var chartPoint = Offset(x, y);
      lineDataPoints.add(chartPoint);

      lastX = x;
      lastY = y;
    }

    lineChartDataPointsPath.close();

    // Linechart Verbindungsline malen
    if (dataSeries.minMaxAreaColor != null) {
      _lineAreaPaint.color = dataSeries.minMaxAreaColor!;
      _lineAreaPaint.style = PaintingStyle.fill;
    }
    canvas.drawPath(
      lineChartDataPointsPath,
      _lineAreaPaint,
    );
  }

  void _drawBackgroundRect({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required Offset? mousePosition,
    required List<CooLinechartDataSeries> linechartDataSeries,
  }) {
    mouseInRectYIndex = -1; // Reset

    // das erste und das letzte Rect sind nur halb so groß, wenn der Punkt direkt bei 0 auf der Y-Achse liegt
    for (var i = 0; i < maxAbsoluteValueCount; i++) {
      var x1 = (i * xSegmentWidth) + padding.left - xSegementWidthHalf;
      var y1 = padding.top.toDouble();

      var x2 = (i * xSegmentWidth) + xSegmentWidth + padding.left - xSegementWidthHalf;
      var y2 = padding.top + chartHeigt;

      // Erster und letzter Datenpunkt sind nur halb zu sehen
      if (i == 0 && !centerDataPointBetweenVerticalGrid) {
        x1 = 0 + padding.left.toDouble();
        x2 = xSegementWidthHalf + padding.left.toDouble();
      }

      if (centerDataPointBetweenVerticalGrid) {
        x1 += xSegementWidthHalf; // add center offset
        x2 += xSegementWidthHalf; // add center offset
      }

      var rect = Rect.fromPoints(Offset(x1, y1), Offset(x2, y2));
      if (mousePosition != null) {
        bool contains = rect.contains(Offset(mousePosition.dx, mousePosition.dy));
        if (contains) {
          if (highlightMouseColumn) {
            canvas.drawRect(rect, _backgroundRectHighlightPaint);
          }
          mouseInRectYIndex = i;
        }
      } else {
        canvas.drawRect(rect, _backgroundRectPaint);
      }

      // Tab Callback der gesamten Spalte
      if (chartTabInfo.tabDownDetails != null && onDataPointTabCallback != null) {
        final tabDownDetails = chartTabInfo.tabDownDetails!;
        bool contains = rect.contains(Offset(tabDownDetails.localPosition.dx, tabDownDetails.localPosition.dy));
        if (contains && chartTabInfo.tabCount != chartTabInfo.tabCountCallbackInvocation) {
          chartTabInfo.tabCountCallbackInvocation = chartTabInfo.tabCountCallbackInvocation + 1;
          var selectedDataPoints = lineChartDataPointsByColumnIndex[i];
          selectedDataPoints ??= List.empty(growable: false);
          onDataPointTabCallback!(i, selectedDataPoints);
        }
      }

      // Merken bei welcher Y-Pos das Re
      chartRectYPos[rect] = i;
    }
  }

  void _drawCrosshair({
    required Canvas canvas,
    Offset? mousePosition,
    required double chartWidth,
    required double chartHeight,
  }) {
    // MausPosition muss nicht vorhanden sein, z.B. wenn der Chart initial gemalt wird
    if (mousePosition == null) {
      return;
    }

    // Nur anzeigen, wenn die Mausposition im Feld des gemalten Charts liegt.
    var rectangle = Rectangle(padding.left, padding.top, chartWidth, chartHeight);
    bool containsPoint = rectangle.containsPoint(Point(mousePosition.dx, mousePosition.dy));
    if (!containsPoint) {
      return;
    }

    // Crosshair malen
    canvas.drawLine(
      Offset(mousePosition.dx, padding.top.toDouble()),
      Offset(mousePosition.dx, chartHeight + padding.top),
      _mousePositionPaint,
    );
    canvas.drawLine(
      Offset(padding.left.toDouble(), mousePosition.dy),
      Offset(chartWidth + padding.left, mousePosition.dy),
      _mousePositionPaint,
    );

    // MousePointer-Punkt
    canvas.drawCircle(mousePosition, 5, _mousePositionPaint);
  }

  /// Malt die X-Achse, alle Y-Linien der Datenpunkte und die Labels in der Breite des Charts
  ///
  /// Labels können unter und über dem Chart gemalt werden.
  /// Definiert wird das durch [xAxisConfig.showTopLabels] und [xAxisConfig.showBottomLabels].
  void _drawXAxisLabelAndVerticalGridLine({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeight,
  }) {
    int xGridLineCount = maxAbsoluteValueCount;
    if (!centerDataPointBetweenVerticalGrid) {
      xGridLineCount -= 1;
    }
    double xOffsetInterval = chartWidth / (xGridLineCount);
    double xBottomPos = chartHeight + padding.top;

    // In case of a date label define the default date format
    DateFormat? topDateFormat;
    DateFormat? bottomDateFormat;
    switch (xAxisConfig.valueType) {
      case XAxisValueType.date:
        topDateFormat = DateFormat.MMMMd();
        bottomDateFormat = DateFormat.MMMMd();
        break;

      case XAxisValueType.datetime:
        topDateFormat = DateFormat.yMd().add_Hm();

        bottomDateFormat = DateFormat.yMd().add_Hm();
        break;
      default:
      // nothing to do for default..
    }

    // Check custom given formats
    if (xAxisConfig.topDateFormat != null) {
      // Custom date format given by implementer
      topDateFormat = DateFormat(xAxisConfig.topDateFormat);
    }

    if (xAxisConfig.bottomDateFormat != null) {
      // Custom date format given by implementer
      bottomDateFormat = DateFormat(xAxisConfig.bottomDateFormat);
    }

    int startNumber = xAxisConfig.startNumber;
    gridLineLoop:
    for (int i = 0; i <= xGridLineCount; i++) {
      double x = (xOffsetInterval * i) + padding.left;
      double xVerticalGridline = x;
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      // Don't draw the first vertical grid line because there is already the y-Axis line
      if (i != 0 && showGridVertical) {
        canvas.drawLine(
            Offset(xVerticalGridline, padding.top.toDouble()), Offset(xVerticalGridline, xBottomPos), _gridPaint);
      }

      // draw highlight vertical line on mouse-over
      if (highlightPointsVerticalLine && i != 0 && i == mouseInRectYIndex) {
        canvas.drawLine(Offset(x, padding.top.toDouble()), Offset(x, xBottomPos), _highlightLinePaint);
      }

      if (!xAxisConfig.showTopLabels && !xAxisConfig.showBottomLabels) {
        // Es sollen keine Labels gemalt werden - können uns diese Auswertung sparen.
        continue gridLineLoop;
      }

      TextStyle textStyle;
      if (highlightPointsVerticalLine && i != 0 && i == mouseInRectYIndex) {
        textStyle = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
      } else {
        textStyle = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        );
      }

      // Die letzte vertikale Linie muss bei Centered zusätzlich gezeichnet werden, das nächste Label allerdings
      // nicht, denn das wäre ein nicht vorhandener Datenpunkt zu viel
      if (!centerDataPointBetweenVerticalGrid || i != xGridLineCount) {
        late String topLabel;
        late String bottomLabel;
        switch (xAxisConfig.valueType) {
          case XAxisValueType.date:
          case XAxisValueType.datetime:
            topLabel = topDateFormat!.format(allDateTimeXAxisValues[i]);
            bottomLabel = bottomDateFormat!.format(allDateTimeXAxisValues[i]);
            break;
          case XAxisValueType.number:
            bottomLabel = startNumber.toString();
            topLabel = startNumber.toString();
            break;
        }

        if (xAxisConfig.labelTopPostfix != null) {
          topLabel = '$topLabel ${xAxisConfig.labelTopPostfix}';
        }
        if (xAxisConfig.labelBottomPostfix != null) {
          topLabel = '$topLabel ${xAxisConfig.labelBottomPostfix}';
        }

        startNumber++;

        if (xAxisConfig.showTopLabels) {
          _axisLabelPainter.text = TextSpan(text: topLabel, style: textStyle);
          _axisLabelPainter.layout();
          // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
          final xPosCenter = (xOffsetInterval / 2) - (_axisLabelPainter.width / 2);
          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final xPos = x - (xOffsetInterval / 2) + xPosCenter;
          _axisLabelPainter.paint(canvas, Offset(xPos, padding.top.toDouble() - 25));
        }

        if (xAxisConfig.showBottomLabels) {
          _axisLabelPainter.text = TextSpan(text: bottomLabel, style: textStyle);
          _axisLabelPainter.layout();
          // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
          final xPosCenter = (xOffsetInterval / 2) - (_axisLabelPainter.width / 2);
          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final xPos = x - (xOffsetInterval / 2) + xPosCenter;
          _axisLabelPainter.paint(canvas, Offset(xPos, chartHeight + padding.top + 10));
        }
      }
    }
  }

  /// Malt die Labels auf der Y-Achse und alle horizontalen X-Linien des Datengrids
  ///
  /// Berechnet die Höhe der einzelnen Zeilen anhand der gegebenen Label-Counts.
  /// Labels werden links neben dem Chart gemalt.
  ///
  void _drawYAxisLabelAndHorizontalGridLine({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeight,
    required List<CooLinechartDataSeries> linechartDataSeries,
    required bool showYAxisLables,
    ChartColumnBlocks? columnBlocks,
  }) {
    bool showColumnBottomDatas = columnBlocks != null;
    double dataPointColumnLegendHeight = showColumnBottomDatas ? columnBlocks.bottomConfig.height.toDouble() : 0;

    final double yOffsetInterval = (chartHeight - dataPointColumnLegendHeight) / (yAxisConfig.labelCount - 1);

    for (int i = 0; i < yAxisConfig.labelCount; i++) {
      double y = chartHeight - (i * yOffsetInterval) + padding.top - dataPointColumnLegendHeight;

      // Don't draw the first horizontal grid line because there is already the x-Axis line
      // Falls die Column Legende angezeigt werden soll dann die erste Line auch zeichnen
      if (i != 0 && showGridHorizontal || showColumnBottomDatas) {
        canvas.drawLine(Offset(padding.left.toDouble(), y), Offset(chartWidth + padding.left, y), _gridPaint);
      }

      // Draw Y-axis scale points
      var yAxisLabelValue = (i * yAxisSteps + yAxisMinValue!);
      late String label;
      if (yAxisLabelValue is int || yAxisLabelValue % 1 == 0) {
        // Zahl ist eine ganze Zahl und wird ohne Kommastelle
        label = yAxisLabelValue.toInt().toString();
      } else {
        label = yAxisLabelValue.toStringAsFixed(2);
      }

      if (yAxisConfig.labelPostfix != null) {
        label = '$label ${yAxisConfig.labelPostfix}';
      }

      _axisLabelPainter.text = TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      );

      if (showYAxisLables) {
        _axisLabelPainter.layout();

        // Die Labels an der Y-Achse sollen rechtsbündig sein.
        // Somit muss der Padding mit der Größe des Textes berechnet werden
        var w = _axisLabelPainter.width;
        _axisLabelPainter.paint(canvas, Offset(padding.left - w - 10, y - _axisLabelPainter.height / 2));
      }
    }
  }

  /// Initialisiert die Rahmendaten anhand DateTime Serien
  /// - Sortiert alle DateTime Datenpunkte und
  /// - Findet die absolute (Data-Series übergreifende) Menge an Datenpunkte heraus
  void _initializeDateTimeLineChartValues() {
    Set<DateTime> allDateTimesTmp = {}; // Alle Dates einmal speichern (doppelte herausfiltern)

    for (var dataSeries in linechartDataSeries) {
      List<DateTime?> allDateTimeValues = dataSeries.dataPoints.map((e) => e.time).toList();

      // // Null Values entfernen, darf eigetnlich nicht vorkommen, denn dann müsste man die Stelle berechnen
      allDateTimeValues.removeWhere((element) => element == null);
      allDateTimeValues.sort((a, b) => a!.compareTo(b!));

      for (var dt in allDateTimeValues) {
        allDateTimesTmp.add(dt!);
      }

      for (var i = 0; i < dataSeries.dataPoints.length; i++) {
        CooLinechartDataPoint dataPoint = dataSeries.dataPoints[i];
        if (lineChartDataPointsByColumnIndex[i] == null) {
          lineChartDataPointsByColumnIndex[i] = [];
        }
        lineChartDataPointsByColumnIndex[i]!.add(dataPoint);
      }
    }

    // Barchart
    for (var dataSeries in barchartDataSeries) {
      List<DateTime?> allDateTimeValues = dataSeries.dataPoints.map((e) => e.time).toList();

      // // Null Values entfernen, darf eigetnlich nicht vorkommen, denn dann müsste man die Stelle berechnen
      allDateTimeValues.removeWhere((element) => element == null);
      allDateTimeValues.sort((a, b) => a!.compareTo(b!));

      for (var dt in allDateTimeValues) {
        allDateTimesTmp.add(dt!);
      }

      for (var i = 0; i < dataSeries.dataPoints.length; i++) {
        CooBarchartDataPoint dataPoint = dataSeries.dataPoints[i];
        if (barChartDataPointsByColumnIndex[i] == null) {
          barChartDataPointsByColumnIndex[i] = [];
        }
        barChartDataPointsByColumnIndex[i]!.add(dataPoint);
      }
    }

    // Die absolute Anzahl an Datenpunkten ist die Länge des Sets
    maxAbsoluteValueCount = allDateTimesTmp.length;

    // Alle Datenpunkte in eine sortierte Liste packen
    allDateTimeXAxisValues.addAll(allDateTimesTmp);
    allDateTimeXAxisValues.sort((a, b) => a.compareTo(b));
  }

  /// Initialisiert die Rahmendaten anhand der übergebenen Werte numerisch
  void _initializeNumberLineChartValues() {
    for (var dataSeries in linechartDataSeries) {
      if (dataSeries.dataPoints.length > maxAbsoluteValueCount) {
        maxAbsoluteValueCount = dataSeries.dataPoints.length;
      }

      for (var i = 0; i < dataSeries.dataPoints.length; i++) {
        CooLinechartDataPoint dataPoint = dataSeries.dataPoints[i];
        if (lineChartDataPointsByColumnIndex[i] == null) {
          lineChartDataPointsByColumnIndex[i] = [];
        }
        lineChartDataPointsByColumnIndex[i]!.add(dataPoint);
      }
    }
  }

  void _initializeValues() {
    // Prüfen ob der erste Wert ein double ist, falls ja und wenn nicht padding eingebaut werden soll sind die Steps
    // double Werte. Sind es nur int Values als erste Werte werden immer ints als Range angeben.
    bool firstIsADoubleValue = false;

    for (var linechartDataSerie in linechartDataSeries) {
      {
        // Alle Datenwerte  prüfen
        List<double?> values = linechartDataSerie.dataPoints.map((e) => e.value).toList();
        values.removeWhere((element) => element == null);

        if (values.isEmpty) {
          continue;
        }

        // check first
        if (!firstIsADoubleValue && values[0]! % 1 != 0) {
          firstIsADoubleValue = true;
        }

        // Min- und Max-Value herausfinden (Nulls beachten und ignorieren)
        final maxValueTmp = values.cast<double>().reduce(max);
        if (maxDataPointValue == null || maxDataPointValue! < maxValueTmp) {
          maxDataPointValue = maxValueTmp;
          yAxisMaxValue = maxValueTmp;
        }
        final minValueTmp = values.cast<double>().reduce(min);
        if (minDataPointValue == null || minDataPointValue! > minValueTmp) {
          minDataPointValue = minValueTmp;
          yAxisMinValue = minValueTmp;
        }
      }

      // Prüfen ob die Max-Werte eines Punktes anezeigt werden sollen.
      // Falls ja, muss dieser als Max-Wert
      if (linechartDataSerie.showMinMaxArea) {
        // Max aus den Punkten der range max Daten
        List<double?> maxValues = linechartDataSerie.dataPoints.map((e) => e.maxValue).toList();
        maxValues.removeWhere((element) => element == null);

        if (maxValues.isNotEmpty) {
          final maxValuesMax = maxValues.cast<double>().reduce(max);
          if (maxDataPointValue == null || maxDataPointValue! < maxValuesMax) {
            maxDataPointValue = maxValuesMax;
            yAxisMaxValue = maxValuesMax;
          }
        }

        // Max aus den Punkten der range max Daten
        List<double?> minValues = linechartDataSerie.dataPoints.map((e) => e.minValue).toList();
        minValues.removeWhere((element) => element == null);

        if (minValues.isNotEmpty) {
          final minValuesMin = minValues.cast<double>().reduce(min);
          if (minDataPointValue == null || minDataPointValue! > minValuesMin) {
            minDataPointValue = minValuesMin;
            yAxisMinValue = minValuesMin;
          }
        }
      }
    }

    // Barchart Min-Max-Werte
    for (var barchartDataSerie in barchartDataSeries) {
      {
        // Alle Datenwerte  prüfen
        List<double?> values = barchartDataSerie.dataPoints.map((e) => e.value).toList();
        values.removeWhere((element) => element == null);

        if (values.isEmpty) {
          continue;
        }

        // check first
        if (!firstIsADoubleValue && values[0]! % 1 != 0) {
          firstIsADoubleValue = true;
        }

        // Min- und Max-Value herausfinden (Nulls beachten und ignorieren)
        final maxValueTmp = values.cast<double>().reduce(max);
        if (maxDataPointValue == null || maxDataPointValue! < maxValueTmp) {
          maxDataPointValue = maxValueTmp;
          yAxisMaxValue = maxValueTmp;
        }
        final minValueTmp = values.cast<double>().reduce(min);
        if (minDataPointValue == null || minDataPointValue! > minValueTmp) {
          minDataPointValue = minValueTmp;
          yAxisMinValue = minValueTmp;
        }
      }
    }

    // Soll unter- und oberhalb der Linie etwas Platz eingerechnet werden?
    if (yAxisConfig.addValuePadding) {
      // Es darf unten und oben etwas Platz gelassen werden- daher wird dynamisch etwas oben und unten dazugerechnet.
      // Liegt kein Wert unterhalb von und und ist die Differenz zu 0 im Vergleich zum Max -> obere Grenze kleiner,
      // wird unten immer bei 0 in der Y-Achsen-Skala angefangen
      var orgStep = ((maxDataPointValue! - minDataPointValue!) / (yAxisConfig.labelCount));

      var maxValueInt = (maxDataPointValue! + (orgStep)).toInt();
      var minValueInt = (minDataPointValue! - (orgStep)).toInt();
      int diff = maxValueInt - minValueInt;
      // tmpStep wird benötigt um Puffer zu addieren. Man könnte auch 10% vom Range nehmen..
      var tmpStep = ((diff / yAxisConfig.labelCount) + 1).toInt();

      if (yAxisConfig.minLabelValue != null && yAxisConfig.minLabelValue! < minDataPointValue!) {
        yAxisMinValue = yAxisConfig.minLabelValue;
      } else {
        yAxisMinValue = minValueInt.toDouble();

        // Wenn kein Wert unter 0 vorhanden ist kann Min auf 0 gesetzt werden
        // Für den Betrachter optisch besser.
        if (minDataPointValue! >= 0 && yAxisMinValue! < 0) {
          yAxisMinValue = 0;
        }
      }

      if (yAxisConfig.maxLabelValue != null && yAxisConfig.maxLabelValue! > maxDataPointValue!) {
        yAxisMaxValue = yAxisConfig.maxLabelValue;
      } else {
        // Der max-Value muss aus den ermittelten Steps berechnet werden
        yAxisMaxValue = yAxisMinValue! + (tmpStep * (yAxisConfig.labelCount - 1));

        // Manchmal kommt es vor, dass die Ermittlung des Puffers und des Steps zu gering ist
        // In diesem Fall muss die Step-Größe um eins erhöht werden um das max zu ermitteln
        if (yAxisMaxValue! < maxDataPointValue!) {
          tmpStep += 1;
          yAxisMaxValue = yAxisMinValue! + (tmpStep * (yAxisConfig.labelCount - 1));
        }
      }

      // Jetzt die Stepgröße nochmal berechnen
      yAxisSteps = ((yAxisMaxValue! - yAxisMinValue!) / (yAxisConfig.labelCount - 1));

      // Die Stepgröße soll ein int sein um keine krummen Zahlen auf der Y-Achse zu bekommen
      if (yAxisSteps % 1 != 0) {
        yAxisSteps = (yAxisSteps + 1).toInt().toDouble();
        yAxisMaxValue = yAxisMinValue! + (yAxisSteps * (yAxisConfig.labelCount - 1));
      }
    } else {
      // Der niedrigste
      // Daten punkt soll unten direkt auf der X-Achse liegen. Kein Puffer dazwischenrechnen
      yAxisSteps = ((maxDataPointValue! - minDataPointValue!) / (yAxisConfig.labelCount - 1));

      // Sonderfall: wenn zwischen min und Max die anzahl an möglichen Skalierungspunkten als ganze Zahlen
      // verwendet werden können, dann bekommt max oben ein bisschen padding
      var scalePotential = maxDataPointValue! / yAxisConfig.labelCount;
      if (scalePotential > 0) {
        yAxisSteps = (scalePotential + 1).toInt().toDouble();
        yAxisMaxValue = yAxisMinValue! + (yAxisSteps * (yAxisConfig.labelCount - 1));
      }
    }
  }

  void _drawColumnBottomBlocks({
    required ui.Canvas canvas,
    required double chartWidth,
    required double chartHeight,
    required List<CooLinechartDataSeries> linechartDataSeries,
    ChartColumnBlocks? columnBlocks,
  }) {
    if (columnBlocks == null || !columnBlocks.showBottomBlocks) {
      return;
    }

    final columnBottomDatasHeight = columnBlocks.bottomConfig.height.toDouble();
    final columnBottomDatas = columnBlocks.bottomDatas;

    // Wenn padding für die Legende verwendet werden soll kann angegben werden wie breit sie ist.
    double backgroundPaddingSize = columnBlocks.bottomConfig.backgroundColorPadding.toDouble();

    int xGridLineCount = maxAbsoluteValueCount;
    if (!centerDataPointBetweenVerticalGrid) {
      xGridLineCount -= 1;
    }
    double xOffsetInterval = chartWidth / (xGridLineCount);
    for (int i = 0; i < xGridLineCount; i++) {
      final columnLegend = columnBottomDatas[i];

      double x = (xOffsetInterval * i) + padding.left;
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      TextStyle textStyle;
      if (i == mouseInRectYIndex) {
        textStyle = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
      } else {
        textStyle = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        );
      }

      // Die letzte vertikale Linie muss bei Centered zusätzlich gezeichnet werden, das nächste Label allerdings
      // nicht, denn das wäre ein nicht vorhandener Datenpunkt zu viel
      if (!centerDataPointBetweenVerticalGrid || i != xGridLineCount) {
        // Hintergrundfarbe rendern
        if (columnLegend.backgroundColor != null) {
          final Paint columnLegendBackground = Paint()
            ..color = columnLegend.backgroundColor!
            ..strokeWidth = 0;

          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final rectX0 = x - (xOffsetInterval / 2) + backgroundPaddingSize;
          final rectY0 = chartHeight + padding.top.toDouble() - columnBottomDatasHeight + backgroundPaddingSize;
          final rectX1 = rectX0 + xOffsetInterval - (backgroundPaddingSize * 2);
          final rectY1 = rectY0 + columnBottomDatasHeight - (backgroundPaddingSize * 2);

          var rect = Rect.fromPoints(Offset(rectX0, rectY0), Offset(rectX1, rectY1));
          canvas.drawRect(rect, columnLegendBackground);
          // Wenn ein spezieller Mouse-Over Highlight benötigt wird kann das hier verwendet werden
          // if (mousePosition != null) {
          //   bool contains = rect.contains(Offset(mousePosition.dx, mousePosition.dy));
          //   if (contains) {
          //     if (highlightMouseColumn) {
          //       canvas.drawRect(rect, _backgroundRectHighlightPaint);
          //     }
          //     mouseInRectYIndex = i;
          //   }
          // } else {
          //   canvas.drawRect(rect, _backgroundRectPaint);
          // }
        }
        // Text rendern
        if (columnLegend.text != null) {
          _columLegendTextPainter.text = TextSpan(text: columnLegend.text, style: textStyle);
          _columLegendTextPainter.layout();

          // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
          final xPosCenter = (xOffsetInterval / 2) - (_columLegendTextPainter.width / 2);
          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final xPos = x - (xOffsetInterval / 2) + xPosCenter;

          // Center ist höhe der fläche / 2 + höhe des textes / 2
          final double yPosCenter = (columnBottomDatasHeight / 2) + (_columLegendTextPainter.height / 2);
          final yPos = chartHeight + padding.top.toDouble() - yPosCenter;

          _columLegendTextPainter.paint(canvas, Offset(xPos, yPos));
        }

        // Asset Image rendern, sofern angegeben und als Bild vorhanden
        if (columnLegend.assetImages.isNotEmpty) {
          assetImageLoop:
          for (var blockAssetImage in columnLegend.assetImages) {
            final ui.Image? image = columLegendsAssetImages[blockAssetImage.path];
            if (image == null) {
              continue assetImageLoop;
            }

            // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
            final xPosCenter = (xOffsetInterval / 2) - (image.width / 2);
            // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
            final xPos = x - (xOffsetInterval / 2) + xPosCenter;

            // Center ist höhe der fläche / 2 + höhe des textes / 2
            final double yPosCenter = (columnBottomDatasHeight / 2) + (image.height / 2);
            final yPos = chartHeight + padding.top.toDouble() - yPosCenter - blockAssetImage.offsetTop;

            // Es ist aktuell nicht möglich ein SVG zu positionieren oder in der Größe zu verändern.
            // Deswegen wird das schlechtere von SVG zu PNG transformierte Bild gezeichnet
            // canvas.drawPicture(columLegendsAssetSvgPictureInfos[blockAssetImage.path]!.picture);

            canvas.drawImage(image, Offset(xPos, yPos), Paint());
          }
        }
      }
    }
  }
}
