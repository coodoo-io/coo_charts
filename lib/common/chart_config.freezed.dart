// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChartConfig {
  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  bool get curvedLine => throw _privateConstructorUsedError;

  /// Soll ein Fadenkreuz angezeigt werden?
  bool get crosshair => throw _privateConstructorUsedError; // if true, grid horizontal lines are painted
  bool get showGridHorizontal => throw _privateConstructorUsedError; // if true, grid vertical lines are painted
  bool get showGridVertical => throw _privateConstructorUsedError; // Soll der path auf der Kurve angezeigt werden?
  bool get showDataPath =>
      throw _privateConstructorUsedError; // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  bool get highlightMouseColumn =>
      throw _privateConstructorUsedError; // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  bool get highlightPoints =>
      throw _privateConstructorUsedError; // Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
  bool get addYAxisValueBuffer =>
      throw _privateConstructorUsedError; // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  bool get highlightPointsVerticalLine =>
      throw _privateConstructorUsedError; // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  bool get highlightPointsHorizontalLine => throw _privateConstructorUsedError;

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  bool get centerDataPointBetweenVerticalGrid => throw _privateConstructorUsedError;

  /// TODO move to theme
  Color? get canvasBackgroundColor => throw _privateConstructorUsedError;

  /// TODO move to theme
  Color? get hightlightColumnColor => throw _privateConstructorUsedError;

  /// Experimental - Background painting style
  PaintingStyle get canvasBackgroundPaintingStyle => throw _privateConstructorUsedError;

  /// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
  bool get scrollable => throw _privateConstructorUsedError;

  /// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
  /// will be scrollable/draggable
  double? get canvasWidth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChartConfigCopyWith<ChartConfig> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartConfigCopyWith<$Res> {
  factory $ChartConfigCopyWith(ChartConfig value, $Res Function(ChartConfig) then) =
      _$ChartConfigCopyWithImpl<$Res, ChartConfig>;
  @useResult
  $Res call(
      {bool curvedLine,
      bool crosshair,
      bool showGridHorizontal,
      bool showGridVertical,
      bool showDataPath,
      bool highlightMouseColumn,
      bool highlightPoints,
      bool addYAxisValueBuffer,
      bool highlightPointsVerticalLine,
      bool highlightPointsHorizontalLine,
      bool centerDataPointBetweenVerticalGrid,
      Color? canvasBackgroundColor,
      Color? hightlightColumnColor,
      PaintingStyle canvasBackgroundPaintingStyle,
      bool scrollable,
      double? canvasWidth});
}

/// @nodoc
class _$ChartConfigCopyWithImpl<$Res, $Val extends ChartConfig> implements $ChartConfigCopyWith<$Res> {
  _$ChartConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? curvedLine = null,
    Object? crosshair = null,
    Object? showGridHorizontal = null,
    Object? showGridVertical = null,
    Object? showDataPath = null,
    Object? highlightMouseColumn = null,
    Object? highlightPoints = null,
    Object? addYAxisValueBuffer = null,
    Object? highlightPointsVerticalLine = null,
    Object? highlightPointsHorizontalLine = null,
    Object? centerDataPointBetweenVerticalGrid = null,
    Object? canvasBackgroundColor = freezed,
    Object? hightlightColumnColor = freezed,
    Object? canvasBackgroundPaintingStyle = null,
    Object? scrollable = null,
    Object? canvasWidth = freezed,
  }) {
    return _then(_value.copyWith(
      curvedLine: null == curvedLine
          ? _value.curvedLine
          : curvedLine // ignore: cast_nullable_to_non_nullable
              as bool,
      crosshair: null == crosshair
          ? _value.crosshair
          : crosshair // ignore: cast_nullable_to_non_nullable
              as bool,
      showGridHorizontal: null == showGridHorizontal
          ? _value.showGridHorizontal
          : showGridHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
      showGridVertical: null == showGridVertical
          ? _value.showGridVertical
          : showGridVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      showDataPath: null == showDataPath
          ? _value.showDataPath
          : showDataPath // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightMouseColumn: null == highlightMouseColumn
          ? _value.highlightMouseColumn
          : highlightMouseColumn // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightPoints: null == highlightPoints
          ? _value.highlightPoints
          : highlightPoints // ignore: cast_nullable_to_non_nullable
              as bool,
      addYAxisValueBuffer: null == addYAxisValueBuffer
          ? _value.addYAxisValueBuffer
          : addYAxisValueBuffer // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightPointsVerticalLine: null == highlightPointsVerticalLine
          ? _value.highlightPointsVerticalLine
          : highlightPointsVerticalLine // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightPointsHorizontalLine: null == highlightPointsHorizontalLine
          ? _value.highlightPointsHorizontalLine
          : highlightPointsHorizontalLine // ignore: cast_nullable_to_non_nullable
              as bool,
      centerDataPointBetweenVerticalGrid: null == centerDataPointBetweenVerticalGrid
          ? _value.centerDataPointBetweenVerticalGrid
          : centerDataPointBetweenVerticalGrid // ignore: cast_nullable_to_non_nullable
              as bool,
      canvasBackgroundColor: freezed == canvasBackgroundColor
          ? _value.canvasBackgroundColor
          : canvasBackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      hightlightColumnColor: freezed == hightlightColumnColor
          ? _value.hightlightColumnColor
          : hightlightColumnColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      canvasBackgroundPaintingStyle: null == canvasBackgroundPaintingStyle
          ? _value.canvasBackgroundPaintingStyle
          : canvasBackgroundPaintingStyle // ignore: cast_nullable_to_non_nullable
              as PaintingStyle,
      scrollable: null == scrollable
          ? _value.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
      canvasWidth: freezed == canvasWidth
          ? _value.canvasWidth
          : canvasWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartConfigImplCopyWith<$Res> implements $ChartConfigCopyWith<$Res> {
  factory _$$ChartConfigImplCopyWith(_$ChartConfigImpl value, $Res Function(_$ChartConfigImpl) then) =
      __$$ChartConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool curvedLine,
      bool crosshair,
      bool showGridHorizontal,
      bool showGridVertical,
      bool showDataPath,
      bool highlightMouseColumn,
      bool highlightPoints,
      bool addYAxisValueBuffer,
      bool highlightPointsVerticalLine,
      bool highlightPointsHorizontalLine,
      bool centerDataPointBetweenVerticalGrid,
      Color? canvasBackgroundColor,
      Color? hightlightColumnColor,
      PaintingStyle canvasBackgroundPaintingStyle,
      bool scrollable,
      double? canvasWidth});
}

/// @nodoc
class __$$ChartConfigImplCopyWithImpl<$Res> extends _$ChartConfigCopyWithImpl<$Res, _$ChartConfigImpl>
    implements _$$ChartConfigImplCopyWith<$Res> {
  __$$ChartConfigImplCopyWithImpl(_$ChartConfigImpl _value, $Res Function(_$ChartConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? curvedLine = null,
    Object? crosshair = null,
    Object? showGridHorizontal = null,
    Object? showGridVertical = null,
    Object? showDataPath = null,
    Object? highlightMouseColumn = null,
    Object? highlightPoints = null,
    Object? addYAxisValueBuffer = null,
    Object? highlightPointsVerticalLine = null,
    Object? highlightPointsHorizontalLine = null,
    Object? centerDataPointBetweenVerticalGrid = null,
    Object? canvasBackgroundColor = freezed,
    Object? hightlightColumnColor = freezed,
    Object? canvasBackgroundPaintingStyle = null,
    Object? scrollable = null,
    Object? canvasWidth = freezed,
  }) {
    return _then(_$ChartConfigImpl(
      curvedLine: null == curvedLine
          ? _value.curvedLine
          : curvedLine // ignore: cast_nullable_to_non_nullable
              as bool,
      crosshair: null == crosshair
          ? _value.crosshair
          : crosshair // ignore: cast_nullable_to_non_nullable
              as bool,
      showGridHorizontal: null == showGridHorizontal
          ? _value.showGridHorizontal
          : showGridHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
      showGridVertical: null == showGridVertical
          ? _value.showGridVertical
          : showGridVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      showDataPath: null == showDataPath
          ? _value.showDataPath
          : showDataPath // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightMouseColumn: null == highlightMouseColumn
          ? _value.highlightMouseColumn
          : highlightMouseColumn // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightPoints: null == highlightPoints
          ? _value.highlightPoints
          : highlightPoints // ignore: cast_nullable_to_non_nullable
              as bool,
      addYAxisValueBuffer: null == addYAxisValueBuffer
          ? _value.addYAxisValueBuffer
          : addYAxisValueBuffer // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightPointsVerticalLine: null == highlightPointsVerticalLine
          ? _value.highlightPointsVerticalLine
          : highlightPointsVerticalLine // ignore: cast_nullable_to_non_nullable
              as bool,
      highlightPointsHorizontalLine: null == highlightPointsHorizontalLine
          ? _value.highlightPointsHorizontalLine
          : highlightPointsHorizontalLine // ignore: cast_nullable_to_non_nullable
              as bool,
      centerDataPointBetweenVerticalGrid: null == centerDataPointBetweenVerticalGrid
          ? _value.centerDataPointBetweenVerticalGrid
          : centerDataPointBetweenVerticalGrid // ignore: cast_nullable_to_non_nullable
              as bool,
      canvasBackgroundColor: freezed == canvasBackgroundColor
          ? _value.canvasBackgroundColor
          : canvasBackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      hightlightColumnColor: freezed == hightlightColumnColor
          ? _value.hightlightColumnColor
          : hightlightColumnColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      canvasBackgroundPaintingStyle: null == canvasBackgroundPaintingStyle
          ? _value.canvasBackgroundPaintingStyle
          : canvasBackgroundPaintingStyle // ignore: cast_nullable_to_non_nullable
              as PaintingStyle,
      scrollable: null == scrollable
          ? _value.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
      canvasWidth: freezed == canvasWidth
          ? _value.canvasWidth
          : canvasWidth // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ChartConfigImpl implements _ChartConfig {
  const _$ChartConfigImpl(
      {this.curvedLine = false,
      this.crosshair = false,
      this.showGridHorizontal = true,
      this.showGridVertical = true,
      this.showDataPath = true,
      this.highlightMouseColumn = true,
      this.highlightPoints = true,
      this.addYAxisValueBuffer = true,
      this.highlightPointsVerticalLine = true,
      this.highlightPointsHorizontalLine = false,
      this.centerDataPointBetweenVerticalGrid = true,
      this.canvasBackgroundColor,
      this.hightlightColumnColor,
      this.canvasBackgroundPaintingStyle = PaintingStyle.fill,
      this.scrollable = false,
      this.canvasWidth});

  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  @override
  @JsonKey()
  final bool curvedLine;

  /// Soll ein Fadenkreuz angezeigt werden?
  @override
  @JsonKey()
  final bool crosshair;
// if true, grid horizontal lines are painted
  @override
  @JsonKey()
  final bool showGridHorizontal;
// if true, grid vertical lines are painted
  @override
  @JsonKey()
  final bool showGridVertical;
// Soll der path auf der Kurve angezeigt werden?
  @override
  @JsonKey()
  final bool showDataPath;
// Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  @override
  @JsonKey()
  final bool highlightMouseColumn;
// Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  @override
  @JsonKey()
  final bool highlightPoints;
// Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
  @override
  @JsonKey()
  final bool addYAxisValueBuffer;
// Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  @override
  @JsonKey()
  final bool highlightPointsVerticalLine;
// Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  @override
  @JsonKey()
  final bool highlightPointsHorizontalLine;

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  @override
  @JsonKey()
  final bool centerDataPointBetweenVerticalGrid;

  /// TODO move to theme
  @override
  final Color? canvasBackgroundColor;

  /// TODO move to theme
  @override
  final Color? hightlightColumnColor;

  /// Experimental - Background painting style
  @override
  @JsonKey()
  final PaintingStyle canvasBackgroundPaintingStyle;

  /// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
  @override
  @JsonKey()
  final bool scrollable;

  /// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
  /// will be scrollable/draggable
  @override
  final double? canvasWidth;

  @override
  String toString() {
    return 'ChartConfig(curvedLine: $curvedLine, crosshair: $crosshair, showGridHorizontal: $showGridHorizontal, showGridVertical: $showGridVertical, showDataPath: $showDataPath, highlightMouseColumn: $highlightMouseColumn, highlightPoints: $highlightPoints, addYAxisValueBuffer: $addYAxisValueBuffer, highlightPointsVerticalLine: $highlightPointsVerticalLine, highlightPointsHorizontalLine: $highlightPointsHorizontalLine, centerDataPointBetweenVerticalGrid: $centerDataPointBetweenVerticalGrid, canvasBackgroundColor: $canvasBackgroundColor, hightlightColumnColor: $hightlightColumnColor, canvasBackgroundPaintingStyle: $canvasBackgroundPaintingStyle, scrollable: $scrollable, canvasWidth: $canvasWidth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartConfigImpl &&
            (identical(other.curvedLine, curvedLine) || other.curvedLine == curvedLine) &&
            (identical(other.crosshair, crosshair) || other.crosshair == crosshair) &&
            (identical(other.showGridHorizontal, showGridHorizontal) ||
                other.showGridHorizontal == showGridHorizontal) &&
            (identical(other.showGridVertical, showGridVertical) || other.showGridVertical == showGridVertical) &&
            (identical(other.showDataPath, showDataPath) || other.showDataPath == showDataPath) &&
            (identical(other.highlightMouseColumn, highlightMouseColumn) ||
                other.highlightMouseColumn == highlightMouseColumn) &&
            (identical(other.highlightPoints, highlightPoints) || other.highlightPoints == highlightPoints) &&
            (identical(other.addYAxisValueBuffer, addYAxisValueBuffer) ||
                other.addYAxisValueBuffer == addYAxisValueBuffer) &&
            (identical(other.highlightPointsVerticalLine, highlightPointsVerticalLine) ||
                other.highlightPointsVerticalLine == highlightPointsVerticalLine) &&
            (identical(other.highlightPointsHorizontalLine, highlightPointsHorizontalLine) ||
                other.highlightPointsHorizontalLine == highlightPointsHorizontalLine) &&
            (identical(other.centerDataPointBetweenVerticalGrid, centerDataPointBetweenVerticalGrid) ||
                other.centerDataPointBetweenVerticalGrid == centerDataPointBetweenVerticalGrid) &&
            (identical(other.canvasBackgroundColor, canvasBackgroundColor) ||
                other.canvasBackgroundColor == canvasBackgroundColor) &&
            (identical(other.hightlightColumnColor, hightlightColumnColor) ||
                other.hightlightColumnColor == hightlightColumnColor) &&
            (identical(other.canvasBackgroundPaintingStyle, canvasBackgroundPaintingStyle) ||
                other.canvasBackgroundPaintingStyle == canvasBackgroundPaintingStyle) &&
            (identical(other.scrollable, scrollable) || other.scrollable == scrollable) &&
            (identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      curvedLine,
      crosshair,
      showGridHorizontal,
      showGridVertical,
      showDataPath,
      highlightMouseColumn,
      highlightPoints,
      addYAxisValueBuffer,
      highlightPointsVerticalLine,
      highlightPointsHorizontalLine,
      centerDataPointBetweenVerticalGrid,
      canvasBackgroundColor,
      hightlightColumnColor,
      canvasBackgroundPaintingStyle,
      scrollable,
      canvasWidth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartConfigImplCopyWith<_$ChartConfigImpl> get copyWith =>
      __$$ChartConfigImplCopyWithImpl<_$ChartConfigImpl>(this, _$identity);
}

abstract class _ChartConfig implements ChartConfig {
  const factory _ChartConfig(
      {final bool curvedLine,
      final bool crosshair,
      final bool showGridHorizontal,
      final bool showGridVertical,
      final bool showDataPath,
      final bool highlightMouseColumn,
      final bool highlightPoints,
      final bool addYAxisValueBuffer,
      final bool highlightPointsVerticalLine,
      final bool highlightPointsHorizontalLine,
      final bool centerDataPointBetweenVerticalGrid,
      final Color? canvasBackgroundColor,
      final Color? hightlightColumnColor,
      final PaintingStyle canvasBackgroundPaintingStyle,
      final bool scrollable,
      final double? canvasWidth}) = _$ChartConfigImpl;

  @override

  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  bool get curvedLine;
  @override

  /// Soll ein Fadenkreuz angezeigt werden?
  bool get crosshair;
  @override // if true, grid horizontal lines are painted
  bool get showGridHorizontal;
  @override // if true, grid vertical lines are painted
  bool get showGridVertical;
  @override // Soll der path auf der Kurve angezeigt werden?
  bool get showDataPath;
  @override // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  bool get highlightMouseColumn;
  @override // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  bool get highlightPoints;
  @override // Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
  bool get addYAxisValueBuffer;
  @override // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  bool get highlightPointsVerticalLine;
  @override // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  bool get highlightPointsHorizontalLine;
  @override

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  bool get centerDataPointBetweenVerticalGrid;
  @override

  /// TODO move to theme
  Color? get canvasBackgroundColor;
  @override

  /// TODO move to theme
  Color? get hightlightColumnColor;
  @override

  /// Experimental - Background painting style
  PaintingStyle get canvasBackgroundPaintingStyle;
  @override

  /// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
  bool get scrollable;
  @override

  /// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
  /// will be scrollable/draggable
  double? get canvasWidth;
  @override
  @JsonKey(ignore: true)
  _$$ChartConfigImplCopyWith<_$ChartConfigImpl> get copyWith => throw _privateConstructorUsedError;
}
