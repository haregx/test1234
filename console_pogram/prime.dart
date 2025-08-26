import 'dart:io';

void main() {
  print('Primfaktorzerlegung');
  int number = readInt('Gib eine positive ganze Zahl ein: ');
  if (number < 2) {
    print('Die Zahl muss mindestens 2 sein.');
    return;
  }
  List<int> factors = primeFactors(number);
  if (factors.length > 1) {
    print('Primfaktorzerlegung von $number: ${factors.join(' × ')}');
  }
  else {
    print('$number ist eine Primzahl.');
  }
}

List<int> primeFactors(int n) {
  List<int> result = [];
  int divisor = 2;
  while (n > 1) {
    while (n % divisor == 0) {
      result.add(divisor);
      n ~/= divisor;
    }
    divisor++;
    if (divisor * divisor > n && n > 1) {
      result.add(n);
      break;
    }
  }
  return result;
}

int readInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input == null) {
      print('Eingabe erforderlich!');
      continue;
    }
    int? value = int.tryParse(input);
    if (value == null || value < 1) {
      print('Ungültige Eingabe, bitte eine positive ganze Zahl eingeben!');
      continue;
    }
    return value;
  }
}
