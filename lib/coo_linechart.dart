import 'dart:ui' as ui;

import 'package:coo_charts/chart_column_blocks.dart';
import 'package:coo_charts/chart_config.dart';
import 'package:coo_charts/chart_tab_info.dart';
import 'package:coo_charts/coo_linechart_data_point.dart';
import 'package:coo_charts/coo_linechart_data_serie.dart';
import 'package:coo_charts/linechart_painter.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as image;

class CooLinechart extends StatefulWidget {
  const CooLinechart({
    super.key,
    required this.dataSeries,
    this.columnBlocks,
    this.chartConfig = const ChartConfig(),
    this.yAxisConfig = const YAxisConfig(),
    this.xAxisConfig = const XAxisConfig(),
    this.padding = const ChartPadding(),
    this.onDataPointTab,
  });

  final List<CooLinechartDataSeries> dataSeries;
  final ChartColumnBlocks? columnBlocks;

  final ChartConfig chartConfig;

  /// Die Konfiguration der Y-Achse
  final YAxisConfig yAxisConfig;
  final XAxisConfig xAxisConfig;

  final ChartPadding padding;

  final Function(int, List<CooLinechartDataPoint>)? onDataPointTab;

  @override
  State<CooLinechart> createState() => _CooLinechartState();
}

class _CooLinechartState extends State<CooLinechart> {
  Offset? _mousePointer;
  final chartTabInfo = ChartTabInfo();

  bool initialized = false;

  final columLegendsAssetImages = <String, ui.Image>{};
  final columLegendsAssetSvgPictureInfos = <String, PictureInfo>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.columnBlocks != null) {
      loadColumnDataImageAssets(widget.columnBlocks!, () {
        setState(() {});
      });
    }
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      // Use Screensize as default and parent widget size, if available
      if (constraints.maxHeight != double.infinity) {
        height = constraints.maxHeight;
      }
      if (constraints.maxWidth != double.infinity) {
        width = constraints.maxWidth;
      }

      return GestureDetector(
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              _mousePointer = event.localPosition;
            });
          },
          onExit: (event) {
            setState(() {
              _mousePointer = null;
            });
          },
          child: SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: LineChartPainter(
                linechartDataSeries: widget.dataSeries,
                columnBlocks: widget.columnBlocks,
                canvasWidth: width,
                canvasHeight: height,
                padding: widget.padding,
                mousePosition: _mousePointer,
                chartTabInfo: chartTabInfo,
                curvedLine: widget.chartConfig.curvedLine,
                crosshair: widget.chartConfig.crosshair,
                showGridHorizontal: widget.chartConfig.showGridHorizontal,
                showGridVertical: widget.chartConfig.showGridVertical,
                highlightMouseColumn: widget.chartConfig.highlightMouseColumn,
                highlightPoints: widget.chartConfig.highlightPoints,
                highlightPointsVerticalLine: widget.chartConfig.highlightPointsVerticalLine,
                highlightPointsHorizontalLine: widget.chartConfig.highlightPointsHorizontalLine,
                xAxisConfig: widget.xAxisConfig,
                centerDataPointBetweenVerticalGrid: widget.chartConfig.centerDataPointBetweenVerticalGrid,
                yAxisConfig: widget.yAxisConfig,
                columLegendsAssetImages: columLegendsAssetImages,
                columLegendsAssetSvgPictureInfos: columLegendsAssetSvgPictureInfos,
                onDataPointTabCallback: widget.onDataPointTab,
              ),
            ),
          ),
        ),
        onTapDown: (detail) {
          chartTabInfo.tabDownDetails = detail;
          chartTabInfo.tabCount = chartTabInfo.tabCount + 1;
          setState(() {});
        },
      );
    });
  }

  void loadColumnDataImageAssets(
    ChartColumnBlocks columnBlocks,
    final VoidCallback onLoadingFinished,
  ) async {
    if (initialized) {
      return;
    }

    for (var columnBottomData in columnBlocks.bottomDatas) {
      if (columnBottomData.assetImages.isEmpty) {
        continue;
      }
      blockAssetImageLoop:
      for (var blockAssetImage in columnBottomData.assetImages) {
        final String assetImagePath = blockAssetImage.path;
        if (columLegendsAssetImages[assetImagePath] != null) {
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
    initialized = true;
    onLoadingFinished();
  }
}

/// Welchen Datentyp hat die X-Achse?
enum XAxisValueType {
  number, // Einfache Durchnummerierung 1,2,3.. (es kann ein Startwert angegeben werden)
  datetime, // Datum mit Zeitangabe
  date, // Datum ohne Zeitangabe
}

/// In welchem Range sollen die Labels angebracht werden?
/// Mo 13.4., Di 14.4., Do 15.4., ...
/// Jan, Feb, Mar, ...
/// 2023, 2024, 2025
enum XAxisDateTimeLabelSpan { hour, day, month, year }
