import 'dart:ui';

/// Data structure for grouped bar values (e.g., rain and snow)
class GroupedBarValue {
  const GroupedBarValue({
    required this.primaryValue,
    required this.secondaryValue,
    this.primaryColor,
    this.secondaryColor,
    this.primaryLabel,
    this.secondaryLabel,
  });

  final double primaryValue;
  final double secondaryValue;
  final Color? primaryColor;
  final Color? secondaryColor;
  final String? primaryLabel;
  final String? secondaryLabel;
}

class CooBarChartDataPoint<T> {
  CooBarChartDataPoint({
    this.value, // Wert des Datenpunkts
    this.minValue, // kleinster Wert dieses Punktes
    this.maxValue, // größter Wert dieses Punktes
    this.label, // Optionaler individueller Label des Datenpunkts
    this.time, // Zeitstempel des Datenpunkts (Optional für Datetime Serien)
    this.color, // Die Farbe dieses bars
    this.groupedValue, // Support for grouped bars (e.g., rain and snow)

    /// Style Informationen
    this.columnBackgroundColor, // Hintergrundfarbe der Spalte des Datenpunkts

    this.valueObject,
  });

  /// Items can have the original value object attached to them `T`
  final T? valueObject;

  double? value;
  double? minValue;
  double? maxValue;
  String? label;
  DateTime? time;
  Color? color;

  /// NEW: Grouped values for displaying two bars at the same position
  /// When set, this takes precedence over the single 'value' property
  final GroupedBarValue? groupedValue;

  Color? columnBackgroundColor;

  /// Helper method to get the effective value for calculations
  /// If groupedValue is set, returns the sum of primary and secondary values
  /// Otherwise returns the single value
  double? get effectiveValue {
    if (groupedValue != null) {
      return groupedValue!.primaryValue + groupedValue!.secondaryValue;
    }
    return value;
  }

  /// Helper method to check if this data point uses grouped values
  bool get hasGroupedValues => groupedValue != null;

  @override
  String toString() {
    if (hasGroupedValues) {
      return 'DataPoint: primary=${groupedValue!.primaryValue}, secondary=${groupedValue!.secondaryValue} ($label)';
    }
    return 'DataPoint: $value ($label)';
  }
}
