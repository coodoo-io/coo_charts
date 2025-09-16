// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// Konfiguration für Hintergrund-Zeiträume im Chart
/// Ermöglicht es, bestimmte Zeitbereiche mit einer anderen Hintergrundfarbe zu markieren
class ChartBackgroundTimeRange {
  const ChartBackgroundTimeRange({
    required this.startTime,
    required this.endTime,
    required this.backgroundColor,
    this.opacity = 0.3,
    this.label,
    this.repeat = ChartBackgroundTimeRangeRepeat.none,
  });

  /// Startzeit des Zeitraums
  final TimeOfDay startTime;

  /// Endzeit des Zeitraums
  final TimeOfDay endTime;

  /// Hintergrundfarbe für diesen Zeitraum
  final Color backgroundColor;

  /// Optional: Transparenz der Hintergrundfarbe (0.0 - 1.0)
  final double opacity;

  /// Optional: Beschreibung/Label für diesen Zeitraum
  final String? label;

  /// Optional: Wiederholung des Zeitraums (täglich, wöchentlich, etc.)
  final ChartBackgroundTimeRangeRepeat repeat;

  ChartBackgroundTimeRange copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Color? backgroundColor,
    double? opacity,
    String? label,
    ChartBackgroundTimeRangeRepeat? repeat,
  }) {
    return ChartBackgroundTimeRange(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      opacity: opacity ?? this.opacity,
      label: label ?? this.label,
      repeat: repeat ?? this.repeat,
    );
  }
}

/// Wiederholungsoptionen für Hintergrund-Zeiträume
enum ChartBackgroundTimeRangeRepeat {
  /// Keine Wiederholung
  none,

  /// Täglich wiederholen
  daily,

  /// Wöchentlich wiederholen
  weekly,

  /// Monatlich wiederholen
  monthly,
}
