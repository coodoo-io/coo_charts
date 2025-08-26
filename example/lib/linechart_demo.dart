import 'package:coo_charts/common/blocks/chart_column_block_config.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config_image.dart';
import 'package:coo_charts/common/blocks/chart_column_block_data.dart';
import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/coo_chart_themes.dart';
import 'package:coo_charts/common/coo_chart_type.enum.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';
import 'package:coo_charts/common/data_point_label_pos.enum.dart';
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:coo_charts/common/x_axis_label_svg.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
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
    _create0To10ValuesChartDataPoints();
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.blue,
          child: const SizedBox(
            height: 50,
            child: Row(),
          ),
        ),
        Container(
          width: double.infinity,
          height: 600,
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
              ),
          },
        ),
        Container(
          color: Colors.amber,
          child: Column(children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _generateWeatherDualAxisChart();
                    setState(() {});
                  },
                  child: const Text('🌦️ Wetter Dual Axis'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateEmptyLists()),
                  child: const Text('Leere Liste'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateBarchart1Bis10()),
                  child: const Text('Bar Chart 1-10'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateKachelmannSonnenscheindauerTrend()),
                  child: const Text('Bar Chart mit Range'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateKachelmannWindoenForecast()),
                  child: const Text('Candle-StickChart'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateMultipleBarchart()),
                  child: const Text('Multiple Bar Charts'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _create0To10To0ValuesChartDataPoints()),
                  child: const Text('0 -> 10 ->0'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _create0To10ValuesChartDataPoints()),
                  child: const Text('0 -> 10'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _createMinus5To5ValuesChartDataPoints()),
                  child: const Text('5 -> -5'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _create0To10To0WithNullValuesChartDataPoints()),
                  child: const Text('NULL Value Test'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generate10DataPointsLargeNumer()),
                  child: const Text('10 große Zahlen'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateKachelmann14TageWetterTrend()),
                  child: const Text('Kachelmann 14-Tage'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateKachelmannVorhersageXL()),
                  child: const Text('Temperaturkurve'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateLargeVorhersageHourly()),
                  child: const Text('Große Datenmennge'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _genrateRandomCooLinechartDataPoints()),
                  child: const Text('Random Daten generieren'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _generateRandomDualLinechart()),
                  child: const Text('Random Daten Dual Axis generieren'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(
                      () => chartConfig = chartConfig.copyWith(showGridHorizontal: !chartConfig.showGridHorizontal)),
                  child: Text('Grid-Horizontal ${chartConfig.showGridHorizontal ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(
                      () => chartConfig = chartConfig.copyWith(showGridVertical: !chartConfig.showGridVertical)),
                  child: Text('Grid-Vertical ${chartConfig.showGridVertical ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => chartConfig = chartConfig.copyWith(curvedLine: !chartConfig.curvedLine)),
                  child: Text('Curved ${chartConfig.curvedLine ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    showDataPoints = !showDataPoints;
                    for (var i = 0; i < linechartDataSeries.length; i++) {
                      final lineChart = linechartDataSeries[i].copyWith(showDataPoints: showDataPoints);
                      linechartDataSeries[i] = lineChart;
                    }
                  }),
                  child: Text('Show Data Points ${showDataPoints ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    showDataLabels = !showDataLabels;
                    for (var i = 0; i < linechartDataSeries.length; i++) {
                      final lineChart = linechartDataSeries[i].copyWith(showDataLabels: showDataLabels);
                      linechartDataSeries[i] = lineChart;
                    }
                  }),
                  child: Text('Show Data Lables ${showDataLabels ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    showDataLine = !showDataLine;
                    for (var i = 0; i < linechartDataSeries.length; i++) {
                      final lineChart = linechartDataSeries[i].copyWith(showDataLine: showDataLine);
                      linechartDataSeries[i] = lineChart;
                    }
                  }),
                  child: Text('Show Data Path ${showDataLine ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => chartConfig = chartConfig.copyWith(crosshair: !chartConfig.crosshair)),
                  child: Text('Crosshair ${chartConfig.crosshair ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => xAxisConfig = xAxisConfig.copyWith(showTopLabels: !xAxisConfig.showTopLabels)),
                  child: Text('Top Labels ${xAxisConfig.showTopLabels ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(
                      () => xAxisConfig = xAxisConfig.copyWith(showBottomLabels: !xAxisConfig.showBottomLabels)),
                  child: Text('Bottom Labels ${xAxisConfig.showBottomLabels ? '✅' : '❌'}'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() =>
                      chartConfig = chartConfig.copyWith(highlightMouseColumn: !chartConfig.highlightMouseColumn)),
                  child: Text('Highlight Column ${chartConfig.highlightMouseColumn ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => chartConfig = chartConfig.copyWith(highlightPoints: !chartConfig.highlightPoints)),
                  child: Text('Highlight points ${chartConfig.highlightPoints ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => chartConfig =
                      chartConfig.copyWith(highlightPointsVerticalLine: !chartConfig.highlightPointsVerticalLine)),
                  child: Text('Highlight points vertical line ${chartConfig.highlightPointsVerticalLine ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () {
                    chartConfig =
                        chartConfig.copyWith(highlightPointsHorizontalLine: !chartConfig.highlightPointsHorizontalLine);
                    setState(() {});
                  },
                  child:
                      Text('Highlight points horizontal line ${chartConfig.highlightPointsHorizontalLine ? '✅' : '❌'}'),
                ),
                // ElevatedButton(
                //   onPressed: () => setState(() => chartConfig = chartConfig.copyWith(
                //       highlightPointsHorizontalLine: !chartConfig.highlightPointsHorizontalLine)),
                //   child: Text(
                //       'Highlight points horizontal line ${chartConfig.highlightPointsHorizontalLine ? '✅' : '❌'}'),
                // ),
                ElevatedButton(
                  onPressed: () => setState(() => chartConfig = chartConfig.copyWith(
                      centerDataPointBetweenVerticalGrid: !chartConfig.centerDataPointBetweenVerticalGrid)),
                  child: Text(
                      'Center DataPoints between vertical Grid ${chartConfig.centerDataPointBetweenVerticalGrid ? '✅' : '❌'}'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => calcYAxisValuePadding = !calcYAxisValuePadding),
                  child: Text('Y-Axes Value Padding ${calcYAxisValuePadding ? '✅' : '❌'}'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => chartBackgroundColorBlack = !chartBackgroundColorBlack),
                  child: Text('Schwarzer Hintergrund ${chartConfig.centerDataPointBetweenVerticalGrid ? '✅' : '❌'}'),
                ),
                Text('Anzahl Labels Y-Achse: ${yAxisLabelCount ?? '-'} '),
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (yAxisLabelCount == null) {
                      yAxisLabelCount = 5;
                    } else {
                      yAxisLabelCount = yAxisLabelCount! - 1;
                    }
                    yAxisConfig = yAxisConfig.copyWith(labelCount: yAxisLabelCount);
                  }),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (yAxisLabelCount == null) {
                      yAxisLabelCount = 5;
                    } else {
                      yAxisLabelCount = yAxisLabelCount! + 1;
                    }
                    yAxisConfig = yAxisConfig.copyWith(labelCount: yAxisLabelCount);
                  }),
                  child: const Text('+'),
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
      topDateFormat: 'E dd.MM',
      useSvgLabels: true, // Enable SVG labels for bottom X-axis
    );

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
    );

    // Generate precipitation BAR data for the bar chart
    barchartDataSeries.clear();
    var precipitationBars = <CooBarChartDataPoint>[];
    var currentTime = DateTime.now().copyWith(hour: 15, minute: 0, second: 0, millisecond: 0);
    final precipValues = [0, 0, 1, 2, 6, 2, 1, 0, 0, 1, 8, 1, 0, 0, 1, 12, 2, 1]; // Added extreme values: 6mm, 8mm, 12mm
    
    for (int i = 0; i < precipValues.length; i++) {
      precipitationBars.add(CooBarChartDataPoint(
        value: precipValues[i].toDouble(),
        time: currentTime.add(Duration(hours: i * 3)),
      ));
    }

    barchartDataSeries.add(CooBarChartDataSeries(
      dataPoints: precipitationBars,
      barColor: const Color(0xFF54B9E9).withOpacity(0.7),
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
        offsetY: -30, // Position above the data point
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
        columnBackgroundColor: Colors.grey.withOpacity(0.2)));
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

    final bgColor = Colors.grey.withOpacity(0.2);
    final bgColorBottom = Colors.blue.withOpacity(0.2);
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
        columnBackgroundColor: Colors.grey.withOpacity(0.2)));
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

    final bgColor = Colors.grey.withOpacity(0.2);
    final bgColorBottom = Colors.blue.withOpacity(0.2);
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
      backgroundColor: colorLimitClear.withOpacity(1),
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
}
