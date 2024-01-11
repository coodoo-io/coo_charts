import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coo_chart_color_scheme.freezed.dart';

@freezed
class CooChartColorScheme with _$CooChartColorScheme {
  const factory CooChartColorScheme({
    /// The color of the outer border lines
    required Color canvasBorderColor,

    /// The color of the inner grid lines
    required Color gridColor,

    /// The color of the outer chart canvas background
    required Color canvasBackgroundColor,
    required Color dataPointColor,
    required Color dataPointHighlightColor,
    required Color columnHighlightColor,
    required Color minMaxRangeColor,
  }) = _CooChartColorScheme;
}
