import 'dart:math';

import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';

class LineChartDemoUtil {
  static List<CooLineChartDataSeries> generateLargeForecastHourlyList({
    int dataSeriesCount = 1,
    DateTime? startDate,
    int maxDataPointCount = 100,
    int minValue = 10,
    int maxValue = 20,
    bool addNullValues = false,
  }) {
    startDate ??= DateTime.now();

    List<CooLineChartDataSeries> linechartDataSeries = [];
    for (int i = 0; i < dataSeriesCount; i++) {
      List<CooLineChartDataPoint<dynamic>> dataPoints = createDataPoints(
        maxDataPointCount: maxDataPointCount,
        minValue: minValue,
        maxValue: maxValue,
        startDate: startDate,
        addNullValues: addNullValues,
      );

      linechartDataSeries.add(CooLineChartDataSeries(dataPoints: dataPoints));
    }
    return linechartDataSeries;
  }

  static List<CooLineChartDataPoint<dynamic>> createDataPoints(
      {required int maxDataPointCount,
      required int minValue,
      required int maxValue,
      DateTime? startDate,
      bool? addNullValues}) {
    startDate ??= DateTime.now();
    addNullValues ??= false;

    final List<CooLineChartDataPoint> dataPoints = [];

    final random = Random();
    final randomValues =
        LineChartDemoUtil.generateRandomDataPoints(count: maxDataPointCount, minValue: minValue, maxValue: maxValue);
    var dataPointTime = startDate;
    for (int j = 0; j < maxDataPointCount; j++) {
      dataPointTime = dataPointTime
          .copyWith(
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          )
          .add(const Duration(hours: 1));
      double? value;
      if (!addNullValues) {
        value = randomValues[j];
      } else {
        if (random.nextBool()) {
          value = randomValues[j];
        }
      }
      dataPoints.add(CooLineChartDataPoint(value: value, time: dataPointTime));
    }
    return dataPoints;
  }

  // Generates random double Values which can be uses für chart point data.
  static List<double> generateRandomDataPoints({int count = 20, int minValue = 0, int maxValue = 100}) {
    var dps = List<double>.empty(growable: true);
    for (var i = 0; i < count; i++) {
      var randomNumber = Random().nextDouble() * (maxValue - minValue) + minValue;
      dps.add(randomNumber);
    }

    return dps;
  }
}
