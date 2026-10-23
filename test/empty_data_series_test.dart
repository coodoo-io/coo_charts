import 'package:coo_charts/common/blocks/chart_column_blocks.dart';
import 'package:coo_charts/common/x_axis_config.dart';
import 'package:coo_charts/common/x_axis_value_type.enum.dart';
import 'package:coo_charts/common/y_axis_config.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_point.dart';
import 'package:coo_charts/coo_bar_chart/coo_bar_chart_data_series.dart';
import 'package:coo_charts/coo_line_chart/coo_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Ohne Datenreihen gibt es keine Spalten. Das Diagramm muss trotzdem Rahmen,
// Achsen und Raster zeichnen können, etwa wenn ein Nutzer alle Datenreihen
// abgewählt hat — und darf dabei weder werfen noch Taps melden.
void main() {
  const yAxisConfig = YAxisConfig(
    labelCount: 3,
    minLabelValue: 0,
    maxLabelValue: 10,
  );

  Widget wrap(Widget chart) => MaterialApp(
    home: Center(child: SizedBox(width: 300, height: 300, child: chart)),
  );

  ChartColumnBlocks emptyColumnBlocks() =>
      ChartColumnBlocks(showTopBlocks: true, showBottomBlocks: true);

  for (final valueType in XAxisValueType.values) {
    final xAxisConfig = XAxisConfig(
      valueType: valueType,
      labelBottomPostfix: 'Uhr',
    );

    testWidgets('CooBarChart ohne Datenreihen ($valueType)', (tester) async {
      final taps = <int>[];
      await tester.pumpWidget(
        wrap(
          CooBarChart(
            dataSeries: const [],
            columnBlocks: emptyColumnBlocks(),
            xAxisConfig: xAxisConfig,
            yAxisConfig: yAxisConfig,
            onDataPointTab: (index, _) => taps.add(index),
          ),
        ),
      );
      await tester.tap(find.byType(CooBarChart));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(taps, isEmpty);
    });

    testWidgets('CooLineChart ohne Datenreihen ($valueType)', (tester) async {
      final taps = <int>[];
      await tester.pumpWidget(
        wrap(
          CooLineChart(
            dataSeries: const [],
            columnBlocks: emptyColumnBlocks(),
            xAxisConfig: xAxisConfig,
            yAxisConfig: yAxisConfig,
            onDataPointTab: (index, _) => taps.add(index),
          ),
        ),
      );
      await tester.tap(find.byType(CooLineChart));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(taps, isEmpty);
    });
  }

  testWidgets('CooBarChart mit Daten meldet Taps weiterhin', (tester) async {
    final taps = <int>[];
    await tester.pumpWidget(
      wrap(
        CooBarChart(
          dataSeries: [
            CooBarChartDataSeries(
              dataPoints: [
                CooBarChartDataPoint(value: 3, time: DateTime(2026, 10, 23)),
              ],
            ),
          ],
          xAxisConfig: const XAxisConfig(valueType: XAxisValueType.date),
          yAxisConfig: yAxisConfig,
          onDataPointTab: (index, _) => taps.add(index),
        ),
      ),
    );
    await tester.tap(find.byType(CooBarChart));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(taps, [0]);
  });
}
