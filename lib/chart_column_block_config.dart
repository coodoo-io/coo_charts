import 'package:flutter/material.dart';

/// Alle möglichen Konfigurationen, die direkten Bezug auf die Y-Achse haben.
class ChartColumnBlockConfig {
  const ChartColumnBlockConfig({
    this.backgroundColorPadding = 0,
    this.height = 30,
    this.textStyle,
    this.textStyleHightlight,
  });

  /// Padding (top, right, bottom and left) for the background color in this column data field
  final int backgroundColorPadding;

  /// Height of the block field.
  ///
  /// Default value is 30
  final int height;

  /// TextStyle vor text value
  final TextStyle? textStyle;
  final TextStyle? textStyleHightlight;
}
