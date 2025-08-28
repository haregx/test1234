void main() {

  List<String> words = ['reger', 'otto', 'hansDampf'];
  for (String word in words) {
    print('Die Länge von $word ist: ${getLength(word)}');
  }
}


int getLength(String text) {
  return text.length;
}