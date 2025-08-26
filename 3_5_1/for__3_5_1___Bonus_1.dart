void main() {

  String word = "reger";  
  bool isPalindrom = true;

  // Bei einer ungeraden Anzahl an Zeichen ist das genau mittlere Zeichen irrelevant
  // Setze isPalindrom auf false und breche ab bei einen Unterschied.
  for (int i = 0; i < word.length ~/ 2; i++) {
    if (word[i] != word[word.length - 1 - i]) {
      isPalindrom = false;
      break;
    }
  }

  if (isPalindrom) {
    print('$word ist ein Palindrom');
  } else {
    print('$word ist kein Palindrom');
  }
}
