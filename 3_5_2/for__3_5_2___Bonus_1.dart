void main() {

  List<int> minutes = [12,67,334,1343];

  for (int i = 0; i < minutes.length; i++) {
    convertMinutesToTime(minutes[i]);
  }
}


void convertMinutesToTime(int minutes) {
  print('$minutes Minuten sind ${minutes ~/ 60} Stunden und ${minutes % 60} Minuten.');
}