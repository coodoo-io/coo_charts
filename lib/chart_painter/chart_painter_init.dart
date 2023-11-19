import 'dart:math';

import 'package:coo_charts/chart_painter/chart_painter_metadata.dart';
import 'package:coo_charts/chart_painter/coo_chart_painter_util.dart';
import 'package:coo_charts/common/chart_config.dart';
import 'package:coo_charts/common/chart_padding.enum.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_point.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart_data_series.dart';

/// Initialisiert alle notwendigen Daten um sie anschließend in einem Chart malen zu können.
class ChartPainterInit {
  static ChartPainterMetadata initializeValues({
    required ChartConfig chartConfig,
    required XAxisConfig xAxisConfig,
    required YAxisConfig yAxisConfig,
    required List<CooLineChartDataSeries> linechartDataSeries,
    required List<CooBarChartDataSeries> barchartDataSeries,
    required double canvasWidth,
    required double canvasHeight,
    required ChartPadding padding,
  }) {
    // Prüfen ob der erste Wert ein double ist, falls ja und wenn nicht padding eingebaut werden soll sind die Steps
    // double Werte. Sind es nur int Values als erste Werte werden immer ints als Range angeben.
    bool firstIsADoubleValue = false;

    // Min und Max-Werte sind mit 0 initialisiert.
    // Damit das Ermitteln korrekt funktioniert werden zwei Flags benötigt um zu initial den ersten Wert zu seten.
    bool minValueSet = false;
    bool maxValueSet = true;

    Set<double> allDataPointValues = {};
    double maxDataPointValue = 0;
    double yAxisMaxValue = 0;
    double minDataPointValue = 0;
    double yAxisMinValue = 0;

    double yAxisSteps = 0;

    for (var linechartDataSerie in linechartDataSeries) {
      {
        // Alle Datenwerte  prüfen
        List<double> notNulValues = [];

        List<double?> values = linechartDataSerie.dataPoints.map((e) => e.value).toList();
        for (var val in values) {
          if (val != null) {
            notNulValues.add(val);
          }
        }
        if (notNulValues.isEmpty) {
          continue;
        }
        allDataPointValues.addAll(notNulValues);

        // check first
        if (!firstIsADoubleValue && notNulValues[0] % 1 != 0) {
          firstIsADoubleValue = true;
        }

        // Min- und Max-Value herausfinden (Nulls beachten und ignorieren)
        final maxValueTmp = notNulValues.cast<double>().reduce(max);
        if (!maxValueSet || maxDataPointValue < maxValueTmp) {
          maxDataPointValue = maxValueTmp;
          yAxisMaxValue = maxValueTmp;
          maxValueSet = true;
        }
        final minValueTmp = notNulValues.cast<double>().reduce(min);
        if (!minValueSet || minDataPointValue > minValueTmp) {
          minDataPointValue = minValueTmp;
          yAxisMinValue = minValueTmp;
          minValueSet = true;
        }
      }

      // Prüfen ob die Max-Werte eines Punktes anezeigt werden sollen.
      // Falls ja, muss dieser als Max-Wert
      if (linechartDataSerie.showMinMaxArea) {
        // Max aus den Punkten der range max Daten
        List<double?> maxValues = linechartDataSerie.dataPoints.map((e) => e.maxValue).toList();
        maxValues.removeWhere((element) => element == null);

        if (maxValues.isNotEmpty) {
          final maxValuesMax = maxValues.cast<double>().reduce(max);
          if (maxDataPointValue < maxValuesMax) {
            maxDataPointValue = maxValuesMax;
            yAxisMaxValue = maxValuesMax;
          }
        }

        // Max aus den Punkten der range max Daten
        List<double?> minValues = linechartDataSerie.dataPoints.map((e) => e.minValue).toList();
        minValues.removeWhere((element) => element == null);

        if (minValues.isNotEmpty) {
          final minValuesMin = minValues.cast<double>().reduce(min);
          if (minDataPointValue > minValuesMin) {
            minDataPointValue = minValuesMin;
            yAxisMinValue = minValuesMin;
          }
        }
      }
    }

    // Barchart Min-Max-Werte
    for (var barchartDataSerie in barchartDataSeries) {
      {
        // Alle Datenwerte  prüfen
        List<double?> values = barchartDataSerie.dataPoints.map((e) => e.value).toList();
        values.removeWhere((element) => element == null);

        if (values.isEmpty) {
          continue;
        }

        // check first
        if (!firstIsADoubleValue && values[0]! % 1 != 0) {
          firstIsADoubleValue = true;
        }

        // Min- und Max-Value herausfinden (Nulls beachten und ignorieren)
        final maxValueTmp = values.cast<double>().reduce(max);
        if (maxDataPointValue < maxValueTmp) {
          maxDataPointValue = maxValueTmp;
          yAxisMaxValue = maxValueTmp;
        }
        final minValueTmp = values.cast<double>().reduce(min);
        if (minDataPointValue > minValueTmp) {
          minDataPointValue = minValueTmp;
          yAxisMinValue = minValueTmp;
        }
      }
    }

    // Bevor der zu vewendente Label Count berechnet wird, dem vom User gewählten setzen
    int yAxisLabelCount = CooChartPainterUtil.getYAxisLabelCount(yAxisConfig);

    // Soll unter- und oberhalb der Linie etwas Platz eingerechnet werden?
    if (yAxisConfig.addValuePadding) {
      // Liegt kein Wert unterhalb von 0 und ist die Differenz zu 0 im Vergleich zum Max -> obere Grenze kleiner,
      // wird unten immer bei 0 in der Y-Achsen-Skala angefangen
      var orgStep = ((maxDataPointValue - minDataPointValue) / (yAxisLabelCount));

      var maxValueInt = (maxDataPointValue + (orgStep)).toInt();
      var minValueInt = (minDataPointValue - (orgStep)).toInt();
      int diff = maxValueInt - minValueInt;
      // tmpStep wird benötigt um Puffer zu addieren. Man könnte auch 10% vom Range nehmen..
      var tmpStep = ((diff / yAxisLabelCount) + 1).toInt();

      if (yAxisConfig.minLabelValue != null && yAxisConfig.minLabelValue! < minDataPointValue) {
        yAxisMinValue = yAxisConfig.minLabelValue!;
      } else {
        yAxisMinValue = minValueInt.toDouble();

        // Wenn kein Wert unter 0 vorhanden ist kann Min auf 0 gesetzt werden
        // Für den Betrachter optisch besser.
        if (minDataPointValue >= 0 && yAxisMinValue < 0) {
          yAxisMinValue = 0;
        }
      }

      if (yAxisConfig.maxLabelValue != null && yAxisConfig.maxLabelValue! > maxDataPointValue) {
        yAxisMaxValue = yAxisConfig.maxLabelValue!;
      } else {
        // Der max-Value muss aus den ermittelten Steps berechnet werden
        yAxisMaxValue = yAxisMinValue + (tmpStep * (yAxisLabelCount - 1));

        // Manchmal kommt es vor, dass die Ermittlung des Puffers und des Steps zu gering ist
        // In diesem Fall muss die Step-Größe um eins erhöht werden um das max zu ermitteln
        if (yAxisMaxValue <= maxDataPointValue) {
          tmpStep += 1;
          yAxisMaxValue = yAxisMinValue + (tmpStep * (yAxisLabelCount - 1));
        }
      }

      // Jetzt die Stepgröße nochmal berechnen
      yAxisSteps = ((yAxisMaxValue - yAxisMinValue) / (yAxisLabelCount - 1));

      // Die Stepgröße soll ein int sein um keine krummen Zahlen auf der Y-Achse zu bekommen
      if (yAxisSteps % 1 != 0) {
        yAxisSteps = (yAxisSteps + 1).toInt().toDouble();
        yAxisMaxValue = yAxisMinValue + (yAxisSteps * (yAxisLabelCount - 1));
      }
    } else {
      // Der niedrigste Datenpunkt soll unten direkt auf der X-Achse liegen. Kein Puffer dazwischenrechnen
      if (yAxisLabelCount < 0) {
        // Es ist kein Labecount vom User gesetzt -> jeder Punkt bekommt eine Linie
        yAxisLabelCount = allDataPointValues.length;
      }
      yAxisSteps = (allDataPointValues.length / yAxisLabelCount);

      yAxisMaxValue = yAxisMinValue + (yAxisSteps * (yAxisLabelCount - 1));

      if (yAxisSteps != 1) {
        // Sonderfall: wenn zwischen min und Max die anzahl an möglichen Skalierungspunkten als ganze Zahlen
        // verwendet werden können, dann bekommt max oben ein bisschen padding
        var scalePotential = maxDataPointValue / yAxisLabelCount;
        if (scalePotential > 0) {
          yAxisSteps = (scalePotential + 1).toInt().toDouble();
          yAxisMaxValue = yAxisMinValue + (yAxisSteps * (yAxisLabelCount - 1));
        }
      }
    }

    // Initialisierung anhand des übergebenen Datentyps.
    // Reihen die ein Datum als Wert haben werden anders bewerted
    int maxAbsoluteValueCount = 0;
    Map<int, List<CooBarChartDataPoint>> barChartDataPointsByColumnIndex = {};
    Map<int, List<CooLineChartDataPoint>> lineChartDataPointsByColumnIndex = {};
    List<DateTime> allDateTimeXAxisValues = [];
    switch (xAxisConfig.valueType) {
      // Initialisiert die Rahmendaten anhand DateTime Serien
      // - Sortiert alle DateTime Datenpunkte und
      // - Findet die absolute (Data-Series übergreifende) Menge an Datenpunkte heraus
      case XAxisValueType.date:
      case XAxisValueType.datetime:
        {
          Set<DateTime> allDateTimesTmp = {}; // Alle Dates einmal speichern (doppelte herausfiltern)

          for (var dataSeries in linechartDataSeries) {
            List<DateTime?> allDateTimeValues = dataSeries.dataPoints.map((e) => e.time).toList();

            // // Null Values entfernen, darf eigetnlich nicht vorkommen, denn dann müsste man die Stelle berechnen
            allDateTimeValues.removeWhere((element) => element == null);
            allDateTimeValues.sort((a, b) => a!.compareTo(b!));

            for (var dt in allDateTimeValues) {
              allDateTimesTmp.add(dt!);
            }

            for (var i = 0; i < dataSeries.dataPoints.length; i++) {
              CooLineChartDataPoint dataPoint = dataSeries.dataPoints[i];
              if (lineChartDataPointsByColumnIndex[i] == null) {
                lineChartDataPointsByColumnIndex[i] = [];
              }
              lineChartDataPointsByColumnIndex[i]!.add(dataPoint);
            }
          }

          // Barchart

          for (var dataSeries in barchartDataSeries) {
            List<DateTime?> allDateTimeValues = dataSeries.dataPoints.map((e) => e.time).toList();

            // // Null Values entfernen, darf eigetnlich nicht vorkommen, denn dann müsste man die Stelle berechnen
            allDateTimeValues.removeWhere((element) => element == null);
            allDateTimeValues.sort((a, b) => a!.compareTo(b!));

            allDateTimeValuesLoop:
            for (var dt in allDateTimeValues) {
              if (dt == null) {
                continue allDateTimeValuesLoop;
              }
              DateTime cleandDateTime;
              switch (xAxisConfig.valueType) {
                case XAxisValueType.date:
                  // Stunde, Minute und MS werden nicht beachtet
                  cleandDateTime = dt.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
                  break;
                case XAxisValueType.datetime:
                  cleandDateTime = dt.copyWith(microsecond: 0);
                  break;
                default:
                  cleandDateTime = dt;
              }
              allDateTimesTmp.add(cleandDateTime);
            }

            for (var i = 0; i < dataSeries.dataPoints.length; i++) {
              CooBarChartDataPoint dataPoint = dataSeries.dataPoints[i];
              if (barChartDataPointsByColumnIndex[i] == null) {
                barChartDataPointsByColumnIndex[i] = [];
              }
              barChartDataPointsByColumnIndex[i]!.add(dataPoint);
            }
          }

          // Die absolute Anzahl an Datenpunkten ist die Länge des Sets
          maxAbsoluteValueCount = allDateTimesTmp.length;

          // Alle Datenpunkte in eine sortierte Liste packen
          allDateTimeXAxisValues.addAll(allDateTimesTmp);
          allDateTimeXAxisValues.sort((a, b) => a.compareTo(b));
        }

      // Initialisiert die Rahmendaten anhand der übergebenen Werte numerisch
      default:
        {
          for (var dataSeries in linechartDataSeries) {
            if (dataSeries.dataPoints.length > maxAbsoluteValueCount) {
              maxAbsoluteValueCount = dataSeries.dataPoints.length;
            }

            for (var i = 0; i < dataSeries.dataPoints.length; i++) {
              CooLineChartDataPoint dataPoint = dataSeries.dataPoints[i];
              if (lineChartDataPointsByColumnIndex[i] == null) {
                lineChartDataPointsByColumnIndex[i] = [];
              }
              lineChartDataPointsByColumnIndex[i]!.add(dataPoint);
            }
          }
        }
    }

    // Festlegen wie viel Breite zwischen zwei Datenpunkten liegen kann
    double chartWidth = canvasWidth - padding.left - padding.right;
    double chartHeight = canvasHeight - padding.bottom - padding.top;
    double xSegmentWidth;
    if (!chartConfig.centerDataPointBetweenVerticalGrid) {
      // Es sind die Punkte links und rechts auf der Y-Achse verfügbar
      // Der erste Datenpunkt liegt direkt auf der Y-Achse
      xSegmentWidth = chartWidth / (maxAbsoluteValueCount - 1);
    } else {
      // Hier liegen die Punkte zwischen den Linien in der MItte
      xSegmentWidth = chartWidth / maxAbsoluteValueCount;
    }

    return ChartPainterMetadata(
      lineChartDataPointsByColumnIndex: lineChartDataPointsByColumnIndex,
      barChartDataPointsByColumnIndex: barChartDataPointsByColumnIndex,
      allDataPointValues: allDataPointValues,
      allDateTimeXAxisValues: allDateTimeXAxisValues,
      maxDataPointValue: maxDataPointValue,
      minDataPointValue: minDataPointValue,
      maxAbsoluteValueCount: maxAbsoluteValueCount,
      yAxisSteps: yAxisSteps,
      yAxisMaxValue: yAxisMaxValue,
      yAxisMinValue: yAxisMinValue,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      chartWidth: chartWidth,
      chartHeight: chartHeight,
      xSegmentWidth: xSegmentWidth,
      xSegementWidthHalf: xSegmentWidth / 2,
    );
  }
}
