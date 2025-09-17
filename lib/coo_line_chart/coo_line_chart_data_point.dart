import 'dart:ui';

/// Represents an SVG icon that can be displayed as a data point label
class DataPointSvgIcon {
  const DataPointSvgIcon({
    required this.assetPath,
    this.width = 24.0,
    this.height = 24.0,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
  });

  /// Path to the SVG asset
  final String assetPath;
  
  /// Width of the SVG icon
  final double width;
  
  /// Height of the SVG icon  
  final double height;
  
  /// Horizontal offset from the data point
  final double offsetX;
  
  /// Vertical offset from the data point
  final double offsetY;
}

class CooLineChartDataPoint<T> {
  CooLineChartDataPoint({
    this.value, // Wert des Datenpunkts
    this.minValue, // kleinster Wert dieses Punktes
    this.maxValue, // größter Wert dieses Punktes
    this.label, // Optionaler individueller Label des Datenpunkts
    this.time, // Zeitstempel des Datenpunkts (Optional für Datetime Serien)

    /// Style Informationen
    this.columnBackgroundColor, // Hintergrundfarbe der Spalte des Datenpunkts

    /// SVG Icon for data point label
    this.svgIcon,

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
  
  /// Optional SVG icon to display instead of or alongside text label
  DataPointSvgIcon? svgIcon;

  @override
  String toString() {
    return 'DataPoint: $value ($label)';
  }
}
