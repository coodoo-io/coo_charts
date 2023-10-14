import 'dart:math';

class ChartUtil {
  /// Generates a list with all given datapoints mapped between 0.0 and 1.0 relative to their original range.
  static List<double> normalizeChartDataPoints(List<double> dataPoints) {
    if (dataPoints.isEmpty) {
      return List.empty();
    }

    final maxDataPoint = dataPoints.reduce((point1, point2) {
      return point1 > point2 ? point1 : point2;
    });
    final normalizedDataPoints = List<double>.empty(growable: true);

    for (var i = 0; i < dataPoints.length; i++) {
      var dp = dataPoints[i];
      dp = maxDataPoint == 0 ? 0 : dp / maxDataPoint;
      normalizedDataPoints.add(dp);
    }
    return normalizedDataPoints;
  }

// Generates random double Values which can be uses für chart point data.
  static List<double> generateRandomDataPoints({int count = 20, int maxValue = 100}) {
    var dps = List<double>.empty(growable: true);
    for (var i = 0; i < count; i++) {
      var randomNumber = Random().nextDouble() * maxValue;
      dps.add(randomNumber);
    }

    return dps;
  }
}
