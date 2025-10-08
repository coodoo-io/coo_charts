// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class XAxisConfig {
  const XAxisConfig({
    this.showAxis = true,
    this.valueType = XAxisValueType.number,
    this.showTopLabels = false,
    this.showSecondTopLabels = false,
    this.topLabelTextStyle,
    this.topLabelSecondTextStyle,
    this.topLabelTextStyleHighlight,
    this.topLabelSecondTextStyleHighlight,
    this.topLabelOffset,
    this.showBottomLabels = true,
    this.bottomLabelTextStyle,
    this.bottomLabelTextStyleHighlight,
    this.bottomLabelOffset,
    this.topDateFormat,
    this.secondTopDateFormat,
    this.bottomDateFormat,
    this.startNumber = 0, // If value type is number -> startnumber
    this.labelBottomPostfix,
    this.labelTopPostfix,
    this.stepAxisLineStart = 0,
    this.stepAxisLine,
    this.useSvgLabels = false, // Whether to use SVG labels instead of text labels
    this.topLabelsAtHours,
    this.secondTopLabelsAtHours,
  });

  /// Shoud the x-axis be printed. Default is true
  final bool showAxis;

  /// Which type of x-axis values (number, date, ...)
  final XAxisValueType valueType;

  // Show the x-axis lables or not?
  final bool showTopLabels;
  final bool showSecondTopLabels;
  final bool showBottomLabels;

  final TextStyle? topLabelTextStyle;
  final TextStyle? topLabelSecondTextStyle;
  final TextStyle? topLabelTextStyleHighlight;
  final TextStyle? topLabelSecondTextStyleHighlight;
  final TextStyle? bottomLabelTextStyle;
  final TextStyle? bottomLabelTextStyleHighlight;

  final Offset? topLabelOffset;
  final Offset? bottomLabelOffset;

  /// The formatter of a date x-axis value. There is a build in default but you can use all the availble
  /// [DateFormat] formatter options (https://api.flutter.dev/flutter/intl/DateFormat-class.html).
  final String? topDateFormat;
  final String? secondTopDateFormat;
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

  /// List of hours at which top labels should be shown (e.g., [12] for only noon, [0, 12] for midnight and noon)
  /// If null, top labels are shown at all positions when showTopLabels is true
  final List<int>? topLabelsAtHours;

  /// List of hours at which second top labels should be shown (e.g., [12] for only noon, [0, 12] for midnight and noon)
  /// If null, second top labels are shown at all positions when showSecondTopLabels is true
  final List<int>? secondTopLabelsAtHours;

  XAxisConfig copyWith({
    TextStyle? topLabelTextStyle,
    TextStyle? topLabelSecondTextStyle,
    TextStyle? topLabelTextStyleHighlight,
    TextStyle? topLabelSecondTextStyleHighlight,
    TextStyle? bottomLabelTextStyle,
    TextStyle? bottomLabelTextStyleHighlight,
    Offset? topLabelOffset,
    Offset? bottomLabelOffset,
    bool? showAxis,
    XAxisValueType? valueType,
    bool? showTopLabels,
    bool? showSecondTopLabels,
    bool? showBottomLabels,
    String? topDateFormat,
    String? secondTopDateFormat,
    String? bottomDateFormat,
    int? startNumber,
    String? labelBottomPostfix,
    String? labelTopPostfix,
    int? stepAxisLine,
    int? stepAxisLineStart,
    bool? useSvgLabels,
    List<int>? topLabelsAtHours,
    List<int>? secondTopLabelsAtHours,
  }) {
    return XAxisConfig(
      topLabelTextStyle: topLabelTextStyle ?? this.topLabelTextStyle,
      topLabelSecondTextStyle: topLabelSecondTextStyle ?? this.topLabelSecondTextStyle,
      topLabelTextStyleHighlight: topLabelTextStyleHighlight ?? this.topLabelTextStyleHighlight,
      topLabelSecondTextStyleHighlight: topLabelSecondTextStyleHighlight ?? this.topLabelSecondTextStyleHighlight,
      bottomLabelTextStyle: bottomLabelTextStyle ?? this.bottomLabelTextStyle,
      bottomLabelTextStyleHighlight: bottomLabelTextStyleHighlight ?? this.bottomLabelTextStyleHighlight,
      topLabelOffset: topLabelOffset ?? this.topLabelOffset,
      bottomLabelOffset: bottomLabelOffset ?? this.bottomLabelOffset,
      showAxis: showAxis ?? this.showAxis,
      valueType: valueType ?? this.valueType,
      showTopLabels: showTopLabels ?? this.showTopLabels,
      showSecondTopLabels: showSecondTopLabels ?? this.showSecondTopLabels,
      showBottomLabels: showBottomLabels ?? this.showBottomLabels,
      topDateFormat: topDateFormat ?? this.topDateFormat,
      secondTopDateFormat: secondTopDateFormat ?? this.secondTopDateFormat,
      bottomDateFormat: bottomDateFormat ?? this.bottomDateFormat,
      startNumber: startNumber ?? this.startNumber,
      labelBottomPostfix: labelBottomPostfix ?? this.labelBottomPostfix,
      labelTopPostfix: labelTopPostfix ?? this.labelTopPostfix,
      stepAxisLine: stepAxisLine ?? this.stepAxisLine,
      stepAxisLineStart: stepAxisLineStart ?? this.stepAxisLineStart,
      useSvgLabels: useSvgLabels ?? this.useSvgLabels,
      topLabelsAtHours: topLabelsAtHours ?? this.topLabelsAtHours,
      secondTopLabelsAtHours: secondTopLabelsAtHours ?? this.secondTopLabelsAtHours,
    );
  }
}
