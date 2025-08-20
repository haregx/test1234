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
  List<double?> rain = [];
  List<double?> wind = [];

  // Füge die Temperaturen der Wetterdaten in die Liste ein
  temps.add(weatherData[0]['temp'] ?? 0);
  temps.add(weatherData[1]['temp'] ?? 0);
  temps.add(weatherData[2]['temp'] ?? 0);

  // Füge die Niederschlagswerte der Wetterdaten in die Liste ein
  rain.add(weatherData[0]['rain'] ?? 0);
  rain.add(weatherData[1]['rain'] ?? 0);
  rain.add(weatherData[2]['rain'] ?? 0);

  // Füge die Windgeschwindigkeiten der Wetterdaten in die Liste ein
  wind.add(weatherData[0]['wind'] ?? 0);
  wind.add(weatherData[1]['wind'] ?? 0);
  wind.add(weatherData[2]['wind'] ?? 0);

  int validTempCount = 0;
  validTempCount += weatherData[0]['temp'] != null ? 1 : 0;
  validTempCount += weatherData[1]['temp'] != null ? 1 : 0;
  validTempCount += weatherData[2]['temp'] != null ? 1 : 0;

  int validRainCount = 0;
  validRainCount += weatherData[0]['rain'] != null ? 1 : 0;
  validRainCount += weatherData[1]['rain'] != null ? 1 : 0;
  validRainCount += weatherData[2]['rain'] != null ? 1 : 0;

  int validWindCount = 0;
  validWindCount += weatherData[0]['wind'] != null ? 1 : 0;
  validWindCount += weatherData[1]['wind'] != null ? 1 : 0;
  validWindCount += weatherData[2]['wind'] != null ? 1 : 0;

  double avgTemp = ((temps[0] ?? 0) + (temps[1] ?? 0) + (temps[2] ?? 0));
  if (validTempCount == 0) {
    print('Es lagen keinerlei gültigen Temperaturwerte vor.');
  } else {
    avgTemp /= validTempCount;
    print('Durchschnittstemperatur: ${avgTemp.toStringAsFixed(1)} °C');
    print('Es lagen für ${weatherData.length - validTempCount} von ${weatherData.length} Tage keine Werte für die Temperatur vor.');
  }

  double avgRain = ((rain[0] ?? 0) + (rain[1] ?? 0) + (rain[2] ?? 0));
  if (validRainCount == 0) {
    print('Es lagen keinerlei gültigen Niederschlagswerte vor.');
  } else {
    avgRain /= validRainCount;
    print('Durchschnittlicher Niederschlag: ${avgRain.toStringAsFixed(1)} mm');
    print('Es lagen für ${weatherData.length - validRainCount} von ${weatherData.length} Tage keine Werte für den Niederschlag vor.');
  }

  double avgWind = ((wind[0] ?? 0) + (wind[1] ?? 0) + (wind[2] ?? 0));
  if (validWindCount == 0) {
    print('Es lagen keinerlei gültigen Windwerte vor.');
  } else {
    avgWind /= validWindCount;
    print('Durchschnittliche Windgeschwindigkeit: ${avgWind.toStringAsFixed(1)} km/h');
    print('Es lagen für ${weatherData.length - validWindCount} von ${weatherData.length} Tage keine Werte für den Wind vor.');
  }
}
