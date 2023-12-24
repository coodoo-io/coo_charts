import 'package:flutter/material.dart';

/// Alle möglichen Konfigurationen, die direkten Bezug auf die Y-Achse haben.
class ChartColumnBlockConfig {
  const ChartColumnBlockConfig({
    this.backgroundColorPadding = 0,
    this.height = 30,
    this.backgroundColor,
    this.backgroundColorHighlight,
    this.textStyle,
    this.textStyleHightlight,
  });

  /// Padding (top, right, bottom and left) for the background color in this column data field
  final int backgroundColorPadding;

  /// Height of the block field.
  ///
  /// Default value is 30
  final int height;

  /// BackgroundColor of this block
  final Color? backgroundColor;

  /// BackgroundColor of this block if column highlighted
  final Color? backgroundColorHighlight;

  /// TextStyle of the printed text
  final TextStyle? textStyle;

  /// TextStyle of the printed text if column highlighted
  final TextStyle? textStyleHightlight;
}
