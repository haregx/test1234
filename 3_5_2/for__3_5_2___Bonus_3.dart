void main() {

  List<int> numbers = [2, 1, 3, 4, 2, 6, 6, 6, 1 -4, 5];

  print ('---------------------------------------');
  print('--- Zahlen: $numbers');
  analyzeNumbers(numbers);
}


// Implementiere folgende Funktionen:
void findAndPrintExtreme(List<int> numbers) {
  // Findet und gibt kleinste und größte Zahl aus
  // Zeigt auch deren Position in der Liste
  int min = numbers[0];
  int max = numbers[0];
  int minIndex = 0;
  int maxIndex = 0;

  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
      minIndex = i;
    }
    if (numbers[i] > max) {
      max = numbers[i];
      maxIndex = i;
    }
  }

  // erstes Element soll die Pos 1 haben statt 0 
  print('--- Kleinste Zahl: $min (erste gefundene Position: ${minIndex + 1})');
  print('--- Größte Zahl: $max (erste gefundene Position: ${maxIndex + 1})');
}

void printNumberTypes(List<int> numbers) {
  // Zählt und gibt aus:
  // - Wie viele gerade/ungerade Zahlen
  // - Wie viele positive/negative Zahlen
  for (int number in numbers) {
     print('--- $number ist ${(number % 2 == 0) ? 'gerade' : 'ungerade'} und ${(number > 0) ? 'positiv / nicht-negativ' : 'negativ'}');
  }
}

void printDistribution(List<int> numbers) {
  // Gibt eine einfache Häufigkeitsverteilung aus
  // z.B. wie oft kommt jede Zahl vor
  Map<int, int> frequency = {};
  for (int n in numbers) {
    frequency[n] = (frequency[n] ?? 0) + 1;
  }
  frequency.forEach((key, value) {
    print('--- $key: ${value}x');
  });

  print ('--- Alternative Ausgabe ---');
  // oder
  for(var entry in frequency.entries) {
    print('--- ${entry.key}: ${entry.value}x');
  }

}

// Hauptfunktion:
void analyzeNumbers(List<int> numbers) {
      // Ruft alle Funktionen der Reihe nach auf
      // Gibt eine übersichtliche Gesamtanalyse
      print ('---------------------------------------');
      print ('--- findAndPrintExtreme(numbers) ------');
      print ('--- Zeige min und max mit Position ----');
      print ('---');
      findAndPrintExtreme(numbers);
      print ('---------------------------------------');
      print ('--- printNumberTypes(numbers)  --------');
      print ('--- Zeige ob gerade oder ungerade  ----');
      print ('---');
      printNumberTypes(numbers);
      print ('---------------------------------------');
      print ('--- printDistribution(numbers) --------');
      print ('--- Zeige Häufigkeitsverteilung -------');
      print ('---');
      printDistribution(numbers);
    print ('---------------------------------------');
}

