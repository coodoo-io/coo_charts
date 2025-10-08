import 'package:flutter/material.dart';

/// Configuration for rendering a custom widget as an X-axis label
class XAxisLabelWidget {
  const XAxisLabelWidget({
    required this.widget,
    this.width = 40.0,
    this.height = 40.0,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.rotationDegrees = 0.0,
  });

  /// The custom widget to render (e.g., CustomPaint with WindBarbPainter)
  final Widget widget;

  /// Width of the widget area
  final double width;

  /// Height of the widget area
  final double height;

  /// X offset from the calculated center position
  final double offsetX;

  /// Y offset from the calculated center position
  final double offsetY;

  /// Rotation in degrees (0 = no rotation)
  final double rotationDegrees;
}
