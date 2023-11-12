import 'package:coo_charts/common/blocks/chart_column_block_data.dart';
import 'package:coo_charts/common/blocks/chart_column_block_config.dart';

/// Adds a info line with blocks over or under a colum.
///
/// If the charts should have a column info line at top or bottom you can add this object to your chart widget.
class ChartColumnBlocks {
  ChartColumnBlocks({
    this.showTopBlocks = false,
    this.topConfig = const ChartColumnBlockConfig(),
    this.topDatas = const [],
    this.showBottomBlocks = false,
    this.bottomConfig = const ChartColumnBlockConfig(),
    this.bottomDatas = const [],
  });

  // Additional config whether the blocks should be shown or not
  final bool showTopBlocks;
  final List<ChartColumnBlockData> topDatas;
  final List<ChartColumnBlockData> bottomDatas;

  final bool showBottomBlocks;
  final ChartColumnBlockConfig topConfig;
  final ChartColumnBlockConfig bottomConfig;
}
