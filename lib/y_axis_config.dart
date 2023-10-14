/// Alle möglichen Konfigurationen, die direkten Bezug auf die Y-Achse haben.
class YAxisConfig {
  const YAxisConfig({
    this.labelCount = 5,
    this.minLabelValue,
    this.maxLabelValue,
    this.addValuePadding = true,
    this.showYAxisLables = true,
    this.showAxis = true,
  });

  /// Shoud the y-axis be printed. Default is true
  final bool showAxis;

  // Anzahl Labels auf der Y-Achse. Es werden die hier konfigurierte Anzahl Labels für die Bezeichner der Y-Achse
  // angezeigt. Dabei werden die Werte zwischen Min- und Max-Werten berechnet.
  final int labelCount; // TODO labelCount darf null sein, dann wird es automatisch berechnet

  /// Welcher ist das kleinste Label, der angezeigt werden soll?
  /// Wenn null wird dieses Label berechnet.
  // TODO minLabelValue Wert auslesen und verwenden
  final double? minLabelValue;

  /// Was ist der größte Label der, der angezeigt werden soll?
  /// Wenn null wird dieses Label berechnet.
  // TODO maxLabelValue Wert auslesen und verwenden
  final double? maxLabelValue;

  /// Soll von dem kleinsten Wert zur X-Achse ein Abstand einberechnet werden?
  /// Wenn true, dann wird das Min- und Max der Y-Achse automatisch berechnet.
  /// Wenn false, wird das Chart von den Grenzen gezeichnet. Es startet dann unten auf der Base-Line mit
  /// dem niedrigsten Wert und endet Oben mit dem Max-Wert.
  final bool addValuePadding;
  final bool showYAxisLables;
}
