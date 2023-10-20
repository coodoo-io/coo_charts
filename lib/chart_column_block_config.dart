/// Alle möglichen Konfigurationen, die direkten Bezug auf die Y-Achse haben.
class ChartColumnBlockConfig {
  const ChartColumnBlockConfig({
    this.backgroundColorPadding = 0,
    this.height = 30,
    this.imageHeight = 20,
  });

  /// Padding (top, right, bottom and left) for the background color in this column data field
  final int backgroundColorPadding;

  /// Height of the block field.
  ///
  /// Default value is 30
  final int height;

  /// The hight of the given asset image
  ///
  /// If null the height of the block will be used
  final int imageHeight;
}
