void main() {

  List<String> words = ['Reger', 'Otto Waalkes', 'Hans Dampf in allen Gassen'];
  List<String> characters = ['a', 'b', 'o', 'w', 'r'];

  for (var element in words) {
    for (var char in characters) {
      print('Die Anzahl an $char in $element ist: ${calcCharsInWord(element, char)}');
    }
  }

}

int calcCharsInWord(String word, String character) {
  int count = 0;
  for (int i = 0; i < word.length; i++) {
    if (word[i].toLowerCase() == character) {
      count++;
    }
  }
  return count;
}



