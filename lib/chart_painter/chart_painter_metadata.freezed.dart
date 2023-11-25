// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_painter_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChartPainterMetadata {
// All sich auf diesem Index befindenden LineChart Datenpunkte
// Die exakte Punkt (X,Y) eines LineChart DataPoint Objekts müsste man in Verbidung dises Objektes noch in einem
// eigenen Objekt halten. Dann könnte man auch den nächstgelegenen Punkt zum Maus Pointer herausfinden
  Map<int, List<CooLineChartDataPoint>> get lineChartDataPointsByColumnIndex =>
      throw _privateConstructorUsedError;
  Map<int, List<CooBarChartDataPoint>> get barChartDataPointsByColumnIndex =>
      throw _privateConstructorUsedError;

  /// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
  /// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
  List<DateTime> get allDateTimeXAxisValues =>
      throw _privateConstructorUsedError;

  /// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
  /// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
  Set<double> get allDataPointValues =>
      throw _privateConstructorUsedError; // Größter Datenpunktwert aller gegbenen Datenpunkt
  double get maxDataPointValue =>
      throw _privateConstructorUsedError; // Kleinster Datenpunktwert aller gegbenen Datenpunkt
  double get minDataPointValue =>
      throw _privateConstructorUsedError; // Anzahl aller gegebener Punkt auf dem x-Achsenwert
  int get maxAbsoluteValueCount => throw _privateConstructorUsedError;

  /// Y-Achse maximale Label-Wert
  double get yAxisMaxValue => throw _privateConstructorUsedError;

  /// Y-Achse kleinster Label-Wert
  double get yAxisMinValue => throw _privateConstructorUsedError;

  /// Größe des "Pixel-Steps" zwischen zwie y-Achse Labelpunkten
  /// Wird zum Berechnen der Datenpunkte für das malen auf dem Canvas benötigt
  double get yAxisSteps => throw _privateConstructorUsedError;

  /// Layout Attributes
  /// The width and height of the constraints
  double get layoutWidth => throw _privateConstructorUsedError;
  double get layoutHeight => throw _privateConstructorUsedError;

  /// The height of the given canvas
  double get canvasWidth => throw _privateConstructorUsedError;
  double get canvasHeight => throw _privateConstructorUsedError;

  /// calculated height of painted chart
  double get chartWidth => throw _privateConstructorUsedError;
  double get chartHeight =>
      throw _privateConstructorUsedError; // Abstand zwischen zwei Datenpunkte auf der X-Achse
  double get xSegmentWidth =>
      throw _privateConstructorUsedError; // Hilfsvariable zu xSegmentWidth, damit sie nicht jedesmal berechnet werden muss
  double get xSegementWidthHalf => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChartPainterMetadataCopyWith<ChartPainterMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartPainterMetadataCopyWith<$Res> {
  factory $ChartPainterMetadataCopyWith(ChartPainterMetadata value,
          $Res Function(ChartPainterMetadata) then) =
      _$ChartPainterMetadataCopyWithImpl<$Res, ChartPainterMetadata>;
  @useResult
  $Res call(
      {Map<int, List<CooLineChartDataPoint>> lineChartDataPointsByColumnIndex,
      Map<int, List<CooBarChartDataPoint>> barChartDataPointsByColumnIndex,
      List<DateTime> allDateTimeXAxisValues,
      Set<double> allDataPointValues,
      double maxDataPointValue,
      double minDataPointValue,
      int maxAbsoluteValueCount,
      double yAxisMaxValue,
      double yAxisMinValue,
      double yAxisSteps,
      double layoutWidth,
      double layoutHeight,
      double canvasWidth,
      double canvasHeight,
      double chartWidth,
      double chartHeight,
      double xSegmentWidth,
      double xSegementWidthHalf});
}

/// @nodoc
class _$ChartPainterMetadataCopyWithImpl<$Res,
        $Val extends ChartPainterMetadata>
    implements $ChartPainterMetadataCopyWith<$Res> {
  _$ChartPainterMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lineChartDataPointsByColumnIndex = null,
    Object? barChartDataPointsByColumnIndex = null,
    Object? allDateTimeXAxisValues = null,
    Object? allDataPointValues = null,
    Object? maxDataPointValue = null,
    Object? minDataPointValue = null,
    Object? maxAbsoluteValueCount = null,
    Object? yAxisMaxValue = null,
    Object? yAxisMinValue = null,
    Object? yAxisSteps = null,
    Object? layoutWidth = null,
    Object? layoutHeight = null,
    Object? canvasWidth = null,
    Object? canvasHeight = null,
    Object? chartWidth = null,
    Object? chartHeight = null,
    Object? xSegmentWidth = null,
    Object? xSegementWidthHalf = null,
  }) {
    return _then(_value.copyWith(
      lineChartDataPointsByColumnIndex: null == lineChartDataPointsByColumnIndex
          ? _value.lineChartDataPointsByColumnIndex
          : lineChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, List<CooLineChartDataPoint>>,
      barChartDataPointsByColumnIndex: null == barChartDataPointsByColumnIndex
          ? _value.barChartDataPointsByColumnIndex
          : barChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, List<CooBarChartDataPoint>>,
      allDateTimeXAxisValues: null == allDateTimeXAxisValues
          ? _value.allDateTimeXAxisValues
          : allDateTimeXAxisValues // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      allDataPointValues: null == allDataPointValues
          ? _value.allDataPointValues
          : allDataPointValues // ignore: cast_nullable_to_non_nullable
              as Set<double>,
      maxDataPointValue: null == maxDataPointValue
          ? _value.maxDataPointValue
          : maxDataPointValue // ignore: cast_nullable_to_non_nullable
              as double,
      minDataPointValue: null == minDataPointValue
          ? _value.minDataPointValue
          : minDataPointValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxAbsoluteValueCount: null == maxAbsoluteValueCount
          ? _value.maxAbsoluteValueCount
          : maxAbsoluteValueCount // ignore: cast_nullable_to_non_nullable
              as int,
      yAxisMaxValue: null == yAxisMaxValue
          ? _value.yAxisMaxValue
          : yAxisMaxValue // ignore: cast_nullable_to_non_nullable
              as double,
      yAxisMinValue: null == yAxisMinValue
          ? _value.yAxisMinValue
          : yAxisMinValue // ignore: cast_nullable_to_non_nullable
              as double,
      yAxisSteps: null == yAxisSteps
          ? _value.yAxisSteps
          : yAxisSteps // ignore: cast_nullable_to_non_nullable
              as double,
      layoutWidth: null == layoutWidth
          ? _value.layoutWidth
          : layoutWidth // ignore: cast_nullable_to_non_nullable
              as double,
      layoutHeight: null == layoutHeight
          ? _value.layoutHeight
          : layoutHeight // ignore: cast_nullable_to_non_nullable
              as double,
      canvasWidth: null == canvasWidth
          ? _value.canvasWidth
          : canvasWidth // ignore: cast_nullable_to_non_nullable
              as double,
      canvasHeight: null == canvasHeight
          ? _value.canvasHeight
          : canvasHeight // ignore: cast_nullable_to_non_nullable
              as double,
      chartWidth: null == chartWidth
          ? _value.chartWidth
          : chartWidth // ignore: cast_nullable_to_non_nullable
              as double,
      chartHeight: null == chartHeight
          ? _value.chartHeight
          : chartHeight // ignore: cast_nullable_to_non_nullable
              as double,
      xSegmentWidth: null == xSegmentWidth
          ? _value.xSegmentWidth
          : xSegmentWidth // ignore: cast_nullable_to_non_nullable
              as double,
      xSegementWidthHalf: null == xSegementWidthHalf
          ? _value.xSegementWidthHalf
          : xSegementWidthHalf // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartPainterMetadataImplCopyWith<$Res>
    implements $ChartPainterMetadataCopyWith<$Res> {
  factory _$$ChartPainterMetadataImplCopyWith(_$ChartPainterMetadataImpl value,
          $Res Function(_$ChartPainterMetadataImpl) then) =
      __$$ChartPainterMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<int, List<CooLineChartDataPoint>> lineChartDataPointsByColumnIndex,
      Map<int, List<CooBarChartDataPoint>> barChartDataPointsByColumnIndex,
      List<DateTime> allDateTimeXAxisValues,
      Set<double> allDataPointValues,
      double maxDataPointValue,
      double minDataPointValue,
      int maxAbsoluteValueCount,
      double yAxisMaxValue,
      double yAxisMinValue,
      double yAxisSteps,
      double layoutWidth,
      double layoutHeight,
      double canvasWidth,
      double canvasHeight,
      double chartWidth,
      double chartHeight,
      double xSegmentWidth,
      double xSegementWidthHalf});
}

/// @nodoc
class __$$ChartPainterMetadataImplCopyWithImpl<$Res>
    extends _$ChartPainterMetadataCopyWithImpl<$Res, _$ChartPainterMetadataImpl>
    implements _$$ChartPainterMetadataImplCopyWith<$Res> {
  __$$ChartPainterMetadataImplCopyWithImpl(_$ChartPainterMetadataImpl _value,
      $Res Function(_$ChartPainterMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lineChartDataPointsByColumnIndex = null,
    Object? barChartDataPointsByColumnIndex = null,
    Object? allDateTimeXAxisValues = null,
    Object? allDataPointValues = null,
    Object? maxDataPointValue = null,
    Object? minDataPointValue = null,
    Object? maxAbsoluteValueCount = null,
    Object? yAxisMaxValue = null,
    Object? yAxisMinValue = null,
    Object? yAxisSteps = null,
    Object? layoutWidth = null,
    Object? layoutHeight = null,
    Object? canvasWidth = null,
    Object? canvasHeight = null,
    Object? chartWidth = null,
    Object? chartHeight = null,
    Object? xSegmentWidth = null,
    Object? xSegementWidthHalf = null,
  }) {
    return _then(_$ChartPainterMetadataImpl(
      lineChartDataPointsByColumnIndex: null == lineChartDataPointsByColumnIndex
          ? _value._lineChartDataPointsByColumnIndex
          : lineChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, List<CooLineChartDataPoint>>,
      barChartDataPointsByColumnIndex: null == barChartDataPointsByColumnIndex
          ? _value._barChartDataPointsByColumnIndex
          : barChartDataPointsByColumnIndex // ignore: cast_nullable_to_non_nullable
              as Map<int, List<CooBarChartDataPoint>>,
      allDateTimeXAxisValues: null == allDateTimeXAxisValues
          ? _value._allDateTimeXAxisValues
          : allDateTimeXAxisValues // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      allDataPointValues: null == allDataPointValues
          ? _value._allDataPointValues
          : allDataPointValues // ignore: cast_nullable_to_non_nullable
              as Set<double>,
      maxDataPointValue: null == maxDataPointValue
          ? _value.maxDataPointValue
          : maxDataPointValue // ignore: cast_nullable_to_non_nullable
              as double,
      minDataPointValue: null == minDataPointValue
          ? _value.minDataPointValue
          : minDataPointValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxAbsoluteValueCount: null == maxAbsoluteValueCount
          ? _value.maxAbsoluteValueCount
          : maxAbsoluteValueCount // ignore: cast_nullable_to_non_nullable
              as int,
      yAxisMaxValue: null == yAxisMaxValue
          ? _value.yAxisMaxValue
          : yAxisMaxValue // ignore: cast_nullable_to_non_nullable
              as double,
      yAxisMinValue: null == yAxisMinValue
          ? _value.yAxisMinValue
          : yAxisMinValue // ignore: cast_nullable_to_non_nullable
              as double,
      yAxisSteps: null == yAxisSteps
          ? _value.yAxisSteps
          : yAxisSteps // ignore: cast_nullable_to_non_nullable
              as double,
      layoutWidth: null == layoutWidth
          ? _value.layoutWidth
          : layoutWidth // ignore: cast_nullable_to_non_nullable
              as double,
      layoutHeight: null == layoutHeight
          ? _value.layoutHeight
          : layoutHeight // ignore: cast_nullable_to_non_nullable
              as double,
      canvasWidth: null == canvasWidth
          ? _value.canvasWidth
          : canvasWidth // ignore: cast_nullable_to_non_nullable
              as double,
      canvasHeight: null == canvasHeight
          ? _value.canvasHeight
          : canvasHeight // ignore: cast_nullable_to_non_nullable
              as double,
      chartWidth: null == chartWidth
          ? _value.chartWidth
          : chartWidth // ignore: cast_nullable_to_non_nullable
              as double,
      chartHeight: null == chartHeight
          ? _value.chartHeight
          : chartHeight // ignore: cast_nullable_to_non_nullable
              as double,
      xSegmentWidth: null == xSegmentWidth
          ? _value.xSegmentWidth
          : xSegmentWidth // ignore: cast_nullable_to_non_nullable
              as double,
      xSegementWidthHalf: null == xSegementWidthHalf
          ? _value.xSegementWidthHalf
          : xSegementWidthHalf // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ChartPainterMetadataImpl implements _ChartPainterMetadata {
  const _$ChartPainterMetadataImpl(
      {required final Map<int, List<CooLineChartDataPoint>>
          lineChartDataPointsByColumnIndex,
      required final Map<int, List<CooBarChartDataPoint>>
          barChartDataPointsByColumnIndex,
      required final List<DateTime> allDateTimeXAxisValues,
      required final Set<double> allDataPointValues,
      required this.maxDataPointValue,
      required this.minDataPointValue,
      required this.maxAbsoluteValueCount,
      required this.yAxisMaxValue,
      required this.yAxisMinValue,
      required this.yAxisSteps,
      required this.layoutWidth,
      required this.layoutHeight,
      required this.canvasWidth,
      required this.canvasHeight,
      required this.chartWidth,
      required this.chartHeight,
      required this.xSegmentWidth,
      required this.xSegementWidthHalf})
      : _lineChartDataPointsByColumnIndex = lineChartDataPointsByColumnIndex,
        _barChartDataPointsByColumnIndex = barChartDataPointsByColumnIndex,
        _allDateTimeXAxisValues = allDateTimeXAxisValues,
        _allDataPointValues = allDataPointValues;

// All sich auf diesem Index befindenden LineChart Datenpunkte
// Die exakte Punkt (X,Y) eines LineChart DataPoint Objekts müsste man in Verbidung dises Objektes noch in einem
// eigenen Objekt halten. Dann könnte man auch den nächstgelegenen Punkt zum Maus Pointer herausfinden
  final Map<int, List<CooLineChartDataPoint>> _lineChartDataPointsByColumnIndex;
// All sich auf diesem Index befindenden LineChart Datenpunkte
// Die exakte Punkt (X,Y) eines LineChart DataPoint Objekts müsste man in Verbidung dises Objektes noch in einem
// eigenen Objekt halten. Dann könnte man auch den nächstgelegenen Punkt zum Maus Pointer herausfinden
  @override
  Map<int, List<CooLineChartDataPoint>> get lineChartDataPointsByColumnIndex {
    if (_lineChartDataPointsByColumnIndex is EqualUnmodifiableMapView)
      return _lineChartDataPointsByColumnIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lineChartDataPointsByColumnIndex);
  }

  final Map<int, List<CooBarChartDataPoint>> _barChartDataPointsByColumnIndex;
  @override
  Map<int, List<CooBarChartDataPoint>> get barChartDataPointsByColumnIndex {
    if (_barChartDataPointsByColumnIndex is EqualUnmodifiableMapView)
      return _barChartDataPointsByColumnIndex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_barChartDataPointsByColumnIndex);
  }

  /// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
  /// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
  final List<DateTime> _allDateTimeXAxisValues;

  /// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
  /// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
  @override
  List<DateTime> get allDateTimeXAxisValues {
    if (_allDateTimeXAxisValues is EqualUnmodifiableListView)
      return _allDateTimeXAxisValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allDateTimeXAxisValues);
  }

  /// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
  /// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
  final Set<double> _allDataPointValues;

  /// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
  /// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
  @override
  Set<double> get allDataPointValues {
    if (_allDataPointValues is EqualUnmodifiableSetView)
      return _allDataPointValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_allDataPointValues);
  }

// Größter Datenpunktwert aller gegbenen Datenpunkt
  @override
  final double maxDataPointValue;
// Kleinster Datenpunktwert aller gegbenen Datenpunkt
  @override
  final double minDataPointValue;
// Anzahl aller gegebener Punkt auf dem x-Achsenwert
  @override
  final int maxAbsoluteValueCount;

  /// Y-Achse maximale Label-Wert
  @override
  final double yAxisMaxValue;

  /// Y-Achse kleinster Label-Wert
  @override
  final double yAxisMinValue;

  /// Größe des "Pixel-Steps" zwischen zwie y-Achse Labelpunkten
  /// Wird zum Berechnen der Datenpunkte für das malen auf dem Canvas benötigt
  @override
  final double yAxisSteps;

  /// Layout Attributes
  /// The width and height of the constraints
  @override
  final double layoutWidth;
  @override
  final double layoutHeight;

  /// The height of the given canvas
  @override
  final double canvasWidth;
  @override
  final double canvasHeight;

  /// calculated height of painted chart
  @override
  final double chartWidth;
  @override
  final double chartHeight;
// Abstand zwischen zwei Datenpunkte auf der X-Achse
  @override
  final double xSegmentWidth;
// Hilfsvariable zu xSegmentWidth, damit sie nicht jedesmal berechnet werden muss
  @override
  final double xSegementWidthHalf;

  @override
  String toString() {
    return 'ChartPainterMetadata(lineChartDataPointsByColumnIndex: $lineChartDataPointsByColumnIndex, barChartDataPointsByColumnIndex: $barChartDataPointsByColumnIndex, allDateTimeXAxisValues: $allDateTimeXAxisValues, allDataPointValues: $allDataPointValues, maxDataPointValue: $maxDataPointValue, minDataPointValue: $minDataPointValue, maxAbsoluteValueCount: $maxAbsoluteValueCount, yAxisMaxValue: $yAxisMaxValue, yAxisMinValue: $yAxisMinValue, yAxisSteps: $yAxisSteps, layoutWidth: $layoutWidth, layoutHeight: $layoutHeight, canvasWidth: $canvasWidth, canvasHeight: $canvasHeight, chartWidth: $chartWidth, chartHeight: $chartHeight, xSegmentWidth: $xSegmentWidth, xSegementWidthHalf: $xSegementWidthHalf)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartPainterMetadataImpl &&
            const DeepCollectionEquality().equals(
                other._lineChartDataPointsByColumnIndex,
                _lineChartDataPointsByColumnIndex) &&
            const DeepCollectionEquality().equals(
                other._barChartDataPointsByColumnIndex,
                _barChartDataPointsByColumnIndex) &&
            const DeepCollectionEquality().equals(
                other._allDateTimeXAxisValues, _allDateTimeXAxisValues) &&
            const DeepCollectionEquality()
                .equals(other._allDataPointValues, _allDataPointValues) &&
            (identical(other.maxDataPointValue, maxDataPointValue) ||
                other.maxDataPointValue == maxDataPointValue) &&
            (identical(other.minDataPointValue, minDataPointValue) ||
                other.minDataPointValue == minDataPointValue) &&
            (identical(other.maxAbsoluteValueCount, maxAbsoluteValueCount) ||
                other.maxAbsoluteValueCount == maxAbsoluteValueCount) &&
            (identical(other.yAxisMaxValue, yAxisMaxValue) ||
                other.yAxisMaxValue == yAxisMaxValue) &&
            (identical(other.yAxisMinValue, yAxisMinValue) ||
                other.yAxisMinValue == yAxisMinValue) &&
            (identical(other.yAxisSteps, yAxisSteps) ||
                other.yAxisSteps == yAxisSteps) &&
            (identical(other.layoutWidth, layoutWidth) ||
                other.layoutWidth == layoutWidth) &&
            (identical(other.layoutHeight, layoutHeight) ||
                other.layoutHeight == layoutHeight) &&
            (identical(other.canvasWidth, canvasWidth) ||
                other.canvasWidth == canvasWidth) &&
            (identical(other.canvasHeight, canvasHeight) ||
                other.canvasHeight == canvasHeight) &&
            (identical(other.chartWidth, chartWidth) ||
                other.chartWidth == chartWidth) &&
            (identical(other.chartHeight, chartHeight) ||
                other.chartHeight == chartHeight) &&
            (identical(other.xSegmentWidth, xSegmentWidth) ||
                other.xSegmentWidth == xSegmentWidth) &&
            (identical(other.xSegementWidthHalf, xSegementWidthHalf) ||
                other.xSegementWidthHalf == xSegementWidthHalf));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lineChartDataPointsByColumnIndex),
      const DeepCollectionEquality().hash(_barChartDataPointsByColumnIndex),
      const DeepCollectionEquality().hash(_allDateTimeXAxisValues),
      const DeepCollectionEquality().hash(_allDataPointValues),
      maxDataPointValue,
      minDataPointValue,
      maxAbsoluteValueCount,
      yAxisMaxValue,
      yAxisMinValue,
      yAxisSteps,
      layoutWidth,
      layoutHeight,
      canvasWidth,
      canvasHeight,
      chartWidth,
      chartHeight,
      xSegmentWidth,
      xSegementWidthHalf);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartPainterMetadataImplCopyWith<_$ChartPainterMetadataImpl>
      get copyWith =>
          __$$ChartPainterMetadataImplCopyWithImpl<_$ChartPainterMetadataImpl>(
              this, _$identity);
}

abstract class _ChartPainterMetadata implements ChartPainterMetadata {
  const factory _ChartPainterMetadata(
      {required final Map<int, List<CooLineChartDataPoint>>
          lineChartDataPointsByColumnIndex,
      required final Map<int, List<CooBarChartDataPoint>>
          barChartDataPointsByColumnIndex,
      required final List<DateTime> allDateTimeXAxisValues,
      required final Set<double> allDataPointValues,
      required final double maxDataPointValue,
      required final double minDataPointValue,
      required final int maxAbsoluteValueCount,
      required final double yAxisMaxValue,
      required final double yAxisMinValue,
      required final double yAxisSteps,
      required final double layoutWidth,
      required final double layoutHeight,
      required final double canvasWidth,
      required final double canvasHeight,
      required final double chartWidth,
      required final double chartHeight,
      required final double xSegmentWidth,
      required final double xSegementWidthHalf}) = _$ChartPainterMetadataImpl;

  @override // All sich auf diesem Index befindenden LineChart Datenpunkte
// Die exakte Punkt (X,Y) eines LineChart DataPoint Objekts müsste man in Verbidung dises Objektes noch in einem
// eigenen Objekt halten. Dann könnte man auch den nächstgelegenen Punkt zum Maus Pointer herausfinden
  Map<int, List<CooLineChartDataPoint>> get lineChartDataPointsByColumnIndex;
  @override
  Map<int, List<CooBarChartDataPoint>> get barChartDataPointsByColumnIndex;
  @override

  /// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
  /// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
  List<DateTime> get allDateTimeXAxisValues;
  @override

  /// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
  /// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
  Set<double> get allDataPointValues;
  @override // Größter Datenpunktwert aller gegbenen Datenpunkt
  double get maxDataPointValue;
  @override // Kleinster Datenpunktwert aller gegbenen Datenpunkt
  double get minDataPointValue;
  @override // Anzahl aller gegebener Punkt auf dem x-Achsenwert
  int get maxAbsoluteValueCount;
  @override

  /// Y-Achse maximale Label-Wert
  double get yAxisMaxValue;
  @override

  /// Y-Achse kleinster Label-Wert
  double get yAxisMinValue;
  @override

  /// Größe des "Pixel-Steps" zwischen zwie y-Achse Labelpunkten
  /// Wird zum Berechnen der Datenpunkte für das malen auf dem Canvas benötigt
  double get yAxisSteps;
  @override

  /// Layout Attributes
  /// The width and height of the constraints
  double get layoutWidth;
  @override
  double get layoutHeight;
  @override

  /// The height of the given canvas
  double get canvasWidth;
  @override
  double get canvasHeight;
  @override

  /// calculated height of painted chart
  double get chartWidth;
  @override
  double get chartHeight;
  @override // Abstand zwischen zwei Datenpunkte auf der X-Achse
  double get xSegmentWidth;
  @override // Hilfsvariable zu xSegmentWidth, damit sie nicht jedesmal berechnet werden muss
  double get xSegementWidthHalf;
  @override
  @JsonKey(ignore: true)
  _$$ChartPainterMetadataImplCopyWith<_$ChartPainterMetadataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
