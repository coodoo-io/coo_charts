import 'dart:math';

import 'package:flutter/material.dart';

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

  /// Erstellt ein Overlay, dass als Tooltip für alle Charts verwendet wird.
  ///
  /// Es muss zwingend die Höhe [tooltipHeight] angegeben werden, damit sich die Position besser berechnen lässt.
  /// Alternativ wäre eine ungernauere Berechnung, dafür dynamische, dem Content angepasste Höhen.
  static OverlayEntry createChartTootlipOverlay({
    required GlobalKey chartContainerKey,
    required Widget tooltipContent,
    required double tooltipHeight,
    required VoidCallback closeCallback,
  }) {
    return OverlayEntry(
      builder: (context) {
        // TODO herausfinden wo sich gerade mein eigenes Widget befindet und entweder darunter oder darüber anzeigeen
        final deviceWidth = MediaQuery.of(context).size.width;
        final deveHeight = MediaQuery.of(context).size.height;

        // Abstand rechts und links für das Tooltip bestimmen
        final horizontalPadding = deviceWidth * 0.1;
        final tooltipWidth = deviceWidth - (horizontalPadding * 2);

        // Y-Pos für das Tooltip bestimmen, dass es nicht über dem Widget liegt
        RenderBox box = chartContainerKey.currentContext!.findRenderObject() as RenderBox;
        Offset chartPosition = box.localToGlobal(Offset.zero);
        double tooltipYPos = MediaQuery.of(context).size.height * 0.3;

        // Prüfen ob sich der Start Widget im oberen Drittel
        if (chartPosition.dy < deveHeight / 3) {
          // Tooltip unter dem Chart positionieren
          tooltipYPos = chartPosition.dy + box.size.height;
        } else {
          // Tooltip über dem Chart positionieren
          tooltipYPos = chartPosition.dy - tooltipHeight;
        }

        return Positioned(
          top: tooltipYPos,
          left: horizontalPadding,
          child: Material(
            child: GestureDetector(
              onTap: () => closeCallback(),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 5,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                width: tooltipWidth,
                height: tooltipHeight,
                child: tooltipContent,
              ),
            ),
          ),
        );
      },
    );
  }
}
