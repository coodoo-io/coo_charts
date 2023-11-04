// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:coo_charts/chart_padding.enum.dart';
import 'package:coo_charts/x_axis_config.dart';
import 'package:coo_charts/y_axis_config.dart';

// Common chart config for every chart Type
class ChartConfig {
  const ChartConfig({
    this.curvedLine = false,
    this.crosshair = false,
    this.showGridHorizontal = true,
    this.showGridVertical = true,
    this.showDataPath = true,
    this.highlightMouseColumn = true,
    this.hightlightColumnColor,
    this.highlightPoints = true,
    this.addYAxisValueBuffer = true,
    this.highlightPointsVerticalLine = true,
    this.highlightPointsHorizontalLine = false,
    this.centerDataPointBetweenVerticalGrid = true,
    this.canvasBackgroundColor,
    this.canvasBackgroundPaintingStyle = PaintingStyle.fill,
  });

  final Color? canvasBackgroundColor;
  final PaintingStyle canvasBackgroundPaintingStyle;

  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  final bool curvedLine;

  /// Soll ein Fadenkreuz angezeigt werden?
  final bool crosshair;
  final bool showGridHorizontal; // if true, grid horizontal lines are painted
  final bool showGridVertical; // if true, grid vertical lines are painted

  final bool showDataPath; // Soll der path auf der Kurve angezeigt werden?
  final bool highlightMouseColumn; // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  final Color? hightlightColumnColor;
  final bool highlightPoints; // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  final bool
      highlightPointsVerticalLine; // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.

  final bool
      highlightPointsHorizontalLine; // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  final bool addYAxisValueBuffer; // Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  final bool centerDataPointBetweenVerticalGrid;

  ChartConfig copyWith({
    Color? canvasBackgroundColor,
    PaintingStyle? canvasBackgroundPaintingStyle,
    bool? curvedLine,
    bool? crosshair,
    bool? showGridHorizontal,
    bool? showGridVertical,
    bool? showDataPath,
    bool? highlightMouseColumn,
    bool? highlightPoints,
    bool? addYAxisValueBuffer,
    bool? centerDataPointBetweenVerticalGrid,
    bool? highlightPointsVerticalLine,
    bool? highlightPointsHorizontalLine,
    YAxisConfig? yAxisConfig,
    XAxisConfig? xAxisConfig,
    ChartPadding? padding,
  }) {
    return ChartConfig(
      canvasBackgroundColor: canvasBackgroundColor ?? this.canvasBackgroundColor,
      canvasBackgroundPaintingStyle: canvasBackgroundPaintingStyle ?? this.canvasBackgroundPaintingStyle,
      curvedLine: curvedLine ?? this.curvedLine,
      crosshair: crosshair ?? this.crosshair,
      showGridHorizontal: showGridHorizontal ?? this.showGridHorizontal,
      showGridVertical: showGridVertical ?? this.showGridVertical,
      showDataPath: showDataPath ?? this.showDataPath,
      highlightMouseColumn: highlightMouseColumn ?? this.highlightMouseColumn,
      highlightPoints: highlightPoints ?? this.highlightPoints,
      addYAxisValueBuffer: addYAxisValueBuffer ?? this.addYAxisValueBuffer,
      centerDataPointBetweenVerticalGrid: centerDataPointBetweenVerticalGrid ?? this.centerDataPointBetweenVerticalGrid,
      highlightPointsVerticalLine: highlightPointsVerticalLine ?? this.highlightPointsVerticalLine,
      highlightPointsHorizontalLine: highlightPointsHorizontalLine ?? this.highlightPointsHorizontalLine,
    );
  }
}
