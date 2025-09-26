import 'dart:math';

import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config_image.dart';
import 'package:coo_charts/common/blocks/chart_column_block_data.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/coo_chart_themes.dart';
import 'package:coo_charts/common/coo_chart_type.enum.dart';
import 'package:coo_charts/common/data_point_label_pos.enum.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/x_axis_label_svg.dart';
import 'package:coo_charts/common/x_axis_label_widget.dart';
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';
import 'package:coo_charts_example/linechart_demo_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kIconWeatherCloudySvg = 'assets/sym_cloudy.svg';
const kIconWeatherRainSvg = 'assets/sym_rain.svg';
const kIconWindArrowSvg = 'assets/wind_over50.svg';
const kIconWindStrongSvg = 'assets/wind_over90.svg';
const kIconWindOver50Svg = 'assets/wind_over50.svg';
const kIconWindOver90Svg = 'assets/wind_over90.svg';
const kIconWeatherCloudyPng = 'assets/cloudcoverage-0.png';
const kIconWeatherRainPng = 'assets/cloudcoverage-6.png';
const kIconWindOver50Png = 'assets/wind_over50.png';
const kIconWindOver90Png = 'assets/wind_over90.png';

/// A wind barb widget that can be used as an X-axis label
class WindBarbWidget extends StatelessWidget {
  const WindBarbWidget({
    super.key,
    required this.windSpeed,
    this.size = const Size(40, 40),
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  });

  final double windSpeed;
  final Size size;
  final Color color;
  final double strokeWidth;

  /// Get the painter directly for use in chart rendering
  WindBarbPainter getPainter() {
    return WindBarbPainter(
      windSpeed: windSpeed,
      color: color,
      strokeWidth: strokeWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: getPainter(),
    );
  }
}

/// Custom painter for wind barbs
class WindBarbPainter extends CustomPainter {
  final double windSpeed;
  final Color color;
  final double strokeWidth;

  WindBarbPainter({
    required this.windSpeed,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print('WindBarbPainter.paint called with size: $size, windSpeed: $windSpeed');

    // Validate size to prevent NaN values
    if (size.width <= 0 ||
        size.height <= 0 ||
        size.width.isNaN ||
        size.height.isNaN ||
        size.width.isInfinite ||
        size.height.isInfinite) {
      print('Invalid size detected, drawing fallback');
      // Draw a simple fallback dot if size is invalid
      final Paint fallbackPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(5, 5), 3, fallbackPaint);
      return;
    }

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double shaftLength = size.width * 0.7; // Longer horizontal shaft
    final Offset start = Offset(size.width * 0.05, size.height / 2);
    final Offset end = Offset(start.dx + shaftLength, start.dy);

    print('Drawing wind barb: start=$start, end=$end, shaftLength=$shaftLength, windSpeed=$windSpeed');

    // Draw main shaft (horizontal line)
    canvas.drawLine(start, end, paint);

    // Draw directional arrow at the end
    _drawArrow(canvas, paint, end, size.width * 0.15);

    // Draw wind barbs based on speed
    if (windSpeed > 0.5) {
      _drawWindBarbs(canvas, paint, end, windSpeed, size);
    }

    // Add a small circle at the start for better visual reference
    final Paint circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(start, strokeWidth, circlePaint);
  }

  void _drawArrow(Canvas canvas, Paint paint, Offset end, double arrowSize) {
    final double arrowAngle = pi / 6; // 30 degrees
    final Offset left = Offset(
      end.dx - arrowSize * cos(arrowAngle),
      end.dy - arrowSize * sin(arrowAngle),
    );
    final Offset right = Offset(
      end.dx - arrowSize * cos(-arrowAngle),
      end.dy - arrowSize * sin(-arrowAngle),
    );

    canvas.drawLine(end, left, paint);
    canvas.drawLine(end, right, paint);
  }

  void _drawWindBarbs(Canvas canvas, Paint paint, Offset end, double speed, Size size) {
    // Validate inputs to prevent NaN calculations
    if (size.width <= 0 ||
        size.height <= 0 ||
        size.width.isNaN ||
        size.height.isNaN ||
        size.width.isInfinite ||
        size.height.isInfinite ||
        speed.isNaN ||
        speed.isInfinite) {
      return; // Skip drawing if invalid values
    }

    double barbSpacing = size.width * 0.12; // Spacing between barbs
    final double barbLength = size.height * 0.35;
    final double triangleBase = size.width * 0.12;
    final double triangleHeight = size.height * 0.35;
    final double halfBarbLength = size.height * 0.25;

    int fullBarbs = (speed / 1).floor(); // Each full line = 1.0 m/s
    bool hasHalfBarb = (speed % 1) >= 0.5;
    int triangles = (fullBarbs / 5).floor(); // Each triangle = 5 m/s
    fullBarbs %= 5; // Remove count covered by triangles

    Offset currentPoint = end;
    final double angle = pi / 3; // 60 degrees in radians

    // Draw triangles (5 m/s each)
    for (int i = 0; i < triangles; i++) {
      Offset right = currentPoint;
      Offset left = Offset(right.dx - triangleBase, right.dy);
      Offset top = Offset(
        right.dx - (triangleBase / 2),
        right.dy - triangleHeight, // Move upwards
      );

      Path triangle = Path()
        ..moveTo(right.dx, right.dy) // Right point
        ..lineTo(left.dx, left.dy) // Left point
        ..lineTo(top.dx, top.dy) // Top of the triangle
        ..close();

      canvas.drawPath(triangle, paint..style = PaintingStyle.fill);
      currentPoint = Offset(currentPoint.dx - barbSpacing, currentPoint.dy);
    }

    if (triangles > 0) {
      currentPoint = Offset(
        currentPoint.dx - (barbSpacing / 2),
        currentPoint.dy,
      );
    }

    // Reset paint style for lines
    paint.style = PaintingStyle.stroke;

    // Draw full barbs (1 m/s each)
    for (int i = 0; i < fullBarbs; i++) {
      Offset barbEnd = Offset(
        currentPoint.dx + barbLength * cos(angle),
        currentPoint.dy - barbLength * sin(angle), // Move upwards
      );
      canvas.drawLine(currentPoint, barbEnd, paint);
      currentPoint = Offset(currentPoint.dx - (barbSpacing * 0.7), currentPoint.dy);
    }

    // Draw half barb (0.5 m/s)
    if (hasHalfBarb) {
      Offset halfBarbEnd = Offset(
        currentPoint.dx + (halfBarbLength) * cos(angle),
        currentPoint.dy - (halfBarbLength) * sin(angle), // Move upwards
      );
      canvas.drawLine(currentPoint, halfBarbEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LineChartDemo extends StatefulWidget {
  const LineChartDemo({super.key});

  @override
  State<LineChartDemo> createState() => _LineChartDemoState();
}

class _LineChartDemoState extends State<LineChartDemo> {
  late List<CooLineChartDataSeries> linechartDataSeries = List.empty(growable: true);
  late List<CooBarChartDataSeries> barchartDataSeries = List.empty(growable: true);

  String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineBottomLabelLineChartCallback;
  String Function(int, List<CooLineChartDataPoint>)? xAxisStepLineTopLabelLineChartCallback;
  String Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomLabelBarChartCallback;
  String Function(int, List<CooBarChartDataPoint>)? xAxisStepLineTopLabelBarChartCallback;

  // SVG callback for X-axis labels
  XAxisLabelSvg? Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomSvgBarChartCallback;

  // Widget callback for X-axis labels
  XAxisLabelWidget? Function(int, List<CooBarChartDataPoint>)? xAxisStepLineBottomWidgetBarChartCallback;

  ChartColumnBlocks? chartColumnBlocks;
  ChartConfig chartConfig = const ChartConfig();
  double columnBottomDatasHeight = 40; // wie hoch soll die Column Legend sein, sofern sie übergeben wird?
  bool calcYAxisValuePadding = true;

  var xAxisConfig = const XAxisConfig();
  var yAxisConfig = const YAxisConfig();
  var yAxisOppositeConfig = const YAxisConfig();

  bool chartBackgroundColorBlack = false;

  CooChartType chartType = CooChartType.bar;

  // TMP Variablen
  bool showDataPoints = false;
  bool showDataLabels = false;
  bool showDataLine = false;

  int? yAxisLabelCount;

  /// X-Achse Config

  @override
  initState() {
    super.initState();
    // _generateKachelmannSonnenscheindauerTrend();
    // _generateBarchart1Bis10();
    // _generateKachelmannWindoenForecast();
    // _generateMultipleBarkchart();
    // _generateKachelmann14TageWetterTrend();
    // _create0To10To0ValuesChartDataPoints();
    // _create0To10ValuesChartDataPoints();
    _generateRainSnowGroupedBarChart();
    // _generateWindBarbChart();
    // _genrateRandomCooLinechartDataPoints();
    // _generateRandomDualLinechart();
    // _generateKachelmannVorhersageXL();
    // _createMinus5To5ValuesChartDataPoints();
    // _generateLargeVorhersageHourly();
    // _generate10DataPointsLargeNumer();
    // _generateEmptyLists();
    // _generateRandomDualLinechart();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: const SizedBox(
            height: 50,
            child: Row(),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: chartBackgroundColorBlack ? Colors.black : Colors.white,
            child: switch (chartType) {
              CooChartType.line => CooLineChart(
                  dataSeries: linechartDataSeries,
                  columnBlocks: chartColumnBlocks,
                  chartConfig: chartConfig,
                  onDataPointTab: (index, cooLinechartDataPoints) => print(
                      'Tab Index: $index | Anzahl DatPoints: ${cooLinechartDataPoints.length}- 1. DataPoint Value: ${cooLinechartDataPoints[0].value}'),
                  xAxisConfig: xAxisConfig,
                  yAxisConfig: yAxisConfig,
                  yAxisOppositeConfig: yAxisOppositeConfig,
                  xAxisStepLineTopLabelCallback: xAxisStepLineTopLabelLineChartCallback,
                  xAxisStepLineBottomLabelCallback: xAxisStepLineBottomLabelLineChartCallback,
                ),
              CooChartType.bar => CooBarChart(
                  key: ValueKey(
                      'bar_chart_${barchartDataSeries.length}_${DateTime.now().millisecondsSinceEpoch}'), // Force rebuild
                  dataSeries: barchartDataSeries,
                  lineDataSeries: linechartDataSeries, // Add line overlay to bar chart
                  columnBlocks: chartColumnBlocks,
                  chartConfig: chartConfig,
                  xAxisConfig: xAxisConfig,
                  yAxisConfig: yAxisConfig,
                  yAxisOppositeConfig: yAxisOppositeConfig,
                  xAxisStepLineBottomLabelCallback: xAxisStepLineBottomLabelBarChartCallback,
                  xAxisStepLineTopLabelCallback: xAxisStepLineTopLabelBarChartCallback,
                  xAxisStepLineBottomSvgCallback: xAxisStepLineBottomSvgBarChartCallback,
                  xAxisStepLineBottomWidgetCallback: xAxisStepLineBottomWidgetBarChartCallback,
                ),
            },
          ),
        ),
        Container(
          color: Colors.amber,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () async {
                      await _generateWeatherDualAxisChart();
                      setState(() {});
                    },
                    child: const Text('🌦️ Wetter', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () {
                      _generateRainSnowGroupedBarChart();
                      setState(() {
                        // Force complete rebuild with new key
                      });
                    },
                    child: const Text('🌧️❄️ Regen+Schnee', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () async {
                      await _generateWindBarbChart();
                      setState(() {});
                    },
                    child: const Text('💨 Wind Barbs', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateEmptyLists()),
                    child: const Text('Leere Liste', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateBarchart1Bis10()),
                    child: const Text('Bar 1-10', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateKachelmannSonnenscheindauerTrend()),
                    child: const Text('Bar Range', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateKachelmannWindoenForecast()),
                    child: const Text('Candle', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateMultipleBarchart()),
                    child: const Text('Multiple', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            // === NEW DEMO BUTTONS FOR CHART VARIANTS ===
            const SizedBox(height: 4),
            const Text('📊 Chart Varianten Demos:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 2),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateSimpleLineChart()),
                    child: const Text('📈 Line', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _generateSimpleBarChart()),
                    child: const Text('📊 Bar', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () async {
                      await _generateLineBarComboNormalLabels();
                      setState(() {});
                    },
                    child: const Text('📈📊 Normal', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () async {
                      await _generateLineBarComboSvgXLabels();
                      setState(() {});
                    },
                    child: const Text('📈📊 SVG X', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () async {
                      await _generateLineBarComboNormalDataPoints();
                      setState(() {});
                    },
                    child: const Text('📈📊 Normal Points', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () async {
                      await _generateLineBarComboSvgDataPoints();
                      setState(() {});
                    },
                    child: const Text('📈📊 SVG Points', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            // === END NEW DEMO BUTTONS ===
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 4,
                runSpacing: 2,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                    onPressed: () => setState(() => _create0To10To0ValuesChartDataPoints()),
                    child: const Text('0 -> 10 ->0', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _create0To10ValuesChartDataPoints()),
                    child: const Text('0->10', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _createMinus5To5ValuesChartDataPoints()),
                    child: const Text('5->-5', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _create0To10To0WithNullValuesChartDataPoints()),
                    child: const Text('NULL Test', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _generate10DataPointsLargeNumer()),
                    child: const Text('Große Zahlen', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _generateKachelmann14TageWetterTrend()),
                    child: const Text('Kachelmann', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 4,
                runSpacing: 2,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _generateKachelmannVorhersageXL()),
                    child: const Text('Temperatur', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _generateLargeVorhersageHourly()),
                    child: const Text('Große Daten', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _genrateRandomCooLinechartDataPoints()),
                    child: const Text('Random', style: TextStyle(fontSize: 10)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)),
                    onPressed: () => setState(() => _generateRandomDualLinechart()),
                    child: const Text('Random Dual', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(
                      () => chartConfig = chartConfig.copyWith(showGridHorizontal: !chartConfig.showGridHorizontal)),
                  child: Text('Grid-H ${chartConfig.showGridHorizontal ? '✅' : '❌'}',
                      style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(
                      () => chartConfig = chartConfig.copyWith(showGridVertical: !chartConfig.showGridVertical)),
                  child:
                      Text('Grid-V ${chartConfig.showGridVertical ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () =>
                      setState(() => chartConfig = chartConfig.copyWith(curvedLine: !chartConfig.curvedLine)),
                  child: Text('Curved ${chartConfig.curvedLine ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() {
                    showDataPoints = !showDataPoints;
                    for (var i = 0; i < linechartDataSeries.length; i++) {
                      final lineChart = linechartDataSeries[i].copyWith(showDataPoints: showDataPoints);
                      linechartDataSeries[i] = lineChart;
                    }
                  }),
                  child: Text('Points ${showDataPoints ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() {
                    showDataLabels = !showDataLabels;
                    for (var i = 0; i < linechartDataSeries.length; i++) {
                      final lineChart = linechartDataSeries[i].copyWith(showDataLabels: showDataLabels);
                      linechartDataSeries[i] = lineChart;
                    }
                  }),
                  child: Text('Labels ${showDataLabels ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() {
                    showDataLine = !showDataLine;
                    for (var i = 0; i < linechartDataSeries.length; i++) {
                      final lineChart = linechartDataSeries[i].copyWith(showDataLine: showDataLine);
                      linechartDataSeries[i] = lineChart;
                    }
                  }),
                  child: Text('Line ${showDataLine ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () =>
                      setState(() => chartConfig = chartConfig.copyWith(crosshair: !chartConfig.crosshair)),
                  child: Text('Cross ${chartConfig.crosshair ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () =>
                      setState(() => xAxisConfig = xAxisConfig.copyWith(showTopLabels: !xAxisConfig.showTopLabels)),
                  child: Text('Top ${xAxisConfig.showTopLabels ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(
                      () => xAxisConfig = xAxisConfig.copyWith(showBottomLabels: !xAxisConfig.showBottomLabels)),
                  child:
                      Text('Bottom ${xAxisConfig.showBottomLabels ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() =>
                      chartConfig = chartConfig.copyWith(highlightMouseColumn: !chartConfig.highlightMouseColumn)),
                  child: Text('Highlight ${chartConfig.highlightMouseColumn ? '✅' : '❌'}',
                      style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () =>
                      setState(() => chartConfig = chartConfig.copyWith(highlightPoints: !chartConfig.highlightPoints)),
                  child:
                      Text('H.Points ${chartConfig.highlightPoints ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() => chartConfig =
                      chartConfig.copyWith(highlightPointsVerticalLine: !chartConfig.highlightPointsVerticalLine)),
                  child: Text('V.Line ${chartConfig.highlightPointsVerticalLine ? '✅' : '❌'}',
                      style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () {
                    chartConfig =
                        chartConfig.copyWith(highlightPointsHorizontalLine: !chartConfig.highlightPointsHorizontalLine);
                    setState(() {});
                  },
                  child: Text('H.Line ${chartConfig.highlightPointsHorizontalLine ? '✅' : '❌'}',
                      style: const TextStyle(fontSize: 10)),
                ),
                // ElevatedButton(
                //   onPressed: () => setState(() => chartConfig = chartConfig.copyWith(
                //       highlightPointsHorizontalLine: !chartConfig.highlightPointsHorizontalLine)),
                //   child: Text(
                //       'Highlight points horizontal line ${chartConfig.highlightPointsHorizontalLine ? '✅' : '❌'}'),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() => chartConfig = chartConfig.copyWith(
                      centerDataPointBetweenVerticalGrid: !chartConfig.centerDataPointBetweenVerticalGrid)),
                  child: Text('Center ${chartConfig.centerDataPointBetweenVerticalGrid ? '✅' : '❌'}',
                      style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() => calcYAxisValuePadding = !calcYAxisValuePadding),
                  child: Text('Padding ${calcYAxisValuePadding ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() => chartBackgroundColorBlack = !chartBackgroundColorBlack),
                  child: Text('Black ${chartBackgroundColorBlack ? '✅' : '❌'}', style: const TextStyle(fontSize: 10)),
                ),
                Text('Y-Achse Labels: ${yAxisLabelCount ?? '-'}', style: const TextStyle(fontSize: 10)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() {
                    if (yAxisLabelCount == null) {
                      yAxisLabelCount = 5;
                    } else {
                      yAxisLabelCount = yAxisLabelCount! - 1;
                    }
                    yAxisConfig = yAxisConfig.copyWith(labelCount: yAxisLabelCount);
                  }),
                  child: const Text('-', style: TextStyle(fontSize: 10)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                  onPressed: () => setState(() {
                    if (yAxisLabelCount == null) {
                      yAxisLabelCount = 5;
                    } else {
                      yAxisLabelCount = yAxisLabelCount! + 1;
                    }
                    yAxisConfig = yAxisConfig.copyWith(labelCount: yAxisLabelCount);
                  }),
                  child: const Text('+', style: TextStyle(fontSize: 10)),
                ),
              ],
            )
          ]),
        ),
      ],
    );
  }

  _resetToDefault() {
    yAxisConfig = const YAxisConfig();
    yAxisOppositeConfig = const YAxisConfig();
    xAxisConfig = const XAxisConfig();
    chartConfig = const ChartConfig();

    chartColumnBlocks = null;
    xAxisStepLineTopLabelLineChartCallback = null;
    xAxisStepLineBottomLabelLineChartCallback = null;
    xAxisStepLineTopLabelBarChartCallback = null;
    xAxisStepLineBottomLabelBarChartCallback = null;
    xAxisStepLineBottomSvgBarChartCallback = null;
    xAxisStepLineBottomWidgetBarChartCallback = null;
    yAxisLabelCount = null;
    linechartDataSeries.clear();
    barchartDataSeries.clear();
  }

  /// Weather dual axis chart demo - temperature with SVG icons and precipitation as bars
  _generateWeatherDualAxisChart() async {
    _resetToDefault();
    chartType = CooChartType.bar; // Switch to bar chart for combo display

    // Preload SVG assets for weather icons
    await CooChartPainterUtil.preloadSvgAssets([
      kIconWeatherCloudySvg,
      kIconWeatherRainSvg,
      kIconWindArrowSvg,
      kIconWindStrongSvg,
    ]);

    // Configure left axis for temperature (will be dynamically calculated)
    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: '°C',
      labelCount: 6,
    );

    // Configure right axis for precipitation (will be dynamically calculated)
    yAxisOppositeConfig = yAxisOppositeConfig.copyWith(
      labelPostfix: 'mm',
      labelCount: 5,
      minLabelValue: 0,
      showRightAxis: true,
      showRightLabels: true,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
      showTopLabels: true,
      topDateFormat: 'HH',
      useSvgLabels: true, // Enable SVG labels for bottom X-axis
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Generate precipitation BAR data for the bar chart
    barchartDataSeries.clear();
    var precipitationBars = <CooBarChartDataPoint>[];
    var currentTime = DateTime.now().copyWith(hour: 15, minute: 0, second: 0, millisecond: 0);
    final precipValues = [
      0,
      0,
      1,
      2,
      6,
      2,
      1,
      0,
      0,
      1,
      8,
      1,
      0,
      0,
      1,
      12,
      2,
      1
    ]; // Added extreme values: 6mm, 8mm, 12mm

    for (int i = 0; i < precipValues.length; i++) {
      precipitationBars.add(CooBarChartDataPoint(
        value: precipValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
      ));
    }

    barchartDataSeries.add(CooBarChartDataSeries(
      dataPoints: precipitationBars,
      barColor: const Color(0xFF54B9E9).withValues(alpha: 0.7),
      maxBarWidth: 20,
      opposite: true, // Use the right axis for precipitation bars
    ));

    // Generate temperature LINE data as overlay (we'll need to add this to the bar chart painter)
    linechartDataSeries.clear();
    var temperaturePoints = <CooLineChartDataPoint>[];
    final tempValues = [32, 30, 28, 24, 21, 19, 18, 19, 22, 26, 29, 32, 30, 28, 25, 22, 20, 18];

    for (int i = 0; i < tempValues.length; i++) {
      // Choose different weather icons based on temperature and precipitation
      final hasRain = precipValues[i] > 0;

      // Show SVG icon at every point
      final DataPointSvgIcon weatherIcon = DataPointSvgIcon(
        assetPath: hasRain ? kIconWeatherRainSvg : kIconWeatherCloudySvg,
        width: 20,
        height: 20,
      );

      temperaturePoints.add(CooLineChartDataPoint(
        value: tempValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
        // Remove text label since showDataLabels is false
        svgIcon: weatherIcon,
      ));
    }

    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: temperaturePoints,
      label: 'Temperature',
      showDataLine: true,
      showDataPoints: true,
      showDataLabels: false, // Turn off text labels, show only SVGs
      opposite: false, // Use the left axis (temperature scale)
      dataLineColor: const Color(0xFFd85930),
      dataPointColor: const Color(0xFFd85930),
      dataPointLabelTextStyle: const TextStyle(
        color: Color(0xFFd85930),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      dataPointLabelPosition: DataPointLabelPos.top,
    ));

    // Configure wind direction arrows as SVG labels for X-axis
    xAxisStepLineBottomLabelBarChartCallback = (index, dataPoints) {
      // This won't be used when useSvgLabels is true, but kept for fallback
      return ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'][index % 8];
    };

    // Set SVG callback for wind direction arrows
    xAxisStepLineBottomSvgBarChartCallback = (index, dataPoints) {
      // Simulate different wind directions with different icons
      final bool isStrongWind = precipValues[index] > 4; // Strong wind when high precipitation
      return XAxisLabelSvg(
        assetPath: isStrongWind ? kIconWindStrongSvg : kIconWindArrowSvg,
        width: 16,
        height: 16,
        offsetY: 0, // Center vertically
      );
    };
  }

  _create0To10To0ValuesChartDataPoints() {
    _resetToDefault();
    chartType = CooChartType.line;
    yAxisConfig = yAxisConfig.copyWith(labelCount: 20);
    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);

    var cooLinechartDataPoints1 = List<CooLineChartDataPoint>.empty(growable: true);
    var cooLinechartDataPoints2 = List<CooLineChartDataPoint>.empty(growable: true);
    var j = 0;
    var k = 10;
    for (int i = 0; i <= 20; i++) {
      if (i % 5 == 1) {
        cooLinechartDataPoints1.add(CooLineChartDataPoint(label: '-'));
        cooLinechartDataPoints1.add(CooLineChartDataPoint(label: '-'));
        cooLinechartDataPoints1.add(CooLineChartDataPoint(label: '-'));
        cooLinechartDataPoints1.add(CooLineChartDataPoint(label: '-'));
      } else {
        CooLineChartDataPoint dataPoint = CooLineChartDataPoint(value: j.toDouble());
        cooLinechartDataPoints1.add(dataPoint);
        CooLineChartDataPoint dataPoint2 = CooLineChartDataPoint(value: k.toDouble());
        cooLinechartDataPoints1.add(dataPoint2);
        CooLineChartDataPoint dataPoint3 = CooLineChartDataPoint(value: (i + 2).toDouble());
        cooLinechartDataPoints2.add(dataPoint3);
        CooLineChartDataPoint dataPoint4 = CooLineChartDataPoint(value: (i + 1).toDouble());
        cooLinechartDataPoints2.add(dataPoint4);
      }
      if (i < 10) {
        j++;
        k--;
      } else {
        j--;
        k++;
      }
    }

    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: cooLinechartDataPoints1,
      label: 'Datenlinie 1',
      showDataLabels: true,
    ));
    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: cooLinechartDataPoints2,
      label: 'Datenlinie 2',
      showDataLabels: true,
    ));
  }

  _create0To10ValuesChartDataPoints() {
    _resetToDefault();
    chartType = CooChartType.line;
    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);
    var cooLinechartDataPoints1 = List<CooLineChartDataPoint>.empty(growable: true);
    var cooLinechartDataPoints2 = List<CooLineChartDataPoint>.empty(growable: true);
    var j = -2;
    for (int i = 0; i <= 10; i++) {
      CooLineChartDataPoint dataPoint = CooLineChartDataPoint(value: i.toDouble());
      cooLinechartDataPoints1.add(dataPoint);

      CooLineChartDataPoint dataPoint2 = CooLineChartDataPoint(value: j.toDouble());
      cooLinechartDataPoints2.add(dataPoint2);

      j++;
    }

    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints1, label: '0 zu 10'));
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints2, label: '-2 zu 8'));
  }

  _create0To10To0WithNullValuesChartDataPoints() {
    _resetToDefault();
    chartType = CooChartType.line;
    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);
    var cooLinechartDataPoints1 = List<CooLineChartDataPoint>.empty(growable: true);
    var cooLinechartDataPoints2 = List<CooLineChartDataPoint>.empty(growable: true);
    var j = -2;
    for (int i = 0; i <= 20; i++) {
      if (i % 3 == 0) {
        // Null Value
        CooLineChartDataPoint dataPoint = CooLineChartDataPoint(label: '-');
        cooLinechartDataPoints1.add(dataPoint);
      } else {
        CooLineChartDataPoint dataPoint = CooLineChartDataPoint(value: i.toDouble());
        cooLinechartDataPoints1.add(dataPoint);
      }

      CooLineChartDataPoint dataPoint2 = CooLineChartDataPoint(value: j.toDouble());
      cooLinechartDataPoints2.add(dataPoint2);

      j++;
    }

    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints1, label: '0 zu 10'));
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints2, label: '-2 zu 8'));
  }

  _createMinus5To5ValuesChartDataPoints() {
    _resetToDefault();
    chartType = CooChartType.line;
    yAxisConfig = yAxisConfig.copyWith(labelCount: 5);
    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);
    var cooLinechartDataPoints = List<CooLineChartDataPoint>.empty(growable: true);
    for (int i = 5; i >= -5; i--) {
      CooLineChartDataPoint dataPoint = CooLineChartDataPoint(value: i.toDouble(), label: 'L: ${i.toString()}');
      cooLinechartDataPoints.add(dataPoint);
    }
    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints, label: '5 zu -5'));
  }

  _genrateRandomCooLinechartDataPoints({int count = 30, int maxValue = 100}) {
    _resetToDefault();
    chartType = CooChartType.line;
    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);
    List<CooLineChartDataPoint> cooLinechartDataPoints = [];

    var generatedValues = LineChartDemoUtil.generateRandomDataPoints(count: count, maxValue: maxValue);
    for (double value in generatedValues) {
      cooLinechartDataPoints.add(CooLineChartDataPoint(
        value: value,
        label: value.toString(),
      ));
    }
    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints, label: 'Random'));
  }

  _generateRandomDualLinechart() {
    _resetToDefault();
    chartType = CooChartType.line;
    chartConfig = chartConfig.copyWith(
      canvasWidth: 3000,
      scrollable: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            backgroundColor: Colors.red,
            chartBackgroundColor: Colors.yellow,
          ),
    );

    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);
    yAxisConfig = yAxisConfig.copyWith(labelPostfix: ' C');
    yAxisOppositeConfig = yAxisConfig.copyWith(labelPostfix: ' hPa');

    const int count = 30;
    {
      // Temperatur
      List<CooLineChartDataPoint> cooLinechartDataPoints = [];
      var generatedValues = LineChartDemoUtil.generateRandomDataPoints(count: count, maxValue: 22, minValue: -10);
      for (double value in generatedValues) {
        cooLinechartDataPoints.add(CooLineChartDataPoint(
          value: value,
          label: value.toStringAsFixed(2),
        ));
      }
      linechartDataSeries.add(
        CooLineChartDataSeries(
          dataPoints: cooLinechartDataPoints,
          label: 'Random',
          showDataLabels: true,
          dataLineColor: Colors.purple,
        ),
      );
    }

    {
      // Opposite - Luftdruck
      List<CooLineChartDataPoint> cooLinechartDataPoints = [];
      var generatedValues = LineChartDemoUtil.generateRandomDataPoints(count: count, maxValue: 1090, minValue: 950);
      for (double value in generatedValues) {
        cooLinechartDataPoints.add(CooLineChartDataPoint(
          value: value,
          label: value.toStringAsFixed(2),
        ));
      }
      linechartDataSeries.add(CooLineChartDataSeries(
        dataPoints: cooLinechartDataPoints,
        label: 'Random',
        showDataLabels: true,
        showDataPoints: true,
        opposite: true,
      ));
    }
  }

  /// https://kachelmannwetter.com/de/vorhersage/2874225-mainz/14-tage-trend
  _generateKachelmannSonnenscheindauerTrend() {
    _resetToDefault();
    chartType = CooChartType.bar;
    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
    );

    yAxisConfig = yAxisConfig.copyWith(
      labelCount: 12,
      minLabelValue: 0,
      maxLabelValue: 11,
      labelPostfix: 'h',
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'dd.MM.',
      showTopLabels: true,
      topDateFormat: 'E',
    );

    barchartDataSeries.clear();

    var sonnenscheindauer = List<CooBarChartDataPoint>.empty(growable: true);
    sonnenscheindauer.add(CooBarChartDataPoint(
        value: 0.4,
        minValue: 0,
        maxValue: 1.2,
        time: DateTime(2023, 10, 22),
        columnBackgroundColor: Colors.grey.withValues(alpha: 0.2)));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 03.3,
      minValue: 0.3,
      maxValue: 6.4,
      time: DateTime(2023, 10, 23),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      minValue: 0,
      maxValue: 5,
      time: DateTime(2023, 10, 24),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 6,
      minValue: 2,
      maxValue: 12,
      time: DateTime(2023, 10, 25),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 3,
      minValue: 1,
      maxValue: 10,
      time: DateTime(2023, 10, 26),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0.5,
      maxValue: 2,
      time: DateTime(2023, 10, 27),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      minValue: 1,
      maxValue: 3,
      time: DateTime(2023, 10, 28),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0,
      maxValue: 3,
      time: DateTime(2023, 10, 29),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0,
      maxValue: 4,
      time: DateTime(2023, 10, 30),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      minValue: 0,
      maxValue: 1.2,
      time: DateTime(2023, 10, 31),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0,
      maxValue: 5,
      time: DateTime(2023, 11, 01),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      minValue: 0,
      maxValue: 6,
      time: DateTime(2023, 11, 02),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 3,
      minValue: 0,
      maxValue: 7,
      time: DateTime(2023, 11, 03),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 4,
      minValue: 0,
      maxValue: 8,
      time: DateTime(2023, 11, 04),
    ));

    CooBarChartDataSeries serie = CooBarChartDataSeries(
      dataPoints: sonnenscheindauer,
    );
    barchartDataSeries.add(serie);

    final bgColor = Colors.grey.withValues(alpha: 0.2);
    final bgColorBottom = Colors.blue.withValues(alpha: 0.2);
    const blockTextStyle = TextStyle(color: Colors.green, fontSize: 7);
    final columnTopDatas = List<ChartColumnBlockData>.empty(growable: true);
    columnTopDatas.add(ChartColumnBlockData(
        text: 'a', backgroundColor: bgColor, assetImages: [const BlockAssetImage(path: kIconWeatherRainSvg)]));
    columnTopDatas.add(ChartColumnBlockData(text: 'b', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'c', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'd', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(
        text: 'e', backgroundColor: bgColor, assetImages: [const BlockAssetImage(path: kIconWeatherRainSvg)]));
    columnTopDatas.add(ChartColumnBlockData(text: 'f', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'g', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'h', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'i', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'j', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'k'));
    columnTopDatas.add(ChartColumnBlockData(text: 'l', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'm', backgroundColor: bgColor, textStyle: blockTextStyle));
    columnTopDatas.add(ChartColumnBlockData(text: 'n', backgroundColor: bgColor));

    final columnBottomDatas = List<ChartColumnBlockData>.empty(growable: true);
    columnBottomDatas.add(ChartColumnBlockData(
        text: '0', backgroundColor: bgColorBottom, textStyle: const TextStyle(color: Colors.yellow)));
    columnBottomDatas.add(ChartColumnBlockData(text: '2', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '6', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '2', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '4', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '1', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '7', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '4', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '3', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '6', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '0', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '2', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '1', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '4', backgroundColor: bgColorBottom));

    chartColumnBlocks = ChartColumnBlocks(
      showTopBlocks: true,
      topDatas: columnTopDatas,
      topConfig: const ChartColumnBlockConfig(height: 40, backgroundColor: Colors.red),
      showBottomBlocks: true,
      bottomDatas: columnBottomDatas,
    );
  }

  /// https://kachelmannwetter.com/de/vorhersage/2874225-mainz/14-tage-trend
  _generateKachelmannWindoenForecast() {
    _resetToDefault();
    chartType = CooChartType.bar;
    chartConfig = chartConfig.copyWith(
      theme: CooChartThemes().defaultTheme.copyWith(
            minMaxRangeColor: Colors.green,
            chartBackgroundColor: Colors.green,
          ),
      showGridHorizontal: true,
      showGridVertical: true,
    );

    yAxisConfig = yAxisConfig.copyWith(
      labelCount: 12,
      minLabelValue: 0,
      maxLabelValue: 11,
      labelPostfix: 'h',
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'dd.MM.',
      showTopLabels: true,
      topDateFormat: 'E',
    );

    barchartDataSeries.clear();

    var sonnenscheindauer = List<CooBarChartDataPoint>.empty(growable: true);
    sonnenscheindauer.add(CooBarChartDataPoint(
        value: 0.4,
        minValue: 0,
        maxValue: 1.2,
        time: DateTime(2023, 10, 22),
        columnBackgroundColor: Colors.grey.withValues(alpha: 0.2)));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 03.3,
      minValue: 0.3,
      maxValue: 6.4,
      time: DateTime(2023, 10, 23),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      minValue: 0,
      maxValue: 5,
      time: DateTime(2023, 10, 24),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 6,
      minValue: 2,
      maxValue: 9,
      time: DateTime(2023, 10, 25),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 3,
      minValue: 1,
      maxValue: 10,
      time: DateTime(2023, 10, 26),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0.5,
      maxValue: 2,
      time: DateTime(2023, 10, 27),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      minValue: 1,
      maxValue: 3,
      time: DateTime(2023, 10, 28),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0,
      maxValue: 3,
      time: DateTime(2023, 10, 29),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0,
      maxValue: 4,
      time: DateTime(2023, 10, 30),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      minValue: 0,
      maxValue: 1.2,
      time: DateTime(2023, 10, 31),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      minValue: 0,
      maxValue: 5,
      time: DateTime(2023, 11, 01),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      minValue: 0,
      maxValue: 6,
      time: DateTime(2023, 11, 02),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 3,
      minValue: 0,
      maxValue: 7,
      time: DateTime(2023, 11, 03),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 4,
      minValue: 0,
      maxValue: 8,
      time: DateTime(2023, 11, 04),
    ));

    CooBarChartDataSeries serie = CooBarChartDataSeries(
      dataPoints: sonnenscheindauer,
      barWidth: 20,
      barHeight: 30,
    );
    barchartDataSeries.add(serie);

    final bgColor = Colors.grey.withValues(alpha: 0.2);
    final bgColorBottom = Colors.blue.withValues(alpha: 0.2);
    final columnTopDatas = List<ChartColumnBlockData>.empty(growable: true);
    columnTopDatas.add(ChartColumnBlockData(
        text: 'a',
        backgroundColor: bgColor,
        assetImages: [const BlockAssetImage(path: kIconWindOver50Png, height: 10)]));
    columnTopDatas.add(ChartColumnBlockData(text: 'b', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'c', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'd', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(
        text: 'e',
        backgroundColor: bgColor,
        assetImages: [const BlockAssetImage(path: kIconWindOver50Png, height: 10)]));
    columnTopDatas.add(ChartColumnBlockData(text: 'f', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'g', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'h', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'i', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'j', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'k', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'l', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'm', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'n', backgroundColor: bgColor));

    final columnBottomDatas = List<ChartColumnBlockData>.empty(growable: true);
    columnBottomDatas.add(ChartColumnBlockData(text: '0', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '2', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '6', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '2', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '4', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '1', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '7', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '4', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '3', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '6', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '0', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '2', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '1', backgroundColor: bgColorBottom));
    columnBottomDatas.add(ChartColumnBlockData(text: '4', backgroundColor: bgColorBottom));

    chartColumnBlocks = ChartColumnBlocks(
      showTopBlocks: true,
      topDatas: columnTopDatas,
      topConfig: const ChartColumnBlockConfig(height: 20),
      showBottomBlocks: true,
      bottomDatas: columnBottomDatas,
    );
  }

  /// Barchart 1-10
  _generateBarchart1Bis10() {
    _resetToDefault();
    chartType = CooChartType.bar;

    yAxisConfig = yAxisConfig.copyWith(
      labelCount: 12,
      minLabelValue: 0,
      showYAxisLables: true,
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
    );
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'dd.MM.',
      showTopLabels: true,
      topLabelTextStyle: const TextStyle(color: Colors.amber, fontSize: 8),
      topLabelOffset: const Offset(0, -20),
      showBottomLabels: true,
      bottomLabelTextStyle: const TextStyle(color: Colors.blue, fontSize: 8),
      bottomLabelOffset: const Offset(0, -20),
    );

    xAxisStepLineBottomLabelBarChartCallback = (p0, p1) {
      return 'Bottom Label';
    };
    xAxisStepLineTopLabelBarChartCallback = (p0, p1) {
      return 'Top\nLabel';
    };

    barchartDataSeries.clear();

    var sonnenscheindauer = List<CooBarChartDataPoint>.empty(growable: true);
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 0.5,
      time: DateTime(2023, 10, 22),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1,
      time: DateTime(2023, 10, 23),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 1.5,
      time: DateTime(2023, 10, 24),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2,
      time: DateTime(2023, 10, 25),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 2.5,
      time: DateTime(2023, 10, 26),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 3,
      time: DateTime(2023, 10, 27),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 3.5,
      time: DateTime(2023, 10, 28),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 4,
      time: DateTime(2023, 10, 29),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 5,
      time: DateTime(2023, 10, 30),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 6,
      time: DateTime(2023, 10, 31),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 7,
      time: DateTime(2023, 11, 01),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 8,
      time: DateTime(2023, 11, 02),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 9,
      time: DateTime(2023, 11, 03),
    ));
    sonnenscheindauer.add(CooBarChartDataPoint(
      value: 10,
      time: DateTime(2023, 11, 04),
    ));

    CooBarChartDataSeries serie = CooBarChartDataSeries(
      dataPoints: sonnenscheindauer,
      barColor: const Color(0xFFfde81a),
      maxBarWidth: 10,
    );
    barchartDataSeries.add(serie);
  }

  /// Barchart 1-10
  _generateMultipleBarchart() {
    _resetToDefault();
    chartType = CooChartType.bar;

    yAxisConfig = yAxisConfig.copyWith(maxLabelValue: 50);

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: false,
    );
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'dd.MM.',
    );

    {
      List<CooBarChartDataPoint> barChartDataPoints1 = [];
      int dataSeries1Size = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeries1Size, minValue: 2, maxValue: 33);
      var time = DateTime.now();
      for (int i = 0; i < dataSeries1Size; i++) {
        barChartDataPoints1.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie1 = CooBarChartDataSeries(
        dataPoints: barChartDataPoints1,
        barColor: const Color(0xFFfde81a),
      );
      barchartDataSeries.add(serie1);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints2 = [];
      int dataSeries1Size = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeries1Size, minValue: 14, maxValue: 20);
      var time = DateTime.now();
      for (int i = 0; i < dataSeries1Size; i++) {
        barChartDataPoints2.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie2 = CooBarChartDataSeries(
        dataPoints: barChartDataPoints2,
        barColor: Colors.green,
      );
      barchartDataSeries.add(serie2);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints3 = [];
      int dataSeries1Size = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeries1Size, minValue: 20, maxValue: 40);
      var time = DateTime.now();
      for (int i = 0; i < dataSeries1Size; i++) {
        barChartDataPoints3.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie3 = CooBarChartDataSeries(
        dataPoints: barChartDataPoints3,
        barColor: Colors.blue,
      );
      barchartDataSeries.add(serie3);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.red,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.amber,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.blueGrey,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.deepPurpleAccent,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.greenAccent,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.orange,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.teal,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.cyan,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.brown,
      );
      barchartDataSeries.add(serie);
    }
    {
      List<CooBarChartDataPoint> barChartDataPoints = [];
      int dataSeriesSize = 14;
      final List<double> values =
          LineChartDemoUtil.generateRandomDataPoints(count: dataSeriesSize, minValue: 11, maxValue: 24);
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        barChartDataPoints.add(CooBarChartDataPoint(value: values[i], time: time));
        time = time.add(const Duration(days: 1));
      }
      CooBarChartDataSeries serie = CooBarChartDataSeries(
        dataPoints: barChartDataPoints,
        barColor: Colors.pinkAccent,
      );
      barchartDataSeries.add(serie);
    }
  }

  // Zeichnet den Kachelmannchart "14 Tage Trend" ()
  // https://kachelmannwetter.com/de/vorhersage/2874225-mainz/14-tage-trend
  _generateKachelmann14TageWetterTrend() {
    _resetToDefault();

    chartType = CooChartType.line;

    // yAxisMinLabelValue = -5;
    // yAxisMaxLabelValue = 30;
    chartConfig = chartConfig.copyWith(
      highlightPointsVerticalLine: false,
      // theme: CooChartThemes().defaultTheme.copyWith(
      //       backgroundColor: Colors.red,
      //       chartBackgroundColor: Colors.yellow,
      //     ),
    );

    yAxisConfig = yAxisConfig.copyWith(labelCount: 8, labelPostfix: '°C');
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'E',
      showTopLabels: true,
    );

    linechartDataSeries.clear();

    const colorLimitClear = Color(0xFFfde81a); // limit_clear >= 90
    const colorLimitFew = Color(0xFFeddf58); // limit_few >= 78
    const colorLimitScattered = Color(0xFFe3d97b); // limit_scattered >= 78
    const colorLimitBroken = Color(0xFFd4d1ad); // limit_broken >= 30;
    const colorSonst = Color(0xFFCCCCCC);

    final columnBottomDatas = List<ChartColumnBlockData>.empty(growable: true);
    columnBottomDatas.add(ChartColumnBlockData(
      time: DateTime(2023, 4, 9),
      text: 'a',
      backgroundColor: colorLimitClear.withValues(alpha: 1),
      assetImages: [
        const BlockAssetImage(path: kIconWeatherCloudySvg),
        const BlockAssetImage(path: kIconWindOver50Svg, offsetTop: 50),
      ],
    ));
    columnBottomDatas.add(ChartColumnBlockData(
      time: DateTime(2023, 4, 10),
      text: 'b',
      backgroundColor: colorLimitClear,
      assetImages: [
        const BlockAssetImage(path: kIconWeatherRainSvg),
        const BlockAssetImage(path: kIconWindOver90Svg, offsetTop: 50),
      ],
    ));
    columnBottomDatas.add(ChartColumnBlockData(
      time: DateTime(2023, 4, 11),
      text: 'c',
      backgroundColor: colorLimitFew,
      assetImages: [const BlockAssetImage(path: kIconWeatherRainSvg)],
    ));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 12), text: 'd', backgroundColor: colorLimitScattered));
    columnBottomDatas.add(ChartColumnBlockData(time: DateTime(2023, 4, 13), text: 'e', backgroundColor: colorSonst));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 14), text: 'f', backgroundColor: colorLimitBroken));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 15), text: 'g', backgroundColor: colorLimitBroken));
    columnBottomDatas.add(ChartColumnBlockData(time: DateTime(2023, 4, 16), text: 'h', backgroundColor: colorSonst));
    columnBottomDatas.add(ChartColumnBlockData(time: DateTime(2023, 4, 17), text: 'i', backgroundColor: colorSonst));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 18), text: 'j', backgroundColor: colorLimitScattered));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 19), text: 'k', backgroundColor: colorLimitScattered));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 20), text: 'l', backgroundColor: colorLimitBroken));
    columnBottomDatas.add(ChartColumnBlockData(time: DateTime(2023, 4, 21), text: 'm', backgroundColor: colorSonst));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 22), text: 'n', backgroundColor: colorLimitClear));
    columnBottomDatas
        .add(ChartColumnBlockData(time: DateTime(2023, 4, 23), text: 'o', backgroundColor: colorLimitClear));
    chartColumnBlocks = ChartColumnBlocks(
      showBottomBlocks: true,
      bottomDatas: columnBottomDatas,
      bottomConfig: const ChartColumnBlockConfig(),
    );

    // Voraussichtliche Tageshöchsttemperatur
    var hoechstTemperatur = List<CooLineChartDataPoint>.empty(growable: true);
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 14, minValue: 12, maxValue: 14, label: '14°', time: DateTime(2023, 4, 9)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 16, minValue: 14, maxValue: 17, label: '16°', time: DateTime(2023, 4, 10)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 14, minValue: 12, maxValue: 15, label: '14°', time: DateTime(2023, 4, 11)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 12, minValue: 10, maxValue: 16, label: '12°', time: DateTime(2023, 4, 12)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 11, minValue: 9, maxValue: 12, label: '11°', time: DateTime(2023, 4, 13)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 11, minValue: 9, maxValue: 12, label: '11°', time: DateTime(2023, 4, 14)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 13, minValue: 10, maxValue: 15, label: '13°', time: DateTime(2023, 4, 15)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 13, minValue: 10, maxValue: 17, label: '13°', time: DateTime(2023, 4, 16)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 17, minValue: 11, maxValue: 20, label: '17°', time: DateTime(2023, 4, 17)));
    hoechstTemperatur
        .add(CooLineChartDataPoint(value: 16, minValue: 12, maxValue: 21, label: '16°', time: DateTime(2023, 4, 18)));
    hoechstTemperatur.add(CooLineChartDataPoint(minValue: 12, maxValue: 23, time: DateTime(2023, 4, 19)));
    hoechstTemperatur.add(CooLineChartDataPoint(minValue: 10, maxValue: 23, time: DateTime(2023, 4, 20)));
    hoechstTemperatur.add(CooLineChartDataPoint(minValue: 10, maxValue: 23, time: DateTime(2023, 4, 21)));
    hoechstTemperatur.add(CooLineChartDataPoint(minValue: 10, maxValue: 23, time: DateTime(2023, 4, 22)));

    var linechartHoechstTemperatur = CooLineChartDataSeries(
      dataPoints: hoechstTemperatur,
      label: 'Voraussichtliche Tageshöchsttemperatur',
      showMinMaxArea: true,
      dataLineColor: const Color(0xffd85930),
      minMaxAreaColor: const Color.fromRGBO(216, 89, 48, .4),
      dataPointLabelTextStyle: const TextStyle(color: Color(0xffd85930), fontWeight: FontWeight.bold, fontSize: 14),
      dataPointLabelPosition: DataPointLabelPos.top,
      showDataLabels: true,
    );
    linechartDataSeries.add(linechartHoechstTemperatur);

    // Voraussichtliche Tagestiefsttemperatur
    var tiefstTemperatur = List<CooLineChartDataPoint>.empty(growable: true);
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 3, minValue: 3, maxValue: 6, label: '3', time: DateTime(2023, 4, 9)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 5, minValue: 2, maxValue: 5, label: '5°', time: DateTime(2023, 4, 10)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 10, minValue: 6, maxValue: 11, label: '10°', time: DateTime(2023, 4, 11)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 7, minValue: 5, maxValue: 8, label: '7°', time: DateTime(2023, 4, 12)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 5, minValue: 2, maxValue: 5.5, label: '5°', time: DateTime(2023, 4, 13)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 4, minValue: 2, maxValue: 6, label: '4°', time: DateTime(2023, 4, 14)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 6, minValue: 3, maxValue: 10, label: '6°', time: DateTime(2023, 4, 15)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 7, minValue: 3, maxValue: 11, label: '7°', time: DateTime(2023, 4, 16)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 8, minValue: 3, maxValue: 10, label: '8°', time: DateTime(2023, 4, 17)));
    tiefstTemperatur
        .add(CooLineChartDataPoint(value: 7, minValue: 3, maxValue: 11, label: '7°', time: DateTime(2023, 4, 18)));
    tiefstTemperatur.add(CooLineChartDataPoint(minValue: 5, maxValue: 12, time: DateTime(2023, 4, 19)));
    tiefstTemperatur.add(CooLineChartDataPoint(minValue: 5, maxValue: 13, time: DateTime(2023, 4, 20)));
    tiefstTemperatur.add(CooLineChartDataPoint(minValue: 5, maxValue: 13, time: DateTime(2023, 4, 21)));
    tiefstTemperatur.add(CooLineChartDataPoint(minValue: 4, maxValue: 12, time: DateTime(2023, 4, 22)));

    var dataSeriesTiefsttemperatur = CooLineChartDataSeries(
      dataPoints: tiefstTemperatur,
      label: 'Voraussichtliche Tagestiefsttemperatur',
      showMinMaxArea: true,
      dataLineColor: const Color(0xff0080b5),
      minMaxAreaColor: const Color.fromRGBO(84, 185, 233, .4),
      dataPointLabelTextStyle: const TextStyle(color: Color(0xff0080b5), fontWeight: FontWeight.bold),
      dataPointLabelPosition: DataPointLabelPos.bottom,
      showDataLabels: true,
    );
    linechartDataSeries.add(dataSeriesTiefsttemperatur);

    setState(() {});
  }

  // Zeichnet den Kachelmannchart "Vorhersage XL" (Vorhersage-Modell-Super-HD.png nach.
  // https://kachelmannwetter.com/de/vorhersage/2874225-mainz/xltrend/euro/temperatur
  // 21 Uhr bis 6 Uhr Nacht
  _generateKachelmannVorhersageXL() {
    _resetToDefault();
    chartType = CooChartType.line;
    yAxisConfig = yAxisConfig.copyWith(
      labelCount: 20,
      labelPostfix: '°C',
      minLabelValue: 0,
    );
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'E',
      showTopLabels: true,
    );
    var cooLinechartDataPoints = List<CooLineChartDataPoint>.empty(growable: true);

    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 3.9, time: DateTime(2023, 4, 9, 7, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 4.7, time: DateTime(2023, 4, 9, 8, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 6.1, time: DateTime(2023, 4, 9, 9, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 7.6, time: DateTime(2023, 4, 9, 10, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 9.1, time: DateTime(2023, 4, 9, 11, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 10.5, time: DateTime(2023, 4, 9, 12, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 10.6, time: DateTime(2023, 4, 9, 13, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11, time: DateTime(2023, 4, 9, 14, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11.3, time: DateTime(2023, 4, 9, 15, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11.8, time: DateTime(2023, 4, 9, 16, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 12.2, time: DateTime(2023, 4, 9, 17, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 12.0, time: DateTime(2023, 4, 9, 18, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11.3, time: DateTime(2023, 4, 9, 19, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 9.8, time: DateTime(2023, 4, 9, 20, 0)));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 7.6, time: DateTime(2023, 4, 9, 21, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 6.3, time: DateTime(2023, 4, 9, 22, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 5.6, time: DateTime(2023, 4, 9, 23, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 5.4, time: DateTime(2023, 4, 10, 0, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 5.1, time: DateTime(2023, 4, 10, 1, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 4.2, time: DateTime(2023, 4, 10, 2, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 3.3, time: DateTime(2023, 4, 10, 3, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 3.2, time: DateTime(2023, 4, 10, 4, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 2.4, time: DateTime(2023, 4, 10, 5, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 2.3, time: DateTime(2023, 4, 10, 6, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 2.1, time: DateTime(2023, 4, 10, 7, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 3.6, time: DateTime(2023, 4, 10, 8, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 5.9, time: DateTime(2023, 4, 10, 9, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 10.1, time: DateTime(2023, 4, 10, 10, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11.5, time: DateTime(2023, 4, 10, 11, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 13.5, time: DateTime(2023, 4, 10, 12, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 15, time: DateTime(2023, 4, 10, 13, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 15.5, time: DateTime(2023, 4, 10, 14, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 16, time: DateTime(2023, 4, 10, 15, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 16.9, time: DateTime(2023, 4, 10, 16, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 15.5, time: DateTime(2023, 4, 10, 17, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 15.5, time: DateTime(2023, 4, 10, 18, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 14.9, time: DateTime(2023, 4, 10, 19, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 14.1, time: DateTime(2023, 4, 10, 20, 0)));
    cooLinechartDataPoints.add(
        CooLineChartDataPoint(value: 11.8, time: DateTime(2023, 4, 10, 21, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints.add(
        CooLineChartDataPoint(value: 11.1, time: DateTime(2023, 4, 10, 22, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints.add(
        CooLineChartDataPoint(value: 11.4, time: DateTime(2023, 4, 10, 23, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 11.0, time: DateTime(2023, 4, 11, 0, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 10.6, time: DateTime(2023, 4, 11, 1, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 10.2, time: DateTime(2023, 4, 11, 2, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 8.2, time: DateTime(2023, 4, 11, 3, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 8.5, time: DateTime(2023, 4, 11, 4, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 6.9, time: DateTime(2023, 4, 11, 5, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints
        .add(CooLineChartDataPoint(value: 5.9, time: DateTime(2023, 4, 11, 6, 0), columnBackgroundColor: Colors.grey));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 6.0, time: DateTime(2023, 4, 11, 7, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 6.8, time: DateTime(2023, 4, 11, 8, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 8.1, time: DateTime(2023, 4, 11, 9, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 8.9, time: DateTime(2023, 4, 11, 10, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 9.5, time: DateTime(2023, 4, 11, 11, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 9.7, time: DateTime(2023, 4, 11, 12, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 10.6, time: DateTime(2023, 4, 11, 13, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 10.8, time: DateTime(2023, 4, 11, 14, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 10.9, time: DateTime(2023, 4, 11, 15, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11.9, time: DateTime(2023, 4, 11, 16, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 12.4, time: DateTime(2023, 4, 11, 17, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 12.4, time: DateTime(2023, 4, 11, 18, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 12.2, time: DateTime(2023, 4, 11, 19, 0)));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 11.2, time: DateTime(2023, 4, 11, 20, 0)));

    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: cooLinechartDataPoints,
      label: 'Temperatur',
      showDataLabels: true,
    ));
  }

  _generate10DataPointsLargeNumer() {
    _resetToDefault();
    linechartDataSeries.clear();
    chartType = CooChartType.line;
    yAxisConfig = yAxisConfig.copyWith(
      addValuePadding: false,
    );

    var time = DateTime.now();

    final List<CooLineChartDataPoint> cooLinechartDataPoints = [];
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 998, time: time));
    time = time.add(const Duration(hours: 1));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 999, time: time));
    time = time.add(const Duration(hours: 1));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 1000, time: time));
    time = time.add(const Duration(hours: 1));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 1001, time: time));
    time = time.add(const Duration(hours: 1));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 1002, time: time));
    time = time.add(const Duration(hours: 1));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 1003, time: time));
    time = time.add(const Duration(hours: 1));
    cooLinechartDataPoints.add(CooLineChartDataPoint(value: 1004, time: time));

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'dd.MM.',
    );

    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: cooLinechartDataPoints,
      showDataPoints: true,
      showDataLabels: true,
    ));
  }

  _generateLargeVorhersageHourly() {
    _resetToDefault();
    linechartDataSeries.clear();
    chartType = CooChartType.line;
    yAxisConfig = yAxisConfig.copyWith();

    xAxisStepLineBottomLabelLineChartCallback = (index, cooLineChartDataPoints) {
      return 'basdfasdfasfsadfasdfasdfasd';
    };

    xAxisStepLineTopLabelLineChartCallback = (index, cooLineChartDataPoints) {
      return DateFormat.E().format(cooLineChartDataPoints[0].time!.add(const Duration(hours: -2)));
    };

    final now = DateTime.now();
    final mitternacht = now.copyWith(hour: 0, minute: 0, microsecond: 0, millisecond: 0).add(const Duration(days: 1));
    final hoursDiff = now.difference(mitternacht).inHours;
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'H',
      showTopLabels: true,
      showBottomLabels: true,
      stepAxisLine: 24,
      stepAxisLineStart: hoursDiff,
    );

    {
      final dataPoints1 = LineChartDemoUtil.createDataPoints(
        maxDataPointCount: 500,
        minValue: 990,
        maxValue: 1040,
      );
      linechartDataSeries.add(CooLineChartDataSeries(
        dataPoints: dataPoints1,
        showDataPoints: true,
        showDataLabels: false,
      ));
    }
    // {
    //   final dataPoints1 = LineChartDemoUtil.createDataPoints(
    //     maxDataPointCount: 130,
    //     minValue: 10,
    //     maxValue: 12,
    //     addNullValues: true,
    //   );
    //   linechartDataSeries.add(CooLineChartDataSeries(dataPoints: dataPoints1, showDataPoints: false));
    // }
    // linechartDataSeries.add(CooLineChartDataSeries(
    //     dataPoints: LineChartDemoUtil.createDataPoints(
    //   maxDataPointCount: 10,
    //   minValue: 10,
    //   maxValue: 32,
    // )));
  }

  _generateEmptyLists() {
    _resetToDefault();
    linechartDataSeries.clear();
    chartType = CooChartType.line;
    chartConfig =
        chartConfig.copyWith(theme: CooChartThemes().defaultTheme.copyWith(chartBackgroundColor: Colors.yellow));
    yAxisConfig = yAxisConfig.copyWith(
      showYAxisLables: false,
    );
  }

  // === NEW DEMO FUNCTIONS FOR CHART VARIANTS ===

  /// Simple LineChart only - basic temperature data
  _generateSimpleLineChart() {
    _resetToDefault();
    chartType = CooChartType.line;

    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: '°C',
      labelCount: 6,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Generate simple temperature line data
    linechartDataSeries.clear();
    var temperaturePoints = <CooLineChartDataPoint>[];
    var currentTime = DateTime.now().copyWith(hour: 6, minute: 0, second: 0, millisecond: 0);
    final tempValues = [12, 14, 16, 18, 22, 24, 26, 25, 23, 20, 18, 15]; // Simple temperature curve

    for (int i = 0; i < tempValues.length; i++) {
      temperaturePoints.add(CooLineChartDataPoint(
        value: tempValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
      ));
    }

    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: temperaturePoints,
      dataLineColor: Colors.orange,
      dataPointColor: Colors.red,
      showDataPoints: true,
      showDataLabels: true,
      dataPointLabelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ));
  }

  /// Simple BarChart only - basic precipitation data
  _generateSimpleBarChart() {
    _resetToDefault();
    chartType = CooChartType.bar;

    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: 'mm',
      labelCount: 5,
      minLabelValue: 0,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Generate simple precipitation bar data
    barchartDataSeries.clear();
    var precipitationBars = <CooBarChartDataPoint>[];
    var currentTime = DateTime.now().copyWith(hour: 6, minute: 0, second: 0, millisecond: 0);
    final precipValues = [0, 1, 3, 5, 2, 0, 0, 1, 4, 2, 1, 0]; // Simple precipitation values

    for (int i = 0; i < precipValues.length; i++) {
      precipitationBars.add(CooBarChartDataPoint(
        value: precipValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
      ));
    }

    barchartDataSeries.add(CooBarChartDataSeries(
      dataPoints: precipitationBars,
      barColor: Colors.blue,
      showDataLabels: true,
    ));
  }

  /// LineChart + BarChart combo with normal X-axis labels
  _generateLineBarComboNormalLabels() async {
    _resetToDefault();
    chartType = CooChartType.bar; // Use bar chart with line overlay

    // Configure left axis for temperature
    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: '°C',
      labelCount: 6,
    );

    // Configure right axis for precipitation
    yAxisOppositeConfig = yAxisOppositeConfig.copyWith(
      labelPostfix: 'mm',
      labelCount: 5,
      minLabelValue: 0,
      showRightAxis: true,
      showRightLabels: true,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
      showTopLabels: true,
      topDateFormat: 'HH',
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Generate data for both charts
    _generateComboChartData(false, false); // no SVG X-labels, no SVG datapoints
  }

  /// LineChart + BarChart combo with SVG X-axis labels
  _generateLineBarComboSvgXLabels() async {
    _resetToDefault();
    chartType = CooChartType.bar; // Use bar chart with line overlay

    // Preload SVG assets for X-axis labels
    await CooChartPainterUtil.preloadSvgAssets([
      kIconWeatherCloudySvg,
      kIconWeatherRainSvg,
      kIconWindArrowSvg,
    ]);

    // Configure left axis for temperature
    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: '°C',
      labelCount: 6,
    );

    // Configure right axis for precipitation
    yAxisOppositeConfig = yAxisOppositeConfig.copyWith(
      labelPostfix: 'mm',
      labelCount: 5,
      minLabelValue: 0,
      showRightAxis: true,
      showRightLabels: true,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
      showTopLabels: true,
      topDateFormat: 'HH',
      useSvgLabels: true, // Enable SVG labels for bottom X-axis
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Set up SVG callback for X-axis
    xAxisStepLineBottomSvgBarChartCallback = (index, cooBarChartDataPoints) {
      // Rotate between different weather SVGs
      final svgPaths = [kIconWeatherCloudySvg, kIconWeatherRainSvg, kIconWindArrowSvg];
      return XAxisLabelSvg(
        assetPath: svgPaths[index % svgPaths.length],
        width: 24,
        height: 24,
      );
    };

    // Generate data for both charts
    _generateComboChartData(true, false); // SVG X-labels, no SVG datapoints
  }

  /// LineChart + BarChart combo with normal data point labels
  _generateLineBarComboNormalDataPoints() async {
    _resetToDefault();
    chartType = CooChartType.bar; // Use bar chart with line overlay

    // Configure axes
    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: '°C',
      labelCount: 6,
    );

    yAxisOppositeConfig = yAxisOppositeConfig.copyWith(
      labelPostfix: 'mm',
      labelCount: 5,
      minLabelValue: 0,
      showRightAxis: true,
      showRightLabels: true,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
      showTopLabels: true,
      topDateFormat: 'HH',
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Generate data for both charts
    _generateComboChartData(false, false); // no SVG X-labels, normal datapoints
  }

  /// LineChart + BarChart combo with SVG data point icons
  _generateLineBarComboSvgDataPoints() async {
    _resetToDefault();
    chartType = CooChartType.bar; // Use bar chart with line overlay

    // Preload SVG assets for data point icons
    await CooChartPainterUtil.preloadSvgAssets([
      kIconWeatherCloudySvg,
      kIconWeatherRainSvg,
      kIconWindArrowSvg,
      kIconWindStrongSvg,
    ]);

    // Configure axes
    yAxisConfig = yAxisConfig.copyWith(
      labelPostfix: '°C',
      labelCount: 6,
    );

    yAxisOppositeConfig = yAxisOppositeConfig.copyWith(
      labelPostfix: 'mm',
      labelCount: 5,
      minLabelValue: 0,
      showRightAxis: true,
      showRightLabels: true,
    );

    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime,
      bottomDateFormat: 'HH',
      showTopLabels: true,
      topDateFormat: 'HH',
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      theme: CooChartThemes().defaultTheme.copyWith(
            labelColor: Colors.black,
          ),
    );

    // Generate data for both charts
    _generateComboChartData(false, true); // no SVG X-labels, SVG datapoints
  }

  /// Helper function to generate data for combo charts
  _generateComboChartData(bool useSvgXLabels, bool useSvgDataPoints) {
    var currentTime = DateTime.now().copyWith(hour: 15, minute: 0, second: 0, millisecond: 0);

    // Generate precipitation BAR data
    barchartDataSeries.clear();
    var precipitationBars = <CooBarChartDataPoint>[];
    final precipValues = [0, 1, 2, 5, 3, 1, 0, 2, 4, 1, 0, 1];

    for (int i = 0; i < precipValues.length; i++) {
      precipitationBars.add(CooBarChartDataPoint(
        value: precipValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
      ));
    }

    barchartDataSeries.add(CooBarChartDataSeries(
      dataPoints: precipitationBars,
      barColor: Colors.blue.withValues(alpha: 0.7),
      showDataLabels: true,
      opposite: true, // Right axis
    ));

    // Generate temperature LINE data
    linechartDataSeries.clear();
    var temperaturePoints = <CooLineChartDataPoint>[];
    final tempValues = [15, 17, 19, 22, 24, 26, 25, 23, 21, 19, 17, 16];
    final weatherIcons = [
      kIconWeatherCloudySvg,
      kIconWeatherRainSvg,
      kIconWindArrowSvg,
      kIconWindStrongSvg,
    ];

    for (int i = 0; i < tempValues.length; i++) {
      var dataPoint = CooLineChartDataPoint(
        value: tempValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
        svgIcon: useSvgDataPoints
            ? DataPointSvgIcon(
                assetPath: weatherIcons[i % weatherIcons.length],
                width: 20,
                height: 20,
              )
            : null,
      );

      temperaturePoints.add(dataPoint);
    }

    linechartDataSeries.add(CooLineChartDataSeries(
      dataPoints: temperaturePoints,
      dataLineColor: Colors.orange,
      dataPointColor: Colors.red,
      showDataPoints: true,
      showDataLabels: !useSvgDataPoints, // Show text labels only when NOT using SVG icons
      opposite: false, // Left axis
      dataPointLabelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ));
  }

  /// Wind Barb demo - shows wind data with custom wind barb widgets as X-axis labels
  _generateWindBarbChart() async {
    _resetToDefault();
    chartType = CooChartType.bar;

    // Configure X-axis for wind data
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'dd.MM.',
      showBottomLabels: true,
    );

    // Configure Y-axis for wind speed
    yAxisConfig = yAxisConfig.copyWith(
      labelCount: 8,
      labelPostfix: ' m/s',
      maxLabelValue: 25.0,
      minLabelValue: 0.0,
    );

    chartConfig = chartConfig.copyWith(
      showChartBorder: true,
      showGridHorizontal: true,
      showGridVertical: true,
      scrollable: true,
    );

    // Generate multiple wind speed data series that share the same time points
    barchartDataSeries.clear();

    // Create 10 time points (days)
    final int dataSeriesSize = 10;

    // Series 1: Light winds (0-5 m/s) - Light blue bars
    {
      List<CooBarChartDataPoint> lightWinds = [];
      final List<double> values = [1.0, 2.5, 1.5, 3.0, 2.0, 4.0, 3.5, 2.5, 1.0, 4.5];
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        lightWinds.add(CooBarChartDataPoint(
          value: values[i],
          time: time,
        ));
        time = time.add(const Duration(days: 1));
      }
      barchartDataSeries.add(CooBarChartDataSeries(
        dataPoints: lightWinds,
        barColor: Colors.lightBlue,
      ));
    }

    // Series 2: Moderate winds (5-12 m/s) - Green bars
    {
      List<CooBarChartDataPoint> moderateWinds = [];
      final List<double> values = [6.0, 8.5, 7.0, 9.5, 6.5, 11.0, 8.0, 7.5, 10.0, 9.0];
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        moderateWinds.add(CooBarChartDataPoint(
          value: values[i],
          time: time,
        ));
        time = time.add(const Duration(days: 1));
      }
      barchartDataSeries.add(CooBarChartDataSeries(
        dataPoints: moderateWinds,
        barColor: Colors.green,
      ));
    }

    // Series 3: Strong winds (12-20 m/s) - Orange bars
    {
      List<CooBarChartDataPoint> strongWinds = [];
      final List<double> values = [13.0, 15.5, 14.0, 17.0, 12.5, 18.5, 16.0, 14.5, 19.0, 15.0];
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        strongWinds.add(CooBarChartDataPoint(
          value: values[i],
          time: time,
        ));
        time = time.add(const Duration(days: 1));
      }
      barchartDataSeries.add(CooBarChartDataSeries(
        dataPoints: strongWinds,
        barColor: Colors.orange,
      ));
    }

    // Series 4: Very strong winds (20+ m/s) - Red bars
    {
      List<CooBarChartDataPoint> veryStrongWinds = [];
      final List<double> values = [21.0, 23.5, 20.5, 24.0, 22.0, 25.0, 23.0, 21.5, 24.5, 22.5];
      var time = DateTime.now();
      for (int i = 0; i < dataSeriesSize; i++) {
        veryStrongWinds.add(CooBarChartDataPoint(
          value: values[i],
          time: time,
        ));
        time = time.add(const Duration(days: 1));
      }
      barchartDataSeries.add(CooBarChartDataSeries(
        dataPoints: veryStrongWinds,
        barColor: Colors.red,
      ));
    }

    // Set up wind barb widgets as X-axis labels
    xAxisStepLineBottomWidgetBarChartCallback = (index, dataPoints) {
      print('Widget callback called for index: $index');

      if (index < 0 || index >= dataSeriesSize) {
        print('Returning null for index $index');
        return null;
      }

      // Use the highest wind speed from all series for this time point
      double maxWindSpeed = 0;
      for (var series in barchartDataSeries) {
        if (index < series.dataPoints.length) {
          maxWindSpeed = max(maxWindSpeed, series.dataPoints[index].value ?? 0);
        }
      }

      print('Creating wind barb widget for index $index with max speed $maxWindSpeed');

      return XAxisLabelWidget(
        widget: WindBarbWidget(
          windSpeed: maxWindSpeed,
          size: const Size(50, 35),
          color: Colors.black,
          strokeWidth: 2.0,
        ),
        width: 50.0,
        height: 35.0,
        offsetX: 0.0,
        offsetY: 20.0,
        rotationDegrees: 0.0,
      );
    };

    print('Wind barb chart configured with ${barchartDataSeries.length} series');
    print('Each series has $dataSeriesSize data points');
  }

  /// NEW: Demo function for Rain & Snow grouped bars
  /// Shows precipitation data with rain (dark blue #005288) and snow (light blue #7DBBEA) side by side
  _generateRainSnowGroupedBarChart() {
    print('=== Starting Rain/Snow Grouped Bar Chart Demo ===');

    // Clear everything first
    barchartDataSeries.clear();
    linechartDataSeries.clear();
    chartColumnBlocks = null;

    _resetToDefault();
    chartType = CooChartType.bar;
    print('Chart type set to: $chartType');

    // Configure Y-axis for precipitation in mm
    yAxisConfig = yAxisConfig.copyWith(
      labelCount: 8,
      labelPostfix: ' mm',
      minLabelValue: 0,
      maxLabelValue: 20, // Increased for higher values (up to ~8mm)
    );
    print('Y-axis configured: ${yAxisConfig.labelPostfix}');

    // Configure X-axis for time-based data
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.datetime, // Use datetime like other examples
      showBottomLabels: true,
    );
    print('X-axis configured for datetime type');

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
      highlightMouseColumn: true,
      scrollable: true, // Make it scrollable to see all bars
      centerDataPointBetweenVerticalGrid: false, // Better spacing
    );

    // Data already cleared above - no need to clear again
    print('Data series already cleared');

    // Generate sample rain and snow data for 14 days
    var precipitationData = <CooBarChartDataPoint>[];
    var baseTime = DateTime(2023, 10, 22); // Use fixed date like other examples

    // Sample data: Rain and Snow values in mm - More varied examples
    final rainSnowData = [
      {'rain': 2.5, 'snow': 1.0}, // Day 1: Both, more rain
      {'rain': 4.2, 'snow': 0.0}, // Day 2: Only rain
      {'rain': 0.0, 'snow': 3.5}, // Day 3: Only snow
      {'rain': 1.8, 'snow': 2.2}, // Day 4: Both, more snow
      {'rain': 6.1, 'snow': 0.0}, // Day 5: Heavy rain only
      {'rain': 0.5, 'snow': 4.8}, // Day 6: Light rain, heavy snow
      {'rain': 3.3, 'snow': 1.5}, // Day 7: Both, more rain
      {'rain': 0.8, 'snow': 3.2}, // Day 8: Both, more snow
      {'rain': 5.5, 'snow': 0.0}, // Day 9: Heavy rain only
      {'rain': 0.0, 'snow': 2.1}, // Day 10: Medium snow only
      {'rain': 2.9, 'snow': 2.9}, // Day 11: Equal amounts
      {'rain': 0.0, 'snow': 5.2}, // Day 12: Heavy snow only
      {'rain': 1.2, 'snow': 0.7}, // Day 13: Both, light amounts
      {'rain': 7.3, 'snow': 0.0}, // Day 14: Very heavy rain
    ];

    for (int i = 0; i < rainSnowData.length; i++) {
      final dayData = rainSnowData[i];
      final rainValue = dayData['rain']!;
      final snowValue = dayData['snow']!;

      precipitationData.add(CooBarChartDataPoint(
        time: baseTime.add(Duration(days: i)),
        label: 'Tag ${i + 1}',
        groupedValue: GroupedBarValue(
          primaryValue: rainValue,
          secondaryValue: snowValue,
          primaryColor: const Color(0xFF005288), // Dark blue for rain
          secondaryColor: const Color(0xFF7DBBEA), // Light blue for snow
          primaryLabel: 'Regen: ${rainValue.toStringAsFixed(1)}mm',
          secondaryLabel: 'Schnee: ${snowValue.toStringAsFixed(1)}mm',
        ),
      ));
      print(
          'Added data point ${i + 1}: Rain=${rainValue}mm, Snow=${snowValue}mm, hasGrouped=${precipitationData.last.hasGroupedValues}');
    }
    print('Created ${precipitationData.length} data points');

    // Add the series
    CooBarChartDataSeries series = CooBarChartDataSeries(
      dataPoints: precipitationData,
      label: 'Niederschlag',
      showDataLabels: false, // Will be handled by grouped bars
      opposite: false,
      barWidth: 20, // Reduced width to prevent overlap (was 30)
      maxBarWidth: 25, // Set maximum width limit
    );
    barchartDataSeries.add(series);
    print('Added series with ${series.dataPoints.length} points');
    print('Total bar chart series: ${barchartDataSeries.length}');

    // Debug: Print all data points
    for (int i = 0; i < precipitationData.length; i++) {
      final dp = precipitationData[i];
      print(
          'Data Point ${i + 1}: ${dp.label}, hasGrouped: ${dp.hasGroupedValues}, rain: ${dp.groupedValue?.primaryValue}, snow: ${dp.groupedValue?.secondaryValue}');
    }

    // Optional: Add X-axis labels showing dates
    xAxisStepLineBottomLabelBarChartCallback = (index, dataPoints) {
      if (index < dataPoints.length) {
        final DateTime? time = dataPoints[index].time;
        if (time != null) {
          return '${time.day}.${time.month}';
        }
      }
      return 'Tag ${index + 1}';
    };

    print('=== Rain/Snow Demo Setup Complete ===');
  }
}
