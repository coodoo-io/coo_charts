import 'dart:ui';

import 'package:coo_charts/chart_column_block_config_image.dart';

/// If data points column legends are enabled this data class is needed for every column
class ChartColumnBlockData {
  ChartColumnBlockData({
    this.time,
    this.text,
    this.backgroundColor,
    this.assetImages = const [],
  });

  /// if the data points belong to datetime.
  DateTime? time;

  // Text der angezeigt werden soll
  String? text;

  Color? backgroundColor;

  List<BlockAssetImage> assetImages;
}
