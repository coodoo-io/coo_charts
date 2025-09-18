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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChartConfig {
  /// The color schema for the whole chart. If not set the default color schema will be used
  CooChartTheme? get theme => throw _privateConstructorUsedError;

  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  bool get curvedLine => throw _privateConstructorUsedError;

  /// Soll ein Fadenkreuz angezeigt werden?
  bool get crosshair => throw _privateConstructorUsedError;

  /// Paint the outer chart border?
  bool get showChartBorder => throw _privateConstructorUsedError; // if true, grid horizontal lines are painted
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

  /// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
  List<ChartBackgroundTimeRange> get backgroundTimeRanges => throw _privateConstructorUsedError;

  /// Experimental - Background painting style
  PaintingStyle get canvasBackgroundPaintingStyle => throw _privateConstructorUsedError;

  /// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
  bool get scrollable => throw _privateConstructorUsedError;

  /// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
  /// will be scrollable/draggable
  double? get canvasWidth => throw _privateConstructorUsedError;

  /// Create a copy of ChartConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartConfigCopyWith<ChartConfig> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartConfigCopyWith<$Res> {
  factory $ChartConfigCopyWith(ChartConfig value, $Res Function(ChartConfig) then) =
      _$ChartConfigCopyWithImpl<$Res, ChartConfig>;
  @useResult
  $Res call(
      {CooChartTheme? theme,
      bool curvedLine,
      bool crosshair,
      bool showChartBorder,
      bool showGridHorizontal,
      bool showGridVertical,
      bool showDataPath,
      bool highlightMouseColumn,
      bool highlightPoints,
      bool addYAxisValueBuffer,
      bool highlightPointsVerticalLine,
      bool highlightPointsHorizontalLine,
      bool centerDataPointBetweenVerticalGrid,
      List<ChartBackgroundTimeRange> backgroundTimeRanges,
      PaintingStyle canvasBackgroundPaintingStyle,
      bool scrollable,
      double? canvasWidth});

  $CooChartThemeCopyWith<$Res>? get theme;
}

/// @nodoc
class _$ChartConfigCopyWithImpl<$Res, $Val extends ChartConfig> implements $ChartConfigCopyWith<$Res> {
  _$ChartConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = freezed,
    Object? curvedLine = null,
    Object? crosshair = null,
    Object? showChartBorder = null,
    Object? showGridHorizontal = null,
    Object? showGridVertical = null,
    Object? showDataPath = null,
    Object? highlightMouseColumn = null,
    Object? highlightPoints = null,
    Object? addYAxisValueBuffer = null,
    Object? highlightPointsVerticalLine = null,
    Object? highlightPointsHorizontalLine = null,
    Object? centerDataPointBetweenVerticalGrid = null,
    Object? backgroundTimeRanges = null,
    Object? canvasBackgroundPaintingStyle = null,
    Object? scrollable = null,
    Object? canvasWidth = freezed,
  }) {
    return _then(_value.copyWith(
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as CooChartTheme?,
      curvedLine: null == curvedLine
          ? _value.curvedLine
          : curvedLine // ignore: cast_nullable_to_non_nullable
              as bool,
      crosshair: null == crosshair
          ? _value.crosshair
          : crosshair // ignore: cast_nullable_to_non_nullable
              as bool,
      showChartBorder: null == showChartBorder
          ? _value.showChartBorder
          : showChartBorder // ignore: cast_nullable_to_non_nullable
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
      backgroundTimeRanges: null == backgroundTimeRanges
          ? _value.backgroundTimeRanges
          : backgroundTimeRanges // ignore: cast_nullable_to_non_nullable
              as List<ChartBackgroundTimeRange>,
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

  /// Create a copy of ChartConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CooChartThemeCopyWith<$Res>? get theme {
    if (_value.theme == null) {
      return null;
    }

    return $CooChartThemeCopyWith<$Res>(_value.theme!, (value) {
      return _then(_value.copyWith(theme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChartConfigImplCopyWith<$Res> implements $ChartConfigCopyWith<$Res> {
  factory _$$ChartConfigImplCopyWith(_$ChartConfigImpl value, $Res Function(_$ChartConfigImpl) then) =
      __$$ChartConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CooChartTheme? theme,
      bool curvedLine,
      bool crosshair,
      bool showChartBorder,
      bool showGridHorizontal,
      bool showGridVertical,
      bool showDataPath,
      bool highlightMouseColumn,
      bool highlightPoints,
      bool addYAxisValueBuffer,
      bool highlightPointsVerticalLine,
      bool highlightPointsHorizontalLine,
      bool centerDataPointBetweenVerticalGrid,
      List<ChartBackgroundTimeRange> backgroundTimeRanges,
      PaintingStyle canvasBackgroundPaintingStyle,
      bool scrollable,
      double? canvasWidth});

  @override
  $CooChartThemeCopyWith<$Res>? get theme;
}

/// @nodoc
class __$$ChartConfigImplCopyWithImpl<$Res> extends _$ChartConfigCopyWithImpl<$Res, _$ChartConfigImpl>
    implements _$$ChartConfigImplCopyWith<$Res> {
  __$$ChartConfigImplCopyWithImpl(_$ChartConfigImpl _value, $Res Function(_$ChartConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = freezed,
    Object? curvedLine = null,
    Object? crosshair = null,
    Object? showChartBorder = null,
    Object? showGridHorizontal = null,
    Object? showGridVertical = null,
    Object? showDataPath = null,
    Object? highlightMouseColumn = null,
    Object? highlightPoints = null,
    Object? addYAxisValueBuffer = null,
    Object? highlightPointsVerticalLine = null,
    Object? highlightPointsHorizontalLine = null,
    Object? centerDataPointBetweenVerticalGrid = null,
    Object? backgroundTimeRanges = null,
    Object? canvasBackgroundPaintingStyle = null,
    Object? scrollable = null,
    Object? canvasWidth = freezed,
  }) {
    return _then(_$ChartConfigImpl(
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as CooChartTheme?,
      curvedLine: null == curvedLine
          ? _value.curvedLine
          : curvedLine // ignore: cast_nullable_to_non_nullable
              as bool,
      crosshair: null == crosshair
          ? _value.crosshair
          : crosshair // ignore: cast_nullable_to_non_nullable
              as bool,
      showChartBorder: null == showChartBorder
          ? _value.showChartBorder
          : showChartBorder // ignore: cast_nullable_to_non_nullable
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
      backgroundTimeRanges: null == backgroundTimeRanges
          ? _value._backgroundTimeRanges
          : backgroundTimeRanges // ignore: cast_nullable_to_non_nullable
              as List<ChartBackgroundTimeRange>,
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
      {this.theme,
      this.curvedLine = false,
      this.crosshair = false,
      this.showChartBorder = true,
      this.showGridHorizontal = true,
      this.showGridVertical = true,
      this.showDataPath = true,
      this.highlightMouseColumn = true,
      this.highlightPoints = false,
      this.addYAxisValueBuffer = true,
      this.highlightPointsVerticalLine = false,
      this.highlightPointsHorizontalLine = false,
      this.centerDataPointBetweenVerticalGrid = true,
      final List<ChartBackgroundTimeRange> backgroundTimeRanges = const [],
      this.canvasBackgroundPaintingStyle = PaintingStyle.fill,
      this.scrollable = false,
      this.canvasWidth})
      : _backgroundTimeRanges = backgroundTimeRanges;

  /// The color schema for the whole chart. If not set the default color schema will be used
  @override
  final CooChartTheme? theme;

  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  @override
  @JsonKey()
  final bool curvedLine;

  /// Soll ein Fadenkreuz angezeigt werden?
  @override
  @JsonKey()
  final bool crosshair;

  /// Paint the outer chart border?
  @override
  @JsonKey()
  final bool showChartBorder;
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

  /// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
  final List<ChartBackgroundTimeRange> _backgroundTimeRanges;

  /// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
  @override
  @JsonKey()
  List<ChartBackgroundTimeRange> get backgroundTimeRanges {
    if (_backgroundTimeRanges is EqualUnmodifiableListView) return _backgroundTimeRanges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backgroundTimeRanges);
  }

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
    return 'ChartConfig(theme: $theme, curvedLine: $curvedLine, crosshair: $crosshair, showChartBorder: $showChartBorder, showGridHorizontal: $showGridHorizontal, showGridVertical: $showGridVertical, showDataPath: $showDataPath, highlightMouseColumn: $highlightMouseColumn, highlightPoints: $highlightPoints, addYAxisValueBuffer: $addYAxisValueBuffer, highlightPointsVerticalLine: $highlightPointsVerticalLine, highlightPointsHorizontalLine: $highlightPointsHorizontalLine, centerDataPointBetweenVerticalGrid: $centerDataPointBetweenVerticalGrid, backgroundTimeRanges: $backgroundTimeRanges, canvasBackgroundPaintingStyle: $canvasBackgroundPaintingStyle, scrollable: $scrollable, canvasWidth: $canvasWidth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartConfigImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.curvedLine, curvedLine) || other.curvedLine == curvedLine) &&
            (identical(other.crosshair, crosshair) || other.crosshair == crosshair) &&
            (identical(other.showChartBorder, showChartBorder) || other.showChartBorder == showChartBorder) &&
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
            const DeepCollectionEquality().equals(other._backgroundTimeRanges, _backgroundTimeRanges) &&
            (identical(other.canvasBackgroundPaintingStyle, canvasBackgroundPaintingStyle) ||
                other.canvasBackgroundPaintingStyle == canvasBackgroundPaintingStyle) &&
            (identical(other.scrollable, scrollable) || other.scrollable == scrollable) &&
            (identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      theme,
      curvedLine,
      crosshair,
      showChartBorder,
      showGridHorizontal,
      showGridVertical,
      showDataPath,
      highlightMouseColumn,
      highlightPoints,
      addYAxisValueBuffer,
      highlightPointsVerticalLine,
      highlightPointsHorizontalLine,
      centerDataPointBetweenVerticalGrid,
      const DeepCollectionEquality().hash(_backgroundTimeRanges),
      canvasBackgroundPaintingStyle,
      scrollable,
      canvasWidth);

  /// Create a copy of ChartConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartConfigImplCopyWith<_$ChartConfigImpl> get copyWith =>
      __$$ChartConfigImplCopyWithImpl<_$ChartConfigImpl>(this, _$identity);
}

abstract class _ChartConfig implements ChartConfig {
  const factory _ChartConfig(
      {final CooChartTheme? theme,
      final bool curvedLine,
      final bool crosshair,
      final bool showChartBorder,
      final bool showGridHorizontal,
      final bool showGridVertical,
      final bool showDataPath,
      final bool highlightMouseColumn,
      final bool highlightPoints,
      final bool addYAxisValueBuffer,
      final bool highlightPointsVerticalLine,
      final bool highlightPointsHorizontalLine,
      final bool centerDataPointBetweenVerticalGrid,
      final List<ChartBackgroundTimeRange> backgroundTimeRanges,
      final PaintingStyle canvasBackgroundPaintingStyle,
      final bool scrollable,
      final double? canvasWidth}) = _$ChartConfigImpl;

  /// The color schema for the whole chart. If not set the default color schema will be used
  @override
  CooChartTheme? get theme;

  /// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
  @override
  bool get curvedLine;

  /// Soll ein Fadenkreuz angezeigt werden?
  @override
  bool get crosshair;

  /// Paint the outer chart border?
  @override
  bool get showChartBorder; // if true, grid horizontal lines are painted
  @override
  bool get showGridHorizontal; // if true, grid vertical lines are painted
  @override
  bool get showGridVertical; // Soll der path auf der Kurve angezeigt werden?
  @override
  bool get showDataPath; // Hinterlegt die Spalte hinter dem Punkt mit einer Highlightfarbe
  @override
  bool get highlightMouseColumn; // Ändert den Punkt wenn mit der Maus über die Spalte gefahren wird
  @override
  bool get highlightPoints; // Fügt einen Puffer auf der Y-Achse vor dem Min-Wert und nach dem Max-Wert hinzu
  @override
  bool get addYAxisValueBuffer; // Zeichnet eine vertikale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  @override
  bool
      get highlightPointsVerticalLine; // Zeichnet eine horizontale Line über den Datenpunkt wenn die Maus in der Nähe ist.
  @override
  bool get highlightPointsHorizontalLine;

  /// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
  @override
  bool get centerDataPointBetweenVerticalGrid;

  /// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
  @override
  List<ChartBackgroundTimeRange> get backgroundTimeRanges;

  /// Experimental - Background painting style
  @override
  PaintingStyle get canvasBackgroundPaintingStyle;

  /// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
  @override
  bool get scrollable;

  /// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
  /// will be scrollable/draggable
  @override
  double? get canvasWidth;

  /// Create a copy of ChartConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartConfigImplCopyWith<_$ChartConfigImpl> get copyWith => throw _privateConstructorUsedError;
}
