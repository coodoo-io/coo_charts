import 'dart:ui' as ui;

import 'package:coo_charts/chart_painter/chart_painter_init.dart';
import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/chart_painter/coo_chart_y_axis_painter.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/chart_tab_info.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/coo_chart_themes.dart';
import 'package:coo_charts/common/coo_chart_type.enum.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The CooLineChart Widget.
///
/// Prints a line chart with optional min-max-range range.
class CooLineChart extends StatefulWidget {
  const CooLineChart({
    super.key,
    required this.dataSeries,
    this.columnBlocks,
    this.chartConfig = const ChartConfig(),
    this.yAxisConfig = const YAxisConfig(),
    this.yAxisOppositeConfig = const YAxisConfig(),
    this.xAxisConfig = const XAxisConfig(),
    this.padding = const ChartPadding(),
    this.onDataPointTab,
    this.xAxisStepLineTopLabelCallback,
    this.xAxisStepLineBottomLabelCallback,
  });

  final List<CooLineChartDataSeries> dataSeries;
  final ChartColumnBlocks? columnBlocks;

  final ChartConfig chartConfig;

  /// Die Konfiguration der Y-Achse
  final YAxisConfig yAxisConfig; // Left axis
  final YAxisConfig yAxisOppositeConfig; // opposite (right) y-axis
  final XAxisConfig xAxisConfig;

  final ChartPadding padding;

  /// Callback function on column tab
  ///
  /// First parameter: Column index (starts at 0)
  /// Second parameter: the [CooLineChartDataPoint] objects which are in this tabbed column
  final Function(int, List<CooLineChartDataPoint>)? onDataPointTab;

  /// If given every step this callback will be invoekd
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineTopLabelCallback;
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineBottomLabelCallback;

  @override
  State<CooLineChart> createState() => _CooLineChartState();
}

class _CooLineChartState extends State<CooLineChart> {
  Offset? _mousePointer;
  final chartTabInfo = ChartTabInfo();

  bool initialized = false;

  final columLegendsAssetImages = <String, ui.Image>{};
  final columLegendsAssetSvgPictureInfos = <String, PictureInfo>{};

  double? scrollControllerOffset;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.columnBlocks != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadColumnDataImageAssets(widget.columnBlocks!, () {
          if (context.mounted) {
            setState(() {});
          }
        });
        // executes after build
      });
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      // Use Screensize as default and parent widget size, if available
      if (constraints.maxHeight != double.infinity) {
        height = constraints.maxHeight;
      }
      if (constraints.maxWidth != double.infinity) {
        width = constraints.maxWidth;
      }

      ChartPainterMetadata metadata = ChartPainterInit.initializeValues(
        chartConfig: widget.chartConfig,
        linechartDataSeries: widget.dataSeries.where((element) => element.opposite == false).toList(),
        barchartDataSeries: [],
        layoutHeight: height,
        layoutWidth: width,
        padding: widget.padding,
        xAxisConfig: widget.xAxisConfig,
        yAxisConfig: widget.yAxisConfig,
      );

      ChartPainterMetadata metadataOpposite = ChartPainterInit.initializeValues(
        chartConfig: widget.chartConfig,
        linechartDataSeries: widget.dataSeries.where((element) => element.opposite == true).toList(),
        barchartDataSeries: [],
        layoutHeight: height,
        layoutWidth: width,
        padding: widget.padding,
        xAxisConfig: widget.xAxisConfig,
        yAxisConfig: widget.yAxisOppositeConfig,
      );

      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        scrollControllerOffset = scrollController.offset;
      });

      Offset? scrollPositionMousePointer;
      if (scrollControllerOffset != null) {
        scrollPositionMousePointer = Offset(scrollControllerOffset! + (_mousePointer != null ? _mousePointer!.dx : 0),
            _mousePointer != null ? _mousePointer!.dy : -1);
      } else if (_mousePointer != null) {
        scrollPositionMousePointer = _mousePointer;
      }

      final chartPaint = GestureDetector(
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
          child: CustomPaint(
            size: Size(metadata.canvasWidth, metadata.canvasHeight),
            painter: CooChartPainter(
              chartConfig: widget.chartConfig,
              theme: widget.chartConfig.theme ?? CooChartThemes().defaultTheme,
              metadata: metadata,
              metadataOpposite: metadataOpposite,
              chartType: CooChartType.line,
              linechartDataSeries: widget.dataSeries,
              barchartDataSeries: [],
              columnBlocks: widget.columnBlocks,
              padding: widget.padding,
              mousePosition: scrollPositionMousePointer,
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
              yAxisOppositeConfig: widget.yAxisOppositeConfig,
              columLegendsAssetImages: columLegendsAssetImages,
              columLegendsAssetSvgPictureInfos: columLegendsAssetSvgPictureInfos,
              onLineChartDataPointTabCallback: widget.onDataPointTab,
              xAxisStepLineTopLabelLineChartCallback: widget.xAxisStepLineTopLabelCallback,
              xAxisStepLineBottomLabelLineChartCallback: widget.xAxisStepLineBottomLabelCallback,
            ),
          ),
        ),
        onTapDown: (detail) {
          chartTabInfo.tabDownDetails = detail;
          chartTabInfo.tabCount = chartTabInfo.tabCount + 1;
          setState(() {});
          if (scrollController.hasClients) {
            scrollController.position.notifyListeners();
          }
        },
      );

      return Stack(
        children: [
          widget.chartConfig.scrollable
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  child: chartPaint,
                )
              : chartPaint,
          CustomPaint(
            painter: CooChartYAxisPainter(
              chartConfig: widget.chartConfig,
              columnBlocks: widget.columnBlocks,
              metadata: metadata,
              metadataOpposite: metadataOpposite,
              padding: widget.padding,
              yAxisConfig: widget.yAxisConfig,
              yAxisOppositeConfig: widget.yAxisOppositeConfig,
            ),
          )
        ],
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
    await CooChartPainterUtil().loadColumnDataImageAssets(
        columnBlocks: columnBlocks,
        columLegendsAssetImages: columLegendsAssetImages,
        columLegendsAssetSvgPictureInfos: columLegendsAssetSvgPictureInfos);
    initialized = true;
    onLoadingFinished();
  }
}
