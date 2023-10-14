import 'package:coo_charts/linechart_widget.dart';

class XAxisConfig {
  const XAxisConfig({
    this.xAxisTopValueType = XAxisValueType.date,
    this.xAxisBottomValueType = XAxisValueType.number,
    this.xAxisValueType = XAxisValueType.number,
    this.startNumber = 0,
    this.topDateFormat,
    this.bottomDateFormat,
    this.showAxis = true,
  });

  /// Shoud the x-axis be printed. Default is true
  final bool showAxis;

  /// Which type of x-axis values (number, date, ...)
  final XAxisValueType? xAxisTopValueType;
  final XAxisValueType? xAxisBottomValueType;

  /// Which type of x-axis values (number, date, ...)
  final XAxisValueType? xAxisValueType;

  /// The formatter of a date x-axis value. There is a build in default but you can use all the availble
  /// [DateFormat] formatter options (https://api.flutter.dev/flutter/intl/DateFormat-class.html).
  final String? topDateFormat;
  final String? bottomDateFormat;

  /// As default the start number of x-axis is 0 but you can configure a individual start number.
  /// Every next datapoint x-value will be counted + 1 from this number.
  final int startNumber;
}
