import 'package:coo_charts/linechart_widget.dart';

class XAxisConfig {
  const XAxisConfig({
    this.xAxisValueType = XAxisValueType.number,
    this.startNumber = 0,
    this.dateFormat,
  });

  /// Which type of x-axis values (number, date, ...)
  final XAxisValueType? xAxisValueType;

  /// The formatter of a date x-axes value. There is a build in default but you can use all the availble
  /// [DateFormat] formatter options (https://api.flutter.dev/flutter/intl/DateFormat-class.html).
  final String? dateFormat;

  /// As default the start number of x-axis is 0 but you can configure a individual start number.
  /// Every next datapoint x-value will be counted + 1 from this number.
  final int startNumber;
}
