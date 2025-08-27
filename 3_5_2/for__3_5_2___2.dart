void main() {

  List<String> words = ['reger', 'otto', 'hansDampf'];
  for (String word in words) {
    triplePrint(word);
  }
}


void triplePrint(String text) {
  for (int i = 1; i <= 3; i++) {
    print('$i -> $text');
  }
}