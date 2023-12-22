import 'package:coo_charts/common/blocks/chart_column_block_config_image.dart';
import 'package:flutter/material.dart';

/// If data points column legends are enabled this data class is needed for every column
class ChartColumnBlockData {
  ChartColumnBlockData({
    this.time,
    this.text,
    this.backgroundColor,
    this.backgroundColorHighlight,
    this.textStyle,
    this.textStyleHighlight,
    this.assetImages = const [],
  });

  /// if the data points belong to datetime.
  DateTime? time;

  /// Text der angezeigt werden soll
  String? text;

  /// BackgroundColor of this block
  Color? backgroundColor;

  /// BackgroundColor of this block if highlighted
  Color? backgroundColorHighlight;

  /// TextStyle of the printed text
  TextStyle? textStyle;

  /// TextStyle of the printed text if highlighted
  TextStyle? textStyleHighlight;

  /// One or more images to be displayed in this block. If there are more than two images,
  /// the offset must be set for the image itself.
  List<BlockAssetImage> assetImages;
}
