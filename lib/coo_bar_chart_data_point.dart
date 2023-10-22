import 'dart:ui';

class CooBarChartDataPoint<T> {
  CooBarChartDataPoint({
    this.value, // Wert des Datenpunkts
    this.minValue, // kleinster Wert dieses Punktes
    this.maxValue, // größter Wert dieses Punktes
    this.label, // Optionaler individueller Label des Datenpunkts
    this.time, // Zeitstempel des Datenpunkts (Optional für Datetime Serien)
    this.color, // Die Farbe dieses bars

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

  Color? columnBackgroundColor;

  @override
  String toString() {
    return 'DataPoint: $value ($label)';
  }
}
