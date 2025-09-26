// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_background_time_range.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/chart_tab_info.dart';
import 'package:coo_charts/common/coo_chart_color_theme.dart';
import 'package:coo_charts/common/coo_chart_type.enum.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/x_axis_label_svg.dart';
import 'package:coo_charts/common/x_axis_label_widget.dart';
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';
import 'package:coo_charts/extensions/iterable.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CooChartPainter extends CustomPainter {
  CooChartPainter({
    required this.chartConfig,
    required this.theme,
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
    this.xAxisStepLineBottomSvgBarChartCallback,
    this.xAxisStepLineBottomWidgetBarChartCallback,
  });

  final ChartConfig chartConfig;
  final ChartPainterMetadata metadata;
  final ChartPainterMetadata? metadataOpposite;
  final CooChartType chartType;

  final CooChartTheme theme;

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

  // SVG callbacks for X-axis labels
  final XAxisLabelSvg? Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomSvgBarChartCallback;

  // Widget callbacks for X-axis labels
  final XAxisLabelWidget? Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomWidgetBarChartCallback;

  final Map<Rect, int> chartRectYPos = {}; // Merken welches Rect bei welcher Y-Pos liegt

  final Paint _highlightLinePaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.7)
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
    CooChartPainterUtil.drawBackground(
      canvas: canvas,
      config: chartConfig,
      colorScheme: theme,
      metadata: metadata,
    );

    /// Chart canvas size to draw on
    CooChartPainterUtil.drawCanvasAndAxis(
      canvas: canvas,
      config: chartConfig,
      colorScheme: theme,
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
      config: chartConfig,
      colorScheme: theme,
      chartWidth: metadata.chartWidth,
      chartHeigt: metadata.chartHeight,
      mousePosition: mousePosition,
      linechartDataSeries: linechartDataSeries,
    );

    // Zeichne Hintergrund-Zeiträume falls konfiguriert
    _drawBackgroundTimeRanges(
      canvas: canvas,
      config: chartConfig,
      chartWidth: metadata.chartWidth,
      chartHeight: metadata.chartHeight,
    );

    _drawXAxisLabelAndVerticalGridLine(
      canvas: canvas,
      config: chartConfig,
      colorScheme: theme,
      chartWidth: metadata.chartWidth,
      chartHeight: metadata.chartHeight,
    );

    CooChartPainterUtil.drawYAxisHorizontalGridLine(
      canvas: canvas,
      config: chartConfig,
      colorScheme: theme,
      metadata: metadata,
      yAxisConfig: yAxisConfig,
      columnBlocks: columnBlocks,
      showGridHorizontal: showGridHorizontal,
      padding: padding,
      axisLabelPainter: _axisLabelPainter,
      opposite: false,
    );
    // if (yAxisOppositeConfig != null && metadataOpposite != null && metadataOpposite!.hasOpposite) {
    //   CooChartPainterUtil.drawYAxisHorizontalGridLine(
    //     canvas: canvas,
    //     colorScheme: theme,
    //     config: chartConfig,
    //     metadata: metadataOpposite!,
    //     yAxisConfig: yAxisOppositeConfig!,
    //     columnBlocks: columnBlocks,
    //     showGridHorizontal: showGridHorizontal,
    //     padding: padding,
    //     axisLabelPainter: _axisLabelPainter,
    //     opposite: true,
    //   );
    // }

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
      // Draw non-opposite bar charts (left axis)
      final nonOppositeBarSeries = barchartDataSeries.where((element) => element.opposite == false).toList();
      if (nonOppositeBarSeries.isNotEmpty) {
        _drawDataBarchartBars(
          theme: theme,
          barchartDataSeries: nonOppositeBarSeries,
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

      // Draw opposite bar charts (right axis) with opposite metadata
      if (metadataOpposite != null && yAxisOppositeConfig != null) {
        final oppositeBarSeries = barchartDataSeries.where((element) => element.opposite == true).toList();
        if (oppositeBarSeries.isNotEmpty) {
          _drawDataBarchartBars(
            theme: theme,
            barchartDataSeries: oppositeBarSeries,
            columnBlocks: columnBlocks,
            canvas: canvas,
            chartWidth: metadataOpposite!.chartWidth,
            chartHeigt: metadataOpposite!.chartHeight,
            mousePosition: mousePosition,
            minDataPointValue: metadataOpposite!.minDataPointValue,
            yAxisConfig: yAxisOppositeConfig!,
            yAxisMaxValue: metadataOpposite!.yAxisMaxValue,
            yAxisMinValue: metadataOpposite!.yAxisMinValue,
            padding: padding,
            xSegmentWidth: metadataOpposite!.xSegmentWidth,
            xSegementWidthHalf: metadataOpposite!.xSegementWidthHalf,
          );
        }
      }

      // Also draw line charts as overlay on bar charts (for combo charts)
      if (linechartDataSeries.isNotEmpty) {
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

      // Also draw line charts on opposite axis if available
      if (metadataOpposite != null && linechartDataSeries.isNotEmpty) {
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

    if (crosshair) {
      _drawCrosshair(
        canvas: canvas,
        chartHeight: metadata.chartHeight,
        chartWidth: metadata.chartWidth,
        mousePosition: mousePosition,
      );
    }
  }

  double _calculateBarWidth(CooBarChartDataSeries dataSeries, int dataSeriesCount) {
    var barWidth = metadata.xSegementWidthHalf * 0.66; // Default: 2/3 of column space

    if (dataSeries.maxBarWidth != null && barWidth > dataSeries.maxBarWidth!) {
      barWidth = dataSeries.maxBarWidth!.toDouble();
    }

    if (dataSeriesCount > 1) {
      barWidth = metadata.xSegementWidthHalf / dataSeriesCount * 0.66;
    }

    if (dataSeries.barWidth != null) {
      barWidth = dataSeries.barWidth!.toDouble();
    }

    return barWidth;
  }

  double? _normalizeValue({
    required double value,
    required double yAxisMinValue,
    required double yAxisMaxValue,
  }) {
    if (yAxisMaxValue == yAxisMinValue) {
      return 0.0; // Prevent division by zero
    }

    var minDataPointDiff = 0.0;
    if (yAxisMinValue < 0) {
      minDataPointDiff = yAxisMinValue.abs();
    }

    double valueOverZeroDiff = yAxisMinValue > 0 ? yAxisMinValue : 0;
    var maxDataPoint = yAxisMaxValue + minDataPointDiff - valueOverZeroDiff;

    double normalizedValue = value;
    normalizedValue += minDataPointDiff;
    normalizedValue -= valueOverZeroDiff;
    normalizedValue = maxDataPoint == 0 ? 0 : normalizedValue / maxDataPoint;

    return normalizedValue;
  }

  void _drawSingleBar({
    required Canvas canvas,
    required CooBarChartDataPoint dataPoint,
    required double x,
    required double y,
    required double startYPos,
    required double topColumnHeight,
    required ChartPadding padding,
    required double barWidth,
    required Paint barPaint,
    required Paint barHightlightPaint,
    required Offset? mousePosition,
    required bool highlightMouseColumn,
  }) {
    // Validate all values before creating rectangle to prevent NaN
    if (x.isNaN ||
        y.isNaN ||
        barWidth.isNaN ||
        startYPos.isNaN ||
        x.isInfinite ||
        y.isInfinite ||
        barWidth.isInfinite ||
        startYPos.isInfinite ||
        barWidth <= 0) {
      return; // Skip this bar if any value is invalid
    }

    double x0 = x - barWidth;
    double y0 = y;
    double x1 = x + barWidth;
    double y1 = startYPos + padding.top + topColumnHeight;

    // Final validation of rectangle coordinates
    if (x0.isNaN ||
        y0.isNaN ||
        x1.isNaN ||
        y1.isNaN ||
        x0.isInfinite ||
        y0.isInfinite ||
        x1.isInfinite ||
        y1.isInfinite) {
      return; // Skip this bar if coordinates are invalid
    }

    var rect = Rect.fromPoints(Offset(x0, y0), Offset(x1, y1));

    bool mouseOverBarHighlight = false;
    if (mousePosition != null) {
      bool contains = rect.contains(Offset(mousePosition.dx, mousePosition.dy));
      mouseOverBarHighlight = contains && highlightMouseColumn;
    }

    if (mouseOverBarHighlight) {
      canvas.drawRect(rect, barHightlightPaint);
    } else {
      canvas.drawRect(rect, barPaint);
    }
  }

  void _drawGroupedBars({
    required Canvas canvas,
    required CooBarChartDataPoint dataPoint,
    required double x,
    required double startYPos,
    required double topColumnHeight,
    required ChartPadding padding,
    required double barWidth,
    required double yAxisMinValue,
    required double yAxisMaxValue,
    required Offset? mousePosition,
    required bool highlightMouseColumn,
    required CooChartTheme theme,
  }) {
    if (!dataPoint.hasGroupedValues) {
      return;
    }

    final groupedValue = dataPoint.groupedValue!;

    final primaryNormalized = _normalizeValue(
      value: groupedValue.primaryValue,
      yAxisMinValue: yAxisMinValue,
      yAxisMaxValue: yAxisMaxValue,
    );
    final secondaryNormalized = _normalizeValue(
      value: groupedValue.secondaryValue,
      yAxisMinValue: yAxisMinValue,
      yAxisMaxValue: yAxisMaxValue,
    );

    final Color primaryColor = groupedValue.primaryColor ?? const Color(0xFF005288);
    final Color secondaryColor = groupedValue.secondaryColor ?? const Color(0xFF7DBBEA);

    final Paint primaryPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 1;
    final Paint secondaryPaint = Paint()
      ..color = secondaryColor
      ..strokeWidth = 1;
    final Paint primaryHighlightPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.8)
      ..strokeWidth = 1;
    final Paint secondaryHighlightPaint = Paint()
      ..color = secondaryColor.withValues(alpha: 0.8)
      ..strokeWidth = 1;

    final chartBottom = startYPos + padding.top + topColumnHeight;

    if (primaryNormalized != null && primaryNormalized > 0) {
      final primaryHeight = primaryNormalized * startYPos;
      final primaryTop = chartBottom - primaryHeight;

      final primaryRect = Rect.fromLTRB(x - barWidth, primaryTop, x + barWidth, chartBottom);

      bool mouseOverPrimary = false;
      if (mousePosition != null) {
        mouseOverPrimary = primaryRect.contains(mousePosition) && highlightMouseColumn;
      }

      canvas.drawRect(primaryRect, mouseOverPrimary ? primaryHighlightPaint : primaryPaint);
    }

    if (secondaryNormalized != null && secondaryNormalized > 0) {
      final primaryHeight = (primaryNormalized ?? 0) * startYPos;
      final secondaryHeight = secondaryNormalized * startYPos;

      final secondaryBottom = chartBottom - primaryHeight;
      final secondaryTop = secondaryBottom - secondaryHeight;

      final secondaryRect = Rect.fromLTRB(x - barWidth, secondaryTop, x + barWidth, secondaryBottom);

      bool mouseOverSecondary = false;
      if (mousePosition != null) {
        mouseOverSecondary = secondaryRect.contains(mousePosition) && highlightMouseColumn;
      }

      canvas.drawRect(secondaryRect, mouseOverSecondary ? secondaryHighlightPaint : secondaryPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CooChartPainter oldDelegate) {
    return mousePosition != oldDelegate.mousePosition;
  }

  void _drawDataBarchartBars({
    required Canvas canvas,
    required CooChartTheme theme,
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
      List<double?> dataPointValues = localLinechartDataSeries.dataPoints.map((e) {
        if (e.hasGroupedValues) {
          return e.effectiveValue;
        }
        return e.value;
      }).toList();

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
      // TODO verschiedene Farben müssen über des Theme vorbestimmt werden können
      final Color barColor = localLinechartDataSeries.barColor ?? theme.barColor;
      final Paint barPaint = Paint()
        ..color = barColor
        ..strokeWidth = 1;

      final Color barColorHighlight = localLinechartDataSeries.barColor ?? theme.barColorHighlight;
      final Paint barHightlightPaint = Paint()
        ..color = barColorHighlight
        ..strokeWidth = 1;

      final Color minMaxRangeLineColor = localLinechartDataSeries.minMaxLineColor ?? theme.minMaxRangeColor;
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
          if (dataPoint.hasGroupedValues) {
            _drawGroupedBars(
              canvas: canvas,
              dataPoint: dataPoint,
              x: x,
              startYPos: startYPos,
              topColumnHeight: topColumnHeight,
              padding: padding,
              barWidth: _calculateBarWidth(localLinechartDataSeries, dataSeriesCount),
              yAxisMinValue: yAxisMinValue,
              yAxisMaxValue: yAxisMaxValue,
              mousePosition: mousePosition,
              highlightMouseColumn: highlightMouseColumn,
              theme: theme,
            );
          } else {
            _drawSingleBar(
              canvas: canvas,
              dataPoint: dataPoint,
              x: x,
              y: startYPos - (dataValue * (startYPos)) + padding.top + topColumnHeight,
              startYPos: startYPos,
              topColumnHeight: topColumnHeight,
              padding: padding,
              barWidth: _calculateBarWidth(localLinechartDataSeries, dataSeriesCount),
              barPaint: barPaint,
              barHightlightPaint: barHightlightPaint,
              mousePosition: mousePosition,
              highlightMouseColumn: highlightMouseColumn,
            );
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
    required ChartConfig config,
    required CooChartTheme colorScheme,
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
      final barchartDataPointsNullable = metadata.barChartDataPointsByColumnIndex[i];
      if (barchartDataPointsNullable != null) {
        List<CooBarChartDataPoint> barchartDataPoints = barchartDataPointsNullable;
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
    required ChartConfig config,
    required CooChartTheme colorScheme,
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

      // Calculate isStepAxisLine independent of grid line drawing conditions
      if (xAxisConfig.stepAxisLine != null) {
        bool drawLine = i == xAxisConfig.stepAxisLineStart; // Wenn i exakt der Startangabe ist
        // Wenn i auf einem vielfachen der angegebenen step liegt. Ist ein Start angegben wird dieser von i abgezogen
        drawLine = drawLine || (i - xAxisConfig.stepAxisLineStart) % xAxisConfig.stepAxisLine! == 0;
        isStepAxisLine = drawLine;
      }

      if (showGridVertical && (i != 0 && i != xGridLineCount || !config.showChartBorder)) {
        if (xAxisConfig.stepAxisLine == null) {
          canvas.drawLine(
              Offset(xVerticalGridline, padding.top.toDouble()), Offset(xVerticalGridline, xBottomPos), gridPaint);
        } else {
          if (isStepAxisLine) {
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
              final dataPoints = metadata.lineChartDataPointsByColumnIndex[i];
              if (dataPoints != null) {
                topLabel = xAxisStepLineTopLabelLineChartCallback!(i, dataPoints);
              }
            }
            break;
          case CooChartType.bar:
            if (xAxisStepLineTopLabelBarChartCallback != null) {
              final dataPoints = metadata.barChartDataPointsByColumnIndex[i];
              if (dataPoints != null) {
                topLabel = xAxisStepLineTopLabelBarChartCallback!(i, dataPoints);
              }
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

        // Calculate bottom label Y position
        final double bottomLabelsYPos = chartHeight + padding.top + 10;

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
            } else if (xAxisConfig.stepAxisLineStart > 0 && i < xAxisConfig.stepAxisLineStart) {
              // Skip labels before the start position (but only if stepAxisLineStart > 0)
              drawLabel = false;
            }

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
        XAxisLabelSvg? bottomSvgLabel;
        XAxisLabelWidget? bottomWidgetLabel;

        // Check if we should use SVG labels
        bool shouldUseSvgLabels = false;
        try {
          shouldUseSvgLabels = xAxisConfig.useSvgLabels;
        } catch (e) {
          shouldUseSvgLabels = false;
        }

        if (shouldUseSvgLabels && chartType == CooChartType.bar && xAxisStepLineBottomSvgBarChartCallback != null) {
          // For SVG labels, we don't need the dataPoints parameter since wind direction is based on index
          bottomSvgLabel = xAxisStepLineBottomSvgBarChartCallback!(i, []);
        } else if (chartType == CooChartType.bar && xAxisStepLineBottomWidgetBarChartCallback != null) {
          // For widget labels
          final dataPoints = metadata.barChartDataPointsByColumnIndex[i] ?? [];
          bottomWidgetLabel = xAxisStepLineBottomWidgetBarChartCallback!(i, dataPoints);
        } else {
          // Bottom Labels Callbacks
          switch (chartType) {
            case CooChartType.line:
              if (xAxisStepLineBottomLabelLineChartCallback != null) {
                final dataPoints = metadata.lineChartDataPointsByColumnIndex[i];
                if (dataPoints != null) {
                  bottomLabel = xAxisStepLineBottomLabelLineChartCallback!(i, dataPoints);
                }
              }
              break;
            case CooChartType.bar:
              if (xAxisStepLineBottomLabelBarChartCallback != null) {
                final dataPoints = metadata.barChartDataPointsByColumnIndex[i];
                if (dataPoints != null) {
                  bottomLabel = xAxisStepLineBottomLabelBarChartCallback!(i, dataPoints);
                }
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
        }

        // Render bottom labels (either Widget, SVG or text)
        if (xAxisConfig.showBottomLabels) {
          if (bottomWidgetLabel != null) {
            // Render widget label
            _drawXAxisWidgetLabel(
              canvas: canvas,
              widgetLabel: bottomWidgetLabel,
              x: x,
              y: bottomLabelsYPos,
            );
          } else if (bottomSvgLabel != null) {
            // Render SVG label
            _drawXAxisSvgLabel(
              canvas: canvas,
              svgLabel: bottomSvgLabel,
              x: x,
              y: bottomLabelsYPos,
            );
          } else if (bottomLabel != null) {
            // Render text label
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
              } else {
                // Prüfen ob die Größe noch in den Bereich passt
                if (xAxisConfig.stepAxisLineStart > 0 && i < xAxisConfig.stepAxisLineStart) {
                  // Skip labels before the start position (but only if stepAxisLineStart > 0)
                  drawLabel = false;
                }
                // TODO Prüfen ob es auch in den abgeschnittenen Space passt
              }
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
              double yPos = bottomLabelsYPos;
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

  /// Renders an SVG icon for X-axis label
  void _drawXAxisSvgLabel({
    required Canvas canvas,
    required XAxisLabelSvg svgLabel,
    required double x,
    required double y,
  }) {
    try {
      // Try to get the SVG from cache
      final PictureInfo? pictureInfo = CooChartPainterUtil.getSvgFromCache(svgLabel.assetPath);

      if (pictureInfo != null) {
        // Calculate center position
        final centerX = x + svgLabel.offsetX - (svgLabel.width / 2);
        final centerY = y + svgLabel.offsetY - (svgLabel.height / 2);

        // Save canvas state
        canvas.save();

        // Translate to the final position
        canvas.translate(centerX, centerY);

        // Apply rotation if specified
        if (svgLabel.rotationDegrees != 0.0) {
          // Translate to center of SVG for rotation
          canvas.translate(svgLabel.width / 2, svgLabel.height / 2);
          // Convert degrees to radians and rotate
          canvas.rotate(svgLabel.rotationDegrees * (pi / 180.0));
          // Translate back
          canvas.translate(-svgLabel.width / 2, -svgLabel.height / 2);
        }

        // Scale the SVG to the desired size
        final scaleX = svgLabel.width / pictureInfo.size.width;
        final scaleY = svgLabel.height / pictureInfo.size.height;
        canvas.scale(scaleX, scaleY);

        // Draw the SVG picture
        canvas.drawPicture(pictureInfo.picture);

        // Restore canvas state
        canvas.restore();
      } else {
        // Fallback: draw a colored circle if SVG is not in cache
        final fallbackPaint = Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(x + svgLabel.offsetX, y + svgLabel.offsetY), 8.0, fallbackPaint);
      }
    } catch (e) {
      // Fallback for any errors
      final fallbackPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x + svgLabel.offsetX, y + svgLabel.offsetY), 8.0, fallbackPaint);
    }
  }

  /// Renders a custom widget for X-axis label
  void _drawXAxisWidgetLabel({
    required Canvas canvas,
    required XAxisLabelWidget widgetLabel,
    required double x,
    required double y,
  }) {
    try {
      // Validate inputs to prevent NaN calculations
      if (widgetLabel.width <= 0 ||
          widgetLabel.height <= 0 ||
          widgetLabel.width.isNaN ||
          widgetLabel.height.isNaN ||
          widgetLabel.width.isInfinite ||
          widgetLabel.height.isInfinite ||
          x.isNaN ||
          y.isNaN ||
          x.isInfinite ||
          y.isInfinite) {
        // Draw fallback for invalid dimensions
        final fallbackPaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(x, y), 4.0, fallbackPaint);
        return;
      }

      // Create the render object for the widget
      final Size widgetSize = Size(widgetLabel.width, widgetLabel.height);

      // Save canvas state
      canvas.save();

      // Calculate center position with additional validation
      final centerX = x + widgetLabel.offsetX - (widgetLabel.width / 2);
      final centerY = y + widgetLabel.offsetY - (widgetLabel.height / 2);

      // Validate calculated positions
      if (centerX.isNaN || centerY.isNaN || centerX.isInfinite || centerY.isInfinite) {
        canvas.restore();
        return;
      }

      // Translate to the final position
      canvas.translate(centerX, centerY);

      // Apply rotation if specified
      if (widgetLabel.rotationDegrees != 0.0 && !widgetLabel.rotationDegrees.isNaN) {
        // Translate to center of widget for rotation
        canvas.translate(widgetLabel.width / 2, widgetLabel.height / 2);
        // Convert degrees to radians and rotate
        canvas.rotate(widgetLabel.rotationDegrees * (pi / 180.0));
        // Translate back
        canvas.translate(-widgetLabel.width / 2, -widgetLabel.height / 2);
      }

      // Create a simple render widget approach
      // Note: This is a simplified approach. In a real implementation, you might want to
      // use RenderBox or similar for more complex widgets
      bool widgetRendered = false;

      if (widgetLabel.widget is CustomPaint) {
        final customPaint = widgetLabel.widget as CustomPaint;
        if (customPaint.painter != null) {
          customPaint.painter!.paint(canvas, widgetSize);
          widgetRendered = true;
        }
      }

      if (!widgetRendered) {
        // For custom widgets, try multiple approaches to get the painter
        try {
          final dynamic widget = widgetLabel.widget;

          // Approach 1: Try to call getPainter() method if it exists
          try {
            final painter = widget.getPainter();
            if (painter != null) {
              painter.paint(canvas, widgetSize);
              widgetRendered = true;
            }
          } catch (e) {
            // getPainter method doesn't exist or failed
          }

          // Approach 2: Try to build the widget if getPainter failed
          if (!widgetRendered) {
            final builtWidget = widget.build(null);
            if (builtWidget is CustomPaint && builtWidget.painter != null) {
              builtWidget.painter!.paint(canvas, widgetSize);
              widgetRendered = true;
            }
          }
        } catch (e) {
          // All approaches failed
        }
      }

      // If nothing worked, draw a fallback indicator
      if (!widgetRendered) {
        final fallbackPaint = Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(widgetSize.width / 2, widgetSize.height / 2), 6.0, fallbackPaint);
      }

      // Restore canvas state
      canvas.restore();
    } catch (e) {
      // Fallback for any errors - draw a simple colored circle
      final fallbackPaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x + widgetLabel.offsetX, y + widgetLabel.offsetY), 8.0, fallbackPaint);
    }
  }

  /// Zeichnet Hintergrund-Zeiträume basierend auf der Chart-Konfiguration
  void _drawBackgroundTimeRanges({
    required Canvas canvas,
    required ChartConfig config,
    required double chartWidth,
    required double chartHeight,
  }) {
    if (config.backgroundTimeRanges.isEmpty) {
      return;
    }

    // Nur für Datum/Zeit-basierte X-Achsen implementieren
    if (xAxisConfig.valueType != XAxisValueType.datetime && xAxisConfig.valueType != XAxisValueType.date) {
      return;
    }

    final chartStartY = padding.top.toDouble();
    final chartEndY = chartStartY + chartHeight;

    for (final ChartBackgroundTimeRange timeRange in config.backgroundTimeRanges) {
      try {
        _drawTimeRangeForAllDays(
          canvas: canvas,
          timeRange: timeRange,
          chartStartY: chartStartY,
          chartEndY: chartEndY,
        );
      } catch (e) {
        // Fehler beim Zeichnen eines Zeitraums - ignorieren und weiter
        continue;
      }
    }
  }

  /// Zeichnet einen Zeitraum für alle Tage im Chart
  void _drawTimeRangeForAllDays({
    required Canvas canvas,
    required ChartBackgroundTimeRange timeRange,
    required double chartStartY,
    required double chartEndY,
  }) {
    final backgroundPaint = Paint()
      ..color = timeRange.backgroundColor.withValues(alpha: timeRange.opacity)
      ..style = PaintingStyle.fill;

    List<int> validIndices = [];

    // Durchgehe alle DateTime-Werte und sammle alle Indizes, die in den Zeitraum fallen
    for (int i = 0; i < metadata.allDateTimeXAxisValues.length; i++) {
      final dateTime = metadata.allDateTimeXAxisValues[i];

      if (_isTimeInRange(dateTime, timeRange.startTime, timeRange.endTime)) {
        validIndices.add(i);
      }
    } // Gruppiere aufeinanderfolgende Indizes zu Bereichen
    if (validIndices.isNotEmpty) {
      List<List<int>> ranges = [];
      List<int> currentRange = [validIndices[0]];

      for (int i = 1; i < validIndices.length; i++) {
        if (validIndices[i] == validIndices[i - 1] + 1) {
          // Aufeinanderfolgender Index - zur aktuellen Range hinzufügen
          currentRange.add(validIndices[i]);
        } else {
          // Lücke gefunden - aktuelle Range abschließen und neue starten
          ranges.add(currentRange);
          currentRange = [validIndices[i]];
        }
      }
      ranges.add(currentRange); // Letzte Range hinzufügen

      // Zeichne jeden Bereich
      for (final range in ranges) {
        final rangeStart = range.first;
        final rangeEnd = range.last;

        // Berechne X-Positionen
        double startX = (rangeStart * metadata.xSegmentWidth) + padding.left;
        double endX = ((rangeEnd + 1) * metadata.xSegmentWidth) + padding.left; // +1 to include end point

        if (centerDataPointBetweenVerticalGrid) {
          startX += metadata.xSegementWidthHalf;
          endX += metadata.xSegementWidthHalf;
        }

        // Zeichne den Hintergrund-Zeitraum
        final rect = Rect.fromLTRB(startX, chartStartY, endX, chartEndY);
        canvas.drawRect(rect, backgroundPaint);
      }
    }
  }

  /// Prüft, ob eine DateTime in einem bestimmten Zeitraum liegt
  bool _isTimeInRange(DateTime dateTime, TimeOfDay startTime, TimeOfDay endTime) {
    final currentMinutes = dateTime.hour * 60 + dateTime.minute;
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    if (startMinutes <= endMinutes) {
      // Normal range (e.g., 09:00 - 17:00)
      return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
    } else {
      // Overnight range (e.g., 20:00 - 06:00)
      return currentMinutes >= startMinutes || currentMinutes <= endMinutes;
    }
  }
}
