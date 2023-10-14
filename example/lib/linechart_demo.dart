import 'package:coo_charts/chart_util.dart';
import 'package:coo_charts/linechart_data_point.dart';
import 'package:coo_charts/linechart_data_serie.dart';
import 'package:coo_charts/linechart_widget.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/y_axis_config.dart';
import 'package:flutter/material.dart';

class LineChartDemo extends StatefulWidget {
  const LineChartDemo({super.key});

  @override
  State<LineChartDemo> createState() => _LineChartDemoState();
}

class _LineChartDemoState extends State<LineChartDemo> {
  late List<LinechartDataSeries> linechartDataSeries = List.empty(growable: true);
  bool curvedLine = false; // Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  bool crosshair = false; // Soll ein Fadenkreuz angezeigt werden?
  bool showGridHorizontal = true; // if true, grid horizontal lines are painted
  bool showGridVertical = true; // if true, grid vertical lines are painted
  bool showDataPoints = true; // Sollen die Punkte auf der Kurve angezeigt werden?
  /// Sollen die data labels direkt auf dem Chart gezeichnet werden?
  bool showDataLabels = false;
  bool showDataLine = true; // Soll der path auf der Kurve angezeigt werden?
  bool highlightMouseColumn = true; // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  bool highlightPoints = true; // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  bool highlightPointsVerticalLine =
      true; // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  bool highlightPointsHorizontalLine =
      false; // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  bool centerDataPointBetweenVerticalGrid = true;

  /// gezeichnet. Es startet dann unten auf der Base-Line mit dem niedrigsten Wert und endet Oben mit dem Max-Wert.
  bool calcYAxisValuePadding = true;

  double? yAxisMinLabelValue;
  double? yAxisMaxLabelValue;
  int yAxisLabelCount = 5;

  /// X-Achse Config
  int xAxisStartNumber = 0;
  XAxisValueType xAxisValueType = XAxisValueType.number; // Konfiguriert den X-Achsen Wert (Zahlen oder Datum usw.)
  String xAxisBottomDateFormat = 'dd.MM';

  bool xAxisShowTopLabels = false;
  bool xAxisShowBottomLabels = true;

  @override
  initState() {
    super.initState();
    // _create0To10To0ValuesChartDataPoints();
    // _create0To10ValuesChartDataPoints();
    // _genrateRandomLineChartDataPoints();
    _generateKachelmann14TageWetterTrend();
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
              SizedBox(
                height: 500,
                child: LineChartWidget(
                  linechartDataSeries: linechartDataSeries,
                  curvedLine: curvedLine,
                  crosshair: crosshair,
                  showGridHorizontal: showGridHorizontal,
                  showGridVertical: showGridVertical,
                  showDataPath: showDataLine,
                  highlightMouseColumn: highlightMouseColumn,
                  highlightPoints: highlightPoints,
                  highlightPointsHorizontalLine: highlightPointsHorizontalLine,
                  highlightPointsVerticalLine: highlightPointsVerticalLine,
                  centerDataPointBetweenVerticalGrid: centerDataPointBetweenVerticalGrid,
                  xAxisConfig: XAxisConfig(
                    startNumber: xAxisStartNumber,
                    valueType: xAxisValueType,
                    showTopLabels: xAxisShowTopLabels,
                    showBottomLabels: xAxisShowBottomLabels,
                    bottomDateFormat: xAxisBottomDateFormat,
                  ),
                  yAxisConfig: YAxisConfig(
                    addValuePadding: calcYAxisValuePadding,
                    minLabelValue: yAxisMinLabelValue,
                    maxLabelValue: yAxisMaxLabelValue,
                    labelCount: yAxisLabelCount,
                  ),
                ),
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
                    onPressed: () => setState(() => _genrateRandomLineChartDataPoints()),
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
                    onPressed: () => setState(() => showGridHorizontal = !showGridHorizontal),
                    child: Text('Grid-Horizontal ${showGridHorizontal ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => showGridVertical = !showGridVertical),
                    child: Text('Grid-Vertical ${showGridVertical ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => curvedLine = !curvedLine),
                    child: Text('Curved ${curvedLine ? '✅' : '❌'}'),
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
                    onPressed: () => setState(() => crosshair = !crosshair),
                    child: Text('Crosshair ${crosshair ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => xAxisShowTopLabels = !xAxisShowTopLabels),
                    child: Text('Top Labels ${xAxisShowTopLabels ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => xAxisShowBottomLabels = !xAxisShowBottomLabels),
                    child: Text('Bottom Labels ${xAxisShowBottomLabels ? '✅' : '❌'}'),
                  ),

                  // ElevatedButton(
                  //   onPressed: () => setState(() => highlightPointsHorizontalLine = !highlightPointsHorizontalLine),
                  //   child: Text('Highlight points horizontal line ${highlightPointsHorizontalLine ? '✅' : '❌'}'),
                  // ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => highlightMouseColumn = !highlightMouseColumn),
                    child: Text('Highlight Column ${highlightMouseColumn ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => highlightPoints = !highlightPoints),
                    child: Text('Highlight points ${highlightPoints ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => highlightPointsVerticalLine = !highlightPointsVerticalLine),
                    child: Text('Highlight points vertical line ${highlightPointsVerticalLine ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        setState(() => centerDataPointBetweenVerticalGrid = !centerDataPointBetweenVerticalGrid),
                    child: Text(
                        'Center DataPoints between vertical Grid ${centerDataPointBetweenVerticalGrid ? '✅' : '❌'}'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => calcYAxisValuePadding = !calcYAxisValuePadding),
                    child: Text('Y-Axes Value Padding ${calcYAxisValuePadding ? '✅' : '❌'}'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Anzahl Labels Y-Achse: $yAxisLabelCount '),
                  ElevatedButton(
                    onPressed: () => setState(() => yAxisLabelCount -= 1),
                    child: const Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => yAxisLabelCount += 1),
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
    yAxisMinLabelValue = null;
    yAxisMaxLabelValue = null;
    yAxisLabelCount = 5;
  }

  _create0To10To0ValuesChartDataPoints() {
    _resetToDefault();
    yAxisLabelCount = 6;
    xAxisValueType = XAxisValueType.number;
    var linechartDataPoints1 = List<LineChartDataPoint>.empty(growable: true);
    var linechartDataPoints2 = List<LineChartDataPoint>.empty(growable: true);
    var j = 0;
    var k = 10;
    for (int i = 0; i <= 20; i++) {
      if (i % 5 == 1) {
        linechartDataPoints1.add(LineChartDataPoint(label: '-'));
        linechartDataPoints1.add(LineChartDataPoint(label: '-'));
        linechartDataPoints2.add(LineChartDataPoint(label: '-'));
        linechartDataPoints2.add(LineChartDataPoint(label: '-'));
      } else {
        LineChartDataPoint dataPoint = LineChartDataPoint(value: j.toDouble());
        linechartDataPoints1.add(dataPoint);
        LineChartDataPoint dataPoint2 = LineChartDataPoint(value: k.toDouble());
        linechartDataPoints1.add(dataPoint2);
        LineChartDataPoint dataPoint3 = LineChartDataPoint(value: (i + 2).toDouble());
        linechartDataPoints2.add(dataPoint3);
        LineChartDataPoint dataPoint4 = LineChartDataPoint(value: (i + 1).toDouble());
        linechartDataPoints2.add(dataPoint4);
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
    linechartDataSeries.add(LinechartDataSeries(
      dataPoints: linechartDataPoints1,
      label: 'Datenlinie 1',
    ));
    linechartDataSeries.add(LinechartDataSeries(
      dataPoints: linechartDataPoints2,
      label: 'Datenlinie 2',
    ));
  }

  _create0To10ValuesChartDataPoints() {
    _resetToDefault();
    xAxisValueType = XAxisValueType.number;
    var linechartDataPoints1 = List<LineChartDataPoint>.empty(growable: true);
    var linechartDataPoints2 = List<LineChartDataPoint>.empty(growable: true);
    var j = -2;
    for (int i = 0; i <= 10; i++) {
      LineChartDataPoint dataPoint = LineChartDataPoint(value: i.toDouble());
      linechartDataPoints1.add(dataPoint);

      LineChartDataPoint dataPoint2 = LineChartDataPoint(value: j.toDouble());
      linechartDataPoints2.add(dataPoint2);

      j++;
    }

    linechartDataSeries.clear();
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints1, label: '0 zu 10'));
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints2, label: '-2 zu 8'));
  }

  _create0To10To0WithNullValuesChartDataPoints() {
    _resetToDefault();
    xAxisValueType = XAxisValueType.number;
    var linechartDataPoints1 = List<LineChartDataPoint>.empty(growable: true);
    var linechartDataPoints2 = List<LineChartDataPoint>.empty(growable: true);
    var j = -2;
    for (int i = 0; i <= 20; i++) {
      if (i % 3 == 0) {
        // Null Value
        LineChartDataPoint dataPoint = LineChartDataPoint(label: '-');
        linechartDataPoints1.add(dataPoint);
      } else {
        LineChartDataPoint dataPoint = LineChartDataPoint(value: i.toDouble());
        linechartDataPoints1.add(dataPoint);
      }

      LineChartDataPoint dataPoint2 = LineChartDataPoint(value: j.toDouble());
      linechartDataPoints2.add(dataPoint2);

      j++;
    }

    linechartDataSeries.clear();
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints1, label: '0 zu 10'));
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints2, label: '-2 zu 8'));
  }

  _createMinus5To5ValuesChartDataPoints() {
    _resetToDefault();
    yAxisLabelCount = 5;
    xAxisValueType = XAxisValueType.number;
    var linechartDataPoints = List<LineChartDataPoint>.empty(growable: true);
    for (int i = 5; i >= -5; i--) {
      LineChartDataPoint dataPoint = LineChartDataPoint(value: i.toDouble(), label: 'L: ${i.toString()}');
      linechartDataPoints.add(dataPoint);
    }
    linechartDataSeries.clear();
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints, label: '5 zu -5'));
  }

  _genrateRandomLineChartDataPoints({int count = 30, int maxValue = 100}) {
    _resetToDefault();
    xAxisValueType = XAxisValueType.number;
    var linechartDataPoints = List<LineChartDataPoint>.empty(growable: true);

    var generatedValues = ChartUtil.generateRandomDataPoints(count: count, maxValue: maxValue);
    for (double value in generatedValues) {
      LineChartDataPoint dataPoint = LineChartDataPoint(value: value, label: value.toString());
      linechartDataPoints.add(dataPoint);
    }
    linechartDataSeries.clear();
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints, label: 'Random'));
  }

  // Zeichnet den Kachelmannchart "14 Tage Trend" ()
  // https://kachelmannwetter.com/de/vorhersage/2874225-mainz/14-tage-trend
  _generateKachelmann14TageWetterTrend() {
    _resetToDefault();

    // yAxisMinLabelValue = -5;
    // yAxisMaxLabelValue = 30;
    yAxisLabelCount = 8;
    xAxisValueType = XAxisValueType.date;
    xAxisBottomDateFormat = 'E';
    xAxisShowTopLabels = true;

    linechartDataSeries.clear();

    // Voraussichtliche Tageshöchsttemperatur
    var hoechstTemperatur = List<LineChartDataPoint>.empty(growable: true);
    hoechstTemperatur
        .add(LineChartDataPoint(value: 14, minValue: 12, maxValue: 14, label: '14°', time: DateTime(2023, 4, 9)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 16, minValue: 14, maxValue: 17, label: '16°', time: DateTime(2023, 4, 10)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 14, minValue: 12, maxValue: 15, label: '14°', time: DateTime(2023, 4, 11)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 12, minValue: 10, maxValue: 16, label: '12°', time: DateTime(2023, 4, 12)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 11, minValue: 9, maxValue: 12, label: '11°', time: DateTime(2023, 4, 13)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 11, minValue: 9, maxValue: 12, label: '11°', time: DateTime(2023, 4, 14)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 13, minValue: 10, maxValue: 15, label: '13°', time: DateTime(2023, 4, 15)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 13, minValue: 10, maxValue: 17, label: '13°', time: DateTime(2023, 4, 16)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 17, minValue: 11, maxValue: 20, label: '17°', time: DateTime(2023, 4, 17)));
    hoechstTemperatur
        .add(LineChartDataPoint(value: 16, minValue: 12, maxValue: 21, label: '16°', time: DateTime(2023, 4, 18)));
    hoechstTemperatur.add(LineChartDataPoint(minValue: 12, maxValue: 23, time: DateTime(2023, 4, 19)));
    hoechstTemperatur.add(LineChartDataPoint(minValue: 10, maxValue: 23, time: DateTime(2023, 4, 20)));
    hoechstTemperatur.add(LineChartDataPoint(minValue: 10, maxValue: 23, time: DateTime(2023, 4, 21)));
    hoechstTemperatur.add(LineChartDataPoint(minValue: 10, maxValue: 23, time: DateTime(2023, 4, 22)));

    var linechartHoechstTemperatur = LinechartDataSeries(
      dataPoints: hoechstTemperatur,
      label: 'Voraussichtliche Tageshöchsttemperatur',
      showMinMaxArea: true,
      dataLineColor: const Color(0xffd85930),
      minMaxAreaColor: const Color.fromRGBO(216, 89, 48, .4),
      dataLabelColor: Colors.white,
    );
    linechartDataSeries.add(linechartHoechstTemperatur);

    // Voraussichtliche Tagestiefsttemperatur
    var tiefstTemperatur = List<LineChartDataPoint>.empty(growable: true);
    tiefstTemperatur
        .add(LineChartDataPoint(value: 3, minValue: 3, maxValue: 6, label: '3', time: DateTime(2023, 4, 9)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 5, minValue: 2, maxValue: 5, label: '5°', time: DateTime(2023, 4, 10)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 10, minValue: 6, maxValue: 11, label: '10°', time: DateTime(2023, 4, 11)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 7, minValue: 5, maxValue: 8, label: '7°', time: DateTime(2023, 4, 12)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 5, minValue: 2, maxValue: 5.5, label: '5°', time: DateTime(2023, 4, 13)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 4, minValue: 2, maxValue: 6, label: '4°', time: DateTime(2023, 4, 14)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 6, minValue: 3, maxValue: 10, label: '6°', time: DateTime(2023, 4, 15)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 7, minValue: 3, maxValue: 11, label: '7°', time: DateTime(2023, 4, 16)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 8, minValue: 3, maxValue: 10, label: '8°', time: DateTime(2023, 4, 17)));
    tiefstTemperatur
        .add(LineChartDataPoint(value: 7, minValue: 3, maxValue: 11, label: '7°', time: DateTime(2023, 4, 18)));
    tiefstTemperatur.add(LineChartDataPoint(minValue: 5, maxValue: 12, time: DateTime(2023, 4, 19)));
    tiefstTemperatur.add(LineChartDataPoint(minValue: 5, maxValue: 13, time: DateTime(2023, 4, 20)));
    tiefstTemperatur.add(LineChartDataPoint(minValue: 5, maxValue: 13, time: DateTime(2023, 4, 21)));
    tiefstTemperatur.add(LineChartDataPoint(minValue: 4, maxValue: 12, time: DateTime(2023, 4, 22)));

    var dataSeriesTiefsttemperatur = LinechartDataSeries(
      dataPoints: tiefstTemperatur,
      label: 'Voraussichtliche Tagestiefsttemperatur',
      showMinMaxArea: true,
      dataLineColor: const Color(0xff0080b5),
      minMaxAreaColor: const Color.fromRGBO(84, 185, 233, .4),
      dataLabelColor: Colors.white,
    );
    linechartDataSeries.add(dataSeriesTiefsttemperatur);
  }

  // Zeichnet den Kachelmannchart "Vorhersage XL" (Vorhersage-Modell-Super-HD.png nach.
  // https://kachelmannwetter.com/de/vorhersage/2874225-mainz/xltrend/euro/temperatur
  // 21 Uhr bis 6 Uhr Nacht
  _generateKachelmannVorhersageXL() {
    _resetToDefault();
    yAxisLabelCount = 5;
    xAxisValueType = XAxisValueType.datetime;
    var linechartDataPoints = List<LineChartDataPoint>.empty(growable: true);

    linechartDataPoints.add(LineChartDataPoint(value: 3.9, time: DateTime(2023, 4, 9, 7, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 4.7, time: DateTime(2023, 4, 9, 8, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 6.1, time: DateTime(2023, 4, 9, 9, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 7.6, time: DateTime(2023, 4, 9, 10, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 9.1, time: DateTime(2023, 4, 9, 11, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 10.5, time: DateTime(2023, 4, 9, 12, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 10.6, time: DateTime(2023, 4, 9, 13, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11, time: DateTime(2023, 4, 9, 14, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11.3, time: DateTime(2023, 4, 9, 15, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11.8, time: DateTime(2023, 4, 9, 16, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 12.2, time: DateTime(2023, 4, 9, 17, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 12.0, time: DateTime(2023, 4, 9, 18, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11.3, time: DateTime(2023, 4, 9, 19, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 9.8, time: DateTime(2023, 4, 9, 20, 0)));
    linechartDataPoints
        .add(LineChartDataPoint(value: 7.6, time: DateTime(2023, 4, 9, 21, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 6.3, time: DateTime(2023, 4, 9, 22, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 5.6, time: DateTime(2023, 4, 9, 23, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 5.4, time: DateTime(2023, 4, 10, 0, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 5.1, time: DateTime(2023, 4, 10, 1, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 4.2, time: DateTime(2023, 4, 10, 2, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 3.3, time: DateTime(2023, 4, 10, 3, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 3.2, time: DateTime(2023, 4, 10, 4, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 2.4, time: DateTime(2023, 4, 10, 5, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 2.3, time: DateTime(2023, 4, 10, 6, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints.add(LineChartDataPoint(value: 2.1, time: DateTime(2023, 4, 10, 7, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 3.6, time: DateTime(2023, 4, 10, 8, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 5.9, time: DateTime(2023, 4, 10, 9, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 10.1, time: DateTime(2023, 4, 10, 10, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11.5, time: DateTime(2023, 4, 10, 11, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 13.5, time: DateTime(2023, 4, 10, 12, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 15, time: DateTime(2023, 4, 10, 13, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 15.5, time: DateTime(2023, 4, 10, 14, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 16, time: DateTime(2023, 4, 10, 15, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 16.9, time: DateTime(2023, 4, 10, 16, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 15.5, time: DateTime(2023, 4, 10, 17, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 15.5, time: DateTime(2023, 4, 10, 18, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 14.9, time: DateTime(2023, 4, 10, 19, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 14.1, time: DateTime(2023, 4, 10, 20, 0)));
    linechartDataPoints
        .add(LineChartDataPoint(value: 11.8, time: DateTime(2023, 4, 10, 21, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 11.1, time: DateTime(2023, 4, 10, 22, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 11.4, time: DateTime(2023, 4, 10, 23, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 11.0, time: DateTime(2023, 4, 11, 0, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 10.6, time: DateTime(2023, 4, 11, 1, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 10.2, time: DateTime(2023, 4, 11, 2, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 8.2, time: DateTime(2023, 4, 11, 3, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 8.5, time: DateTime(2023, 4, 11, 4, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 6.9, time: DateTime(2023, 4, 11, 5, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints
        .add(LineChartDataPoint(value: 5.9, time: DateTime(2023, 4, 11, 6, 0), columnBackgroundColor: Colors.grey));
    linechartDataPoints.add(LineChartDataPoint(value: 6.0, time: DateTime(2023, 4, 11, 7, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 6.8, time: DateTime(2023, 4, 11, 8, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 8.1, time: DateTime(2023, 4, 11, 9, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 8.9, time: DateTime(2023, 4, 11, 10, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 9.5, time: DateTime(2023, 4, 11, 11, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 9.7, time: DateTime(2023, 4, 11, 12, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 10.6, time: DateTime(2023, 4, 11, 13, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 10.8, time: DateTime(2023, 4, 11, 14, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 10.9, time: DateTime(2023, 4, 11, 15, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11.9, time: DateTime(2023, 4, 11, 16, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 12.4, time: DateTime(2023, 4, 11, 17, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 12.4, time: DateTime(2023, 4, 11, 18, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 12.2, time: DateTime(2023, 4, 11, 19, 0)));
    linechartDataPoints.add(LineChartDataPoint(value: 11.2, time: DateTime(2023, 4, 11, 20, 0)));

    linechartDataSeries.clear();
    linechartDataSeries.add(LinechartDataSeries(dataPoints: linechartDataPoints, label: 'Temperatur'));
  }
}
