/// Welchen Datentyp hat die X-Achse?
enum XAxisValueType {
  number, // Einfache Durchnummerierung 1,2,3.. (es kann ein Startwert angegeben werden)
  datetime, // Datum mit Zeitangabe -> Es werden auch die Millisekunden beachtet
  date, // Datum ohne Zeitangabe -> Die Zeit wird nicht beachtet und für die X-Achse Bestimmung gecleart.
}
