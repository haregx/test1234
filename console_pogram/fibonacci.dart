import 'dart:io';

void main() {

  print('##############################################');
  print('Fibonacci-Folge 1 bis X und das Verhältnis');
  print('zw. zwei aufeinanderfolgender Zahlen');
  print('##############################################');

  bool inputValid =  false;
  int value = 0;

  // Input validation
  while (!inputValid) {
    print('Geben eine Zahl zwischen 30 und 50 ein:');
    String? input = stdin.readLineSync();
    if (input != null && int.tryParse(input) != null) {
      value = int.tryParse(input) ?? -1;
      if (value >= 30 && value <= 50) {
        inputValid = true;
      } else {
        print('');
        print('Die Zahl $value liegt nicht zwischen 30 und 50.');
        print('');
      }
    } else {
      print('');
      print('Deine Eingabe war ungültig.');
      print('');

    }
  }

  // Generate Fibonacci sequence
  List<int> fibonacci = [0, 1];
  for (int i = 1; i < value; i++) {
    fibonacci.add(fibonacci[i] + fibonacci[i - 1]);
  }


  print('##############################################');
  // Print Fibonacci sequence and ratios
  print ('F(0) = ${fibonacci[0]}');
  for (int i = 1; i < fibonacci.length; i++) {
    if (i==1) {
      print('F(${i}) = ${fibonacci[i]} | Verhältnis zu F(0): --------');
    }
    else {
      double ratio = fibonacci[i] / fibonacci[i - 1];
      print('F(${i}) = ${fibonacci[i]} | Verhältnis zu F(${i-1}): ${ratio.toStringAsFixed(8)}');
    }
  }

  print('##############################################');
  print('Große Preisfrage:');
  print('Das Verhältnis zwischen zwei aufeinanderfolgender'); 
  print('Zahlen einer Fibonacci-Folge nähert sich welchem Wert an?');
  print('##############################################');
  print('');
  print('1. Euler-Zahl (e)');
  print('2. Goldener Schnitt');
  print('3. Phi (φ)');
  print('4. pi (π)');
  print('');

  print('Gebe als Antwort die Zahl ein, die du für richtig hältst.');
  String? answer = stdin.readLineSync();
  if (answer != null && int.tryParse(answer) != null) {
    int answerValue = int.tryParse(answer) ?? -1;
    if (answerValue >= 1 && answerValue <= 4) {
      if (answerValue == 2) {
        print('Richtig! Der Goldene Schnitt ist die Lösung.');
      } else {
        print('Leider falsch. Die richtige Antwort ist der Goldene Schnitt.');
      }
    } else {
      print('Ungültige Antwort. Bitte gib eine Zahl zwischen 1 und 4 ein.');
    }
  } else {
    print('Ungültige Eingabe. Bitte gib eine Zahl zwischen 1 und 4 ein.');
  }

}
