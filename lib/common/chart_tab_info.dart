import 'package:flutter/material.dart';

// Hält im State die Infos über die Tab-Aktivität des Users ohne sie zu resetten wenn der Chart neu gemalt wird.
class ChartTabInfo {
  ChartTabInfo({
    this.tabDownDetails,
    this.tabCount = 0,
    this.tabCountCallbackInvocation = 0,
  });

  // Hält die Position des Tabs und wird für die Erkennung der Tab-Index-Spalte benötigt
  TapDownDetails? tabDownDetails;

  // Sicherstellen, dass auch die gleiche Tab-Index mehrfach aufgerufen werden kann
  // Aber dennoch nicht bei jedem MouseOver
  int tabCount; // Wird vom Widget hochgezählt, der den Tab abfängt
  int tabCountCallbackInvocation; // Wird vom Painter hochgezählt, der den Callback aufruft.
}
