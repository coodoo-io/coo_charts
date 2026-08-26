// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_painter_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartPainterMetadata {

 Map<int, List<CooLineChartDataPoint<dynamic>>> get lineChartDataPointsByColumnIndex; Map<int, List<CooBarChartDataPoint<dynamic>>> get barChartDataPointsByColumnIndex; bool get hasOpposite;/// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
/// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
 List<DateTime> get allDateTimeXAxisValues;/// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
/// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
 Set<double> get allDataPointValues; double get maxDataPointValue; double get minDataPointValue; int get maxAbsoluteValueCount;/// Y-Achse maximale Label-Wert
 double get yAxisMaxValue;/// Y-Achse kleinster Label-Wert
 double get yAxisMinValue;/// Größe des "Pixel-Steps" zwischen zwie y-Achse Labelpunkten
/// Wird zum Berechnen der Datenpunkte für das malen auf dem Canvas benötigt
 double get yAxisSteps;/// Layout Attributes
/// The width and height of the constraints
 double get layoutWidth; double get layoutHeight;/// The height of the given canvas
 double get canvasWidth; double get canvasHeight;/// calculated height of painted chart
 double get chartWidth; double get chartHeight; double get xSegmentWidth; double get xSegementWidthHalf;/// Number of y-axis labels
 int get yAxisLabelCount;
/// Create a copy of ChartPainterMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartPainterMetadataCopyWith<ChartPainterMetadata> get copyWith => _$ChartPainterMetadataCopyWithImpl<ChartPainterMetadata>(this as ChartPainterMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartPainterMetadata&&const DeepCollectionEquality().equals(other.lineChartDataPointsByColumnIndex, lineChartDataPointsByColumnIndex)&&const DeepCollectionEquality().equals(other.barChartDataPointsByColumnIndex, barChartDataPointsByColumnIndex)&&(identical(other.hasOpposite, hasOpposite) || other.hasOpposite == hasOpposite)&&const DeepCollectionEquality().equals(other.allDateTimeXAxisValues, allDateTimeXAxisValues)&&const DeepCollectionEquality().equals(other.allDataPointValues, allDataPointValues)&&(identical(other.maxDataPointValue, maxDataPointValue) || other.maxDataPointValue == maxDataPointValue)&&(identical(other.minDataPointValue, minDataPointValue) || other.minDataPointValue == minDataPointValue)&&(identical(other.maxAbsoluteValueCount, maxAbsoluteValueCount) || other.maxAbsoluteValueCount == maxAbsoluteValueCount)&&(identical(other.yAxisMaxValue, yAxisMaxValue) || other.yAxisMaxValue == yAxisMaxValue)&&(identical(other.yAxisMinValue, yAxisMinValue) || other.yAxisMinValue == yAxisMinValue)&&(identical(other.yAxisSteps, yAxisSteps) || other.yAxisSteps == yAxisSteps)&&(identical(other.layoutWidth, layoutWidth) || other.layoutWidth == layoutWidth)&&(identical(other.layoutHeight, layoutHeight) || other.layoutHeight == layoutHeight)&&(identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth)&&(identical(other.canvasHeight, canvasHeight) || other.canvasHeight == canvasHeight)&&(identical(other.chartWidth, chartWidth) || other.chartWidth == chartWidth)&&(identical(other.chartHeight, chartHeight) || other.chartHeight == chartHeight)&&(identical(other.xSegmentWidth, xSegmentWidth) || other.xSegmentWidth == xSegmentWidth)&&(identical(other.xSegementWidthHalf, xSegementWidthHalf) || other.xSegementWidthHalf == xSegementWidthHalf)&&(identical(other.yAxisLabelCount, yAxisLabelCount) || other.yAxisLabelCount == yAxisLabelCount));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(lineChartDataPointsByColumnIndex),const DeepCollectionEquality().hash(barChartDataPointsByColumnIndex),hasOpposite,const DeepCollectionEquality().hash(allDateTimeXAxisValues),const DeepCollectionEquality().hash(allDataPointValues),maxDataPointValue,minDataPointValue,maxAbsoluteValueCount,yAxisMaxValue,yAxisMinValue,yAxisSteps,layoutWidth,layoutHeight,canvasWidth,canvasHeight,chartWidth,chartHeight,xSegmentWidth,xSegementWidthHalf,yAxisLabelCount]);

@override
String toString() {
  return 'ChartPainterMetadata(lineChartDataPointsByColumnIndex: $lineChartDataPointsByColumnIndex, barChartDataPointsByColumnIndex: $barChartDataPointsByColumnIndex, hasOpposite: $hasOpposite, allDateTimeXAxisValues: $allDateTimeXAxisValues, allDataPointValues: $allDataPointValues, maxDataPointValue: $maxDataPointValue, minDataPointValue: $minDataPointValue, maxAbsoluteValueCount: $maxAbsoluteValueCount, yAxisMaxValue: $yAxisMaxValue, yAxisMinValue: $yAxisMinValue, yAxisSteps: $yAxisSteps, layoutWidth: $layoutWidth, layoutHeight: $layoutHeight, canvasWidth: $canvasWidth, canvasHeight: $canvasHeight, chartWidth: $chartWidth, chartHeight: $chartHeight, xSegmentWidth: $xSegmentWidth, xSegementWidthHalf: $xSegementWidthHalf, yAxisLabelCount: $yAxisLabelCount)';
}


}

/// @nodoc
abstract mixin class $ChartPainterMetadataCopyWith<$Res>  {
  factory $ChartPainterMetadataCopyWith(ChartPainterMetadata value, $Res Function(ChartPainterMetadata) _then) = _$ChartPainterMetadataCopyWithImpl;
@useResult
$Res call({
 Map<int, List<CooLineChartDataPoint<dynamic>>> lineChartDataPointsByColumnIndex, Map<int, List<CooBarChartDataPoint<dynamic>>> barChartDataPointsByColumnIndex, bool hasOpposite, List<DateTime> allDateTimeXAxisValues, Set<double> allDataPointValues, double maxDataPointValue, double minDataPointValue, int maxAbsoluteValueCount, double yAxisMaxValue, double yAxisMinValue, double yAxisSteps, double layoutWidth, double layoutHeight, double canvasWidth, double canvasHeight, double chartWidth, double chartHeight, double xSegmentWidth, double xSegementWidthHalf, int yAxisLabelCount
});




}
/// @nodoc
class _$ChartPainterMetadataCopyWithImpl<$Res>
    implements $ChartPainterMetadataCopyWith<$Res> {
  _$ChartPainterMetadataCopyWithImpl(this._self, this._then);

  final ChartPainterMetadata _self;
  final $Res Function(ChartPainterMetadata) _then;

/// Create a copy of ChartPainterMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lineChartDataPointsByColumnIndex = null,Object? barChartDataPointsByColumnIndex = null,Object? hasOpposite = null,Object? allDateTimeXAxisValues = null,Object? allDataPointValues = null,Object? maxDataPointValue = null,Object? minDataPointValue = null,Object? maxAbsoluteValueCount = null,Object? yAxisMaxValue = null,Object? yAxisMinValue = null,Object? yAxisSteps = null,Object? layoutWidth = null,Object? layoutHeight = null,Object? canvasWidth = null,Object? canvasHeight = null,Object? chartWidth = null,Object? chartHeight = null,Object? xSegmentWidth = null,Object? xSegementWidthHalf = null,Object? yAxisLabelCount = null,}) {
  return _then(ChartPainterMetadata(
lineChartDataPointsByColumnIndex: null == lineChartDataPointsByColumnIndex ? _self.lineChartDataPointsByColumnIndex : lineChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
as Map<int, List<CooLineChartDataPoint<dynamic>>>,barChartDataPointsByColumnIndex: null == barChartDataPointsByColumnIndex ? _self.barChartDataPointsByColumnIndex : barChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
as Map<int, List<CooBarChartDataPoint<dynamic>>>,hasOpposite: null == hasOpposite ? _self.hasOpposite : hasOpposite // ignore: cast_nullable_to_non_nullable
as bool,allDateTimeXAxisValues: null == allDateTimeXAxisValues ? _self.allDateTimeXAxisValues : allDateTimeXAxisValues // ignore: cast_nullable_to_non_nullable
as List<DateTime>,allDataPointValues: null == allDataPointValues ? _self.allDataPointValues : allDataPointValues // ignore: cast_nullable_to_non_nullable
as Set<double>,maxDataPointValue: null == maxDataPointValue ? _self.maxDataPointValue : maxDataPointValue // ignore: cast_nullable_to_non_nullable
as double,minDataPointValue: null == minDataPointValue ? _self.minDataPointValue : minDataPointValue // ignore: cast_nullable_to_non_nullable
as double,maxAbsoluteValueCount: null == maxAbsoluteValueCount ? _self.maxAbsoluteValueCount : maxAbsoluteValueCount // ignore: cast_nullable_to_non_nullable
as int,yAxisMaxValue: null == yAxisMaxValue ? _self.yAxisMaxValue : yAxisMaxValue // ignore: cast_nullable_to_non_nullable
as double,yAxisMinValue: null == yAxisMinValue ? _self.yAxisMinValue : yAxisMinValue // ignore: cast_nullable_to_non_nullable
as double,yAxisSteps: null == yAxisSteps ? _self.yAxisSteps : yAxisSteps // ignore: cast_nullable_to_non_nullable
as double,layoutWidth: null == layoutWidth ? _self.layoutWidth : layoutWidth // ignore: cast_nullable_to_non_nullable
as double,layoutHeight: null == layoutHeight ? _self.layoutHeight : layoutHeight // ignore: cast_nullable_to_non_nullable
as double,canvasWidth: null == canvasWidth ? _self.canvasWidth : canvasWidth // ignore: cast_nullable_to_non_nullable
as double,canvasHeight: null == canvasHeight ? _self.canvasHeight : canvasHeight // ignore: cast_nullable_to_non_nullable
as double,chartWidth: null == chartWidth ? _self.chartWidth : chartWidth // ignore: cast_nullable_to_non_nullable
as double,chartHeight: null == chartHeight ? _self.chartHeight : chartHeight // ignore: cast_nullable_to_non_nullable
as double,xSegmentWidth: null == xSegmentWidth ? _self.xSegmentWidth : xSegmentWidth // ignore: cast_nullable_to_non_nullable
as double,xSegementWidthHalf: null == xSegementWidthHalf ? _self.xSegementWidthHalf : xSegementWidthHalf // ignore: cast_nullable_to_non_nullable
as double,yAxisLabelCount: null == yAxisLabelCount ? _self.yAxisLabelCount : yAxisLabelCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChartPainterMetadata].
extension ChartPainterMetadataPatterns on ChartPainterMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChartPainterMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChartPainterMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChartPainterMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ChartPainterMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChartPainterMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ChartPainterMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<int, List<CooLineChartDataPoint<dynamic>>> lineChartDataPointsByColumnIndex,  Map<int, List<CooBarChartDataPoint<dynamic>>> barChartDataPointsByColumnIndex,  bool hasOpposite,  List<DateTime> allDateTimeXAxisValues,  Set<double> allDataPointValues,  double maxDataPointValue,  double minDataPointValue,  int maxAbsoluteValueCount,  double yAxisMaxValue,  double yAxisMinValue,  double yAxisSteps,  double layoutWidth,  double layoutHeight,  double canvasWidth,  double canvasHeight,  double chartWidth,  double chartHeight,  double xSegmentWidth,  double xSegementWidthHalf,  int yAxisLabelCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChartPainterMetadata() when $default != null:
return $default(_that.lineChartDataPointsByColumnIndex,_that.barChartDataPointsByColumnIndex,_that.hasOpposite,_that.allDateTimeXAxisValues,_that.allDataPointValues,_that.maxDataPointValue,_that.minDataPointValue,_that.maxAbsoluteValueCount,_that.yAxisMaxValue,_that.yAxisMinValue,_that.yAxisSteps,_that.layoutWidth,_that.layoutHeight,_that.canvasWidth,_that.canvasHeight,_that.chartWidth,_that.chartHeight,_that.xSegmentWidth,_that.xSegementWidthHalf,_that.yAxisLabelCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<int, List<CooLineChartDataPoint<dynamic>>> lineChartDataPointsByColumnIndex,  Map<int, List<CooBarChartDataPoint<dynamic>>> barChartDataPointsByColumnIndex,  bool hasOpposite,  List<DateTime> allDateTimeXAxisValues,  Set<double> allDataPointValues,  double maxDataPointValue,  double minDataPointValue,  int maxAbsoluteValueCount,  double yAxisMaxValue,  double yAxisMinValue,  double yAxisSteps,  double layoutWidth,  double layoutHeight,  double canvasWidth,  double canvasHeight,  double chartWidth,  double chartHeight,  double xSegmentWidth,  double xSegementWidthHalf,  int yAxisLabelCount)  $default,) {final _that = this;
switch (_that) {
case _ChartPainterMetadata():
return $default(_that.lineChartDataPointsByColumnIndex,_that.barChartDataPointsByColumnIndex,_that.hasOpposite,_that.allDateTimeXAxisValues,_that.allDataPointValues,_that.maxDataPointValue,_that.minDataPointValue,_that.maxAbsoluteValueCount,_that.yAxisMaxValue,_that.yAxisMinValue,_that.yAxisSteps,_that.layoutWidth,_that.layoutHeight,_that.canvasWidth,_that.canvasHeight,_that.chartWidth,_that.chartHeight,_that.xSegmentWidth,_that.xSegementWidthHalf,_that.yAxisLabelCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<int, List<CooLineChartDataPoint<dynamic>>> lineChartDataPointsByColumnIndex,  Map<int, List<CooBarChartDataPoint<dynamic>>> barChartDataPointsByColumnIndex,  bool hasOpposite,  List<DateTime> allDateTimeXAxisValues,  Set<double> allDataPointValues,  double maxDataPointValue,  double minDataPointValue,  int maxAbsoluteValueCount,  double yAxisMaxValue,  double yAxisMinValue,  double yAxisSteps,  double layoutWidth,  double layoutHeight,  double canvasWidth,  double canvasHeight,  double chartWidth,  double chartHeight,  double xSegmentWidth,  double xSegementWidthHalf,  int yAxisLabelCount)?  $default,) {final _that = this;
switch (_that) {
case _ChartPainterMetadata() when $default != null:
return $default(_that.lineChartDataPointsByColumnIndex,_that.barChartDataPointsByColumnIndex,_that.hasOpposite,_that.allDateTimeXAxisValues,_that.allDataPointValues,_that.maxDataPointValue,_that.minDataPointValue,_that.maxAbsoluteValueCount,_that.yAxisMaxValue,_that.yAxisMinValue,_that.yAxisSteps,_that.layoutWidth,_that.layoutHeight,_that.canvasWidth,_that.canvasHeight,_that.chartWidth,_that.chartHeight,_that.xSegmentWidth,_that.xSegementWidthHalf,_that.yAxisLabelCount);case _:
  return null;

}
}

}

/// @nodoc


class _ChartPainterMetadata implements ChartPainterMetadata {
  const _ChartPainterMetadata({required  Map<int, List<CooLineChartDataPoint<dynamic>>> lineChartDataPointsByColumnIndex, required  Map<int, List<CooBarChartDataPoint<dynamic>>> barChartDataPointsByColumnIndex, required this.hasOpposite, required  List<DateTime> allDateTimeXAxisValues, required  Set<double> allDataPointValues, required this.maxDataPointValue, required this.minDataPointValue, required this.maxAbsoluteValueCount, required this.yAxisMaxValue, required this.yAxisMinValue, required this.yAxisSteps, required this.layoutWidth, required this.layoutHeight, required this.canvasWidth, required this.canvasHeight, required this.chartWidth, required this.chartHeight, required this.xSegmentWidth, required this.xSegementWidthHalf, required this.yAxisLabelCount}): _lineChartDataPointsByColumnIndex = lineChartDataPointsByColumnIndex,_barChartDataPointsByColumnIndex = barChartDataPointsByColumnIndex,_allDateTimeXAxisValues = allDateTimeXAxisValues,_allDataPointValues = allDataPointValues;
  

 final  Map<int, List<CooLineChartDataPoint<dynamic>>> _lineChartDataPointsByColumnIndex;
@override Map<int, List<CooLineChartDataPoint<dynamic>>> get lineChartDataPointsByColumnIndex {
  if (_lineChartDataPointsByColumnIndex is EqualUnmodifiableMapView) return _lineChartDataPointsByColumnIndex;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lineChartDataPointsByColumnIndex);
}

 final  Map<int, List<CooBarChartDataPoint<dynamic>>> _barChartDataPointsByColumnIndex;
@override Map<int, List<CooBarChartDataPoint<dynamic>>> get barChartDataPointsByColumnIndex {
  if (_barChartDataPointsByColumnIndex is EqualUnmodifiableMapView) return _barChartDataPointsByColumnIndex;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_barChartDataPointsByColumnIndex);
}

@override final  bool hasOpposite;
/// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
/// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
 final  List<DateTime> _allDateTimeXAxisValues;
/// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
/// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
@override List<DateTime> get allDateTimeXAxisValues {
  if (_allDateTimeXAxisValues is EqualUnmodifiableListView) return _allDateTimeXAxisValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allDateTimeXAxisValues);
}

/// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
/// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
 final  Set<double> _allDataPointValues;
/// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
/// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
@override Set<double> get allDataPointValues {
  if (_allDataPointValues is EqualUnmodifiableSetView) return _allDataPointValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_allDataPointValues);
}

@override final  double maxDataPointValue;
@override final  double minDataPointValue;
@override final  int maxAbsoluteValueCount;
/// Y-Achse maximale Label-Wert
@override final  double yAxisMaxValue;
/// Y-Achse kleinster Label-Wert
@override final  double yAxisMinValue;
/// Größe des "Pixel-Steps" zwischen zwie y-Achse Labelpunkten
/// Wird zum Berechnen der Datenpunkte für das malen auf dem Canvas benötigt
@override final  double yAxisSteps;
/// Layout Attributes
/// The width and height of the constraints
@override final  double layoutWidth;
@override final  double layoutHeight;
/// The height of the given canvas
@override final  double canvasWidth;
@override final  double canvasHeight;
/// calculated height of painted chart
@override final  double chartWidth;
@override final  double chartHeight;
@override final  double xSegmentWidth;
@override final  double xSegementWidthHalf;
/// Number of y-axis labels
@override final  int yAxisLabelCount;

/// Create a copy of ChartPainterMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartPainterMetadataCopyWith<_ChartPainterMetadata> get copyWith => __$ChartPainterMetadataCopyWithImpl<_ChartPainterMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartPainterMetadata&&const DeepCollectionEquality().equals(other._lineChartDataPointsByColumnIndex, _lineChartDataPointsByColumnIndex)&&const DeepCollectionEquality().equals(other._barChartDataPointsByColumnIndex, _barChartDataPointsByColumnIndex)&&(identical(other.hasOpposite, hasOpposite) || other.hasOpposite == hasOpposite)&&const DeepCollectionEquality().equals(other._allDateTimeXAxisValues, _allDateTimeXAxisValues)&&const DeepCollectionEquality().equals(other._allDataPointValues, _allDataPointValues)&&(identical(other.maxDataPointValue, maxDataPointValue) || other.maxDataPointValue == maxDataPointValue)&&(identical(other.minDataPointValue, minDataPointValue) || other.minDataPointValue == minDataPointValue)&&(identical(other.maxAbsoluteValueCount, maxAbsoluteValueCount) || other.maxAbsoluteValueCount == maxAbsoluteValueCount)&&(identical(other.yAxisMaxValue, yAxisMaxValue) || other.yAxisMaxValue == yAxisMaxValue)&&(identical(other.yAxisMinValue, yAxisMinValue) || other.yAxisMinValue == yAxisMinValue)&&(identical(other.yAxisSteps, yAxisSteps) || other.yAxisSteps == yAxisSteps)&&(identical(other.layoutWidth, layoutWidth) || other.layoutWidth == layoutWidth)&&(identical(other.layoutHeight, layoutHeight) || other.layoutHeight == layoutHeight)&&(identical(other.canvasWidth, canvasWidth) || other.canvasWidth == canvasWidth)&&(identical(other.canvasHeight, canvasHeight) || other.canvasHeight == canvasHeight)&&(identical(other.chartWidth, chartWidth) || other.chartWidth == chartWidth)&&(identical(other.chartHeight, chartHeight) || other.chartHeight == chartHeight)&&(identical(other.xSegmentWidth, xSegmentWidth) || other.xSegmentWidth == xSegmentWidth)&&(identical(other.xSegementWidthHalf, xSegementWidthHalf) || other.xSegementWidthHalf == xSegementWidthHalf)&&(identical(other.yAxisLabelCount, yAxisLabelCount) || other.yAxisLabelCount == yAxisLabelCount));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_lineChartDataPointsByColumnIndex),const DeepCollectionEquality().hash(_barChartDataPointsByColumnIndex),hasOpposite,const DeepCollectionEquality().hash(_allDateTimeXAxisValues),const DeepCollectionEquality().hash(_allDataPointValues),maxDataPointValue,minDataPointValue,maxAbsoluteValueCount,yAxisMaxValue,yAxisMinValue,yAxisSteps,layoutWidth,layoutHeight,canvasWidth,canvasHeight,chartWidth,chartHeight,xSegmentWidth,xSegementWidthHalf,yAxisLabelCount]);

@override
String toString() {
  return 'ChartPainterMetadata(lineChartDataPointsByColumnIndex: $lineChartDataPointsByColumnIndex, barChartDataPointsByColumnIndex: $barChartDataPointsByColumnIndex, hasOpposite: $hasOpposite, allDateTimeXAxisValues: $allDateTimeXAxisValues, allDataPointValues: $allDataPointValues, maxDataPointValue: $maxDataPointValue, minDataPointValue: $minDataPointValue, maxAbsoluteValueCount: $maxAbsoluteValueCount, yAxisMaxValue: $yAxisMaxValue, yAxisMinValue: $yAxisMinValue, yAxisSteps: $yAxisSteps, layoutWidth: $layoutWidth, layoutHeight: $layoutHeight, canvasWidth: $canvasWidth, canvasHeight: $canvasHeight, chartWidth: $chartWidth, chartHeight: $chartHeight, xSegmentWidth: $xSegmentWidth, xSegementWidthHalf: $xSegementWidthHalf, yAxisLabelCount: $yAxisLabelCount)';
}


}

/// @nodoc
abstract mixin class _$ChartPainterMetadataCopyWith<$Res> implements $ChartPainterMetadataCopyWith<$Res> {
  factory _$ChartPainterMetadataCopyWith(_ChartPainterMetadata value, $Res Function(_ChartPainterMetadata) _then) = __$ChartPainterMetadataCopyWithImpl;
@override @useResult
$Res call({
 Map<int, List<CooLineChartDataPoint<dynamic>>> lineChartDataPointsByColumnIndex, Map<int, List<CooBarChartDataPoint<dynamic>>> barChartDataPointsByColumnIndex, bool hasOpposite, List<DateTime> allDateTimeXAxisValues, Set<double> allDataPointValues, double maxDataPointValue, double minDataPointValue, int maxAbsoluteValueCount, double yAxisMaxValue, double yAxisMinValue, double yAxisSteps, double layoutWidth, double layoutHeight, double canvasWidth, double canvasHeight, double chartWidth, double chartHeight, double xSegmentWidth, double xSegementWidthHalf, int yAxisLabelCount
});




}
/// @nodoc
class __$ChartPainterMetadataCopyWithImpl<$Res>
    implements _$ChartPainterMetadataCopyWith<$Res> {
  __$ChartPainterMetadataCopyWithImpl(this._self, this._then);

  final _ChartPainterMetadata _self;
  final $Res Function(_ChartPainterMetadata) _then;

/// Create a copy of ChartPainterMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lineChartDataPointsByColumnIndex = null,Object? barChartDataPointsByColumnIndex = null,Object? hasOpposite = null,Object? allDateTimeXAxisValues = null,Object? allDataPointValues = null,Object? maxDataPointValue = null,Object? minDataPointValue = null,Object? maxAbsoluteValueCount = null,Object? yAxisMaxValue = null,Object? yAxisMinValue = null,Object? yAxisSteps = null,Object? layoutWidth = null,Object? layoutHeight = null,Object? canvasWidth = null,Object? canvasHeight = null,Object? chartWidth = null,Object? chartHeight = null,Object? xSegmentWidth = null,Object? xSegementWidthHalf = null,Object? yAxisLabelCount = null,}) {
  return _then(_ChartPainterMetadata(
lineChartDataPointsByColumnIndex: null == lineChartDataPointsByColumnIndex ? _self._lineChartDataPointsByColumnIndex : lineChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
as Map<int, List<CooLineChartDataPoint<dynamic>>>,barChartDataPointsByColumnIndex: null == barChartDataPointsByColumnIndex ? _self._barChartDataPointsByColumnIndex : barChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
as Map<int, List<CooBarChartDataPoint<dynamic>>>,hasOpposite: null == hasOpposite ? _self.hasOpposite : hasOpposite // ignore: cast_nullable_to_non_nullable
as bool,allDateTimeXAxisValues: null == allDateTimeXAxisValues ? _self._allDateTimeXAxisValues : allDateTimeXAxisValues // ignore: cast_nullable_to_non_nullable
as List<DateTime>,allDataPointValues: null == allDataPointValues ? _self._allDataPointValues : allDataPointValues // ignore: cast_nullable_to_non_nullable
as Set<double>,maxDataPointValue: null == maxDataPointValue ? _self.maxDataPointValue : maxDataPointValue // ignore: cast_nullable_to_non_nullable
as double,minDataPointValue: null == minDataPointValue ? _self.minDataPointValue : minDataPointValue // ignore: cast_nullable_to_non_nullable
as double,maxAbsoluteValueCount: null == maxAbsoluteValueCount ? _self.maxAbsoluteValueCount : maxAbsoluteValueCount // ignore: cast_nullable_to_non_nullable
as int,yAxisMaxValue: null == yAxisMaxValue ? _self.yAxisMaxValue : yAxisMaxValue // ignore: cast_nullable_to_non_nullable
as double,yAxisMinValue: null == yAxisMinValue ? _self.yAxisMinValue : yAxisMinValue // ignore: cast_nullable_to_non_nullable
as double,yAxisSteps: null == yAxisSteps ? _self.yAxisSteps : yAxisSteps // ignore: cast_nullable_to_non_nullable
as double,layoutWidth: null == layoutWidth ? _self.layoutWidth : layoutWidth // ignore: cast_nullable_to_non_nullable
as double,layoutHeight: null == layoutHeight ? _self.layoutHeight : layoutHeight // ignore: cast_nullable_to_non_nullable
as double,canvasWidth: null == canvasWidth ? _self.canvasWidth : canvasWidth // ignore: cast_nullable_to_non_nullable
as double,canvasHeight: null == canvasHeight ? _self.canvasHeight : canvasHeight // ignore: cast_nullable_to_non_nullable
as double,chartWidth: null == chartWidth ? _self.chartWidth : chartWidth // ignore: cast_nullable_to_non_nullable
as double,chartHeight: null == chartHeight ? _self.chartHeight : chartHeight // ignore: cast_nullable_to_non_nullable
as double,xSegmentWidth: null == xSegmentWidth ? _self.xSegmentWidth : xSegmentWidth // ignore: cast_nullable_to_non_nullable
as double,xSegementWidthHalf: null == xSegementWidthHalf ? _self.xSegementWidthHalf : xSegementWidthHalf // ignore: cast_nullable_to_non_nullable
as double,yAxisLabelCount: null == yAxisLabelCount ? _self.yAxisLabelCount : yAxisLabelCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
