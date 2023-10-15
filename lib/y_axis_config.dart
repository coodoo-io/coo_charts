/// Alle möglichen Konfigurationen, die direkten Bezug auf die Y-Achse haben.
class YAxisConfig {
  const YAxisConfig({
    this.labelCount = 5,
    this.minLabelValue,
    this.maxLabelValue,
    this.addValuePadding = true,
    this.showYAxisLables = true,
    this.showAxis = true,
    this.labelPostfix,
  });

  /// Shoud the y-axis be printed. Default is true
  final bool showAxis;

  /// Defines whether labels on the y-axis are shown or not.
  /// Default is [true]
  final bool showYAxisLables;

  // Anzahl Labels auf der Y-Achse. Es werden die hier konfigurierte Anzahl Labels für die Bezeichner der Y-Achse
  // angezeigt. Dabei werden die Werte zwischen Min- und Max-Werten berechnet.
  final int labelCount;

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
}
