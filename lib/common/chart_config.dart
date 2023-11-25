// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_config.freezed.dart';

// Common chart config for every chart Type
@freezed
class ChartConfig with _$ChartConfig {
  const factory ChartConfig({
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

    // TODO move to theme
    Color? canvasBackgroundColor,

    // TODO move to theme
    Color? hightlightColumnColor,
    @Default(PaintingStyle.fill) PaintingStyle canvasBackgroundPaintingStyle,
    // Breite des Canvas. Wenn null dann wird die Breite des gegbenen Layouts verwendet. Falls Größer wird das
    // Canvas scrollbar.
    canvasWidth,
  }) = _ChartConfig;
}
