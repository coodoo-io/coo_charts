// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coo_chart_color_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CooChartTheme {
  /// The color of the complete chart painter
  Color get backgroundColor => throw _privateConstructorUsedError;

  /// If the chart is scrollable the background of the labels can be configured as transparent gradient
  /// Default is not transperant.
  bool get labelBackgroundTransparentGradient =>
      throw _privateConstructorUsedError;

  /// The color of the outer chart canvas background
  Color get chartBackgroundColor => throw _privateConstructorUsedError;

  /// The color of the outer border lines
  Color get chartBorderColor => throw _privateConstructorUsedError;

  /// y- and x-axis label color
  Color get labelColor => throw _privateConstructorUsedError;

  /// y- and x-axis label font size
  double get labelFontSize => throw _privateConstructorUsedError;

  /// y- and x-axis label textStyle. If given the label color and font size is not used
  TextStyle? get labelTextStyle => throw _privateConstructorUsedError;

  /// The color of the inner grid lines
  Color get gridColor => throw _privateConstructorUsedError;
  Color get dataPointColor => throw _privateConstructorUsedError;
  Color get dataPointHighlightColor => throw _privateConstructorUsedError;
  Color get columnHighlightColor => throw _privateConstructorUsedError;

  /// bar chart colors
  Color get barColor => throw _privateConstructorUsedError;
  Color get barColorHighlight => throw _privateConstructorUsedError;

  /// Min- Max range is available in barchart and linechart. Define the color of this line.
  Color get minMaxRangeColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CooChartThemeCopyWith<CooChartTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CooChartThemeCopyWith<$Res> {
  factory $CooChartThemeCopyWith(
          CooChartTheme value, $Res Function(CooChartTheme) then) =
      _$CooChartThemeCopyWithImpl<$Res, CooChartTheme>;
  @useResult
  $Res call(
      {Color backgroundColor,
      bool labelBackgroundTransparentGradient,
      Color chartBackgroundColor,
      Color chartBorderColor,
      Color labelColor,
      double labelFontSize,
      TextStyle? labelTextStyle,
      Color gridColor,
      Color dataPointColor,
      Color dataPointHighlightColor,
      Color columnHighlightColor,
      Color barColor,
      Color barColorHighlight,
      Color minMaxRangeColor});
}

/// @nodoc
class _$CooChartThemeCopyWithImpl<$Res, $Val extends CooChartTheme>
    implements $CooChartThemeCopyWith<$Res> {
  _$CooChartThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? labelBackgroundTransparentGradient = null,
    Object? chartBackgroundColor = null,
    Object? chartBorderColor = null,
    Object? labelColor = null,
    Object? labelFontSize = null,
    Object? labelTextStyle = freezed,
    Object? gridColor = null,
    Object? dataPointColor = null,
    Object? dataPointHighlightColor = null,
    Object? columnHighlightColor = null,
    Object? barColor = null,
    Object? barColorHighlight = null,
    Object? minMaxRangeColor = null,
  }) {
    return _then(_value.copyWith(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      labelBackgroundTransparentGradient: null ==
              labelBackgroundTransparentGradient
          ? _value.labelBackgroundTransparentGradient
          : labelBackgroundTransparentGradient // ignore: cast_nullable_to_non_nullable
              as bool,
      chartBackgroundColor: null == chartBackgroundColor
          ? _value.chartBackgroundColor
          : chartBackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      chartBorderColor: null == chartBorderColor
          ? _value.chartBorderColor
          : chartBorderColor // ignore: cast_nullable_to_non_nullable
              as Color,
      labelColor: null == labelColor
          ? _value.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as Color,
      labelFontSize: null == labelFontSize
          ? _value.labelFontSize
          : labelFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      labelTextStyle: freezed == labelTextStyle
          ? _value.labelTextStyle
          : labelTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyle?,
      gridColor: null == gridColor
          ? _value.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      dataPointColor: null == dataPointColor
          ? _value.dataPointColor
          : dataPointColor // ignore: cast_nullable_to_non_nullable
              as Color,
      dataPointHighlightColor: null == dataPointHighlightColor
          ? _value.dataPointHighlightColor
          : dataPointHighlightColor // ignore: cast_nullable_to_non_nullable
              as Color,
      columnHighlightColor: null == columnHighlightColor
          ? _value.columnHighlightColor
          : columnHighlightColor // ignore: cast_nullable_to_non_nullable
              as Color,
      barColor: null == barColor
          ? _value.barColor
          : barColor // ignore: cast_nullable_to_non_nullable
              as Color,
      barColorHighlight: null == barColorHighlight
          ? _value.barColorHighlight
          : barColorHighlight // ignore: cast_nullable_to_non_nullable
              as Color,
      minMaxRangeColor: null == minMaxRangeColor
          ? _value.minMaxRangeColor
          : minMaxRangeColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CooChartThemeImplCopyWith<$Res>
    implements $CooChartThemeCopyWith<$Res> {
  factory _$$CooChartThemeImplCopyWith(
          _$CooChartThemeImpl value, $Res Function(_$CooChartThemeImpl) then) =
      __$$CooChartThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Color backgroundColor,
      bool labelBackgroundTransparentGradient,
      Color chartBackgroundColor,
      Color chartBorderColor,
      Color labelColor,
      double labelFontSize,
      TextStyle? labelTextStyle,
      Color gridColor,
      Color dataPointColor,
      Color dataPointHighlightColor,
      Color columnHighlightColor,
      Color barColor,
      Color barColorHighlight,
      Color minMaxRangeColor});
}

/// @nodoc
class __$$CooChartThemeImplCopyWithImpl<$Res>
    extends _$CooChartThemeCopyWithImpl<$Res, _$CooChartThemeImpl>
    implements _$$CooChartThemeImplCopyWith<$Res> {
  __$$CooChartThemeImplCopyWithImpl(
      _$CooChartThemeImpl _value, $Res Function(_$CooChartThemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? labelBackgroundTransparentGradient = null,
    Object? chartBackgroundColor = null,
    Object? chartBorderColor = null,
    Object? labelColor = null,
    Object? labelFontSize = null,
    Object? labelTextStyle = freezed,
    Object? gridColor = null,
    Object? dataPointColor = null,
    Object? dataPointHighlightColor = null,
    Object? columnHighlightColor = null,
    Object? barColor = null,
    Object? barColorHighlight = null,
    Object? minMaxRangeColor = null,
  }) {
    return _then(_$CooChartThemeImpl(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      labelBackgroundTransparentGradient: null ==
              labelBackgroundTransparentGradient
          ? _value.labelBackgroundTransparentGradient
          : labelBackgroundTransparentGradient // ignore: cast_nullable_to_non_nullable
              as bool,
      chartBackgroundColor: null == chartBackgroundColor
          ? _value.chartBackgroundColor
          : chartBackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      chartBorderColor: null == chartBorderColor
          ? _value.chartBorderColor
          : chartBorderColor // ignore: cast_nullable_to_non_nullable
              as Color,
      labelColor: null == labelColor
          ? _value.labelColor
          : labelColor // ignore: cast_nullable_to_non_nullable
              as Color,
      labelFontSize: null == labelFontSize
          ? _value.labelFontSize
          : labelFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      labelTextStyle: freezed == labelTextStyle
          ? _value.labelTextStyle
          : labelTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyle?,
      gridColor: null == gridColor
          ? _value.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      dataPointColor: null == dataPointColor
          ? _value.dataPointColor
          : dataPointColor // ignore: cast_nullable_to_non_nullable
              as Color,
      dataPointHighlightColor: null == dataPointHighlightColor
          ? _value.dataPointHighlightColor
          : dataPointHighlightColor // ignore: cast_nullable_to_non_nullable
              as Color,
      columnHighlightColor: null == columnHighlightColor
          ? _value.columnHighlightColor
          : columnHighlightColor // ignore: cast_nullable_to_non_nullable
              as Color,
      barColor: null == barColor
          ? _value.barColor
          : barColor // ignore: cast_nullable_to_non_nullable
              as Color,
      barColorHighlight: null == barColorHighlight
          ? _value.barColorHighlight
          : barColorHighlight // ignore: cast_nullable_to_non_nullable
              as Color,
      minMaxRangeColor: null == minMaxRangeColor
          ? _value.minMaxRangeColor
          : minMaxRangeColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$CooChartThemeImpl implements _CooChartTheme {
  const _$CooChartThemeImpl(
      {required this.backgroundColor,
      this.labelBackgroundTransparentGradient = false,
      required this.chartBackgroundColor,
      required this.chartBorderColor,
      required this.labelColor,
      required this.labelFontSize,
      this.labelTextStyle,
      required this.gridColor,
      required this.dataPointColor,
      required this.dataPointHighlightColor,
      required this.columnHighlightColor,
      required this.barColor,
      required this.barColorHighlight,
      required this.minMaxRangeColor});

  /// The color of the complete chart painter
  @override
  final Color backgroundColor;

  /// If the chart is scrollable the background of the labels can be configured as transparent gradient
  /// Default is not transperant.
  @override
  @JsonKey()
  final bool labelBackgroundTransparentGradient;

  /// The color of the outer chart canvas background
  @override
  final Color chartBackgroundColor;

  /// The color of the outer border lines
  @override
  final Color chartBorderColor;

  /// y- and x-axis label color
  @override
  final Color labelColor;

  /// y- and x-axis label font size
  @override
  final double labelFontSize;

  /// y- and x-axis label textStyle. If given the label color and font size is not used
  @override
  final TextStyle? labelTextStyle;

  /// The color of the inner grid lines
  @override
  final Color gridColor;
  @override
  final Color dataPointColor;
  @override
  final Color dataPointHighlightColor;
  @override
  final Color columnHighlightColor;

  /// bar chart colors
  @override
  final Color barColor;
  @override
  final Color barColorHighlight;

  /// Min- Max range is available in barchart and linechart. Define the color of this line.
  @override
  final Color minMaxRangeColor;

  @override
  String toString() {
    return 'CooChartTheme(backgroundColor: $backgroundColor, labelBackgroundTransparentGradient: $labelBackgroundTransparentGradient, chartBackgroundColor: $chartBackgroundColor, chartBorderColor: $chartBorderColor, labelColor: $labelColor, labelFontSize: $labelFontSize, labelTextStyle: $labelTextStyle, gridColor: $gridColor, dataPointColor: $dataPointColor, dataPointHighlightColor: $dataPointHighlightColor, columnHighlightColor: $columnHighlightColor, barColor: $barColor, barColorHighlight: $barColorHighlight, minMaxRangeColor: $minMaxRangeColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CooChartThemeImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.labelBackgroundTransparentGradient,
                    labelBackgroundTransparentGradient) ||
                other.labelBackgroundTransparentGradient ==
                    labelBackgroundTransparentGradient) &&
            (identical(other.chartBackgroundColor, chartBackgroundColor) ||
                other.chartBackgroundColor == chartBackgroundColor) &&
            (identical(other.chartBorderColor, chartBorderColor) ||
                other.chartBorderColor == chartBorderColor) &&
            (identical(other.labelColor, labelColor) ||
                other.labelColor == labelColor) &&
            (identical(other.labelFontSize, labelFontSize) ||
                other.labelFontSize == labelFontSize) &&
            (identical(other.labelTextStyle, labelTextStyle) ||
                other.labelTextStyle == labelTextStyle) &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.dataPointColor, dataPointColor) ||
                other.dataPointColor == dataPointColor) &&
            (identical(
                    other.dataPointHighlightColor, dataPointHighlightColor) ||
                other.dataPointHighlightColor == dataPointHighlightColor) &&
            (identical(other.columnHighlightColor, columnHighlightColor) ||
                other.columnHighlightColor == columnHighlightColor) &&
            (identical(other.barColor, barColor) ||
                other.barColor == barColor) &&
            (identical(other.barColorHighlight, barColorHighlight) ||
                other.barColorHighlight == barColorHighlight) &&
            (identical(other.minMaxRangeColor, minMaxRangeColor) ||
                other.minMaxRangeColor == minMaxRangeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      labelBackgroundTransparentGradient,
      chartBackgroundColor,
      chartBorderColor,
      labelColor,
      labelFontSize,
      labelTextStyle,
      gridColor,
      dataPointColor,
      dataPointHighlightColor,
      columnHighlightColor,
      barColor,
      barColorHighlight,
      minMaxRangeColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CooChartThemeImplCopyWith<_$CooChartThemeImpl> get copyWith =>
      __$$CooChartThemeImplCopyWithImpl<_$CooChartThemeImpl>(this, _$identity);
}

abstract class _CooChartTheme implements CooChartTheme {
  const factory _CooChartTheme(
      {required final Color backgroundColor,
      final bool labelBackgroundTransparentGradient,
      required final Color chartBackgroundColor,
      required final Color chartBorderColor,
      required final Color labelColor,
      required final double labelFontSize,
      final TextStyle? labelTextStyle,
      required final Color gridColor,
      required final Color dataPointColor,
      required final Color dataPointHighlightColor,
      required final Color columnHighlightColor,
      required final Color barColor,
      required final Color barColorHighlight,
      required final Color minMaxRangeColor}) = _$CooChartThemeImpl;

  @override

  /// The color of the complete chart painter
  Color get backgroundColor;
  @override

  /// If the chart is scrollable the background of the labels can be configured as transparent gradient
  /// Default is not transperant.
  bool get labelBackgroundTransparentGradient;
  @override

  /// The color of the outer chart canvas background
  Color get chartBackgroundColor;
  @override

  /// The color of the outer border lines
  Color get chartBorderColor;
  @override

  /// y- and x-axis label color
  Color get labelColor;
  @override

  /// y- and x-axis label font size
  double get labelFontSize;
  @override

  /// y- and x-axis label textStyle. If given the label color and font size is not used
  TextStyle? get labelTextStyle;
  @override

  /// The color of the inner grid lines
  Color get gridColor;
  @override
  Color get dataPointColor;
  @override
  Color get dataPointHighlightColor;
  @override
  Color get columnHighlightColor;
  @override

  /// bar chart colors
  Color get barColor;
  @override
  Color get barColorHighlight;
  @override

  /// Min- Max range is available in barchart and linechart. Define the color of this line.
  Color get minMaxRangeColor;
  @override
  @JsonKey(ignore: true)
  _$$CooChartThemeImplCopyWith<_$CooChartThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
