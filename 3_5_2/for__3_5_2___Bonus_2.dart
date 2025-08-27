void main() {

  List<int> grades = [2, 1, 3, 4, 2, 6, 6, 6, 1];

  analyzeGrades(grades);
}


// Erstelle zwei Funktionen:
void printGrades(List<int> grades) {
  // Gibt alle Noten nacheinander aus
  for (int i = 0; i < grades.length; i++) {
    print('Note ${i + 1}: ${grades[i]}');
  }
}

void calculateAndPrintAverage(List<int> grades) {
  // Berechnet den Durchschnitt und gibt aus:
  double average = grades.reduce((a, b) => a + b) / grades.length;
  print('Der Durchschnitt ist: ${average.toStringAsFixed(1)}');
}

// Hauptfunktion:
void analyzeGrades(List<int> grades) {
  printGrades(grades);
  calculateAndPrintAverage(grades);
}