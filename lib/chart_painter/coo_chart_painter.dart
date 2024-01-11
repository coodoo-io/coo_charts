// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/chart_tab_info.dart';
import 'package:coo_charts/common/coo_chart_color_scheme.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/common/coo_chart_constants.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/coo_chart_type.enum.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';
import 'package:coo_charts/extensions/iterable.extension.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CooChartPainter extends CustomPainter {
  CooChartPainter({
    required this.chartConfig,
    required this.colorScheme,
    required this.metadata,
    required this.metadataOpposite,
    required this.chartType,
    required this.linechartDataSeries,
    required this.barchartDataSeries,
    this.columnBlocks,
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
    required this.yAxisOppositeConfig,
    required this.padding,
    required this.columLegendsAssetImages,
    required this.columLegendsAssetSvgPictureInfos,
    this.onLineChartDataPointTabCallback,
    this.onBarChartDataPointTabCallback,
    this.xAxisStepLineTopLabelLineChartCallback,
    this.xAxisStepLineBottomLabelLineChartCallback,
    this.xAxisStepLineTopLabelBarChartCallback,
    this.xAxisStepLineBottomLabelBarChartCallback,
  });

  final ChartConfig chartConfig;
  final ChartPainterMetadata metadata;
  final ChartPainterMetadata? metadataOpposite;
  final CooChartType chartType;

  final CooChartColorScheme colorScheme;

  final List<CooLineChartDataSeries> linechartDataSeries;
  final List<CooBarChartDataSeries> barchartDataSeries;

  final ChartColumnBlocks? columnBlocks;
  final Map<String, ui.Image> columLegendsAssetImages;
  final Map<String, PictureInfo> columLegendsAssetSvgPictureInfos;

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
  final YAxisConfig? yAxisOppositeConfig;
  final XAxisConfig xAxisConfig;

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  final bool centerDataPointBetweenVerticalGrid;

  Function(int, List<CooLineChartDataPoint>)? onLineChartDataPointTabCallback;
  Function(int, List<CooBarChartDataPoint>)? onBarChartDataPointTabCallback;

// Hält alle Punkte die zu einer Axe Vertikal liegen. Das rect bestimmt den Maus-Hover-Bereich
  int mouseInRectYIndex = -1; // In welchem Y-Index befindet sich die Maus gerade?

  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineTopLabelLineChartCallback;
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineBottomLabelLineChartCallback;
  final String Function(int, List<CooBarChartDataPoint>)? xAxisStepLineTopLabelBarChartCallback;
  final String Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomLabelBarChartCallback;

  final Map<Rect, int> chartRectYPos = {}; // Merken welches Rect bei welcher Y-Pos liegt

  final Paint _highlightLinePaint = Paint()
    ..color = Colors.white.withOpacity(0.7)
    ..strokeWidth = 1;

  final Paint _mousePositionPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 1;

  final TextPainter _axisLabelPainter = TextPainter(
    textAlign: TextAlign.left,
    textDirection: ui.TextDirection.ltr,
  );

  final TextPainter _columLegendTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: ui.TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    /// Chart canvas size to draw on

    CooChartPainterUtil.drawCanvasAndAxis(
      canvas: canvas,
      colorScheme: colorScheme,
      padding: padding,
      canvasWidth: metadata.canvasWidth,
      canvasHeight: metadata.canvasHeight,
      showYAxis: yAxisConfig.showAxis,
      showXAxis: xAxisConfig.showAxis,
      showFullRect: true,
    );

    // Berechnet die Spalten für alle Datenpunkte und setzt den Index welche Column für die
    // darüberliegende Maus gerade aktiv ist.
    _drawBackgroundRect(
      canvas: canvas,
      colorScheme: colorScheme,
      chartWidth: metadata.chartWidth,
      chartHeigt: metadata.chartHeight,
      mousePosition: mousePosition,
      linechartDataSeries: linechartDataSeries,
    );

    _drawXAxisLabelAndVerticalGridLine(
      canvas: canvas,
      colorScheme: colorScheme,
      chartWidth: metadata.chartWidth,
      chartHeight: metadata.chartHeight,
    );

    CooChartPainterUtil.drawYAxisHorizontalGridLine(
      canvas: canvas,
      colorScheme: colorScheme,
      config: chartConfig,
      metadata: metadata,
      yAxisConfig: yAxisConfig,
      columnBlocks: columnBlocks,
      showGridHorizontal: showGridHorizontal,
      padding: padding,
      axisLabelPainter: _axisLabelPainter,
      opposite: false,
    );
    if (yAxisOppositeConfig != null && metadataOpposite != null) {
      CooChartPainterUtil.drawYAxisHorizontalGridLine(
        canvas: canvas,
        colorScheme: colorScheme,
        config: chartConfig,
        metadata: metadataOpposite!,
        yAxisConfig: yAxisOppositeConfig!,
        columnBlocks: columnBlocks,
        showGridHorizontal: showGridHorizontal,
        padding: padding,
        axisLabelPainter: _axisLabelPainter,
        opposite: true,
      );
    }

    _drawColumnBlocks(
      canvas: canvas,
      chartWidth: metadata.chartWidth,
      chartHeight: metadata.chartHeight,
      linechartDataSeries: linechartDataSeries,
      columnBlocks: columnBlocks,
    );

    if (chartType == CooChartType.line) {
      CooChartPainterUtil.drawDataLinechartDataPointsAndPath(
        metadata: metadata,
        padding: padding,
        centerDataPointBetweenVerticalGrid: centerDataPointBetweenVerticalGrid,
        curvedLine: curvedLine,
        highlightPoints: highlightPoints,
        mouseInRectYIndex: mouseInRectYIndex,
        linechartDataSeries: linechartDataSeries.where((element) => element.opposite == false).toList(),
        columnBlocks: columnBlocks,
        canvas: canvas,
        mousePosition: mousePosition,
      );
    }
    if (metadataOpposite != null) {
      if (chartType == CooChartType.line) {
        CooChartPainterUtil.drawDataLinechartDataPointsAndPath(
          metadata: metadataOpposite!,
          padding: padding,
          centerDataPointBetweenVerticalGrid: centerDataPointBetweenVerticalGrid,
          curvedLine: curvedLine,
          highlightPoints: highlightPoints,
          mouseInRectYIndex: mouseInRectYIndex,
          linechartDataSeries: linechartDataSeries.where((element) => element.opposite == true).toList(),
          columnBlocks: columnBlocks,
          canvas: canvas,
          mousePosition: mousePosition,
        );
      }
    }
    if (chartType == CooChartType.bar) {
      _drawDataBarchartBars(
        barchartDataSeries: barchartDataSeries,
        columnBlocks: columnBlocks,
        canvas: canvas,
        chartWidth: metadata.chartWidth,
        chartHeigt: metadata.chartHeight,
        mousePosition: mousePosition,
        minDataPointValue: metadata.minDataPointValue,
        yAxisConfig: yAxisConfig,
        yAxisMaxValue: metadata.yAxisMaxValue,
        yAxisMinValue: metadata.yAxisMinValue,
        padding: padding,
        xSegmentWidth: metadata.xSegmentWidth,
        xSegementWidthHalf: metadata.xSegementWidthHalf,
      );
    }

    if (crosshair) {
      _drawCrosshair(
        canvas: canvas,
        chartHeight: metadata.chartHeight,
        chartWidth: metadata.chartWidth,
        mousePosition: mousePosition,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CooChartPainter oldDelegate) {
    return mousePosition != oldDelegate.mousePosition;
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
    required List<CooBarChartDataSeries> barchartDataSeries,
    ChartColumnBlocks? columnBlocks,
  }) {
    bool showColumnBottomDatas = false;
    double bottomColumnHeight = 0;
    bool showColumnTopDatas = false;
    double topColumnHeight = 0;
    if (columnBlocks != null) {
      showColumnBottomDatas = columnBlocks.showBottomBlocks && columnBlocks.bottomDatas.isNotEmpty;
      if (showColumnBottomDatas) {
        bottomColumnHeight = columnBlocks.bottomConfig.height.toDouble();
      }

      showColumnTopDatas = columnBlocks.showTopBlocks && columnBlocks.topDatas.isNotEmpty;
      if (showColumnTopDatas) {
        topColumnHeight = columnBlocks.topConfig.height.toDouble();
      }
    }

    final int dataSeriesCount = barchartDataSeries.length;
    // Die Segment-width muss über alle vorhandenen Datenpunkte aller Reihen berechnet werden.
    for (var i = 0; i < dataSeriesCount; i++) {
      CooBarChartDataSeries localLinechartDataSeries = barchartDataSeries[i];
      List<String?> dataSeriesLabels = List.empty(growable: true);

      // Alle Punkte auf einen Bereich zwischen 0.0 und 1.0 bringen um sie in der Fläche relativ berechnen zu können
      List<double?> dataPointValues = localLinechartDataSeries.dataPoints.map((e) => e.value).toList();
      List<double?> dataSeriesNormalizedValues = CooChartPainterUtil.normalizeChartDataPoints(
        linechartDataPoints: dataPointValues,
        minDataPointValue: minDataPointValue,
        yAxisMinValue: yAxisMinValue,
        yAxisMaxValue: yAxisMaxValue,
      );

      List<double?> dataPointMaxValues = localLinechartDataSeries.dataPoints.map((e) => e.maxValue).toList();
      List<double?> maxPointsNormalized = CooChartPainterUtil.normalizeChartDataPoints(
        linechartDataPoints: dataPointMaxValues,
        minDataPointValue: minDataPointValue,
        yAxisMinValue: yAxisMinValue,
        yAxisMaxValue: yAxisMaxValue,
      );

      List<double?> dataPointMinalues = localLinechartDataSeries.dataPoints.map((e) => e.minValue).toList();
      List<double?> minPointsNormalized = CooChartPainterUtil.normalizeChartDataPoints(
        linechartDataPoints: dataPointMinalues,
        minDataPointValue: minDataPointValue,
        yAxisMinValue: yAxisMinValue,
        yAxisMaxValue: yAxisMaxValue,
      );

      final Color barColor =
          localLinechartDataSeries.barColor ?? CooChartConstants().getColorShemas()[i].dataPointColor;
      final Paint barPaint = Paint()
        ..color = barColor
        ..strokeWidth = 1;

      final Color barColorHighlight =
          localLinechartDataSeries.barColor ?? CooChartConstants().getColorShemas()[i].dataPointHighlightColor;
      final Paint barHightlightPaint = Paint()
        ..color = barColorHighlight
        ..strokeWidth = 1;

      final Color minMaxRangeLineColor =
          localLinechartDataSeries.minMaxLineColor ?? CooChartConstants().getColorShemas()[i].minMaxRangeColor;
      final Paint minMaxRangePaint = Paint()
        ..color = minMaxRangeLineColor
        ..strokeWidth = 1;

      for (var j = 0; j < dataSeriesNormalizedValues.length; j++) {
        // Lables für den späteren plotten parsen
        CooBarChartDataPoint dataPoint = localLinechartDataSeries.dataPoints[j];
        if (localLinechartDataSeries.showDataLabels) {
          if (dataPoint.label != null) {
            dataSeriesLabels.add(dataPoint.label!.trim());
          } else if (dataPoint.value != null) {
            dataSeriesLabels.add(dataPoint.value.toString());
          } else {
            dataSeriesLabels.add(null);
          }
        }

        // Vorberechneter X-Wert, der dann für das Bar oder die Linie angepasst werden muss
        // Mittiger X-Wert anhand der Positon der gerade durchlaufenden Data Point
        // Wenn mehrere BarChart Serien vorhanden sind teilen sie sich den Platz und die X-Pos verändert sich
        // entsprechend der Anzahl
        double x;
        if (j == 0) {
          x = 0.0 + padding.left;
        } else {
          x = (j * xSegmentWidth) + padding.left;
        }
        final multipleBarchartSegmentWidth = xSegmentWidth * 0.12; // Extra Space von links und rechts in einem Segment
        final multipleSegmentWidth =
            (xSegmentWidth - multipleBarchartSegmentWidth) / (dataSeriesCount); // Mögliche Gesamtbreite für jeden bar
        // Verschieben um die serienanzahl der breite -> z.B. 3. Serie muss direkt um 2 * bar-segment-breite verschoben werden
        // anschließend um die hälfte verschieben, dann ist der bar in der mitte
        // Dann nochmal um den angepassten platz für das gesamte segment aller bars verschieben
        x += (i * multipleSegmentWidth) + (multipleSegmentWidth / 2) + (multipleBarchartSegmentWidth / 2);

        final startYPos = metadata.canvasHeight - padding.bottom - padding.top - bottomColumnHeight - topColumnHeight;
        final dataValue = dataSeriesNormalizedValues[j];
        if (dataValue != null) {
          // Berechnen der Position zum Plotten der Linie
          final y = startYPos - (dataValue * (startYPos)) + padding.top + topColumnHeight;

          /// Pos(x0,y0) - Pos(x1,y0)
          ///     |                |
          ///     |                |
          ///     |                |
          ///     |                |
          ///     |                |
          /// Pos(x0,y1)  -  Pos(x1,y1)

          // Durch die X-Verschiebung des Punktes ist die Hälfte des Segments die komplette Breite eines Segments
          // in der Berechnung
          var barWidth = xSegementWidthHalf * 0.66; // Default Bar Breite soll 2/3 des Spaltenplaztes einnehmen
          if (localLinechartDataSeries.maxBarWidth != null && barWidth > localLinechartDataSeries.maxBarWidth!) {
            barWidth = localLinechartDataSeries.maxBarWidth!.toDouble();
          }
          if (dataSeriesCount > 1) {
            // Breite muss sich durch die Anzahl der Serien aufteilen
            barWidth = xSegementWidthHalf / dataSeriesCount * 0.66;
          }
          if (localLinechartDataSeries.barWidth != null) {
            barWidth = localLinechartDataSeries.barWidth!.toDouble();
          }
          double x0 = x - barWidth;
          double y0 = y;
          double x1 = x + barWidth;
          double y1 = startYPos + padding.top + topColumnHeight;

          if (localLinechartDataSeries.barHeight != null) {
            // Ist eigentlich ein Candle-Stick-Chart
            // TODO move to candle sti
            //ck chart
            y0 = y0 - (localLinechartDataSeries.barHeight!.toDouble() / 2);
            y1 = y0 + localLinechartDataSeries.barHeight!.toDouble();
          }

          var rect = Rect.fromPoints(Offset(x0, y0), Offset(x1, y1));

          bool mouseOverBarHiglight = false;
          if (mousePosition != null) {
            bool contains = rect.contains(Offset(mousePosition.dx, mousePosition.dy));
            mouseOverBarHiglight = contains && highlightMouseColumn;
          }

          if (mouseOverBarHiglight) {
            canvas.drawRect(rect, barHightlightPaint);
          } else {
            canvas.drawRect(rect, barPaint);
          }
        }

        /// Draw Min-Max-Range Line
        ///
        /// ----- (Max)
        ///   |
        ///   |
        ///   |
        ///   |
        /// ----- (Min)
        if (dataPoint.minValue != null && dataPoint.maxValue != null) {
          // Der normalisierte Wert muss da sein, weil der min und max Wert nicht null sind
          // Horizontale Linie für MAX
          double maxDataValue = maxPointsNormalized[j]!;
          final yMax = startYPos - (maxDataValue * (startYPos)) + padding.top;
          double xMax0 = x - (xSegementWidthHalf / 3);
          double yMax0 = yMax + topColumnHeight;
          double xMax1 = x + (xSegementWidthHalf / 3);
          double yMax1 = yMax + topColumnHeight;
          canvas.drawLine(Offset(xMax0, yMax0), Offset(xMax1, yMax1), minMaxRangePaint);

          // Horizontale Linie für MIN
          double minDataValue = minPointsNormalized[j]!;
          final yMin = startYPos - (minDataValue * (startYPos)) + padding.top;
          double xMin0 = x - (xSegementWidthHalf / 3);
          double yMin0 = yMin + topColumnHeight;
          double xMin1 = x + (xSegementWidthHalf / 3);
          double yMin1 = yMin + topColumnHeight;
          canvas.drawLine(Offset(xMin0, yMin0), Offset(xMin1, yMin1), minMaxRangePaint);

          // Linie von Min zu Max
          double xLinie0 = x;
          double yLinie0 = yMax + topColumnHeight;
          double xLinie1 = x;
          double yLinie1 = yMin + topColumnHeight;
          canvas.drawLine(Offset(xLinie0, yLinie0), Offset(xLinie1, yLinie1), minMaxRangePaint);
        }
      }
    }
  }

  ///
  void _drawBackgroundRect({
    required Canvas canvas,
    required CooChartColorScheme colorScheme,
    required double chartWidth,
    required double chartHeigt,
    required Offset? mousePosition,
    required List<CooLineChartDataSeries> linechartDataSeries,
  }) {
    mouseInRectYIndex = -1; // Reset

    final Paint backgroundRectHighlightPaint = Paint()
      ..color = colorScheme.columnHighlightColor
      ..strokeWidth = 0;

    // das erste und das letzte Rect sind nur halb so groß, wenn der Punkt direkt bei 0 auf der Y-Achse liegt
    for (var i = 0; i < metadata.maxAbsoluteValueCount; i++) {
      var x1 = (i * metadata.xSegmentWidth) + padding.left - metadata.xSegementWidthHalf;
      var y1 = padding.top.toDouble();

      var x2 = (i * metadata.xSegmentWidth) + metadata.xSegmentWidth + padding.left - metadata.xSegementWidthHalf;
      var y2 = padding.top + chartHeigt;

      // Erster und letzter Datenpunkt sind nur halb zu sehen
      if (i == 0 && !centerDataPointBetweenVerticalGrid) {
        x1 = 0 + padding.left.toDouble();
        x2 = metadata.xSegementWidthHalf + padding.left.toDouble();
      }

      if (centerDataPointBetweenVerticalGrid) {
        x1 += metadata.xSegementWidthHalf; // add center offset
        x2 += metadata.xSegementWidthHalf; // add center offset
      }

      var rect = Rect.fromPoints(Offset(x1, y1), Offset(x2, y2));

      // Falls es sich um ein Barchart handelt kann auch nur dieser "bar" gehighlightet werden.
      if (metadata.barChartDataPointsByColumnIndex[i] != null) {
        List<CooBarChartDataPoint> barchartDataPoints = metadata.barChartDataPointsByColumnIndex[i]!;
        // get first background color, if available
        final dataPoint = barchartDataPoints.firstWhereOrNull((element) => element.columnBackgroundColor != null);
        if (dataPoint != null) {
          final Paint columnBackgroundColor = Paint()
            ..color = dataPoint.columnBackgroundColor!
            ..strokeWidth = 0;
          canvas.drawRect(rect, columnBackgroundColor);
        }
      }

      // Tab Callback der gesamten Spalte
      if (chartTabInfo.tabDownDetails != null) {
        final tabDownDetails = chartTabInfo.tabDownDetails!;
        bool contains = rect.contains(Offset(tabDownDetails.localPosition.dx, tabDownDetails.localPosition.dy));
        if (contains) {
          canvas.drawRect(rect, backgroundRectHighlightPaint);
          // invoke callbacks, but only once a time on a column
          if (chartTabInfo.tabCount != chartTabInfo.tabCountCallbackInvocation) {
            chartTabInfo.tabCountCallbackInvocation = chartTabInfo.tabCountCallbackInvocation + 1;

            // Linechart callback
            if (chartType == CooChartType.line && onLineChartDataPointTabCallback != null) {
              final selectedDataPoints = metadata.lineChartDataPointsByColumnIndex[i] ?? List.empty(growable: false);
              if (metadataOpposite != null && metadataOpposite!.lineChartDataPointsByColumnIndex[i] != null) {
                selectedDataPoints.addAll(metadataOpposite!.lineChartDataPointsByColumnIndex[i]!);
              }
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                onLineChartDataPointTabCallback!(i, selectedDataPoints);
              });
            }

            // Barchchart callback
            if (chartType == CooChartType.bar && onBarChartDataPointTabCallback != null) {
              final selectedDataPoints = metadata.barChartDataPointsByColumnIndex[i] ?? List.empty(growable: false);
              if (metadataOpposite != null && metadataOpposite!.lineChartDataPointsByColumnIndex[i] != null) {
                selectedDataPoints.addAll(metadataOpposite!.barChartDataPointsByColumnIndex[i]!);
              }
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                onBarChartDataPointTabCallback!(i, selectedDataPoints);
              });
            }
          }
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
    required CooChartColorScheme colorScheme,
    required double chartWidth,
    required double chartHeight,
  }) {
    final Paint gridPaint = Paint()
      ..color = colorScheme.gridColor
      ..strokeWidth = 1;

    int xGridLineCount = metadata.maxAbsoluteValueCount;
    if (!centerDataPointBetweenVerticalGrid) {
      xGridLineCount -= 1;
    }
    double xOffsetInterval = xGridLineCount == 0 ? chartWidth : chartWidth / (xGridLineCount);
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
    axisStepLoop:
    for (int i = 0; i <= xGridLineCount; i++) {
      double x = (xOffsetInterval * i) + padding.left;
      double xVerticalGridline = x;
      if (centerDataPointBetweenVerticalGrid) {
        x += metadata.xSegementWidthHalf; // add center offset
      }

      // Don't draw the first vertical grid line because there is already the y-Axis line
      // Draw only vertical lines if general config enabled it and no individual config is given
      bool isStepAxisLine = false;
      if (i != 0 && showGridVertical) {
        if (xAxisConfig.stepAxisLine == null) {
          canvas.drawLine(
              Offset(xVerticalGridline, padding.top.toDouble()), Offset(xVerticalGridline, xBottomPos), gridPaint);
        } else {
          bool drawLine = i == xAxisConfig.stepAxisLineStart; // Wenn i exakt der Startangabe ist
          // Wenn i auf einem vielfachen der angegebenen step liegt. Ist ein Start angegben wird dieser von i abgezogen
          drawLine = drawLine || (i - xAxisConfig.stepAxisLineStart) % xAxisConfig.stepAxisLine! == 0;

          if (drawLine) {
            isStepAxisLine = true;
            // Nur zeichen wenn der Start Step oder der konfigierte Step ab dem start übereinstimmt
            canvas.drawLine(
                Offset(xVerticalGridline, padding.top.toDouble()), Offset(xVerticalGridline, xBottomPos), gridPaint);
          }
        }
      }

      // draw highlight vertical line on mouse-over
      if (highlightPointsVerticalLine && i != 0 && i == mouseInRectYIndex) {
        canvas.drawLine(Offset(x, padding.top.toDouble()), Offset(x, xBottomPos), _highlightLinePaint);
      }

      if (!xAxisConfig.showTopLabels && !xAxisConfig.showBottomLabels) {
        // Es sollen keine Labels gemalt werden - können uns diese Auswertung sparen.
        continue axisStepLoop;
      }

      // TODO in Theme auslagern
      TextStyle? topLabelTextStyle;
      TextStyle? bottomLabelTextStyle;
      if (xAxisConfig.topLabelTextStyle != null) {
        topLabelTextStyle = xAxisConfig.topLabelTextStyle!;
      }
      if (xAxisConfig.bottomLabelTextStyle != null) {
        bottomLabelTextStyle = xAxisConfig.bottomLabelTextStyle!;
      }
      if (highlightPointsVerticalLine && i != 0 && i == mouseInRectYIndex) {
        topLabelTextStyle ??= const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: ui.Color.fromARGB(255, 71, 0, 251),
        );
        bottomLabelTextStyle ??= topLabelTextStyle;
      }

      // Defaults
      bottomLabelTextStyle ??= const TextStyle(color: Colors.grey, fontSize: 11);
      topLabelTextStyle ??= const TextStyle(color: Colors.grey, fontSize: 11);

      // Die letzte vertikale Linie muss bei Centered zusätzlich gezeichnet werden, das nächste Label allerdings
      // nicht, denn das wäre ein nicht vorhandener Datenpunkt zu viel
      if (!centerDataPointBetweenVerticalGrid || i != xGridLineCount) {
        String? topLabel;
        // Top Labels Callbacks
        switch (chartType) {
          case CooChartType.line:
            if (xAxisStepLineTopLabelLineChartCallback != null) {
              topLabel = xAxisStepLineTopLabelLineChartCallback!(i, metadata.lineChartDataPointsByColumnIndex[i]!);
            }
            break;
          case CooChartType.bar:
            if (xAxisStepLineTopLabelBarChartCallback != null) {
              topLabel = xAxisStepLineTopLabelBarChartCallback!(i, metadata.barChartDataPointsByColumnIndex[i]!);
              break;
            }
        }

        // Top Labels Defaults
        if (topLabel == null) {
          switch (xAxisConfig.valueType) {
            case XAxisValueType.date:
            case XAxisValueType.datetime:
              topLabel = topDateFormat!.format(metadata.allDateTimeXAxisValues[i]);
              break;
            case XAxisValueType.number:
              topLabel = startNumber.toString();
              break;
          }
          if (xAxisConfig.labelTopPostfix != null) {
            topLabel = '$topLabel ${xAxisConfig.labelTopPostfix}';
          }
        }

        startNumber++;

        if (xAxisConfig.showTopLabels) {
          _axisLabelPainter.text = TextSpan(text: topLabel, style: topLabelTextStyle);
          _axisLabelPainter.layout();
          final double labelTextWidth = _axisLabelPainter.width;

          // Prüfen ob die Größe noch in den Bereich passt
          bool textFitsInSpace = true;
          if (labelTextWidth < (i * (metadata.xSegmentWidth - 1))) {
            // Der Platz reicht für das Label aus
            textFitsInSpace = true;
          } else {
            textFitsInSpace = false;
          }
          bool drawLabel = true;
          // Wenn ein Axis Step konfiguriert ist soll auch nur dann das Label geschrieben werden,
          // Wenn Platz dafür ist.
          if (xAxisConfig.stepAxisLine != null) {
            if (!isStepAxisLine) {
              drawLabel = false;
            } else if (xAxisConfig.stepAxisLineStart > 0 && i <= xAxisConfig.stepAxisLineStart) {}

            // TODO Prüfen ob es auch in den abgeschnittenen Space passt
          }

          if (drawLabel) {
            // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
            final xPosCenter = (xOffsetInterval / 2) - (labelTextWidth / 2);

            // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
            double xPos;
            if (isStepAxisLine && textFitsInSpace) {
              // Es müssen Anzahl steps * breite Column für den Offset nehmen
              xPos = x - (xOffsetInterval * xAxisConfig.stepAxisLine! / 2) + xPosCenter;
            } else {
              xPos = x - (xOffsetInterval / 2) + xPosCenter;
            }
            double yPos = padding.top.toDouble() - 25;
            if (xAxisConfig.topLabelOffset != null) {
              xPos += xAxisConfig.topLabelOffset!.dx;
              yPos += xAxisConfig.topLabelOffset!.dy;
            }
            _axisLabelPainter.paint(canvas, Offset(xPos, yPos));
          }
        }

        String? bottomLabel;
        // Bottom Labels Callbacks
        switch (chartType) {
          case CooChartType.line:
            if (xAxisStepLineBottomLabelLineChartCallback != null) {
              bottomLabel =
                  xAxisStepLineBottomLabelLineChartCallback!(i, metadata.lineChartDataPointsByColumnIndex[i]!);
            }
            break;
          case CooChartType.bar:
            if (xAxisStepLineBottomLabelBarChartCallback != null) {
              bottomLabel = xAxisStepLineBottomLabelBarChartCallback!(i, metadata.barChartDataPointsByColumnIndex[i]!);
              break;
            }
        }

        // Bottom Labels Defaults, wenn kein Callback gegeben ist
        if (bottomLabel == null) {
          switch (xAxisConfig.valueType) {
            case XAxisValueType.date:
            case XAxisValueType.datetime:
              bottomLabel = bottomDateFormat!.format(metadata.allDateTimeXAxisValues[i]);
              break;
            case XAxisValueType.number:
              bottomLabel = startNumber.toString();
              break;
          }
          if (xAxisConfig.labelBottomPostfix != null) {
            bottomLabel = '$bottomLabel ${xAxisConfig.labelBottomPostfix}';
          }
        }
        if (xAxisConfig.showBottomLabels) {
          _axisLabelPainter.text = TextSpan(text: bottomLabel, style: bottomLabelTextStyle);
          _axisLabelPainter.layout();
          final double labelTextWidth = _axisLabelPainter.width;
          // Prüfen ob die Größe noch in den Bereich passt
          bool textFitsInSpace = true;
          if (labelTextWidth < (metadata.xSegmentWidth - 1)) {
            // Der Platz reicht für das Label aus
            textFitsInSpace = true;
          } else {
            textFitsInSpace = false;
          }
          // Wenn ein Axis Step konfiguriert ist soll auch nur dann das Label geschrieben werden,
          // Wenn Platz dafür ist.
          bool drawLabel = true;
          if (drawLabel && xAxisConfig.stepAxisLine != null) {
            if (!isStepAxisLine) {
              drawLabel = false;
            } else

            // Prüfen ob die Größe noch in den Bereich passt
            if (xAxisConfig.stepAxisLineStart > 0 && i <= xAxisConfig.stepAxisLineStart) {}
            // TODO Prüfen ob es auch in den abgeschnittenen Space passt
          }

          if (drawLabel && textFitsInSpace) {
            // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
            final xPosCenter = (xOffsetInterval / 2) - (labelTextWidth / 2);
            // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
            double xPos;
            if (isStepAxisLine) {
              // Es müssen Anzahl steps * breite Column für den Offset nehmen
              xPos = x - (xOffsetInterval * xAxisConfig.stepAxisLine! / 2) + xPosCenter;
            } else {
              xPos = x - (xOffsetInterval / 2) + xPosCenter;
            }
            double yPos = chartHeight + padding.top + 10;
            if (xAxisConfig.bottomLabelOffset != null) {
              xPos += xAxisConfig.bottomLabelOffset!.dx;
              yPos += xAxisConfig.bottomLabelOffset!.dy;
            }
            _axisLabelPainter.paint(canvas, Offset(xPos, yPos));
          }
        }
      }
    }
  }

  void _drawColumnBlocks({
    required ui.Canvas canvas,
    required double chartWidth,
    required double chartHeight,
    required List<CooLineChartDataSeries> linechartDataSeries,
    ChartColumnBlocks? columnBlocks,
  }) {
    if (columnBlocks == null) {
      return;
    }
    if (!columnBlocks.showBottomBlocks && !columnBlocks.showTopBlocks) {
      // Beide Blocks sollen nicht angezeigt werden.
      return;
    }
    if (columnBlocks.bottomDatas.isEmpty && columnBlocks.topDatas.isEmpty) {
      // Sollen zwar angezeigt werden, sind aber leer..
      return;
    }

    // Bottom Blocks
    if (columnBlocks.showTopBlocks && columnBlocks.topDatas.isNotEmpty) {
      paintColumnBlocks(canvas, columnBlocks, chartWidth, chartHeight, true);
    }
    if (columnBlocks.showBottomBlocks && columnBlocks.bottomDatas.isNotEmpty) {
      paintColumnBlocks(canvas, columnBlocks, chartWidth, chartHeight, false);
    }
  }

  void paintColumnBlocks(
      ui.Canvas canvas, ChartColumnBlocks columnBlocks, double chartWidth, double chartHeight, bool topBlocks) {
    ChartColumnBlockConfig config = topBlocks ? columnBlocks.topConfig : columnBlocks.bottomConfig;
    final columnDatas = topBlocks ? columnBlocks.topDatas : columnBlocks.bottomDatas;

    final columnDatasHeight = config.height.toDouble();
    // Wenn padding für die Legende verwendet werden soll kann angegben werden wie breit sie ist.
    double backgroundPaddingSize = columnBlocks.bottomConfig.backgroundColorPadding.toDouble();

    int xGridLineCount = metadata.maxAbsoluteValueCount;
    if (!centerDataPointBetweenVerticalGrid) {
      xGridLineCount -= 1;
    }

    // TODO in Default Theme auslagern
    final TextStyle textStyleNormal = config.textStyle ??
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        );
    final TextStyle textStyleHighlight = config.textStyleHightlight ??
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        );

    double xOffsetInterval = chartWidth / (xGridLineCount);
    for (int i = 0; i < xGridLineCount; i++) {
      final columnData = columnDatas[i];

      double x = (xOffsetInterval * i) + padding.left;
      if (centerDataPointBetweenVerticalGrid) {
        x += metadata.xSegementWidthHalf; // add center offset
      }

      final isHighlightColum = i == mouseInRectYIndex;

      final textStyle = isHighlightColum ? textStyleHighlight : textStyleNormal;

      // Die letzte vertikale Linie muss bei Centered zusätzlich gezeichnet werden, das nächste Label allerdings
      // nicht, denn das wäre ein nicht vorhandener Datenpunkt zu viel
      if (!centerDataPointBetweenVerticalGrid || i != xGridLineCount) {
        // Hintergrundfarbe rendern
        bool isBackgroundColor = config.backgroundColor != null || columnData.backgroundColor != null;
        if (isBackgroundColor) {
          final Paint columnLegendBackground = Paint()
            ..color = columnData.backgroundColor ?? config.backgroundColor!
            ..strokeWidth = 0;

          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final rectX0 = x - (xOffsetInterval / 2) + backgroundPaddingSize;
          final rectY0 = (topBlocks ? config.height : chartHeight) +
              padding.top.toDouble() -
              columnDatasHeight +
              backgroundPaddingSize;
          final rectX1 = rectX0 + xOffsetInterval - (backgroundPaddingSize * 2);
          final rectY1 = rectY0 + columnDatasHeight - (backgroundPaddingSize * 2);

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
        if (columnData.text != null) {
          final TextStyle blockDataTextStyle = isHighlightColum
              ? columnData.textStyleHighlight ?? textStyleHighlight
              : columnData.textStyle ?? textStyle;
          _columLegendTextPainter.text = TextSpan(text: columnData.text, style: blockDataTextStyle);
          _columLegendTextPainter.layout();

          // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
          final xPosCenter = (xOffsetInterval / 2) - (_columLegendTextPainter.width / 2);
          // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
          final xPos = x - (xOffsetInterval / 2) + xPosCenter;

          // Center ist höhe der fläche / 2 + höhe des textes / 2
          final double yPosCenter = (columnDatasHeight / 2) + (_columLegendTextPainter.height / 2);
          final yPos = (topBlocks ? config.height : chartHeight) + padding.top.toDouble() - yPosCenter;

          _columLegendTextPainter.paint(canvas, Offset(xPos, yPos));
        }

        // Asset Image rendern, sofern angegeben und als Bild vorhanden
        if (columnData.assetImages.isNotEmpty) {
          assetImageLoop:
          for (var blockAssetImage in columnData.assetImages) {
            final ui.Image? image = columLegendsAssetImages[blockAssetImage.path];
            if (image == null) {
              continue assetImageLoop;
            }

            // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
            final xPosCenter = (xOffsetInterval / 2) - (image.width / 2);
            // Berechnen der XPos relativ zu dem gerade berechnetem Punkt
            final xPos = x - (xOffsetInterval / 2) + xPosCenter;

            // Center ist höhe der fläche / 2 + höhe des textes / 2
            final double yPosCenter = (columnDatasHeight / 2) + (image.height / 2);
            final yPos = (topBlocks ? config.height : chartHeight) +
                padding.top.toDouble() -
                yPosCenter -
                blockAssetImage.offsetTop;

            // Es ist aktuell nicht möglich ein SVG zu positionieren oder in der Größe zu verändern.
            // Deswegen wird das schlechtere von SVG zu PNG transformierte Bild gezeichnet
            // canvas.drawPicture(columLegendsAssetSvgPictureInfos[blockAssetImage.path]!.picture);

            canvas.drawImage(image, Offset(xPos, yPos), Paint()..filterQuality = FilterQuality.high);
          }
        }
      }
    }
  }
}
