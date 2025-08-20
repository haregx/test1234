// für fehlende Werte wird 0 verwendet und fließt NICHT in die Berechnung des Durchschnitts ein

void main() {
  // Liste hat garantiert immer 3 Elemente
  List<Map<String, double?>> weatherData = [
    {'temp': 5.3, 'rain': 0.9, 'wind': null},
    {'temp': 4.5, 'rain': null, 'wind': 16.8},
    {'temp': null, 'rain': 3.8, 'wind': null},
  ];

  // Erstelle leere Liste für Temperaturen
  List<double?> temps = [];
  
  // Füge die Temperaturen der Wetterdaten in die Liste ein
  temps.add(weatherData[0]['temp'] ?? 0);
  temps.add(weatherData[1]['temp'] ?? 0);
  temps.add(weatherData[2]['temp'] ?? 0);

  int validTempCount = 0;
  validTempCount += weatherData[0]['temp'] != null ? 1 : 0;
  validTempCount += weatherData[1]['temp'] != null ? 1 : 0;
  validTempCount += weatherData[2]['temp'] != null ? 1 : 0;

  double avgTemp = ((temps[0] ?? 0) + (temps[1] ?? 0) + (temps[2] ?? 0));
  if (validTempCount == 0) {
    print('Es lagen keinerlei gültigen Temperaturwerte vor.');
  } else {
    avgTemp /= validTempCount;
    print('Durchschnittstemperatur: ${avgTemp.toStringAsFixed(1)} °C');
    print('Es lagen für ${weatherData.length - validTempCount} von ${weatherData.length} Tage keine Werte vor.');
  }
}
