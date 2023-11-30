import 'dart:ui' as ui;

import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:flutter/material.dart';

class CooChartYAxisPainter extends CustomPainter {
  CooChartYAxisPainter({
    required this.metadata,
    required this.metadataOpposite,
    required this.yAxisConfig,
    required this.yAxisOppositeConfig,
    required this.columnBlocks,
    required this.chartConfig,
    required this.padding,
  });

  final ChartConfig chartConfig;

  final ChartPadding padding;

  final ChartPainterMetadata metadata;
  final ChartPainterMetadata? metadataOpposite;

  /// Die Konfiguration für X- und Y-Achse
  final YAxisConfig yAxisConfig;
  final YAxisConfig? yAxisOppositeConfig;

  final ChartColumnBlocks? columnBlocks;

  final Paint _gridPaint = Paint()
    ..color = Colors.grey.withOpacity(0.4)
    ..strokeWidth = 1;

  final TextPainter _axisLabelPainter = TextPainter(
    textAlign: TextAlign.left,
    textDirection: ui.TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    CooChartPainterUtil.drawYAxisLabelAndHorizontalGridLine(
      canvas: canvas,
      config: chartConfig,
      metadata: metadata,
      yAxisConfig: yAxisConfig,
      columnBlocks: columnBlocks,
      showGridHorizontal: chartConfig.showGridHorizontal,
      padding: padding,
      gridPaint: _gridPaint,
      axisLabelPainter: _axisLabelPainter,
      opposite: false,
    );
    if (yAxisOppositeConfig != null && metadataOpposite != null) {
      CooChartPainterUtil.drawYAxisLabelAndHorizontalGridLine(
        canvas: canvas,
        config: chartConfig,
        metadata: metadataOpposite!,
        yAxisConfig: yAxisOppositeConfig!,
        columnBlocks: columnBlocks,
        showGridHorizontal: chartConfig.showGridHorizontal,
        padding: padding,
        gridPaint: _gridPaint,
        axisLabelPainter: _axisLabelPainter,
        opposite: true,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
