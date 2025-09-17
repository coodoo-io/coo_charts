/// Represents an SVG icon that can be displayed as an X-axis label
class XAxisLabelSvg {
  const XAxisLabelSvg({
    required this.assetPath,
    this.width = 16.0,
    this.height = 16.0,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.rotationDegrees = 0.0,
  });

  /// Path to the SVG asset
  final String assetPath;
  
  /// Width of the SVG icon
  final double width;
  
  /// Height of the SVG icon  
  final double height;
  
  /// Horizontal offset from the label position
  final double offsetX;
  
  /// Vertical offset from the label position
  final double offsetY;

  /// Rotation in degrees (0-360)
  final double rotationDegrees;
}
