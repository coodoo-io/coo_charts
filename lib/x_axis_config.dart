import 'package:coo_charts/linechart_widget.dart';

class XAxisConfig {
  const XAxisConfig({
    this.valueType = XAxisValueType.number,
    this.showAxis = true,
    this.showTopLabels = false,
    this.showBottomLabels = true,
    this.startNumber = 0, // If value type is number -> startnumber
    this.topDateFormat, // If value type is date - date formatter for top labels
    this.bottomDateFormat, // If value type is date - date formatter for bottom labels
    this.labelBottomPostfix,
    this.labelTopPostfix,
  });

  /// Shoud the x-axis be printed. Default is true
  final bool showAxis;

  /// Which type of x-axis values (number, date, ...)
  final XAxisValueType valueType;

  // Show the x-axis lables or not?
  final bool showTopLabels;
  final bool showBottomLabels;

  /// The formatter of a date x-axis value. There is a build in default but you can use all the availble
  /// [DateFormat] formatter options (https://api.flutter.dev/flutter/intl/DateFormat-class.html).
  final String? topDateFormat;
  final String? bottomDateFormat;

  /// As default the start number of x-axis is 0 but you can configure a individual start number.
  /// Every next datapoint x-value will be counted + 1 from this number.
  final int startNumber;

  /// This text will be added to every label on x-axis
  /// e.g. °C -> 2 °C, 4 °C, 6 °C ...
  /// or cm -> 2 cm, 4 cm, 6 cm
  final String? labelBottomPostfix;
  final String? labelTopPostfix;
}
