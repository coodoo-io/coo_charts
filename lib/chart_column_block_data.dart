import 'dart:ui';

/// If data points column legends are enabled this data class is needed for every column
class ChartColumnBlockData {
  ChartColumnBlockData({
    this.time,
    this.text,
    this.backgroundColor,
    this.assetImage,
  });

  /// if the data points belong to datetime.
  DateTime? time;

  // Text der angezeigt werden soll
  String? text;

  Color? backgroundColor;

  /// Must be a svg image which is available in the asset folder,
  String? assetImage;
}
