// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui' as ui;

import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config_image.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/data_point_label_pos.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as image;

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
  static void drawCanvasAndAxis({
    required Canvas canvas,
    required Paint axisPaint,
    required ChartPadding padding,
    required double canvasWidth,
    required double canvasHeight,
    required bool showYAxis,
    required bool showXAxis,
    required bool showFullRect,
    Color? backgroundColor,
    required PaintingStyle backgroundPaintingStyle,
  }) {
    double x0 = padding.left.toDouble(); // Links erste X-Pos
    double x1 = canvasWidth - padding.right; // Rechts zweite X-Pos
    double y0 = padding.top.toDouble(); // Oben erste Y-Pos
    double y1 = canvasHeight - padding.bottom; // Unten zweite Y-Pos
    Offset posX0Y0 = Offset(x0, y0);
    Offset posX0Y1 = Offset(x0, y1);
    Offset posX1Y0 = Offset(x1, y0);
    Offset posX1Y1 = Offset(x1, y1);

    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..strokeWidth = 10
        ..style = backgroundPaintingStyle;
      var rect = Rect.fromPoints(Offset(x0, y0), Offset(x1, y1));
      canvas.drawRect(rect, backgroundPaint);
    }

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

  Future<void> loadColumnDataImageAssets({
    required ChartColumnBlocks columnBlocks,
    required Map<String, ui.Image> columLegendsAssetImages,
    required Map<String, PictureInfo> columLegendsAssetSvgPictureInfos,
  }) async {
    if (!columnBlocks.showBottomBlocks && !columnBlocks.showTopBlocks) {
      // Beide Blocks sollen nicht angezeigt werden.
      return;
    }
    if (columnBlocks.bottomDatas.isEmpty && columnBlocks.topDatas.isEmpty) {
      // Sollen zwar angezeigt werden, sind aber leer..
      return;
    }
    // Alle Bilder sammeln

    List<BlockAssetImage> assetImages = [];
    for (var columnData in columnBlocks.bottomDatas) {
      for (var blockAssetImage in columnData.assetImages) {
        assetImages.add(blockAssetImage);
      }
    }
    for (var columnData in columnBlocks.topDatas) {
      for (var blockAssetImage in columnData.assetImages) {
        assetImages.add(blockAssetImage);
      }
    }
    if (assetImages.isEmpty) {
      return;
    }

    blockAssetImageLoop:
    for (var blockAssetImage in assetImages) {
      final String assetImagePath = blockAssetImage.path;
      if (columLegendsAssetImages[assetImagePath] != null) {
        continue blockAssetImageLoop;
      }
      if (assetImagePath.endsWith('.png')) {
        try {
          ui.Image uiImg = await loadImage(assetImagePath, blockAssetImage.height);
          columLegendsAssetImages[assetImagePath] = uiImg;
        } catch (e) {
          // TODO Logging
        }
        continue blockAssetImageLoop;
      }
      try {
        PictureInfo pictureInfo = await vg.loadPicture(
          SvgAssetLoader(assetImagePath),
          null,
        );

        var imageHeight = pictureInfo.size.height.toInt();
        var imageWidth = pictureInfo.size.width.toInt();
        final newHeight = blockAssetImage.height.toDouble();
        final double targetHeight = newHeight;
        final double targetWidth = (newHeight / imageHeight) * imageWidth;
        final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
        final ui.Canvas canvas =
            Canvas(pictureRecorder, Rect.fromPoints(Offset.zero, Offset(targetWidth, targetHeight)));
        canvas.scale(targetWidth / pictureInfo.size.width, targetHeight / pictureInfo.size.height);
        canvas.drawPicture(pictureInfo.picture);
        final ui.Image scaledImage =
            await pictureRecorder.endRecording().toImage(targetWidth.ceil(), targetHeight.ceil());

        columLegendsAssetImages[assetImagePath] = scaledImage;
        columLegendsAssetSvgPictureInfos[assetImagePath] = pictureInfo;
      } catch (e) {
        /// Image could not be processed..
      }
    }
  }

  Future<ui.Image> loadImage(String assetImagePath, int height) async {
    final data = await rootBundle.load(assetImagePath);
    image.Image baseSizeImage = image.decodeImage(data.buffer.asUint8List())!;
    image.Image resizeImage = image.copyResize(baseSizeImage, height: height);
    ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(resizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();

    return frameInfo.image;
  }

  /// Alle Chart-Punkte auf einen Wert zwischen 0.0 und 1.0 bringen. So wird später die Position
  /// relativ zur 100% Fläche berechnet.
  static List<double?> normalizeChartDataPoints(
      {required List<double?> linechartDataPoints,
      required double yAxisMinValue,
      required double yAxisMaxValue,
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
    double valueOverZeroDiff = minDataPointValue > 0 ? yAxisMinValue : 0;

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

  /// Malt die Labels auf der Y-Achse
  ///
  /// Berechnet die Höhe der einzelnen Zeilen anhand der gegebenen Label-Counts.
  /// Labels werden links oder rechts auf dem verfügbaren Canvas gemalt.
  ///
  static void drawYAxisLabels({
    required Canvas canvas,
    required ChartConfig config,
    required ChartPainterMetadata metadata,
    required YAxisConfig yAxisConfig,
    required bool showGridHorizontal,
    required ChartPadding padding,
    ChartColumnBlocks? columnBlocks,
    required bool opposite, // if true the right y-axis labels will be printed
  }) {
    if (!yAxisConfig.showYAxisLables) {
      // Wenn kein Grid und keine Labels gezeichnet werden sollen, muss auch nichts berechnet werden
      return;
    }

    // Blocks werden für die korrekte Berechnung der Labelposition benötigt
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

    final labelTextStyle = TextStyle(
      fontSize: 12,
      color: Colors.black,
      // background: Paint()
      //   ..strokeWidth = 30.0
      //   ..color = Colors.grey
      //   ..style = PaintingStyle.stroke
      //   ..strokeJoin = StrokeJoin.round,
    );

    /// Draw Background Rect if scrollable, so the lines are not visible
    final TextPainter axisLabelPainterCalc = TextPainter(
      textAlign: TextAlign.left,
      textDirection: ui.TextDirection.ltr,
    );
    // Check max width of label text

    final List<(String label, double length)> labels = [];
    double maxLabelWidth = 0;
    for (int i = 0; i < metadata.yAxisLabelCount; i++) {
      var yAxisLabelValue = (i * metadata.yAxisSteps + metadata.yAxisMinValue);
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

      axisLabelPainterCalc.text = TextSpan(text: label, style: labelTextStyle);

      axisLabelPainterCalc.layout();

      // Die Labels an der Y-Achse sollen rechtsbündig sein.
      // Somit muss der Padding mit der Größe des Textes berechnet werden
      if (maxLabelWidth < axisLabelPainterCalc.width) {
        maxLabelWidth = axisLabelPainterCalc.width;
      }
      labels.add((label, axisLabelPainterCalc.width));
    }

    double rectPosX0 = 0;
    if (opposite == true) {
      // rechte Seite
      rectPosX0 = (config.scrollable ? metadata.layoutWidth : metadata.canvasWidth) - padding.right + 10;
    }
    double rectPosY0 = 0;
    double rectPosX1 = rectPosX0 + maxLabelWidth + 20;
    double rectPosY1 = metadata.chartHeight + padding.top + padding.bottom;
    var rect = Rect.fromPoints(Offset(rectPosX0, rectPosY0), Offset(rectPosX1, rectPosY1));
    final rectPaint = Paint()..color = ui.Color.fromARGB(255, 255, 255, 255);
    canvas.drawRect(rect, rectPaint);

    final double yOffsetInterval =
        (metadata.chartHeight - bottomColumnHeight - topColumnHeight) / (metadata.yAxisLabelCount - 1);

    final TextPainter axisLabelPainter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: ui.TextDirection.ltr,
    );
    for (int i = 0; i < metadata.yAxisLabelCount; i++) {
      double y = metadata.chartHeight - (i * yOffsetInterval) + padding.top - bottomColumnHeight;

      // Draw Y-axis scale points

      final String label = labels[i].$1;
      final double labelWidth = labels[i].$2;

      axisLabelPainter.text = TextSpan(
        text: label,
        style: labelTextStyle,
      );

      double xLabelPos;

      if (opposite == false) {
        // Linke Seite
        xLabelPos = padding.left - labelWidth - 10;
      } else {
        // rechte Seite
        xLabelPos = (config.scrollable ? metadata.layoutWidth : metadata.canvasWidth) - padding.right + 10;
      }
      axisLabelPainter.layout();
      final yLabelPos = y - axisLabelPainter.height / 2;
      axisLabelPainter.paint(canvas, Offset(xLabelPos, yLabelPos));
    }
  }

  /// Malt die Labels auf der Y-Achse und alle horizontalen X-Linien des Datengrids
  ///
  /// Berechnet die Höhe der einzelnen Zeilen anhand der gegebenen Label-Counts.
  /// Labels werden links neben dem Chart gemalt.
  ///
  static void drawYAxisHorizontalGridLine({
    required Canvas canvas,
    required ChartConfig config,
    required ChartPainterMetadata metadata,
    required YAxisConfig yAxisConfig,
    required bool showGridHorizontal,
    required ChartPadding padding,
    required Paint gridPaint,
    required TextPainter axisLabelPainter,
    ChartColumnBlocks? columnBlocks,
    required bool opposite, // if true the right y-axis labels will be printed
  }) {
    if (!showGridHorizontal) {
      // Wenn kein Grid und keine Labels gezeichnet werden sollen, muss auch nichts berechnet werden
      return;
    }

    // Blocks werden für die korrekte Berechnung der Labelposition benötigt
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

    final double yOffsetInterval =
        (metadata.chartHeight - bottomColumnHeight - topColumnHeight) / (metadata.yAxisLabelCount - 1);

    for (int i = 0; i < metadata.yAxisLabelCount; i++) {
      double y = metadata.chartHeight - (i * yOffsetInterval) + padding.top - bottomColumnHeight;

      // Don't draw the first horizontal grid line because there is already the x-Axis line
      // Falls die Column Legende angezeigt werden soll dann die erste Line auch zeichnen
      if ((i != 0 && showGridHorizontal) || showColumnBottomDatas) {
        canvas.drawLine(Offset(padding.left.toDouble(), y), Offset(metadata.chartWidth + padding.left, y), gridPaint);
      }
    }
  }

  static void drawDataLinechartDataPointsAndPath({
    required ChartPainterMetadata metadata,
    required Canvas canvas,
    required ChartPadding padding,
    required Offset? mousePosition,
    required List<CooLineChartDataSeries> linechartDataSeries,
    required bool centerDataPointBetweenVerticalGrid,
    required bool curvedLine,
    required bool highlightPoints,
    required int mouseInRectYIndex,
    ChartColumnBlocks? columnBlocks,
  }) {
    // TODO move to theme
    final linePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Paint pointPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    final Paint pointPaintHighlight = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final TextPainter dataLabelPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );

    final columnBottomDatasHeight =
        columnBlocks != null && columnBlocks.showBottomBlocks ? columnBlocks.bottomConfig.height.toDouble() : 0;
    // Die Segment-width muss über alle vorhandenen Datenpunkte aller Reihen berechnet werden.
    for (var i = 0; i < linechartDataSeries.length; i++) {
      CooLineChartDataSeries localLinechartDataSeries = linechartDataSeries[i];
      List<String?> dataSeriesLabels = List.empty(growable: true);
      List<double?> dataPointValues = localLinechartDataSeries.dataPoints.map((e) => e.value).toList();

      // Alle Punkte auf einen Bereich zwischen 0.0 und 1.0 bringen um sie in der Fläche relativ berechnen zu können
      List<double?> dataSeriesNormalizedValues = CooChartPainterUtil.normalizeChartDataPoints(
        linechartDataPoints: dataPointValues,
        minDataPointValue: metadata.minDataPointValue,
        yAxisMinValue: metadata.yAxisMinValue,
        yAxisMaxValue: metadata.yAxisMaxValue,
      );

      final segmentWidthCurve = metadata.xSegmentWidth / 3; // each datapoint segment width

      /// calculate datapoint positions
      var lineDataPoints = List<Offset?>.empty(growable: true);
      double lastX = 0;
      double lastY = 0;

      var lineChartDataPointsPath = Path();
      bool startPointAdded = false;
      dataPointsLoop:
      for (var i = 0; i < dataSeriesNormalizedValues.length; i++) {
        // Lables für den späteren plotten parsen
        CooLineChartDataPoint dataPoint = localLinechartDataSeries.dataPoints[i];
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
          x = (i * metadata.xSegmentWidth) + padding.left;
        }
        if (centerDataPointBetweenVerticalGrid) {
          x += metadata.xSegementWidthHalf; // add center offset
        }

        final startYPos = metadata.canvasHeight - padding.top - padding.bottom - columnBottomDatasHeight;
        final y = startYPos - (dataValue * startYPos) + padding.top;

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
          chartWidth: metadata.chartWidth,
          chartHeigt: metadata.chartHeight,
          metadata: metadata,
          dataSeries: localLinechartDataSeries,
          minMaxPoints: localLinechartDataSeries.dataPoints,
          mousePosition: mousePosition,
          dataPointColumnLegendHeight: columnBottomDatasHeight,
          centerDataPointBetweenVerticalGrid: centerDataPointBetweenVerticalGrid,
          curvedLine: curvedLine,
          padding: padding,
        );
      }
      // Linechart Verbindungsline malen
      if (localLinechartDataSeries.showDataLine) {
        if (localLinechartDataSeries.dataLineColor != null) {
          linePaint.color = localLinechartDataSeries.dataLineColor!;

          // Falls die Linefarbe angegeben wurde wird diese als default für die Datenpunkte, Highlight und Font gesetzt.
          pointPaint.color = localLinechartDataSeries.dataLineColor!;
          pointPaintHighlight.color = localLinechartDataSeries.dataLineColor!;
        }
        canvas.drawPath(
          lineChartDataPointsPath,
          linePaint,
        );
      }

      if (localLinechartDataSeries.dataPointColor != null) {
        pointPaint.color = localLinechartDataSeries.dataPointColor!;
      }
      if (localLinechartDataSeries.dataPointHighlightColor != null) {
        pointPaintHighlight.color = localLinechartDataSeries.dataPointHighlightColor!;
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
          canvas.drawCircle(dataPointOffset, 8, pointPaintHighlight);
        } else if (localLinechartDataSeries.showDataPoints) {
          canvas.drawCircle(dataPointOffset, 4, pointPaint);
        }

        // Data Point Label malen
        if (localLinechartDataSeries.showDataLabels) {
          String? label = dataSeriesLabels[i];
          if (label != null) {
            dataLabelPainter.text = TextSpan(text: label, style: localLinechartDataSeries.dataPointLabelTextStyle);
            dataLabelPainter.layout();

            double xPosCenter;
            double yPos;
            switch (localLinechartDataSeries.dataPointLabelPosition) {
              case DataPointLabelPos.top:
                // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
                xPosCenter = (dataPointOffset.dx) - (dataLabelPainter.width / 2);
                yPos = dataPointOffset.dy - 25 + (localLinechartDataSeries.dataPointLabelPadding * -1);
                break;
              case DataPointLabelPos.right:
                xPosCenter = (dataPointOffset.dx) + 10 + localLinechartDataSeries.dataPointLabelPadding;
                yPos = dataPointOffset.dy - (dataLabelPainter.height / 2);
                break;
              case DataPointLabelPos.left:
                xPosCenter = (dataPointOffset.dx) - 30 + (localLinechartDataSeries.dataPointLabelPadding * -1);
                yPos = dataPointOffset.dy - (dataLabelPainter.height / 2);
                break;
              case DataPointLabelPos.bottom:
                // Berechnen des Startpunktes damit der Text in seiner errechneten Größe mittig ist
                xPosCenter = (dataPointOffset.dx) - (dataLabelPainter.width / 2);
                yPos = dataPointOffset.dy + 10 + localLinechartDataSeries.dataPointLabelPadding;
                break;
            }

            dataLabelPainter.paint(canvas, Offset(xPosCenter, yPos));
          }
        }
      }
    }
  }

  static void _drawMinMaxDataPointArea({
    required Canvas canvas,
    required double chartWidth,
    required double chartHeigt,
    required ChartPadding padding,
    required ChartPainterMetadata metadata,
    required Offset? mousePosition,
    required CooLineChartDataSeries dataSeries,
    required List<CooLineChartDataPoint> minMaxPoints,
    required bool centerDataPointBetweenVerticalGrid,
    required bool curvedLine,
    required dataPointColumnLegendHeight,
  }) {
    // TODO move to theme
    final lineAreaPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Min- Max-Datenpunkte in eine Reihe bringen um eine Form zu bilden
    List<double?> minPoints = minMaxPoints.map((e) => e.minValue).toList();
    List<double?> maxPoints = minMaxPoints.map((e) => e.maxValue).toList();

    // Alle hintereinander ergibt das custom paint path die zweite reihe reversed,
    // damit es einen ordentlichen Kreis ergib

    List<double?> minPointsNormalized = CooChartPainterUtil.normalizeChartDataPoints(
      linechartDataPoints: minPoints,
      minDataPointValue: metadata.minDataPointValue,
      yAxisMinValue: metadata.yAxisMinValue,
      yAxisMaxValue: metadata.yAxisMaxValue,
    );
    List<double?> maxPointsNormalized = CooChartPainterUtil.normalizeChartDataPoints(
      linechartDataPoints: maxPoints,
      minDataPointValue: metadata.minDataPointValue,
      yAxisMinValue: metadata.yAxisMinValue,
      yAxisMaxValue: metadata.yAxisMaxValue,
    );

    final segmentWidthCurve = metadata.xSegmentWidth / 3; // each datapoint segment width

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
        x = (i * metadata.xSegmentWidth) + padding.left;
      }
      if (centerDataPointBetweenVerticalGrid) {
        x += metadata.xSegementWidthHalf; // add center offset
      }

      final startYPos = metadata.canvasHeight - padding.top - padding.bottom - dataPointColumnLegendHeight;
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
        x = (i * metadata.xSegmentWidth) + padding.left;
      }
      if (centerDataPointBetweenVerticalGrid) {
        x += metadata.xSegementWidthHalf; // add center offset
      }

      final startYPos = metadata.canvasHeight - padding.top - padding.bottom - dataPointColumnLegendHeight;
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
      lineAreaPaint.color = dataSeries.minMaxAreaColor!;
      lineAreaPaint.style = PaintingStyle.fill;
    }
    canvas.drawPath(
      lineChartDataPointsPath,
      lineAreaPaint,
    );
  }
}
