import 'dart:async';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:coo_charts/linechart_column_legend.dart';
import 'package:coo_charts/linechart_data_serie.dart';
import 'package:coo_charts/linechart_painter.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class LineChartWidget extends StatefulWidget {
  LineChartWidget({
    super.key,
    required this.linechartDataSeries,
    this.columnLegends = const [],
    this.columnLegendsHeight = 0,
    this.curvedLine = false,
    this.crosshair = false,
    this.showGridHorizontal = false,
    this.showGridVertical = false,
    this.showDataPath = true,
    this.highlightMouseColumn = false,
    this.highlightPoints = true,
    this.highlightPointsHorizontalLine = false,
    this.highlightPointsVerticalLine = true,
    this.addYAxisValueBuffer = true,
    this.centerDataPointBetweenVerticalGrid = false,
    this.yAxisConfig = const YAxisConfig(),
    this.xAxisConfig = const XAxisConfig(),
    this.padding = const ChartPadding(),
  });

  final List<LinechartDataSeries> linechartDataSeries;
  final List<LineChartColumnLegend> columnLegends;
  final double columnLegendsHeight;
  final bool curvedLine; // Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  final bool crosshair; // Soll ein Fadenkreuz angezeigt werden?
  final bool showGridHorizontal; // if true, grid horizontal lines are painted
  final bool showGridVertical; // if true, grid vertical lines are painted

  final bool showDataPath; // Soll der path auf der Kurve angezeigt werden?
  final bool highlightMouseColumn; // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  final bool highlightPoints; // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  final bool
      highlightPointsVerticalLine; // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.

  final bool
      highlightPointsHorizontalLine; // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  final bool addYAxisValueBuffer; // Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  final bool centerDataPointBetweenVerticalGrid;

  /// Die Konfiguration der Y-Achse
  final YAxisConfig yAxisConfig;
  final XAxisConfig xAxisConfig;

  final ChartPadding padding;

  final columLegendsAssetImages = <String, ui.Image>{};

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  Offset? _mousePointer;

  bool initialized = false;

  @override
  void initState() {
    super.initState();

    // So werdenalle SVGs nur einmal vorbereitet und geladen
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   loadAssets(widget.columnLegends);
    // });
  }

  @override
  Widget build(BuildContext context) {
    loadAssets(widget.columnLegends, () {
      setState(() {});
    });
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
                linechartDataSeries: widget.linechartDataSeries,
                columnLegends: widget.columnLegends,
                columnLegendsHeight: widget.columnLegendsHeight,
                canvasWidth: width,
                canvasHeight: height,
                padding: widget.padding,
                mousePosition: _mousePointer,
                curvedLine: widget.curvedLine,
                crosshair: widget.crosshair,
                showGridHorizontal: widget.showGridHorizontal,
                showGridVertical: widget.showGridVertical,
                highlightMouseColumn: widget.highlightMouseColumn,
                highlightPoints: widget.highlightPoints,
                highlightPointsVerticalLine: widget.highlightPointsVerticalLine,
                highlightPointsHorizontalLine: widget.highlightPointsHorizontalLine,
                xAxisConfig: widget.xAxisConfig,
                centerDataPointBetweenVerticalGrid: widget.centerDataPointBetweenVerticalGrid,
                yAxisConfig: widget.yAxisConfig,
                columLegendsAssetImages: widget.columLegendsAssetImages,
              ),
            ),
          ),
        ),
        onTapDown: (detail) {
          if (kDebugMode) {
            print('tab');
          }
        },
      );
    });
  }

  void loadAssets(
    List<LineChartColumnLegend> columnLegends,
    final VoidCallback onLoadingFinished,
  ) async {
    if (initialized) {
      return;
    }
    for (var columnLegend in columnLegends) {
      if (columnLegend.assetImage == null) {
        continue;
      }
      final String assetImagePath = columnLegend.assetImage!;
      PictureInfo pictureInfo = await vg.loadPicture(SvgAssetLoader(columnLegend.assetImage!), null);

      // Change colum legend image size so that it fits into the legend column
      // the legend column height is given
      var imageHeight = pictureInfo.size.height.toInt();
      var imageWidth = pictureInfo.size.width.toInt();
      ui.Image svgImg = pictureInfo.picture.toImageSync(imageHeight, imageWidth);
      if (imageHeight > widget.columnLegendsHeight) {
        // Größe muss umgerechnet werden damit es in die Legende passt
        double percentTile = widget.columnLegendsHeight / imageHeight;
        imageHeight = (imageHeight * percentTile).toInt();
        imageWidth = (imageWidth * percentTile).toInt();

        // var i2 = await getUiImage3(assetImagePath, imageHeight, imageWidth);

        final ByteData? assetImageByteData = await svgImg.toByteData(format: ui.ImageByteFormat.png);
        if (assetImageByteData != null) {
          image.Image? i = await image.decodeImage(assetImageByteData!.buffer.asUint8List());

          image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List())!;
          image.Image resizeImage = image.copyResize(baseSizeImage, height: imageHeight, width: imageWidth);
          ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(resizeImage));
          ui.FrameInfo frameInfo = await codec.getNextFrame();
          svgImg = frameInfo.image;
        }

        // image = await getUiImage(image, imageHeight, imageWidth);
      }
      widget.columLegendsAssetImages[assetImagePath] = svgImg;
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
