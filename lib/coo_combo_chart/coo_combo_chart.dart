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
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';

/// A combo chart widget that can display both line charts and bar charts in a single view.
/// 
/// Perfect for displaying weather data with temperature lines and precipitation bars.
class CooComboChart extends StatefulWidget {
  const CooComboChart({
    super.key,
    this.lineDataSeries = const [],
    this.barDataSeries = const [],
    this.columnBlocks,
    this.chartConfig = const ChartConfig(),
    this.leftYAxisConfig = const YAxisConfig(),
    this.rightYAxisConfig = const YAxisConfig(),
    this.xAxisConfig = const XAxisConfig(),
    this.padding = const ChartPadding(),
    this.onDataPointTab,
    this.xAxisStepLineTopLabelCallback,
    this.xAxisStepLineBottomLabelCallback,
  });

  /// Line chart data series (typically for temperature)
  final List<CooLineChartDataSeries> lineDataSeries;
  
  /// Bar chart data series (typically for precipitation)
  final List<CooBarChartDataSeries> barDataSeries;
  
  final ChartColumnBlocks? columnBlocks;
  final ChartConfig chartConfig;

  /// Configuration for the left Y-axis (typically for line charts)
  final YAxisConfig leftYAxisConfig;
  
  /// Configuration for the right Y-axis (typically for bar charts)
  final YAxisConfig rightYAxisConfig;
  
  final XAxisConfig xAxisConfig;
  final ChartPadding padding;

  /// Callback function on data point tap
  final Function(int, List<CooLineChartDataPoint>)? onDataPointTab;

  /// Callback function to create a label on the top of the x-axis-steps
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineTopLabelCallback;

  /// Callback function to create a label on the bottom of the x-axis-steps
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineBottomLabelCallback;

  @override
  State<CooComboChart> createState() => _CooComboChartState();
}

class _CooComboChartState extends State<CooComboChart> {
  ChartTabInfo tabInfo = ChartTabInfo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return _buildChart(size);
      },
    );
  }

  Widget _buildChart(Size size) {
    if (widget.lineDataSeries.isEmpty && widget.barDataSeries.isEmpty) {
      return Container(
        width: size.width,
        height: size.height,
        color: widget.chartConfig.theme.chartBackgroundColor,
        child: const Center(
          child: Text('No data available'),
        ),
      );
    }

    // Combine all data points for metadata calculation
    List<CooLineChartDataPoint> allDataPoints = [];
    for (var series in widget.lineDataSeries) {
      allDataPoints.addAll(series.dataPoints);
    }
    
    // Convert bar chart data points to line chart data points for metadata calculation
    for (var series in widget.barDataSeries) {
      for (var barPoint in series.dataPoints) {
        allDataPoints.add(CooLineChartDataPoint(
          value: barPoint.value,
          minValue: barPoint.minValue,
          maxValue: barPoint.maxValue,
          time: barPoint.time,
        ));
      }
    }

    if (allDataPoints.isEmpty) {
      return Container(
        width: size.width,
        height: size.height,
        color: widget.chartConfig.theme.chartBackgroundColor,
        child: const Center(
          child: Text('No data points available'),
        ),
      );
    }

    final chartPainterInit = ChartPainterInit();
    final chartPainterMetadata = chartPainterInit.create(
      allDataPoints,
      widget.leftYAxisConfig,
      widget.rightYAxisConfig,
      widget.xAxisConfig,
      widget.chartConfig,
      size,
      widget.columnBlocks,
      tabInfo,
    );

    return GestureDetector(
      onTapDown: (details) => _onTapDown(details, chartPainterMetadata),
      onPanUpdate: (details) => _onPanUpdate(details, chartPainterMetadata),
      child: CustomPaint(
        size: size,
        painter: CooComboChartPainter(
          lineDataSeries: widget.lineDataSeries,
          barDataSeries: widget.barDataSeries,
          chartPainterMetadata: chartPainterMetadata,
          columnBlocks: widget.columnBlocks,
          xAxisStepLineTopLabelCallback: widget.xAxisStepLineTopLabelCallback,
          xAxisStepLineBottomLabelCallback: widget.xAxisStepLineBottomLabelCallback,
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, ChartPainterMetadata chartPainterMetadata) {
    if (widget.onDataPointTab == null) return;

    final localPosition = details.localPosition;
    final columnIndex = CooChartPainterUtil.getColumnIndexFromPosition(
      localPosition,
      chartPainterMetadata,
    );

    if (columnIndex != null && columnIndex < widget.lineDataSeries.first.dataPoints.length) {
      final dataPointsAtIndex = widget.lineDataSeries.map((series) => series.dataPoints[columnIndex]).toList();
      widget.onDataPointTab!(columnIndex, dataPointsAtIndex);
    }
  }

  void _onPanUpdate(PanUpdateDetails details, ChartPainterMetadata chartPainterMetadata) {
    if (!widget.chartConfig.highlightMouseColumn) return;

    final localPosition = details.localPosition;
    final columnIndex = CooChartPainterUtil.getColumnIndexFromPosition(
      localPosition,
      chartPainterMetadata,
    );

    if (columnIndex != tabInfo.highlightTabColumnIndex) {
      setState(() {
        tabInfo.highlightTabColumnIndex = columnIndex;
      });
    }
  }
}

/// Custom painter for the combo chart
class CooComboChartPainter extends CustomPainter {
  CooComboChartPainter({
    required this.lineDataSeries,
    required this.barDataSeries,
    required this.chartPainterMetadata,
    this.columnBlocks,
    this.xAxisStepLineTopLabelCallback,
    this.xAxisStepLineBottomLabelCallback,
  });

  final List<CooLineChartDataSeries> lineDataSeries;
  final List<CooBarChartDataSeries> barDataSeries;
  final ChartPainterMetadata chartPainterMetadata;
  final ChartColumnBlocks? columnBlocks;
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineTopLabelCallback;
  final String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineBottomLabelCallback;

  @override
  void paint(Canvas canvas, Size size) {
    final chartPainter = CooChartPainter();
    
    // Draw the base chart (grid, axes, etc.)
    chartPainter.drawChart(
      canvas,
      size,
      lineDataSeries.isNotEmpty ? lineDataSeries : [CooLineChartDataSeries(dataPoints: [])],
      chartPainterMetadata,
      columnBlocks,
      xAxisStepLineTopLabelCallback,
      xAxisStepLineBottomLabelCallback,
      CooChartType.line,
    );

    // Draw bar charts first (background)
    for (var barSeries in barDataSeries) {
      _drawBarSeries(canvas, barSeries, chartPainterMetadata);
    }

    // Draw line charts on top
    for (var lineSeries in lineDataSeries) {
      _drawLineSeries(canvas, lineSeries, chartPainterMetadata);
    }

    // Draw SVG icons for data points
    for (var lineSeries in lineDataSeries) {
      _drawSvgIcons(canvas, lineSeries, chartPainterMetadata);
    }
  }

  void _drawBarSeries(Canvas canvas, CooBarChartDataSeries barSeries, ChartPainterMetadata metadata) {
    final paint = Paint()
      ..color = barSeries.barColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < barSeries.dataPoints.length; i++) {
      final dataPoint = barSeries.dataPoints[i];
      if (dataPoint.value == null) continue;

      final x = metadata.chartAreaRect.left + (i * metadata.columnWidth) + (metadata.columnWidth / 2);
      final barWidth = barSeries.maxBarWidth ?? 20.0;
      
      // Calculate bar height based on right Y-axis scale
      final valueRatio = (dataPoint.value! - metadata.rightYAxisMinValue) / 
                        (metadata.rightYAxisMaxValue - metadata.rightYAxisMinValue);
      final barHeight = valueRatio * metadata.chartAreaRect.height;
      
      final barRect = Rect.fromLTWH(
        x - barWidth / 2,
        metadata.chartAreaRect.bottom - barHeight,
        barWidth,
        barHeight,
      );

      canvas.drawRect(barRect, paint);
    }
  }

  void _drawLineSeries(Canvas canvas, CooLineChartDataSeries lineSeries, ChartPainterMetadata metadata) {
    if (!lineSeries.showDataLine && !lineSeries.showDataPoints) return;

    final paint = Paint()
      ..color = lineSeries.dataLineColor ?? Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    bool isFirstPoint = true;

    for (int i = 0; i < lineSeries.dataPoints.length; i++) {
      final dataPoint = lineSeries.dataPoints[i];
      if (dataPoint.value == null) continue;

      final x = metadata.chartAreaRect.left + (i * metadata.columnWidth) + (metadata.columnWidth / 2);
      
      // Calculate y position based on left Y-axis scale
      final valueRatio = (dataPoint.value! - metadata.leftYAxisMinValue) / 
                        (metadata.leftYAxisMaxValue - metadata.leftYAxisMinValue);
      final y = metadata.chartAreaRect.bottom - (valueRatio * metadata.chartAreaRect.height);

      if (isFirstPoint) {
        path.moveTo(x, y);
        isFirstPoint = false;
      } else {
        path.lineTo(x, y);
      }

      // Draw data points
      if (lineSeries.showDataPoints) {
        final pointPaint = Paint()
          ..color = lineSeries.dataPointColor ?? Colors.red
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(x, y), 4.0, pointPaint);
      }

      // Draw data labels
      if (lineSeries.showDataLabels && dataPoint.label != null) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: dataPoint.label!,
            style: lineSeries.dataPointLabelTextStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        final labelY = y - 20; // Position above the point
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, labelY));
      }
    }

    if (lineSeries.showDataLine) {
      canvas.drawPath(path, paint);
    }
  }

  void _drawSvgIcons(Canvas canvas, CooLineChartDataSeries lineSeries, ChartPainterMetadata metadata) {
    // Note: SVG rendering would require flutter_svg integration
    // This is a placeholder for SVG icon rendering logic
    for (int i = 0; i < lineSeries.dataPoints.length; i++) {
      final dataPoint = lineSeries.dataPoints[i];
      if (dataPoint.svgIcon == null || dataPoint.value == null) continue;

      final x = metadata.chartAreaRect.left + (i * metadata.columnWidth) + (metadata.columnWidth / 2);
      final valueRatio = (dataPoint.value! - metadata.leftYAxisMinValue) / 
                        (metadata.leftYAxisMaxValue - metadata.leftYAxisMinValue);
      final y = metadata.chartAreaRect.bottom - (valueRatio * metadata.chartAreaRect.height);

      // TODO: Implement SVG rendering here
      // This would involve loading and rendering the SVG at the calculated position
      // For now, we'll draw a placeholder circle
      final paint = Paint()
        ..color = Colors.orange
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x + dataPoint.svgIcon!.offsetX, y + dataPoint.svgIcon!.offsetY), 
        8.0, 
        paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
