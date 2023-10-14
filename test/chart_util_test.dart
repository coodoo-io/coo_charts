import 'package:coo_charts/chart_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizeChartDataPoints(): handle empty List', () {
    var dataPoints = List<double>.empty(growable: true);
    var normalizeChartDataPoints = ChartUtil.normalizeChartDataPoints(dataPoints);

    expect(normalizeChartDataPoints.isEmpty, isTrue);
  });

  group('normalizeChartDataPoints(): length of given and returnd list is equal - ', () {
    test('empty list', () {
      var dataPoints = List<double>.empty(growable: true);
      var normalizeChartDataPoints = ChartUtil.normalizeChartDataPoints(dataPoints);

      expect(normalizeChartDataPoints.length, 0);
    });

    test('1 datapoint', () {
      var dataPoints = List<double>.filled(1, 1.0);
      var normalizeChartDataPoints = ChartUtil.normalizeChartDataPoints(dataPoints);

      expect(normalizeChartDataPoints.length, 1);
    });

    test('10.000 datapoints', () {
      var dataPoints = List<double>.filled(10000, 1.0);
      var normalizeChartDataPoints = ChartUtil.normalizeChartDataPoints(dataPoints);

      expect(normalizeChartDataPoints.length, 10000);
    });
  });
}
