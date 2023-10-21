/// An image which can be printed into a chart block
class BlockAssetImage {
  const BlockAssetImage({
    required this.path,
    this.height = 30,
    this.offsetTop = 0,
  });

  /// Padding (top, right, bottom and left) for the background color in this column data field
  final String path;

  /// The hight of the given asset image
  ///
  /// If null the height of the block will be used
  final int height;

  /// The offset top of the image
  ///
  /// The image can be moved furthe to the top from the center of this block
  final int offsetTop;
}
