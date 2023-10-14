// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:coo_charts/linechart_data_point.dart';
import 'package:coo_charts/linechart_data_serie.dart';
import 'package:coo_charts/linechart_widget.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartPainter extends CustomPainter {
  LineChartPainter({
    required this.linechartDataSeries,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.curvedLine,
    required this.mousePosition,
    required this.crosshair,
    required this.showGridHorizontal,
    required this.showGridVertical,
    required this.highlightMouseColumn,
    required this.highlightPoints,
    required this.highlightPointsVerticalLine,
    required this.highlightPointsHorizontalLine,
    required this.xAxisConfig,
    required this.centerDataPointBetweenVerticalGrid,
    required this.yAxisConfig,
  }) {
    chartWidth = canvasWidth - paddingLeft - paddingRight;
    chartHeight = canvasHeight - paddingBottom - paddingTop;

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

  final List<LinechartDataSeries> linechartDataSeries;
  final double canvasHeight;
  final double canvasWidth;
  final Offset? mousePosition; // Position des Mauszeigers - wird für das Fadenkreuz benötigt (interne Variable)

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
  final int paddingLeft = 100;
  final int paddingRight = 100;
  final int paddingTop = 50;
  final int paddingBottom = 50;

  double chartWidth = 0.0;
  double chartHeight = 0.0;

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

// Hält alle Punkte die zu einer Axe Vertikal liegen. Das rect bestimmt den Maus-Hover-Bereich
  int mouseInRectYIndex = -1;
  final Map<int, Offset> datapointsOnYRect = {};
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

  var dataLabelTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  void paint(Canvas canvas, Size size) {
    /// Chart canvas size to draw on

    _drawAxis(
      canvas: canvas,
      chartWidth: chartWidth,
      height: canvasHeight,
      showYAxis: yAxisConfig.showAxis,
      showXAxis: xAxisConfig.showAxis,
    );

    // Malt das Grid und setzt den Index welche Column für die darüberliegende Maus
    // gerade aktiv ist.
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
      linechartDataSeries: linechartDataSeries,
    );
    _drawYAxisLabelAndHorizontalGridLine(
      canvas: canvas,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      linechartDataSeries: linechartDataSeries,
    );

    _drawDataPointsAndLine(
      canvas: canvas,
      chartWidth: chartWidth,
      chartHeigt: chartHeight,
      mousePosition: mousePosition,
      linechartDataSeries: linechartDataSeries,
    );

    if (crosshair) {
      _drawCrosshair(canvas: canvas, chartHeight: chartHeight, chartWidth: chartWidth, mousePosition: mousePosition);
    }
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    return mousePosition != oldDelegate.mousePosition;
  }

  void _drawDataPointsAndLine({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required Offset? mousePosition,
    required List<LinechartDataSeries> linechartDataSeries,
  }) {
    // Die Segment-width muss über alle vorhandenen Datenpunkte aller Reihen berechnet werden.
    for (var i = 0; i < linechartDataSeries.length; i++) {
      LinechartDataSeries localLinechartDataSeries = linechartDataSeries[i];
      List<String?> dataSeriesLabels = List.empty(growable: true);
      List<double?> dataPointValues = localLinechartDataSeries.dataPoints.map((e) => e.value).toList();
      List<double?> dataSeriesNormalizedValues = _normalizeChartDataPoints(dataPointValues);

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
        if (localLinechartDataSeries.showDataLabels) {
          var dataPoint = localLinechartDataSeries.dataPoints[i];
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

        double x;
        if (i == 0) {
          x = 0.0 + paddingLeft;
        } else {
          x = (i * xSegmentWidth) + paddingLeft;
        }
        if (centerDataPointBetweenVerticalGrid) {
          x += xSegementWidthHalf; // add center offset
        }

        final y = (canvasHeight - paddingTop - paddingBottom) -
            (dataValue * (canvasHeight - paddingTop - paddingBottom)) +
            paddingTop;

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
        datapointsOnYRect[i] = chartPoint;

        lastX = x;
        lastY = y;
      }

      // Linechart Min- & Max-Area malen
      if (localLinechartDataSeries.showMinMaxArea) {
        _drawArea(
          canvas: canvas,
          chartWidth: chartWidth,
          chartHeigt: chartHeigt,
          dataSeries: localLinechartDataSeries,
          minMaxPoints: localLinechartDataSeries.dataPoints,
          mousePosition: mousePosition,
        );
      }
      // Linechart Verbindungsline malen
      if (localLinechartDataSeries.showDataLine) {
        if (localLinechartDataSeries.dataLineColor != null) {
          _linePaint.color = localLinechartDataSeries.dataLineColor!;

          // Falls die Linefarbe angegeben wurde wird diese als default für die Datenpunkte, Highlight und Font gesetzt.
          _pointPaint.color = localLinechartDataSeries.dataLineColor!;
          _pointPaintHighlight.color = localLinechartDataSeries.dataLineColor!;
          dataLabelTextStyle = dataLabelTextStyle.copyWith(color: localLinechartDataSeries.dataLineColor!);
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

      // check individual font color
      if (localLinechartDataSeries.dataLabelColor != null) {
        dataLabelTextStyle = dataLabelTextStyle.copyWith(color: localLinechartDataSeries.dataLabelColor!);
      }

      // Linechart Datenpunkte malen
      drawLineDataPointsLoop:
      for (var i = 0; i < lineDataPoints.length; i++) {
        Offset? dataPointOffset = lineDataPoints[i];
        if (dataPointOffset == null) {
          // gibt nichts zu sehen..
          continue drawLineDataPointsLoop;
        }
        if (highlightPoints && mouseInRectYIndex == i) {
          canvas.drawCircle(dataPointOffset, 8, _pointPaintHighlight);
        } else if (localLinechartDataSeries.showDataPoints) {
          canvas.drawCircle(dataPointOffset, 4, _pointPaint);
        }

        if (localLinechartDataSeries.showDataLabels) {
          String? label = dataSeriesLabels[i];
          if (label != null) {
            _dataLabelPainter.text = TextSpan(text: label, style: dataLabelTextStyle);
            _dataLabelPainter.layout();
            // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
            var xPosCenter = (dataPointOffset.dx) - (_dataLabelPainter.width / 2);
            var yPos = dataPointOffset.dy - 20;
            _dataLabelPainter.paint(canvas, Offset(xPosCenter, yPos));
          }
        }
      }
    }
  }

  void _drawArea({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required Offset? mousePosition,
    required LinechartDataSeries dataSeries,
    required List<LineChartDataPoint> minMaxPoints,
  }) {
    // Min- Max-Datenpunkte in eine Reihe bringen um eine Form zu bilden
    List<double?> minPoints = minMaxPoints.map((e) => e.minValue).toList();
    List<double?> maxPoints = minMaxPoints.map((e) => e.maxValue).toList();

    // Alle hintereinander ergibt das custom paint path die zweite reihe reversed,
    // damit es einen ordentlichen Kreis ergib

    List<double?> minPointsNormalized = _normalizeChartDataPoints(minPoints);
    List<double?> maxPointsNormalized = _normalizeChartDataPoints(maxPoints);

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
        x = 0.0 + paddingLeft;
      } else {
        x = (i * xSegmentWidth) + paddingLeft;
      }
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      final y = (canvasHeight - paddingTop - paddingBottom) -
          (dataValue * (canvasHeight - paddingTop - paddingBottom)) +
          paddingTop;

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
      datapointsOnYRect[i] = chartPoint;

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
        x = 0.0 + paddingLeft;
      } else {
        x = (i * xSegmentWidth) + paddingLeft;
      }
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      final y = (canvasHeight - paddingTop - paddingBottom) -
          (dataValue * (canvasHeight - paddingTop - paddingBottom)) +
          paddingTop;

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
      datapointsOnYRect[i] = chartPoint;

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
    required List<LinechartDataSeries> linechartDataSeries,
  }) {
    mouseInRectYIndex = -1; // Reset

    // das erste und das letzte Rect sind nur halb so groß, wenn der Punkt direkt bei 0 auf der Y-Achse liegt
    for (var i = 0; i < maxAbsoluteValueCount; i++) {
      var x1 = (i * xSegmentWidth) + paddingLeft - xSegementWidthHalf;
      var y1 = paddingTop.toDouble();

      var x2 = (i * xSegmentWidth) + xSegmentWidth + paddingLeft - xSegementWidthHalf;
      var y2 = paddingTop + chartHeigt;

      // Erster und letzter Datenpunkt sind nur halb zu sehen
      if (i == 0 && !centerDataPointBetweenVerticalGrid) {
        x1 = 0 + paddingLeft.toDouble();
        x2 = xSegementWidthHalf + paddingLeft.toDouble();
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
    var rectangle = Rectangle(paddingLeft, paddingTop, chartWidth, chartHeight);
    bool containsPoint = rectangle.containsPoint(Point(mousePosition.dx, mousePosition.dy));
    if (!containsPoint) {
      return;
    }

    // Crosshair malen
    canvas.drawLine(
      Offset(mousePosition.dx, paddingTop.toDouble()),
      Offset(mousePosition.dx, chartHeight + paddingTop),
      _mousePositionPaint,
    );
    canvas.drawLine(
      Offset(paddingLeft.toDouble(), mousePosition.dy),
      Offset(chartWidth + paddingLeft, mousePosition.dy),
      _mousePositionPaint,
    );

    // MousePointer-Punkt
    canvas.drawCircle(mousePosition, 5, _mousePositionPaint);
  }

  /// Draw both (x and y) lines.
  void _drawAxis({
    required Canvas canvas,
    required double chartWidth,
    required double height,
    required bool showYAxis,
    required bool showXAxis,
  }) {
    if (showXAxis) {
      canvas.drawLine(
        Offset(paddingLeft.toDouble(), height - paddingBottom),
        Offset(chartWidth + paddingLeft, height - paddingBottom),
        _axisPaint,
      );
    }

    if (showYAxis) {
      canvas.drawLine(
        Offset(paddingLeft.toDouble(), paddingTop.toDouble()),
        Offset(paddingLeft.toDouble(), height - paddingBottom),
        _axisPaint,
      );
    }
  }

  /// Malt die Y-Achse, alle Y-Linien der Datenpunkte und die Labels in der Breite des Charts
  ///
  /// Labels können unter und über dem Chart gemalt werden.
  /// Definiert wird das durch [xAxisConfig.topValueType] und [xAxisConfig.bottomValueType].
  void _drawXAxisLabelAndVerticalGridLine({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeight,
    required List<LinechartDataSeries> linechartDataSeries,
  }) {
    int xGridLineCount = maxAbsoluteValueCount;
    if (!centerDataPointBetweenVerticalGrid) {
      xGridLineCount -= 1;
    }
    double xOffsetInterval = chartWidth / (xGridLineCount);
    double xBottomPos = chartHeight + paddingTop;

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
      double x = (xOffsetInterval * i) + paddingLeft;
      double xVerticalGridline = x;
      if (centerDataPointBetweenVerticalGrid) {
        x += xSegementWidthHalf; // add center offset
      }

      // Don't draw the first vertical grid line because there is already the y-Axis line
      if (i != 0 && showGridVertical) {
        canvas.drawLine(
            Offset(xVerticalGridline, paddingTop.toDouble()), Offset(xVerticalGridline, xBottomPos), _gridPaint);
      }

      // draw highlight vertical line on mouse-over
      if (highlightPointsVerticalLine && i != 0 && i == mouseInRectYIndex) {
        canvas.drawLine(Offset(x, paddingTop.toDouble()), Offset(x, xBottomPos), _highlightLinePaint);
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

        startNumber++;

        if (xAxisConfig.showTopLabels) {
          _axisLabelPainter.text = TextSpan(text: topLabel, style: textStyle);
          _axisLabelPainter.layout();
          // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
          final xPosCenter = (xOffsetInterval / 2) - (_axisLabelPainter.width / 2);
          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final xPos = x - (xOffsetInterval / 2) + xPosCenter;
          _axisLabelPainter.paint(canvas, Offset(xPos, paddingTop.toDouble() - 25));
        }

        if (xAxisConfig.showBottomLabels) {
          _axisLabelPainter.text = TextSpan(text: bottomLabel, style: textStyle);
          _axisLabelPainter.layout();
          // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
          final xPosCenter = (xOffsetInterval / 2) - (_axisLabelPainter.width / 2);
          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final xPos = x - (xOffsetInterval / 2) + xPosCenter;
          _axisLabelPainter.paint(canvas, Offset(xPos, chartHeight + paddingTop + 10));
        }
      }
    }
  }

  void _drawYAxisLabelAndHorizontalGridLine({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeight,
    required List<LinechartDataSeries> linechartDataSeries,
    bool showYAxisLables = true,
  }) {
    final double yOffsetInterval = chartHeight / (yAxisConfig.labelCount - 1);

    for (int i = 0; i < yAxisConfig.labelCount; i++) {
      double y = chartHeight - (i * yOffsetInterval) + paddingTop;

      // // Don't draw the first horizontal grid line because there is already the x-Axis line
      if (i != 0 && showGridHorizontal) {
        canvas.drawLine(Offset(paddingLeft.toDouble(), y), Offset(chartWidth + paddingLeft, y), _gridPaint);
      }

      // Draw Y-axis scale points
      var yAxisLabelValue = (i * yAxisSteps + yAxisMinValue!);
      late String label;
      if (yAxisLabelValue is int) {
        label = yAxisLabelValue.toInt().toString();
      } else {
        label = yAxisLabelValue.toStringAsFixed(2);
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
        _axisLabelPainter.paint(canvas, Offset(paddingLeft - 35, y - _axisLabelPainter.height / 2));
      }
    }
  }

  /// Alle Chart-Punkte auf einen Wert zwischen 0.0 und 1.0 bringen. So wird später die Position
  /// relativ zur 100% Fläche berechnet.
  List<double?> _normalizeChartDataPoints(List<double?> linechartDataPoints) {
    if (linechartDataSeries.isEmpty) {
      return List.empty();
    }

    /// Falls es Werte im negativen Bereich gibt müssen diese Werte für die Normalisierung alle
    /// in den positiven Wertebereich gebracht werden.
    var minDataPointDiff = 0.0;
    if (yAxisMinValue! < 0) {
      minDataPointDiff = yAxisMinValue!.abs();
    }

    // Falls der kleinste Wert > 0 ist müssen alle Punkte um diesen Wert verringert werden.
    // Aber nur, wenn es nicht mit padding ausgespielt wird
    double valueOverZeroDiff = 0.0;
    if (!yAxisConfig.addValuePadding) {
      valueOverZeroDiff = minDataPointValue! > 0 ? yAxisMinValue! : 0;
    }

    var maxDataPoint =
        yAxisMaxValue! + minDataPointDiff - valueOverZeroDiff; // negativen Ausgleich addieren, falls vorhanden

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
    }

    // Die absolute Anzahl an Datenpunkten ist die Länge des Sets
    maxAbsoluteValueCount = allDateTimesTmp.length;

    // Alle Datenpunkte in eine sortierte Liste packen
    allDateTimeXAxisValues.addAll(allDateTimesTmp);
    allDateTimeXAxisValues.sort((a, b) => a.compareTo(b));
  }

  /// Initialisiert die Rahmendaten anhand der übergebenen Werte numerisch
  void _initializeNumberLineChartValues() {
    for (var linechartDataSerie in linechartDataSeries) {
      if (linechartDataSerie.dataPoints.length > maxAbsoluteValueCount) {
        maxAbsoluteValueCount = linechartDataSerie.dataPoints.length;
      }
    }
  }

  void _initializeValues() {
    // Prüfen ob der erste Wert ein double ist, falls ja und wenn nicht padding eingebaut werden soll sind die Steps
    // double Werte. Sind es nur int Values als erste Werte werden immer ints als Range angeben.
    bool firstIsADoubleValue = false;

    for (var linechartDataSerie in linechartDataSeries) {
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

        // Wenn kei Wert unter 0 vorhanden ist kann Min auf 0 gesetzt werden - für den Betrachter optisch besser
        if (minDataPointValue! >= 0) {
          if (yAxisMinValue! < 0) {
            yAxisMinValue = 0;
          }
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
}
