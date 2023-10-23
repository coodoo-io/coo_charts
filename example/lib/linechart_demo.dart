import 'package:coo_charts/chart_column_block_config.dart';
import 'package:coo_charts/chart_column_block_config_image.dart';
import 'package:coo_charts/chart_column_block_data.dart';
import 'package:coo_charts/chart_column_blocks.dart';
import 'package:coo_charts/chart_config.dart';
import 'package:coo_charts/chart_util.dart';
import 'package:coo_charts/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_chart_type.enum.dart';
import 'package:coo_charts/coo_bar_chart.dart';
import 'package:coo_charts/coo_line_chart.dart';
import 'package:coo_charts/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart_data_series.dart';
import 'package:coo_charts/coo_bar_chart_data_series.dart';
import 'package:coo_charts/data_point_label_pos.enum.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/x_axis_value_type.enum.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/material.dart';

const kIconWeatherCloudySvg = 'assets/sym_cloudy.svg';
const kIconWeatherRainSvg = 'assets/sym_rain.svg';
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

  ChartColumnBlocks? chartColumnBlocks;
  ChartConfig chartConfig = const ChartConfig();
  double columnBottomDatasHeight = 40; // wie hoch soll die Column Legend sein, sofern sie übergeben wird?
  bool calcYAxisValuePadding = true;

  var xAxisConfig = const XAxisConfig();
  var yAxisConfig = const YAxisConfig();

  bool chartBackgroundColorBlack = false;

  CooChartType chartType = CooChartType.bar;

  // TMP Variablen
  bool showDataPoints = false;
  bool showDataLabels = false;
  bool showDataLine = false;

  /// X-Achse Config

  @override
  initState() {
    super.initState();
    // _generateKachelmann14TageWetterTrend();
    // _generateKachelmannSonnenscheindauerTrend();
    _generateKachelmannWindoenForecast();
    // _generateBarchart1Bis10();
    // _create0To10To0ValuesChartDataPoints();
    // _create0To10ValuesChartDataPoints();
    // _genrateRandomCooLinechartDataPoints();
    // _generateKachelmannVorhersageXL();
    // _createMinus5To5ValuesChartDataPoints();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            child: const SizedBox(
              height: 50,
              child: Row(),
            ),
          ),
          Row(
            children: [
              // Container(
              //   color: Colors.red,
              //   child: SizedBox(
              //     width: 20,
              //     height: 500,
              //   ),
              // ),
              Container(
                color: chartBackgroundColorBlack ? Colors.black : Colors.white,
                child: SizedBox(
                    height: 500,
                    child: switch (chartType) {
                      CooChartType.line => CooLineChart(
                          dataSeries: linechartDataSeries,
                          columnBlocks: chartColumnBlocks,
                          chartConfig: chartConfig,
                          onDataPointTab: (index, cooLinechartDataPoints) =>
                              print('Tab $index - ${cooLinechartDataPoints[0].value}'),
                          xAxisConfig: xAxisConfig,
                          yAxisConfig: yAxisConfig,
                        ),
                      CooChartType.bar => CooBarChart(
                          dataSeries: barchartDataSeries,
                          columnBlocks: chartColumnBlocks,
                          chartConfig: chartConfig,
                          xAxisConfig: xAxisConfig,
                          yAxisConfig: yAxisConfig,
                        ),
                    }),
              ),
              // Container(
              //   color: Colors.red,
              //   child: SizedBox(
              //     width: 20,
              //     height: 500,
              //   ),
              // ),
            ],
          ),
          Container(
            color: Colors.amber,
            child: Column(children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _generateBarchart1Bis10()),
                    child: const Text('Barchart 1-10'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _generateKachelmannSonnenscheindauerTrend()),
                    child: const Text('Kachelmann Sonnenschein'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _generateKachelmannWindoenForecast()),
                    child: const Text('Kachelmann Windböen'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _genrateRandomCooLinechartDataPoints()),
                    child: const Text('Random Daten generieren'),
                  ),
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
                    onPressed: () => setState(() => _generateKachelmann14TageWetterTrend()),
                    child: const Text('Kachelmann 14-Tage'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _generateKachelmannVorhersageXL()),
                    child: const Text('Kachelmann Vorhersage XL'),
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
                    onPressed: () => setState(
                        () => chartConfig = chartConfig.copyWith(highlightPoints: !chartConfig.highlightPoints)),
                    child: Text('Highlight points ${chartConfig.highlightPoints ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => chartConfig =
                        chartConfig.copyWith(highlightPointsVerticalLine: !chartConfig.highlightPointsVerticalLine)),
                    child:
                        Text('Highlight points vertical line ${chartConfig.highlightPointsVerticalLine ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      chartConfig = chartConfig.copyWith(
                          highlightPointsHorizontalLine: !chartConfig.highlightPointsHorizontalLine);
                      setState(() {});
                    },
                    child: Text(
                        'Highlight points horizontal line ${chartConfig.highlightPointsHorizontalLine ? '✅' : '❌'}'),
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
                  Text('Anzahl Labels Y-Achse: ${yAxisConfig.labelCount} '),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => yAxisConfig = yAxisConfig.copyWith(labelCount: yAxisConfig.labelCount - 1)),
                    child: const Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => yAxisConfig = yAxisConfig.copyWith(labelCount: yAxisConfig.labelCount + 1)),
                    child: const Text('+'),
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  _resetToDefault() {
    yAxisConfig = const YAxisConfig();
    xAxisConfig = const XAxisConfig();

    chartColumnBlocks = null;
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
    xAxisConfig = xAxisConfig.copyWith(valueType: XAxisValueType.number);
    var cooLinechartDataPoints = List<CooLineChartDataPoint>.empty(growable: true);

    var generatedValues = ChartUtil.generateRandomDataPoints(count: count, maxValue: maxValue);
    for (double value in generatedValues) {
      CooLineChartDataPoint dataPoint = CooLineChartDataPoint(value: value, label: value.toString());
      cooLinechartDataPoints.add(dataPoint);
    }
    linechartDataSeries.clear();
    linechartDataSeries.add(CooLineChartDataSeries(dataPoints: cooLinechartDataPoints, label: 'Random'));
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
      barColor: const Color(0xFFfde81a),
      minMaxLineColor: Colors.black,
    );
    barchartDataSeries.add(serie);

    final bgColor = Colors.grey.withOpacity(0.2);
    final bgColorBottom = Colors.blue.withOpacity(0.2);
    final columnTopDatas = List<ChartColumnBlockData>.empty(growable: true);
    columnTopDatas.add(ChartColumnBlockData(
        text: 'a', backgroundColor: bgColor, assetImages: [const BlockAssetImage(path: kIconWeatherRainSvg)]));
    columnTopDatas.add(ChartColumnBlockData(text: 'b', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'c', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(text: 'd', backgroundColor: bgColor));
    columnTopDatas.add(ChartColumnBlockData(
        text: 'e', backgroundColor: bgColor, assetImages: [const BlockAssetImage(path: kIconWeatherRainSvg)]));
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
      topConfig: ChartColumnBlockConfig(height: 40),
      showBottomBlocks: true,
      bottomDatas: columnBottomDatas,
    );
  }

  /// https://kachelmannwetter.com/de/vorhersage/2874225-mainz/14-tage-trend
  _generateKachelmannWindoenForecast() {
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
      barColor: const Color(0xFFfc2a86),
      minMaxLineColor: Colors.black,
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
      topConfig: ChartColumnBlockConfig(height: 20),
      showBottomBlocks: true,
      bottomDatas: columnBottomDatas,
    );
  }

  /// Barchart 1-10
  _generateBarchart1Bis10() {
    _resetToDefault();
    chartType = CooChartType.bar;

    yAxisConfig = yAxisConfig.copyWith(labelCount: 11);
    yAxisConfig = yAxisConfig.copyWith(minLabelValue: 0);
    yAxisConfig = yAxisConfig.copyWith(maxLabelValue: 10);

    chartConfig = chartConfig.copyWith(
      showGridHorizontal: true,
      showGridVertical: true,
    );
    xAxisConfig = xAxisConfig.copyWith(
      valueType: XAxisValueType.date,
      bottomDateFormat: 'dd.MM.',
    );

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
    );
    barchartDataSeries.add(serie);
  }

  // Zeichnet den Kachelmannchart "14 Tage Trend" ()
  // https://kachelmannwetter.com/de/vorhersage/2874225-mainz/14-tage-trend
  _generateKachelmann14TageWetterTrend() {
    _resetToDefault();

    chartType = CooChartType.line;

    // yAxisMinLabelValue = -5;
    // yAxisMaxLabelValue = 30;
    chartConfig = chartConfig.copyWith(highlightPointsVerticalLine: false);
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
    yAxisConfig = yAxisConfig.copyWith(labelCount: 20, labelPostfix: '°C');
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
}
