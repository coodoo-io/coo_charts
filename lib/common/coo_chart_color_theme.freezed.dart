// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coo_chart_color_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CooChartTheme {

/// The color of the complete chart painter
 Color get backgroundColor;/// If the chart is scrollable the background of the labels can be configured as transparent gradient
/// Default is not transperant.
 bool get labelBackgroundTransparentGradient;/// The color of the outer chart canvas background
 Color get chartBackgroundColor;/// The color of the outer border lines
 Color get chartBorderColor;/// y- and x-axis label color
 Color get labelColor;/// y- and x-axis label font size
 double get labelFontSize;/// y- and x-axis label textStyle. If given the label color and font size is not used
 TextStyle? get labelTextStyle;/// The color of the inner grid lines
 Color get gridColor; Color get dataPointColor; Color get dataPointHighlightColor; Color get columnHighlightColor;/// bar chart colors
 Color get barColor; Color get barColorHighlight;/// Min- Max range is available in barchart and linechart. Define the color of this line.
 Color get minMaxRangeColor;
/// Create a copy of CooChartTheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CooChartThemeCopyWith<CooChartTheme> get copyWith => _$CooChartThemeCopyWithImpl<CooChartTheme>(this as CooChartTheme, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CooChartTheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.labelBackgroundTransparentGradient, labelBackgroundTransparentGradient) || other.labelBackgroundTransparentGradient == labelBackgroundTransparentGradient)&&(identical(other.chartBackgroundColor, chartBackgroundColor) || other.chartBackgroundColor == chartBackgroundColor)&&(identical(other.chartBorderColor, chartBorderColor) || other.chartBorderColor == chartBorderColor)&&(identical(other.labelColor, labelColor) || other.labelColor == labelColor)&&(identical(other.labelFontSize, labelFontSize) || other.labelFontSize == labelFontSize)&&(identical(other.labelTextStyle, labelTextStyle) || other.labelTextStyle == labelTextStyle)&&(identical(other.gridColor, gridColor) || other.gridColor == gridColor)&&(identical(other.dataPointColor, dataPointColor) || other.dataPointColor == dataPointColor)&&(identical(other.dataPointHighlightColor, dataPointHighlightColor) || other.dataPointHighlightColor == dataPointHighlightColor)&&(identical(other.columnHighlightColor, columnHighlightColor) || other.columnHighlightColor == columnHighlightColor)&&(identical(other.barColor, barColor) || other.barColor == barColor)&&(identical(other.barColorHighlight, barColorHighlight) || other.barColorHighlight == barColorHighlight)&&(identical(other.minMaxRangeColor, minMaxRangeColor) || other.minMaxRangeColor == minMaxRangeColor));
}


@override
int get hashCode => Object.hash(runtimeType,backgroundColor,labelBackgroundTransparentGradient,chartBackgroundColor,chartBorderColor,labelColor,labelFontSize,labelTextStyle,gridColor,dataPointColor,dataPointHighlightColor,columnHighlightColor,barColor,barColorHighlight,minMaxRangeColor);

@override
String toString() {
  return 'CooChartTheme(backgroundColor: $backgroundColor, labelBackgroundTransparentGradient: $labelBackgroundTransparentGradient, chartBackgroundColor: $chartBackgroundColor, chartBorderColor: $chartBorderColor, labelColor: $labelColor, labelFontSize: $labelFontSize, labelTextStyle: $labelTextStyle, gridColor: $gridColor, dataPointColor: $dataPointColor, dataPointHighlightColor: $dataPointHighlightColor, columnHighlightColor: $columnHighlightColor, barColor: $barColor, barColorHighlight: $barColorHighlight, minMaxRangeColor: $minMaxRangeColor)';
}


}

/// @nodoc
abstract mixin class $CooChartThemeCopyWith<$Res>  {
  factory $CooChartThemeCopyWith(CooChartTheme value, $Res Function(CooChartTheme) _then) = _$CooChartThemeCopyWithImpl;
@useResult
$Res call({
 Color backgroundColor, bool labelBackgroundTransparentGradient, Color chartBackgroundColor, Color chartBorderColor, Color labelColor, double labelFontSize, TextStyle? labelTextStyle, Color gridColor, Color dataPointColor, Color dataPointHighlightColor, Color columnHighlightColor, Color barColor, Color barColorHighlight, Color minMaxRangeColor
});




}
/// @nodoc
class _$CooChartThemeCopyWithImpl<$Res>
    implements $CooChartThemeCopyWith<$Res> {
  _$CooChartThemeCopyWithImpl(this._self, this._then);

  final CooChartTheme _self;
  final $Res Function(CooChartTheme) _then;

/// Create a copy of CooChartTheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = null,Object? labelBackgroundTransparentGradient = null,Object? chartBackgroundColor = null,Object? chartBorderColor = null,Object? labelColor = null,Object? labelFontSize = null,Object? labelTextStyle = freezed,Object? gridColor = null,Object? dataPointColor = null,Object? dataPointHighlightColor = null,Object? columnHighlightColor = null,Object? barColor = null,Object? barColorHighlight = null,Object? minMaxRangeColor = null,}) {
  return _then(CooChartTheme(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,labelBackgroundTransparentGradient: null == labelBackgroundTransparentGradient ? _self.labelBackgroundTransparentGradient : labelBackgroundTransparentGradient // ignore: cast_nullable_to_non_nullable
as bool,chartBackgroundColor: null == chartBackgroundColor ? _self.chartBackgroundColor : chartBackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,chartBorderColor: null == chartBorderColor ? _self.chartBorderColor : chartBorderColor // ignore: cast_nullable_to_non_nullable
as Color,labelColor: null == labelColor ? _self.labelColor : labelColor // ignore: cast_nullable_to_non_nullable
as Color,labelFontSize: null == labelFontSize ? _self.labelFontSize : labelFontSize // ignore: cast_nullable_to_non_nullable
as double,labelTextStyle: freezed == labelTextStyle ? _self.labelTextStyle : labelTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyle?,gridColor: null == gridColor ? _self.gridColor : gridColor // ignore: cast_nullable_to_non_nullable
as Color,dataPointColor: null == dataPointColor ? _self.dataPointColor : dataPointColor // ignore: cast_nullable_to_non_nullable
as Color,dataPointHighlightColor: null == dataPointHighlightColor ? _self.dataPointHighlightColor : dataPointHighlightColor // ignore: cast_nullable_to_non_nullable
as Color,columnHighlightColor: null == columnHighlightColor ? _self.columnHighlightColor : columnHighlightColor // ignore: cast_nullable_to_non_nullable
as Color,barColor: null == barColor ? _self.barColor : barColor // ignore: cast_nullable_to_non_nullable
as Color,barColorHighlight: null == barColorHighlight ? _self.barColorHighlight : barColorHighlight // ignore: cast_nullable_to_non_nullable
as Color,minMaxRangeColor: null == minMaxRangeColor ? _self.minMaxRangeColor : minMaxRangeColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [CooChartTheme].
extension CooChartThemePatterns on CooChartTheme {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CooChartTheme value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CooChartTheme() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CooChartTheme value)  $default,){
final _that = this;
switch (_that) {
case _CooChartTheme():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CooChartTheme value)?  $default,){
final _that = this;
switch (_that) {
case _CooChartTheme() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color backgroundColor,  bool labelBackgroundTransparentGradient,  Color chartBackgroundColor,  Color chartBorderColor,  Color labelColor,  double labelFontSize,  TextStyle? labelTextStyle,  Color gridColor,  Color dataPointColor,  Color dataPointHighlightColor,  Color columnHighlightColor,  Color barColor,  Color barColorHighlight,  Color minMaxRangeColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CooChartTheme() when $default != null:
return $default(_that.backgroundColor,_that.labelBackgroundTransparentGradient,_that.chartBackgroundColor,_that.chartBorderColor,_that.labelColor,_that.labelFontSize,_that.labelTextStyle,_that.gridColor,_that.dataPointColor,_that.dataPointHighlightColor,_that.columnHighlightColor,_that.barColor,_that.barColorHighlight,_that.minMaxRangeColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color backgroundColor,  bool labelBackgroundTransparentGradient,  Color chartBackgroundColor,  Color chartBorderColor,  Color labelColor,  double labelFontSize,  TextStyle? labelTextStyle,  Color gridColor,  Color dataPointColor,  Color dataPointHighlightColor,  Color columnHighlightColor,  Color barColor,  Color barColorHighlight,  Color minMaxRangeColor)  $default,) {final _that = this;
switch (_that) {
case _CooChartTheme():
return $default(_that.backgroundColor,_that.labelBackgroundTransparentGradient,_that.chartBackgroundColor,_that.chartBorderColor,_that.labelColor,_that.labelFontSize,_that.labelTextStyle,_that.gridColor,_that.dataPointColor,_that.dataPointHighlightColor,_that.columnHighlightColor,_that.barColor,_that.barColorHighlight,_that.minMaxRangeColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color backgroundColor,  bool labelBackgroundTransparentGradient,  Color chartBackgroundColor,  Color chartBorderColor,  Color labelColor,  double labelFontSize,  TextStyle? labelTextStyle,  Color gridColor,  Color dataPointColor,  Color dataPointHighlightColor,  Color columnHighlightColor,  Color barColor,  Color barColorHighlight,  Color minMaxRangeColor)?  $default,) {final _that = this;
switch (_that) {
case _CooChartTheme() when $default != null:
return $default(_that.backgroundColor,_that.labelBackgroundTransparentGradient,_that.chartBackgroundColor,_that.chartBorderColor,_that.labelColor,_that.labelFontSize,_that.labelTextStyle,_that.gridColor,_that.dataPointColor,_that.dataPointHighlightColor,_that.columnHighlightColor,_that.barColor,_that.barColorHighlight,_that.minMaxRangeColor);case _:
  return null;

}
}

}

/// @nodoc


class _CooChartTheme implements CooChartTheme {
  const _CooChartTheme({required this.backgroundColor, this.labelBackgroundTransparentGradient = false, required this.chartBackgroundColor, required this.chartBorderColor, required this.labelColor, required this.labelFontSize, this.labelTextStyle, required this.gridColor, required this.dataPointColor, required this.dataPointHighlightColor, required this.columnHighlightColor, required this.barColor, required this.barColorHighlight, required this.minMaxRangeColor});
  

/// The color of the complete chart painter
@override final  Color backgroundColor;
/// If the chart is scrollable the background of the labels can be configured as transparent gradient
/// Default is not transperant.
@override@JsonKey() final  bool labelBackgroundTransparentGradient;
/// The color of the outer chart canvas background
@override final  Color chartBackgroundColor;
/// The color of the outer border lines
@override final  Color chartBorderColor;
/// y- and x-axis label color
@override final  Color labelColor;
/// y- and x-axis label font size
@override final  double labelFontSize;
/// y- and x-axis label textStyle. If given the label color and font size is not used
@override final  TextStyle? labelTextStyle;
/// The color of the inner grid lines
@override final  Color gridColor;
@override final  Color dataPointColor;
@override final  Color dataPointHighlightColor;
@override final  Color columnHighlightColor;
/// bar chart colors
@override final  Color barColor;
@override final  Color barColorHighlight;
/// Min- Max range is available in barchart and linechart. Define the color of this line.
@override final  Color minMaxRangeColor;

/// Create a copy of CooChartTheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CooChartThemeCopyWith<_CooChartTheme> get copyWith => __$CooChartThemeCopyWithImpl<_CooChartTheme>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CooChartTheme&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.labelBackgroundTransparentGradient, labelBackgroundTransparentGradient) || other.labelBackgroundTransparentGradient == labelBackgroundTransparentGradient)&&(identical(other.chartBackgroundColor, chartBackgroundColor) || other.chartBackgroundColor == chartBackgroundColor)&&(identical(other.chartBorderColor, chartBorderColor) || other.chartBorderColor == chartBorderColor)&&(identical(other.labelColor, labelColor) || other.labelColor == labelColor)&&(identical(other.labelFontSize, labelFontSize) || other.labelFontSize == labelFontSize)&&(identical(other.labelTextStyle, labelTextStyle) || other.labelTextStyle == labelTextStyle)&&(identical(other.gridColor, gridColor) || other.gridColor == gridColor)&&(identical(other.dataPointColor, dataPointColor) || other.dataPointColor == dataPointColor)&&(identical(other.dataPointHighlightColor, dataPointHighlightColor) || other.dataPointHighlightColor == dataPointHighlightColor)&&(identical(other.columnHighlightColor, columnHighlightColor) || other.columnHighlightColor == columnHighlightColor)&&(identical(other.barColor, barColor) || other.barColor == barColor)&&(identical(other.barColorHighlight, barColorHighlight) || other.barColorHighlight == barColorHighlight)&&(identical(other.minMaxRangeColor, minMaxRangeColor) || other.minMaxRangeColor == minMaxRangeColor));
}


@override
int get hashCode => Object.hash(runtimeType,backgroundColor,labelBackgroundTransparentGradient,chartBackgroundColor,chartBorderColor,labelColor,labelFontSize,labelTextStyle,gridColor,dataPointColor,dataPointHighlightColor,columnHighlightColor,barColor,barColorHighlight,minMaxRangeColor);

@override
String toString() {
  return 'CooChartTheme(backgroundColor: $backgroundColor, labelBackgroundTransparentGradient: $labelBackgroundTransparentGradient, chartBackgroundColor: $chartBackgroundColor, chartBorderColor: $chartBorderColor, labelColor: $labelColor, labelFontSize: $labelFontSize, labelTextStyle: $labelTextStyle, gridColor: $gridColor, dataPointColor: $dataPointColor, dataPointHighlightColor: $dataPointHighlightColor, columnHighlightColor: $columnHighlightColor, barColor: $barColor, barColorHighlight: $barColorHighlight, minMaxRangeColor: $minMaxRangeColor)';
}


}

/// @nodoc
abstract mixin class _$CooChartThemeCopyWith<$Res> implements $CooChartThemeCopyWith<$Res> {
  factory _$CooChartThemeCopyWith(_CooChartTheme value, $Res Function(_CooChartTheme) _then) = __$CooChartThemeCopyWithImpl;
@override @useResult
$Res call({
 Color backgroundColor, bool labelBackgroundTransparentGradient, Color chartBackgroundColor, Color chartBorderColor, Color labelColor, double labelFontSize, TextStyle? labelTextStyle, Color gridColor, Color dataPointColor, Color dataPointHighlightColor, Color columnHighlightColor, Color barColor, Color barColorHighlight, Color minMaxRangeColor
});




}
/// @nodoc
class __$CooChartThemeCopyWithImpl<$Res>
    implements _$CooChartThemeCopyWith<$Res> {
  __$CooChartThemeCopyWithImpl(this._self, this._then);

  final _CooChartTheme _self;
  final $Res Function(_CooChartTheme) _then;

/// Create a copy of CooChartTheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = null,Object? labelBackgroundTransparentGradient = null,Object? chartBackgroundColor = null,Object? chartBorderColor = null,Object? labelColor = null,Object? labelFontSize = null,Object? labelTextStyle = freezed,Object? gridColor = null,Object? dataPointColor = null,Object? dataPointHighlightColor = null,Object? columnHighlightColor = null,Object? barColor = null,Object? barColorHighlight = null,Object? minMaxRangeColor = null,}) {
  return _then(_CooChartTheme(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color,labelBackgroundTransparentGradient: null == labelBackgroundTransparentGradient ? _self.labelBackgroundTransparentGradient : labelBackgroundTransparentGradient // ignore: cast_nullable_to_non_nullable
as bool,chartBackgroundColor: null == chartBackgroundColor ? _self.chartBackgroundColor : chartBackgroundColor // ignore: cast_nullable_to_non_nullable
as Color,chartBorderColor: null == chartBorderColor ? _self.chartBorderColor : chartBorderColor // ignore: cast_nullable_to_non_nullable
as Color,labelColor: null == labelColor ? _self.labelColor : labelColor // ignore: cast_nullable_to_non_nullable
as Color,labelFontSize: null == labelFontSize ? _self.labelFontSize : labelFontSize // ignore: cast_nullable_to_non_nullable
as double,labelTextStyle: freezed == labelTextStyle ? _self.labelTextStyle : labelTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyle?,gridColor: null == gridColor ? _self.gridColor : gridColor // ignore: cast_nullable_to_non_nullable
as Color,dataPointColor: null == dataPointColor ? _self.dataPointColor : dataPointColor // ignore: cast_nullable_to_non_nullable
as Color,dataPointHighlightColor: null == dataPointHighlightColor ? _self.dataPointHighlightColor : dataPointHighlightColor // ignore: cast_nullable_to_non_nullable
as Color,columnHighlightColor: null == columnHighlightColor ? _self.columnHighlightColor : columnHighlightColor // ignore: cast_nullable_to_non_nullable
as Color,barColor: null == barColor ? _self.barColor : barColor // ignore: cast_nullable_to_non_nullable
as Color,barColorHighlight: null == barColorHighlight ? _self.barColorHighlight : barColorHighlight // ignore: cast_nullable_to_non_nullable
as Color,minMaxRangeColor: null == minMaxRangeColor ? _self.minMaxRangeColor : minMaxRangeColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
