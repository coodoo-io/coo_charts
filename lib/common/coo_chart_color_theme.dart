import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coo_chart_color_theme.freezed.dart';

@freezed
class CooChartTheme with _$CooChartTheme {
  const factory CooChartTheme({
    /// The color of the complete chart painter
    required Color backgroundColor,

    /// If the chart is scrollable the background of the labels can be configured as transparent gradient
    /// Default is not transperant.
    @Default(false) bool labelBackgroundTransparentGradient,

    /// The color of the outer chart canvas background
    required Color chartBackgroundColor,

    /// The color of the outer border lines
    required Color chartBorderColor,

    /// y- and x-axis label color
    required Color labelColor,

    /// y- and x-axis label font size
    required double labelFontSize,

    /// y- and x-axis label textStyle. If given the label color and font size is not used
    TextStyle? labelTextStyle,

    /// The color of the inner grid lines
    required Color gridColor,
    required Color dataPointColor,
    required Color dataPointHighlightColor,
    required Color columnHighlightColor,

    /// bar chart colors
    required Color barColor,
    required Color barColorHighlight,

    /// Min- Max range is available in barchart and linechart. Define the color of this line.
    required Color minMaxRangeColor,
  }) = _CooChartTheme;
}
