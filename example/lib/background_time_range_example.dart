import 'package:coo_charts/common/chart_background_time_range.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:flutter/material.dart';

/// Beispiel für die Verwendung von Hintergrund-Zeiträumen
///
/// Dieses Beispiel zeigt, wie Sie bestimmte Uhrzeiten im Chart mit einer
/// anderen Hintergrundfarbe hervorheben können.
class BackgroundTimeRangeExample {
  static ChartConfig createExampleConfig() {
    return const ChartConfig(
      backgroundTimeRanges: [
        // Nachtzeit von 20:00 bis 06:00 - durchgehend grau (tagesübergreifend)
        ChartBackgroundTimeRange(
          startTime: TimeOfDay(hour: 20, minute: 0),
          endTime: TimeOfDay(hour: 6, minute: 0),
          backgroundColor: Colors.grey,
          opacity: 0.3,
          label: 'Nachtzeit',
        ),

        // Mittagspause von 12:00 bis 13:00 - hellblau
        ChartBackgroundTimeRange(
          startTime: TimeOfDay(hour: 12, minute: 0),
          endTime: TimeOfDay(hour: 13, minute: 0),
          backgroundColor: Colors.lightBlue,
          opacity: 0.2,
          label: 'Mittagspause',
        ),

        // Arbeitszeit von 09:00 bis 17:00 - sehr hellgrün
        ChartBackgroundTimeRange(
          startTime: TimeOfDay(hour: 9, minute: 0),
          endTime: TimeOfDay(hour: 17, minute: 0),
          backgroundColor: Colors.green,
          opacity: 0.1,
          label: 'Arbeitszeit',
        ),
      ],
      showGridHorizontal: true,
      showGridVertical: true,
      curvedLine: true,
    );
  }

  /// Spezielles Beispiel für das Screenshot-Problem: 20:00-06:00 Nachtzeit
  static ChartConfig createNightTimeConfig() {
    return const ChartConfig(
      backgroundTimeRanges: [
        // Nachtzeit von 20:00 bis 06:00 - wiederholt sich jeden Tag
        ChartBackgroundTimeRange(
          startTime: TimeOfDay(hour: 20, minute: 0),
          endTime: TimeOfDay(hour: 6, minute: 0),
          backgroundColor: Colors.grey,
          opacity: 0.25,
          label: 'Nachtzeit (20:00-06:00)',
        ),
      ],
      showGridHorizontal: true,
      showGridVertical: true,
    );
  }
}

/// Hilfsmethoden für häufig verwendete Zeiträume
class CommonTimeRanges {
  /// Nachtzeit (20:00 - 06:00) in grau - tagesübergreifend
  static ChartBackgroundTimeRange nightTime({
    Color color = Colors.grey,
    double opacity = 0.3,
  }) {
    return ChartBackgroundTimeRange(
      startTime: const TimeOfDay(hour: 20, minute: 0),
      endTime: const TimeOfDay(hour: 6, minute: 0),
      backgroundColor: color,
      opacity: opacity,
      label: 'Nachtzeit',
    );
  }

  /// Arbeitszeit (09:00 - 17:00) in hellgrün
  static ChartBackgroundTimeRange workingHours({
    Color color = Colors.green,
    double opacity = 0.1,
  }) {
    return ChartBackgroundTimeRange(
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
      backgroundColor: color,
      opacity: opacity,
      label: 'Arbeitszeit',
    );
  }

  /// Mittagspause (12:00 - 13:00) in hellblau
  static ChartBackgroundTimeRange lunchBreak({
    Color color = Colors.lightBlue,
    double opacity = 0.2,
  }) {
    return ChartBackgroundTimeRange(
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 13, minute: 0),
      backgroundColor: color,
      opacity: opacity,
      label: 'Mittagspause',
    );
  }

  /// Rush Hour morgens (07:00 - 09:00) in orange
  static ChartBackgroundTimeRange morningRushHour({
    Color color = Colors.orange,
    double opacity = 0.2,
  }) {
    return ChartBackgroundTimeRange(
      startTime: const TimeOfDay(hour: 7, minute: 0),
      endTime: const TimeOfDay(hour: 9, minute: 0),
      backgroundColor: color,
      opacity: opacity,
      label: 'Stoßzeit morgens',
    );
  }

  /// Rush Hour abends (17:00 - 19:00) in orange
  static ChartBackgroundTimeRange eveningRushHour({
    Color color = Colors.orange,
    double opacity = 0.2,
  }) {
    return ChartBackgroundTimeRange(
      startTime: const TimeOfDay(hour: 17, minute: 0),
      endTime: const TimeOfDay(hour: 19, minute: 0),
      backgroundColor: color,
      opacity: opacity,
      label: 'Stoßzeit abends',
    );
  }
}
