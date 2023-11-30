// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Alle möglichen Konfigurationen, die direkten Bezug auf die Y-Achse haben.
class YAxisConfig {
  const YAxisConfig({
    this.showAxis = true,
    this.showYAxisLables = true,
    this.labelCount,
    this.minLabelValue,
    this.maxLabelValue,
    this.addValuePadding = true,
    this.labelPostfix,
    this.showAboveGrid = false,
  });

  /// Shoud the y-axis be printed. Default is true
  final bool showAxis;

  /// Defines whether labels on the y-axis are shown or not.
  /// Default is [true]
  final bool showYAxisLables;

  // Anzahl Labels auf der Y-Achse. Es werden die hier konfigurierte Anzahl Labels für die Bezeichner der Y-Achse
  // angezeigt. Dabei werden die Werte zwischen Min- und Max-Werten berechnet.
  final int? labelCount;

  /// Welcher ist das kleinste Label, der angezeigt werden soll?
  /// Wenn null wird dieses Label berechnet.
  final double? minLabelValue;

  /// Was ist der größte Label der, der angezeigt werden soll?
  /// Wenn null wird dieses Label berechnet.
  final double? maxLabelValue;

  /// Soll von dem kleinsten Wert zur X-Achse ein Abstand einberechnet werden?
  /// Wenn true, dann wird das Min- und Max der Y-Achse automatisch berechnet.
  /// Wenn false, wird das Chart von den Grenzen gezeichnet. Es startet dann unten auf der Base-Line mit
  /// dem niedrigsten Wert und endet Oben mit dem Max-Wert.
  final bool addValuePadding;

  /// This text will added to every label on y-axis
  /// e.g. '°C' -> '2 °C', '4 °C', '6 °C' ...
  /// or 'cm' -> '2 cm', '4 cm', '6 cm'
  final String? labelPostfix;

  /// If set to true the y-labels will be viewed above the grid, not next to the chart-canvas.
  final bool showAboveGrid;

  YAxisConfig copyWith({
    bool? showAxis,
    bool? showYAxisLables,
    int? labelCount,
    double? minLabelValue,
    double? maxLabelValue,
    bool? addValuePadding,
    String? labelPostfix,
  }) {
    return YAxisConfig(
      showAxis: showAxis ?? this.showAxis,
      showYAxisLables: showYAxisLables ?? this.showYAxisLables,
      labelCount: labelCount ?? this.labelCount,
      minLabelValue: minLabelValue ?? this.minLabelValue,
      maxLabelValue: maxLabelValue ?? this.maxLabelValue,
      addValuePadding: addValuePadding ?? this.addValuePadding,
      labelPostfix: labelPostfix ?? this.labelPostfix,
    );
  }
}
