void main() {
  List<int> points = [4, 5, 4, 2, 6, 6, 3];
  List<String> names = ['Julietta', 'Benjamino', 'Hans-Günther', 'Evaline', 'Fiona', 'Gregory', 'Leonhart'];

  for (String name in names) {
    print('Name: $name');
  }

  double average = 0;
  for (int point in points) {
    average += point;
  }
  average /= points.length;
  print('Durchschnitt Punkte über alle Benutzer: ${average.toStringAsFixed(1)}');

  /////////////////////
  // oder besser
  /////////////////////
  double average1 = points.reduce((a, b) => a + b) / points.length;
  print('Durchschnitt Punkte über alle Benutzer: ${average1.toStringAsFixed(1)}');
}
