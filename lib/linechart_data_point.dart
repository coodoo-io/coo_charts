import 'dart:ui';

class LineChartDataPoint {
  double? value;
  double? minValue;
  double? maxValue;
  String? label;
  DateTime? time;
  Color? columnBackgroundColor;

  LineChartDataPoint({
    this.value, // Wert des Datenpunkts
    this.minValue, // kleinster Wert dieses Punktes
    this.maxValue, // größter Wert dieses Punktes
    this.label, // Optionaler individueller Label des Datenpunkts
    this.time, // Zeitstempel des Datenpunkts (Optional für Datetime Serien)

    /// Style Informationen
    this.columnBackgroundColor, // Hintergrundfarbe der Spalte des Datenpunkts
  });

  @override
  String toString() {
    return 'DataPoint: $value ($label)';
  }
}
