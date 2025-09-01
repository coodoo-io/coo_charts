import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_painter_metadata.freezed.dart';

/// Alle von den Chartdaten abhängigen und berechneten Werte die für die Darstellung notwendig sind.

@freezed
class ChartPainterMetadata with _$ChartPainterMetadata {
  const factory ChartPainterMetadata({
    // All sich auf diesem Index befindenden LineChart Datenpunkte
    // Die exakte Punkt (X,Y) eines LineChart DataPoint Objekts müsste man in Verbidung dises Objektes noch in einem
    // eigenen Objekt halten. Dann könnte man auch den nächstgelegenen Punkt zum Maus Pointer herausfinden
    required Map<int, List<CooLineChartDataPoint>> lineChartDataPointsByColumnIndex,
    required Map<int, List<CooBarChartDataPoint>> barChartDataPointsByColumnIndex,

    // If there are datapoints wich are marked as opposite this flag will be true
    required bool hasOpposite,

    /// Falls die Datenreihe eine zeitlichen Verlauf hat werden hier alle DateTime Datenpunkte zeitlich sortiert
    /// gehalten. Es werden alle gegebenen Datenreihen analysiert und jeder Zeitpunkt nur einmal hinzugefügt.
    required List<DateTime> allDateTimeXAxisValues,

    /// Die Werte aller Datenreihen werden hier gehalten. Dabei werden alle gegebenen Datenreihen angesehen und jeder
    /// Wert exakt einmal in diesem Set gespeichrt. So kanne infach über alle vorkommenden Datenwerte iteriert werden.
    required Set<double> allDataPointValues,

    // Größter Datenpunktwert aller gegbenen Datenpunkt
    required double maxDataPointValue,

    // Kleinster Datenpunktwert aller gegbenen Datenpunkt
    required double minDataPointValue,

    // Anzahl aller gegebener Punkt auf dem x-Achsenwert
    required int maxAbsoluteValueCount,

    /// Y-Achse maximale Label-Wert
    required double yAxisMaxValue,

    /// Y-Achse kleinster Label-Wert
    required double yAxisMinValue,

    /// Größe des "Pixel-Steps" zwischen zwie y-Achse Labelpunkten
    /// Wird zum Berechnen der Datenpunkte für das malen auf dem Canvas benötigt
    required double yAxisSteps,

    /// Layout Attributes
    /// The width and height of the constraints
    required double layoutWidth,
    required double layoutHeight,

    /// The height of the given canvas
    required double canvasWidth,
    required double canvasHeight,

    /// calculated height of painted chart
    required double chartWidth,
    required double chartHeight,

    // Abstand zwischen zwei Datenpunkte auf der X-Achse
    required double xSegmentWidth,

    // Hilfsvariable zu xSegmentWidth, damit sie nicht jedesmal berechnet werden muss
    required double xSegementWidthHalf,

    /// Number of y-axis labels
    required int yAxisLabelCount,
  }) = _ChartPainterMetadata;
}
