import 'dart:ui' as ui;

import 'package:coo_charts/chart_painter/chart_painter_init.dart';
import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/chart_tab_info.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/coo_chart_type.enum.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The CooBarChart Widget.
///
/// Prints a bar chart with optional min-max-range line.
class CooBarChart extends StatefulWidget {
  const CooBarChart({
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

  final List<CooBarChartDataSeries> dataSeries;
  final ChartColumnBlocks? columnBlocks;

  final ChartConfig chartConfig;

  /// Die Konfiguration der Y-Achse
  final YAxisConfig yAxisConfig;
  final YAxisConfig yAxisOppositeConfig;
  final XAxisConfig xAxisConfig;

  final ChartPadding padding;

  /// Callback function on column tab
  ///
  /// First parameter: Column index (starts at 0)
  /// Second parameter: the [CooBarChartDataPoint] objects which are in this tabbed column
  final Function(int, List<CooBarChartDataPoint>)? onDataPointTab;

  /// If given every step this callback will be invoekd
  final String Function(int, List<CooBarChartDataPoint>)? xAxisStepLineTopLabelCallback;
  final String Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomLabelCallback;

  @override
  State<CooBarChart> createState() => _CooBarChartState();
}

class _CooBarChartState extends State<CooBarChart> {
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadColumnDataImageAssets(widget.columnBlocks!, () {
          if (context.mounted) {
            setState(() {});
          }
        });
        // executes after build
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

      ChartPainterMetadata metadata = ChartPainterInit.initializeValues(
        linechartDataSeries: [],
        barchartDataSeries: widget.dataSeries,
        layoutHeight: height,
        layoutWidth: width,
        chartConfig: widget.chartConfig,
        padding: widget.padding,
        xAxisConfig: widget.xAxisConfig,
        yAxisConfig: widget.yAxisConfig,
      );

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
              painter: CooChartPainter(
                chartConfig: widget.chartConfig,
                metadata: metadata,
                metadataOpposite: null,
                chartType: CooChartType.bar,
                linechartDataSeries: [],
                barchartDataSeries: widget.dataSeries,
                columnBlocks: widget.columnBlocks,
                canvasBackgroundPaintingStyle: widget.chartConfig.canvasBackgroundPaintingStyle,
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
                centerDataPointBetweenVerticalGrid: true,
                yAxisConfig: widget.yAxisConfig,
                yAxisOppositeConfig: widget.yAxisOppositeConfig,
                columLegendsAssetImages: columLegendsAssetImages,
                columLegendsAssetSvgPictureInfos: columLegendsAssetSvgPictureInfos,
                onBarChartDataPointTabCallback: widget.onDataPointTab,
                xAxisStepLineTopLabelBarChartCallback: widget.xAxisStepLineTopLabelCallback,
                xAxisStepLineBottomLabelBarChartCallback: widget.xAxisStepLineBottomLabelCallback,
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
    await CooChartPainterUtil().loadColumnDataImageAssets(
        columnBlocks: columnBlocks,
        columLegendsAssetImages: columLegendsAssetImages,
        columLegendsAssetSvgPictureInfos: columLegendsAssetSvgPictureInfos);
    initialized = true;
    onLoadingFinished();
  }
}
