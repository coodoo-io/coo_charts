// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class XAxisConfig {
  const XAxisConfig({
    this.showAxis = true,
    this.valueType = XAxisValueType.number,
    this.showTopLabels = false,
    this.topLabelTextStyle,
    this.topLabelTextStyleHighlight,
    this.topLabelOffset,
    this.showBottomLabels = true,
    this.bottomLabelTextStyle,
    this.bottomLabelTextStyleHighlight,
    this.bottomLabelOffset,
    this.topDateFormat,
    this.bottomDateFormat,
    this.startNumber = 0, // If value type is number -> startnumber
    this.labelBottomPostfix,
    this.labelTopPostfix,
    this.stepAxisLineStart = 0,
    this.stepAxisLine,
    this.useSvgLabels = false, // Whether to use SVG labels instead of text labels
  });

  /// Shoud the x-axis be printed. Default is true
  final bool showAxis;

  /// Which type of x-axis values (number, date, ...)
  final XAxisValueType valueType;

  // Show the x-axis lables or not?
  final bool showTopLabels;
  final bool showBottomLabels;

  final TextStyle? topLabelTextStyle;
  final TextStyle? topLabelTextStyleHighlight;
  final TextStyle? bottomLabelTextStyle;
  final TextStyle? bottomLabelTextStyleHighlight;

  final Offset? topLabelOffset;
  final Offset? bottomLabelOffset;

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

  /// Print every given step, started at axisStepStart or 0 an x-axis line
  /// If given no other axis lines will be printed
  final int? stepAxisLine;

  // start step for the first printed x-axise line
  final int stepAxisLineStart;

  /// Whether to use SVG labels instead of text labels for bottom X-axis
  final bool useSvgLabels;

  XAxisConfig copyWith({
    TextStyle? topLabelTextStyle,
    TextStyle? topLabelTextStyleHighlight,
    TextStyle? bottomLabelTextStyle,
    TextStyle? bottomLabelTextStyleHighlight,
    Offset? topLabelOffset,
    Offset? bottomLabelOffset,
    bool? showAxis,
    XAxisValueType? valueType,
    bool? showTopLabels,
    bool? showBottomLabels,
    String? topDateFormat,
    String? bottomDateFormat,
    int? startNumber,
    String? labelBottomPostfix,
    String? labelTopPostfix,
    int? stepAxisLine,
    int? stepAxisLineStart,
    bool? useSvgLabels,
  }) {
    return XAxisConfig(
      topLabelTextStyle: topLabelTextStyle ?? this.topLabelTextStyle,
      topLabelTextStyleHighlight: topLabelTextStyleHighlight ?? this.topLabelTextStyleHighlight,
      bottomLabelTextStyle: bottomLabelTextStyle ?? this.bottomLabelTextStyle,
      bottomLabelTextStyleHighlight: bottomLabelTextStyleHighlight ?? this.bottomLabelTextStyleHighlight,
      topLabelOffset: topLabelOffset ?? this.topLabelOffset,
      bottomLabelOffset: bottomLabelOffset ?? this.bottomLabelOffset,
      showAxis: showAxis ?? this.showAxis,
      valueType: valueType ?? this.valueType,
      showTopLabels: showTopLabels ?? this.showTopLabels,
      showBottomLabels: showBottomLabels ?? this.showBottomLabels,
      topDateFormat: topDateFormat ?? this.topDateFormat,
      bottomDateFormat: bottomDateFormat ?? this.bottomDateFormat,
      startNumber: startNumber ?? this.startNumber,
      labelBottomPostfix: labelBottomPostfix ?? this.labelBottomPostfix,
      labelTopPostfix: labelTopPostfix ?? this.labelTopPostfix,
      stepAxisLine: stepAxisLine ?? this.stepAxisLine,
      stepAxisLineStart: stepAxisLineStart ?? this.stepAxisLineStart,
      useSvgLabels: useSvgLabels ?? this.useSvgLabels,
    );
  }
}
