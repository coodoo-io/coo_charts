// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:coo_charts/chart_column_block_config_image.dart';
import 'package:coo_charts/chart_column_blocks.dart';
import 'package:coo_charts/chart_padding.enum.dart';
import 'package:coo_charts/y_axis_config.dart';
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
      // TODO ausschließlich PNGs erlauben..
      if (assetImagePath.endsWith('.png')) {
        try {
          ui.Image uiImg = await loadImage(assetImagePath, blockAssetImage.height);
          // TODO nicht nur nach assetpath speichern sondern auch nach gwünschter größe
          columLegendsAssetImages[assetImagePath] = uiImg;
        } catch (e) {
          // TODO Logging
        }
        continue blockAssetImageLoop;
      }
      try {
        PictureInfo pictureInfo = await vg.loadPicture(SvgAssetLoader(assetImagePath), null);

        // Change colum legend image size so that it fits into the legend column
        // the legend column height is given
        var imageHeight = pictureInfo.size.height.toInt();
        var imageWidth = pictureInfo.size.width.toInt();
        ui.Image svgImg = pictureInfo.picture.toImageSync(imageHeight, imageWidth);
        final height = columnBlocks.bottomConfig.height;
        if (imageHeight > height) {
          // Größe muss umgerechnet werden damit es in die Legende passt
          final ByteData? assetImageByteData = await svgImg.toByteData(format: ui.ImageByteFormat.png);
          if (assetImageByteData != null) {
            image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List())!;
            image.Image resizeImage = image.copyResize(baseSizeImage, height: blockAssetImage.height);
            ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(resizeImage));
            ui.FrameInfo frameInfo = await codec.getNextFrame();
            svgImg = frameInfo.image;
          }
        }
        columLegendsAssetImages[assetImagePath] = svgImg;
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
