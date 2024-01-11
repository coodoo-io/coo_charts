// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:coo_charts/common/coo_chart_color_scheme.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_config.freezed.dart';

// Common chart config for every chart Type
@freezed
class ChartConfig with _$ChartConfig {
  const factory ChartConfig({
    /// The color schema for the whole chart. If not set the default color schema will be used
    CooChartColorScheme? colorScheme,

    /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
    @Default(false) bool curvedLine,

    /// Soll ein Fadenkreuz angezeigt werden?
    @Default(false) bool crosshair,

    // if true, grid horizontal lines are painted
    @Default(true) bool showGridHorizontal,

    // if true, grid vertical lines are painted
    @Default(true) bool showGridVertical,

    // Soll der path auf der Kurve angezeigt werden?
    @Default(true) bool showDataPath,

    // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
    @Default(true) bool highlightMouseColumn,

    // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
    @Default(true) bool highlightPoints,

    // Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
    @Default(true) bool addYAxisValueBuffer,

    // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
    @Default(true) bool highlightPointsVerticalLine,

    // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
    @Default(false) bool highlightPointsHorizontalLine,

    /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
    @Default(true) bool centerDataPointBetweenVerticalGrid,

    /// Experimental - Background painting style
    @Default(PaintingStyle.fill) PaintingStyle canvasBackgroundPaintingStyle,

    /// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
    @Default(false) bool scrollable,

    /// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
    /// will be scrollable/draggable
    double? canvasWidth,
  }) = _ChartConfig;
}
