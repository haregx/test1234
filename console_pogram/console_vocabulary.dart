
import 'dart:io';

String red = '\x1B[31m';
String green = '\x1B[32m';
String blue = '\x1B[34m';
String yellow = '\x1B[33m';
String colReset = '\x1B[0m';

void main() {
  Map<String, String> vocabulary = {
    'Hund': 'dog',
    'Katze': 'cat',
    'Vogel': 'bird'
  };

  stdout.writeln('');
  // German <> English dictionary
  stdout.writeln('Deutsch -> Englisch Wörterbuch');

  while (true) {
    stdout.writeln('');
  // 1. Add a new vocabulary
  // 2. Quiz
  // 3. Exit
  stdout.writeln('1. Füge eine neue Vokabel hinzu');
  stdout.writeln('2. Quiz');
  stdout.writeln('3. Beenden');
  stdout.writeln('');
  // Please choose an option [1-3]
  stdout.write('Bitte wähle eine Option [1-3] % ');
  // read user input
  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      addWord(vocabulary);
      break;
      case '2':
        quiz(vocabulary);
        break;
      case '3':
        // Goodbye message
        stdout.writeln('${blue}Auf Wiedersehen!${colReset}');
        return;
      default:
        // Invalid input message
        stdout.writeln('${red}Ungültige Eingabe, bitte versuche es erneut.${colReset}');
    }
  }
}

/**
 * adds a new vocabulary
 */
void addWord(Map<String, String> vocabulary) {
  // Enter the word
  stdout.write('Gib das Wort ein: ');
  String? word = stdin.readLineSync();
  // Enter the translation
  stdout.write('Gib die Übersetzung ein: ');
  String? translation = stdin.readLineSync();
  if (word != null && word.isNotEmpty && translation != null && translation.isNotEmpty) {
    if (!vocabulary.containsKey(word)) {
      vocabulary[word] = translation;
      // Vocabulary added
      stdout.writeln('Vokabel hinzugefügt: $word - $translation');
    } else {
      stdout.writeln('${red}Das Wort "$word" ist bereits im Wörterbuch.${colReset}');
    }
  } else {
    stdout.writeln('${red}Ungültige Eingabe, bitte versuche es erneut.${colReset}');
  }
}

/**
 * starts a quiz
 */
void quiz(Map<String, String> vocabulary) {
  // If no vocabulary is available
  if (vocabulary.isEmpty) {
    stdout.writeln('${red}Keine Vokabeln für ein Quiz verfügbar.${colReset}');
    return;
  }
  int correct = 0;
  int incorrect = 0;
  // Shuffle the vocabulary keys for random order
  var keys = vocabulary.keys.toList()..shuffle();
  for (var word in keys) {
    // Ask for the translation
    stdout.write('Was ist die Übersetzung von "$word"? % ');
    String? answer = stdin.readLineSync();
    if (answer == vocabulary[word]) {
      // Correct answer
      stdout.writeln('${green}Richtig!${colReset}');
      correct++;
    } else {
      // Wrong answer, show correct one
      stdout.writeln('${red}Falsch! Die richtige Übersetzung von "$word" ist: ${green}${vocabulary[word]}${colReset}');
      incorrect++;
    }
  }
  // Calculate total and percentage
  int total = correct + incorrect;
  double percent = total > 0 ? (correct / total * 100) : 0;
  // Show result
  stdout.writeln('');
  stdout.writeln('${blue}Ergebnis: $correct richtig, $incorrect falsch ($percent% richtig)${colReset}');
}