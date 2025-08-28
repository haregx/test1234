void main() {

  List<String> words = ['reger', 'Otto Waalkes', 'Hans Dampf in allen Gassen'];
  for (String word in words) {
    print('Die Anzahl an Vokalen in $word ist: ${calcVocals(word)}');
    print('Die Anzahl an Vokalen in $word ist: ${calcAlternative(word)}');
  }
}


int calcVocals(String text) {
  int count = 0;
  for (int i = 0; i < text.length; i++) {
    if ('aeiou'.contains(text[i].toLowerCase())) {
      count++;
    }
  }
  return count;
}

// und jetzt mal ein Code mit switch, falls wird contains nicht hatten...

int calcAlternative(String text) {
  int count = 0;
  for (int i = 0; i < text.length; i++) {
    switch (text[i].toLowerCase()) {
      case 'a':
      case 'e':
      case 'i':
      case 'o':
      case 'u':
        count++;
        break;
    }
  }
  return count;
}
  