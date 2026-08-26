// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartConfig {

/// The color schema for the whole chart. If not set the default color schema will be used
 CooChartTheme? get theme;/// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
 bool get curvedLine;/// Soll ein Fadenkreuz angezeigt werden?
 bool get crosshair;/// Paint the outer chart border?
 bool get showChartBorder; bool get showGridHorizontal; bool get showGridVertical; bool get showDataPath; bool get highlightMouseColumn; bool get highlightPoints; bool get addYAxisValueBuffer; bool get highlightPointsVerticalLine; bool get highlightPointsHorizontalLine;/// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
 bool get centerDataPointBetweenVerticalGrid;/// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
 List<ChartBackgroundTimeRange> get backgroundTimeRanges;/// Experimental - Background painting style
 PaintingStyle get canvasBackgroundPaintingStyle;/// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
 bool get scrollable;/// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
/// will be scrollable/draggable
 double? get canvasWidth;
/// Create a copy of ChartConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartConfigCopyWith<ChartConfig> get copyWith => _$ChartConfigCopyWithImpl<ChartConfig>(this as ChartConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartConfig&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.curvedLine, curvedLine) || other.curvedLine == curvedLine)&&(identical(other.crosshair, crosshair) || other.crosshair == crosshair)&&(identical(other.showChartBorder, showChartBorder) || other.showChartBorder == showChartBorder)&&(identical(other.showGridHorizontal, showGridHorizontal) || other.showGridHorizontal == showGridHorizontal)&&(identical(other.showGridVertical, showGridVertical) || other.showGridVertical == showGridVertical)&&(identical(other.showDataPath, showDataPath) || other.showDataPath == showDataPath)&&(identical(other.highlightMouseColumn, highlightMouseColumn) || other.highlightMouseColumn == highlightMouseColumn)&&(identical(other.highlightPoints, highlightPoints) || other.highlightPoints == highlightPoints)&&(identical(other.addYAxisValueBuffer, addYAxisValueBuffer) || other.addYAxisValueBuffer == addYAxisValueBuffer)&&(identical(other.highlightPointsVerticalLine, highlightPointsVerticalLine) || other.highlightPointsVerticalLine == highlightPointsVerticalLine)&&(identical(other.highlightPointsHorizontalLine, highlightPointsHorizontalLine) || other.highlightPointsHorizontalLine == highlightPointsHorizontalLine)&&(identical(other.centerDataPointBetweenVerticalGrid, centerDataPointBetweenVerticalGrid) || other.centerDataPointBetweenVerticalGrid == centerDataPointBetweenVerticalGrid)&&const DeepCollectionEquality().equals(other.backgroundTimeRanges, backgroundTimeRanges)&&(identical(other.canvasBackgroundPaintingStyle, canvasBackgroundPaintingStyle) || other.canvasBackgroundPaintingStyle == canvasBackgroundPaintingStyle)&&(identical(other.scrollable, scrollable) || other.scrollable == scrollable)&&(identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth));
}


@override
int get hashCode => Object.hash(runtimeType,theme,curvedLine,crosshair,showChartBorder,showGridHorizontal,showGridVertical,showDataPath,highlightMouseColumn,highlightPoints,addYAxisValueBuffer,highlightPointsVerticalLine,highlightPointsHorizontalLine,centerDataPointBetweenVerticalGrid,const DeepCollectionEquality().hash(backgroundTimeRanges),canvasBackgroundPaintingStyle,scrollable,canvasWidth);

@override
String toString() {
  return 'ChartConfig(theme: $theme, curvedLine: $curvedLine, crosshair: $crosshair, showChartBorder: $showChartBorder, showGridHorizontal: $showGridHorizontal, showGridVertical: $showGridVertical, showDataPath: $showDataPath, highlightMouseColumn: $highlightMouseColumn, highlightPoints: $highlightPoints, addYAxisValueBuffer: $addYAxisValueBuffer, highlightPointsVerticalLine: $highlightPointsVerticalLine, highlightPointsHorizontalLine: $highlightPointsHorizontalLine, centerDataPointBetweenVerticalGrid: $centerDataPointBetweenVerticalGrid, backgroundTimeRanges: $backgroundTimeRanges, canvasBackgroundPaintingStyle: $canvasBackgroundPaintingStyle, scrollable: $scrollable, canvasWidth: $canvasWidth)';
}


}

/// @nodoc
abstract mixin class $ChartConfigCopyWith<$Res>  {
  factory $ChartConfigCopyWith(ChartConfig value, $Res Function(ChartConfig) _then) = _$ChartConfigCopyWithImpl;
@useResult
$Res call({
 CooChartTheme? theme, bool curvedLine, bool crosshair, bool showChartBorder, bool showGridHorizontal, bool showGridVertical, bool showDataPath, bool highlightMouseColumn, bool highlightPoints, bool addYAxisValueBuffer, bool highlightPointsVerticalLine, bool highlightPointsHorizontalLine, bool centerDataPointBetweenVerticalGrid, List<ChartBackgroundTimeRange> backgroundTimeRanges, PaintingStyle canvasBackgroundPaintingStyle, bool scrollable, double? canvasWidth
});


$CooChartThemeCopyWith<$Res>? get theme;

}
/// @nodoc
class _$ChartConfigCopyWithImpl<$Res>
    implements $ChartConfigCopyWith<$Res> {
  _$ChartConfigCopyWithImpl(this._self, this._then);

  final ChartConfig _self;
  final $Res Function(ChartConfig) _then;

/// Create a copy of ChartConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = freezed,Object? curvedLine = null,Object? crosshair = null,Object? showChartBorder = null,Object? showGridHorizontal = null,Object? showGridVertical = null,Object? showDataPath = null,Object? highlightMouseColumn = null,Object? highlightPoints = null,Object? addYAxisValueBuffer = null,Object? highlightPointsVerticalLine = null,Object? highlightPointsHorizontalLine = null,Object? centerDataPointBetweenVerticalGrid = null,Object? backgroundTimeRanges = null,Object? canvasBackgroundPaintingStyle = null,Object? scrollable = null,Object? canvasWidth = freezed,}) {
  return _then(ChartConfig(
theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as CooChartTheme?,curvedLine: null == curvedLine ? _self.curvedLine : curvedLine // ignore: cast_nullable_to_non_nullable
as bool,crosshair: null == crosshair ? _self.crosshair : crosshair // ignore: cast_nullable_to_non_nullable
as bool,showChartBorder: null == showChartBorder ? _self.showChartBorder : showChartBorder // ignore: cast_nullable_to_non_nullable
as bool,showGridHorizontal: null == showGridHorizontal ? _self.showGridHorizontal : showGridHorizontal // ignore: cast_nullable_to_non_nullable
as bool,showGridVertical: null == showGridVertical ? _self.showGridVertical : showGridVertical // ignore: cast_nullable_to_non_nullable
as bool,showDataPath: null == showDataPath ? _self.showDataPath : showDataPath // ignore: cast_nullable_to_non_nullable
as bool,highlightMouseColumn: null == highlightMouseColumn ? _self.highlightMouseColumn : highlightMouseColumn // ignore: cast_nullable_to_non_nullable
as bool,highlightPoints: null == highlightPoints ? _self.highlightPoints : highlightPoints // ignore: cast_nullable_to_non_nullable
as bool,addYAxisValueBuffer: null == addYAxisValueBuffer ? _self.addYAxisValueBuffer : addYAxisValueBuffer // ignore: cast_nullable_to_non_nullable
as bool,highlightPointsVerticalLine: null == highlightPointsVerticalLine ? _self.highlightPointsVerticalLine : highlightPointsVerticalLine // ignore: cast_nullable_to_non_nullable
as bool,highlightPointsHorizontalLine: null == highlightPointsHorizontalLine ? _self.highlightPointsHorizontalLine : highlightPointsHorizontalLine // ignore: cast_nullable_to_non_nullable
as bool,centerDataPointBetweenVerticalGrid: null == centerDataPointBetweenVerticalGrid ? _self.centerDataPointBetweenVerticalGrid : centerDataPointBetweenVerticalGrid // ignore: cast_nullable_to_non_nullable
as bool,backgroundTimeRanges: null == backgroundTimeRanges ? _self.backgroundTimeRanges : backgroundTimeRanges // ignore: cast_nullable_to_non_nullable
as List<ChartBackgroundTimeRange>,canvasBackgroundPaintingStyle: null == canvasBackgroundPaintingStyle ? _self.canvasBackgroundPaintingStyle : canvasBackgroundPaintingStyle // ignore: cast_nullable_to_non_nullable
as PaintingStyle,scrollable: null == scrollable ? _self.scrollable : scrollable // ignore: cast_nullable_to_non_nullable
as bool,canvasWidth: freezed == canvasWidth ? _self.canvasWidth : canvasWidth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of ChartConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CooChartThemeCopyWith<$Res>? get theme {
    if (_self.theme == null) {
    return null;
  }

  return $CooChartThemeCopyWith<$Res>(_self.theme!, (value) {
    return _then(_self.copyWith(theme: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChartConfig].
extension ChartConfigPatterns on ChartConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChartConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChartConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChartConfig value)  $default,){
final _that = this;
switch (_that) {
case _ChartConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChartConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ChartConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CooChartTheme? theme,  bool curvedLine,  bool crosshair,  bool showChartBorder,  bool showGridHorizontal,  bool showGridVertical,  bool showDataPath,  bool highlightMouseColumn,  bool highlightPoints,  bool addYAxisValueBuffer,  bool highlightPointsVerticalLine,  bool highlightPointsHorizontalLine,  bool centerDataPointBetweenVerticalGrid,  List<ChartBackgroundTimeRange> backgroundTimeRanges,  PaintingStyle canvasBackgroundPaintingStyle,  bool scrollable,  double? canvasWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChartConfig() when $default != null:
return $default(_that.theme,_that.curvedLine,_that.crosshair,_that.showChartBorder,_that.showGridHorizontal,_that.showGridVertical,_that.showDataPath,_that.highlightMouseColumn,_that.highlightPoints,_that.addYAxisValueBuffer,_that.highlightPointsVerticalLine,_that.highlightPointsHorizontalLine,_that.centerDataPointBetweenVerticalGrid,_that.backgroundTimeRanges,_that.canvasBackgroundPaintingStyle,_that.scrollable,_that.canvasWidth);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CooChartTheme? theme,  bool curvedLine,  bool crosshair,  bool showChartBorder,  bool showGridHorizontal,  bool showGridVertical,  bool showDataPath,  bool highlightMouseColumn,  bool highlightPoints,  bool addYAxisValueBuffer,  bool highlightPointsVerticalLine,  bool highlightPointsHorizontalLine,  bool centerDataPointBetweenVerticalGrid,  List<ChartBackgroundTimeRange> backgroundTimeRanges,  PaintingStyle canvasBackgroundPaintingStyle,  bool scrollable,  double? canvasWidth)  $default,) {final _that = this;
switch (_that) {
case _ChartConfig():
return $default(_that.theme,_that.curvedLine,_that.crosshair,_that.showChartBorder,_that.showGridHorizontal,_that.showGridVertical,_that.showDataPath,_that.highlightMouseColumn,_that.highlightPoints,_that.addYAxisValueBuffer,_that.highlightPointsVerticalLine,_that.highlightPointsHorizontalLine,_that.centerDataPointBetweenVerticalGrid,_that.backgroundTimeRanges,_that.canvasBackgroundPaintingStyle,_that.scrollable,_that.canvasWidth);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CooChartTheme? theme,  bool curvedLine,  bool crosshair,  bool showChartBorder,  bool showGridHorizontal,  bool showGridVertical,  bool showDataPath,  bool highlightMouseColumn,  bool highlightPoints,  bool addYAxisValueBuffer,  bool highlightPointsVerticalLine,  bool highlightPointsHorizontalLine,  bool centerDataPointBetweenVerticalGrid,  List<ChartBackgroundTimeRange> backgroundTimeRanges,  PaintingStyle canvasBackgroundPaintingStyle,  bool scrollable,  double? canvasWidth)?  $default,) {final _that = this;
switch (_that) {
case _ChartConfig() when $default != null:
return $default(_that.theme,_that.curvedLine,_that.crosshair,_that.showChartBorder,_that.showGridHorizontal,_that.showGridVertical,_that.showDataPath,_that.highlightMouseColumn,_that.highlightPoints,_that.addYAxisValueBuffer,_that.highlightPointsVerticalLine,_that.highlightPointsHorizontalLine,_that.centerDataPointBetweenVerticalGrid,_that.backgroundTimeRanges,_that.canvasBackgroundPaintingStyle,_that.scrollable,_that.canvasWidth);case _:
  return null;

}
}

}

/// @nodoc


class _ChartConfig implements ChartConfig {
  const _ChartConfig({this.theme, this.curvedLine = false, this.crosshair = false, this.showChartBorder = true, this.showGridHorizontal = true, this.showGridVertical = true, this.showDataPath = true, this.highlightMouseColumn = true, this.highlightPoints = false, this.addYAxisValueBuffer = true, this.highlightPointsVerticalLine = false, this.highlightPointsHorizontalLine = false, this.centerDataPointBetweenVerticalGrid = true,  List<ChartBackgroundTimeRange> backgroundTimeRanges = const [], this.canvasBackgroundPaintingStyle = PaintingStyle.fill, this.scrollable = false, this.canvasWidth}): _backgroundTimeRanges = backgroundTimeRanges;
  

/// The color schema for the whole chart. If not set the default color schema will be used
@override final  CooChartTheme? theme;
/// Soll der Linechart weich gebogen (true) oder kantik (false) verlaufen?
@override@JsonKey() final  bool curvedLine;
/// Soll ein Fadenkreuz angezeigt werden?
@override@JsonKey() final  bool crosshair;
/// Paint the outer chart border?
@override@JsonKey() final  bool showChartBorder;
@override@JsonKey() final  bool showGridHorizontal;
@override@JsonKey() final  bool showGridVertical;
@override@JsonKey() final  bool showDataPath;
@override@JsonKey() final  bool highlightMouseColumn;
@override@JsonKey() final  bool highlightPoints;
@override@JsonKey() final  bool addYAxisValueBuffer;
@override@JsonKey() final  bool highlightPointsVerticalLine;
@override@JsonKey() final  bool highlightPointsHorizontalLine;
/// Zentriert den Datenpunkte in der Mitte des vertikalen Grids (shift nach rechts der Datenpunkte - beginnt nicht bei 0)
@override@JsonKey() final  bool centerDataPointBetweenVerticalGrid;
/// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
 final  List<ChartBackgroundTimeRange> _backgroundTimeRanges;
/// Liste von Hintergrund-Zeiträumen, die im Chart hervorgehoben werden sollen
@override@JsonKey() List<ChartBackgroundTimeRange> get backgroundTimeRanges {
  if (_backgroundTimeRanges is EqualUnmodifiableListView) return _backgroundTimeRanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgroundTimeRanges);
}

/// Experimental - Background painting style
@override@JsonKey() final  PaintingStyle canvasBackgroundPaintingStyle;
/// Is the canvas scrollable? if true a canvasWidth can be given and the axis are fix.
@override@JsonKey() final  bool scrollable;
/// Width of the canvas. if scrollable is true or the width is greater than the available space the chart
/// will be scrollable/draggable
@override final  double? canvasWidth;

/// Create a copy of ChartConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartConfigCopyWith<_ChartConfig> get copyWith => __$ChartConfigCopyWithImpl<_ChartConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartConfig&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.curvedLine, curvedLine) || other.curvedLine == curvedLine)&&(identical(other.crosshair, crosshair) || other.crosshair == crosshair)&&(identical(other.showChartBorder, showChartBorder) || other.showChartBorder == showChartBorder)&&(identical(other.showGridHorizontal, showGridHorizontal) || other.showGridHorizontal == showGridHorizontal)&&(identical(other.showGridVertical, showGridVertical) || other.showGridVertical == showGridVertical)&&(identical(other.showDataPath, showDataPath) || other.showDataPath == showDataPath)&&(identical(other.highlightMouseColumn, highlightMouseColumn) || other.highlightMouseColumn == highlightMouseColumn)&&(identical(other.highlightPoints, highlightPoints) || other.highlightPoints == highlightPoints)&&(identical(other.addYAxisValueBuffer, addYAxisValueBuffer) || other.addYAxisValueBuffer == addYAxisValueBuffer)&&(identical(other.highlightPointsVerticalLine, highlightPointsVerticalLine) || other.highlightPointsVerticalLine == highlightPointsVerticalLine)&&(identical(other.highlightPointsHorizontalLine, highlightPointsHorizontalLine) || other.highlightPointsHorizontalLine == highlightPointsHorizontalLine)&&(identical(other.centerDataPointBetweenVerticalGrid, centerDataPointBetweenVerticalGrid) || other.centerDataPointBetweenVerticalGrid == centerDataPointBetweenVerticalGrid)&&const DeepCollectionEquality().equals(other._backgroundTimeRanges, _backgroundTimeRanges)&&(identical(other.canvasBackgroundPaintingStyle, canvasBackgroundPaintingStyle) || other.canvasBackgroundPaintingStyle == canvasBackgroundPaintingStyle)&&(identical(other.scrollable, scrollable) || other.scrollable == scrollable)&&(identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth));
}


@override
int get hashCode => Object.hash(runtimeType,theme,curvedLine,crosshair,showChartBorder,showGridHorizontal,showGridVertical,showDataPath,highlightMouseColumn,highlightPoints,addYAxisValueBuffer,highlightPointsVerticalLine,highlightPointsHorizontalLine,centerDataPointBetweenVerticalGrid,const DeepCollectionEquality().hash(_backgroundTimeRanges),canvasBackgroundPaintingStyle,scrollable,canvasWidth);

@override
String toString() {
  return 'ChartConfig(theme: $theme, curvedLine: $curvedLine, crosshair: $crosshair, showChartBorder: $showChartBorder, showGridHorizontal: $showGridHorizontal, showGridVertical: $showGridVertical, showDataPath: $showDataPath, highlightMouseColumn: $highlightMouseColumn, highlightPoints: $highlightPoints, addYAxisValueBuffer: $addYAxisValueBuffer, highlightPointsVerticalLine: $highlightPointsVerticalLine, highlightPointsHorizontalLine: $highlightPointsHorizontalLine, centerDataPointBetweenVerticalGrid: $centerDataPointBetweenVerticalGrid, backgroundTimeRanges: $backgroundTimeRanges, canvasBackgroundPaintingStyle: $canvasBackgroundPaintingStyle, scrollable: $scrollable, canvasWidth: $canvasWidth)';
}


}

/// @nodoc
abstract mixin class _$ChartConfigCopyWith<$Res> implements $ChartConfigCopyWith<$Res> {
  factory _$ChartConfigCopyWith(_ChartConfig value, $Res Function(_ChartConfig) _then) = __$ChartConfigCopyWithImpl;
@override @useResult
$Res call({
 CooChartTheme? theme, bool curvedLine, bool crosshair, bool showChartBorder, bool showGridHorizontal, bool showGridVertical, bool showDataPath, bool highlightMouseColumn, bool highlightPoints, bool addYAxisValueBuffer, bool highlightPointsVerticalLine, bool highlightPointsHorizontalLine, bool centerDataPointBetweenVerticalGrid, List<ChartBackgroundTimeRange> backgroundTimeRanges, PaintingStyle canvasBackgroundPaintingStyle, bool scrollable, double? canvasWidth
});


@override $CooChartThemeCopyWith<$Res>? get theme;

}
/// @nodoc
class __$ChartConfigCopyWithImpl<$Res>
    implements _$ChartConfigCopyWith<$Res> {
  __$ChartConfigCopyWithImpl(this._self, this._then);

  final _ChartConfig _self;
  final $Res Function(_ChartConfig) _then;

/// Create a copy of ChartConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = freezed,Object? curvedLine = null,Object? crosshair = null,Object? showChartBorder = null,Object? showGridHorizontal = null,Object? showGridVertical = null,Object? showDataPath = null,Object? highlightMouseColumn = null,Object? highlightPoints = null,Object? addYAxisValueBuffer = null,Object? highlightPointsVerticalLine = null,Object? highlightPointsHorizontalLine = null,Object? centerDataPointBetweenVerticalGrid = null,Object? backgroundTimeRanges = null,Object? canvasBackgroundPaintingStyle = null,Object? scrollable = null,Object? canvasWidth = freezed,}) {
  return _then(_ChartConfig(
theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as CooChartTheme?,curvedLine: null == curvedLine ? _self.curvedLine : curvedLine // ignore: cast_nullable_to_non_nullable
as bool,crosshair: null == crosshair ? _self.crosshair : crosshair // ignore: cast_nullable_to_non_nullable
as bool,showChartBorder: null == showChartBorder ? _self.showChartBorder : showChartBorder // ignore: cast_nullable_to_non_nullable
as bool,showGridHorizontal: null == showGridHorizontal ? _self.showGridHorizontal : showGridHorizontal // ignore: cast_nullable_to_non_nullable
as bool,showGridVertical: null == showGridVertical ? _self.showGridVertical : showGridVertical // ignore: cast_nullable_to_non_nullable
as bool,showDataPath: null == showDataPath ? _self.showDataPath : showDataPath // ignore: cast_nullable_to_non_nullable
as bool,highlightMouseColumn: null == highlightMouseColumn ? _self.highlightMouseColumn : highlightMouseColumn // ignore: cast_nullable_to_non_nullable
as bool,highlightPoints: null == highlightPoints ? _self.highlightPoints : highlightPoints // ignore: cast_nullable_to_non_nullable
as bool,addYAxisValueBuffer: null == addYAxisValueBuffer ? _self.addYAxisValueBuffer : addYAxisValueBuffer // ignore: cast_nullable_to_non_nullable
as bool,highlightPointsVerticalLine: null == highlightPointsVerticalLine ? _self.highlightPointsVerticalLine : highlightPointsVerticalLine // ignore: cast_nullable_to_non_nullable
as bool,highlightPointsHorizontalLine: null == highlightPointsHorizontalLine ? _self.highlightPointsHorizontalLine : highlightPointsHorizontalLine // ignore: cast_nullable_to_non_nullable
as bool,centerDataPointBetweenVerticalGrid: null == centerDataPointBetweenVerticalGrid ? _self.centerDataPointBetweenVerticalGrid : centerDataPointBetweenVerticalGrid // ignore: cast_nullable_to_non_nullable
as bool,backgroundTimeRanges: null == backgroundTimeRanges ? _self._backgroundTimeRanges : backgroundTimeRanges // ignore: cast_nullable_to_non_nullable
as List<ChartBackgroundTimeRange>,canvasBackgroundPaintingStyle: null == canvasBackgroundPaintingStyle ? _self.canvasBackgroundPaintingStyle : canvasBackgroundPaintingStyle // ignore: cast_nullable_to_non_nullable
as PaintingStyle,scrollable: null == scrollable ? _self.scrollable : scrollable // ignore: cast_nullable_to_non_nullable
as bool,canvasWidth: freezed == canvasWidth ? _self.canvasWidth : canvasWidth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of ChartConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CooChartThemeCopyWith<$Res>? get theme {
    if (_self.theme == null) {
    return null;
  }

  return $CooChartThemeCopyWith<$Res>(_self.theme!, (value) {
    return _then(_self.copyWith(theme: value));
  });
}
}

// dart format on
