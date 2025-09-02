
import 'dart:io';

String clear = '\x1B[2J\x1B[H'; 

String red = '\x1B[31m';
String green = '\x1B[32m';
String blue = '\x1B[34m';
String yellow = '\x1B[33m';
String reset = '\x1B[0m';

String bold = '\x1B[1m';
String italic = '\x1B[3m';
String underline = '\x1B[4m';
String strike = '\x1B[9m';

String redBackground = '\x1B[41m';

String reverse = '\x1B[7m';

void main() {
  Map<String, String> vocabulary = {
   // 'Hund': 'dog',
   // 'Katze': 'cat',
   // 'Vogel': 'bird'
  };

  stdout.write(clear);
  stdout.writeln('');
  // German <> English dictionary
  stdout.writeln('${underline}${bold}Deutsch -> Englisch Wörterbuch${reset}');

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
        startQuiz(vocabulary);
        break;
      case '3':
        // Goodbye message
        stdout.writeln('${blue}Auf Wiedersehen!${reset}');
        return;
      default:
        // Invalid input message
        stdout.writeln('${red}${bold}Ungültige Eingabe${reset}${red}, bitte versuche es erneut.${reset}');
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
  if (word != null && word.trim().isNotEmpty && translation != null && translation.trim().isNotEmpty) {
    if (!vocabulary.containsKey(word.trim())) {
      vocabulary[word.trim()] = translation.trim();
      // Vocabulary added
      stdout.writeln('Vokabel hinzugefügt: ${word.trim()} - ${translation.trim()}');
    } else {
      stdout.writeln('${red}Das Wort ${bold}${word.trim()}${reset} ${red}ist bereits im Wörterbuch.${reset}');
    }
  } else {
    stdout.writeln('${red}Ungültige Eingabe, bitte versuche es erneut.${reset}');
  }
}

/**
 * starts a quiz
 */
void startQuiz(Map<String, String> vocabulary) {
  // If no vocabulary is available
  if (vocabulary.isEmpty) {
    stdout.writeln('${redBackground}${yellow}Keine Vokabeln für ein Quiz verfügbar.${reset}');
    return;
  }
  int correct = 0;
  int incorrect = 0;
  // Shuffle the vocabulary keys for random order
  var keys = vocabulary.keys.toList()..shuffle();
  for (var word in keys) {
    // Ask for the translation
    stdout.write('Was ist die Übersetzung von ${blue}${bold}$word${reset}? % ');
    String? answer = stdin.readLineSync();
    if (answer != null && vocabulary[word] != null && answer.toLowerCase() == vocabulary[word]!.toLowerCase()) {
      // Correct answer
      stdout.writeln('${green}${reverse}Richtig!${reset}');
      correct++;
    } else {
      // Wrong answer, show correct one
      stdout.writeln('${red}${reverse}Falsch!${reset} Die richtige Übersetzung von ${blue}${bold}$word${reset} ist: ${blue}${bold}${vocabulary[word]}${reset}');
      incorrect++;
    }
  }
  // Calculate total and percentage
  int total = correct + incorrect;
  double percent = total > 0 ? (correct / total * 100) : 0;
  // Show result
  stdout.writeln('');
  stdout.writeln('${blue}Ergebnis: $correct richtig, $incorrect falsch (${percent.toStringAsFixed(2)}% richtig)${reset}');
}

