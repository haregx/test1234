void main() {

  String word = 'Leisure Suit Larry in the Land of the Lounge Lizards';
  List<String> characters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];


    List<String> foundChars = [];
    for (var char in characters) {
      if (isCharInWord(word, char)) {
        foundChars.add(char);
      }
    }
    print('Im Wort $word kommen die Buchstaben $foundChars vor.');
}

bool isCharInWord(String word, String character) {
  for (int i = 0; i < word.length; i++) {
    if (word[i].toLowerCase() == character) {
      return true;
    }
  }
  return false;
}
 
