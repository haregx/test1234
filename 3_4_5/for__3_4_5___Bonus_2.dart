void main() {
  List<int> points = [4, 5, 4, 2, 6, 6, 3];
  List<String> names = ['Julietta', 'Benjamino', 'Hans-Günther', 'Evaline', 'Fiona', 'Gregory', 'Leonhart'];

  Map<String, int> nameToPoints = Map.fromIterables(names, points);

  for(String name in nameToPoints.keys) {
    print('Name: $name');
  }
  print('');
  for (int points in nameToPoints.values) {
    print('Punkte: $points');
  }
  print('');
  for (MapEntry<String, int> entry in nameToPoints.entries) {
    print('Name: ${entry.key}, Punkte: ${entry.value}');
  }
}
