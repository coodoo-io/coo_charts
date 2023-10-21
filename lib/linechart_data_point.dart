import 'dart:ui';

class LineChartDataPoint<T> {
  LineChartDataPoint({
    this.value, // Wert des Datenpunkts
    this.minValue, // kleinster Wert dieses Punktes
    this.maxValue, // größter Wert dieses Punktes
    this.label, // Optionaler individueller Label des Datenpunkts
    this.time, // Zeitstempel des Datenpunkts (Optional für Datetime Serien)

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
  Color? columnBackgroundColor;

  @override
  String toString() {
    return 'DataPoint: $value ($label)';
  }
}
