import 'dart:io';
import 'dart:math';

void main() {
  stdout.writeln('');
  stdout.writeln('\x1B[34m####################################################\x1B[0m');
  stdout.writeln('\x1B[34m###    Ich kaufe mir ein Auto - Kreditplaner     ###\x1B[0m');
  stdout.writeln('\x1B[34m####################################################\x1B[0m');

  do {
    stdout.writeln('');
    double loanAmount = readDouble('Kreditsumme (Euro)');
    double interestRatePerYearNominal = readDouble('Jährlicher Kreditzins [nominal](%)');
    double monthlyRate = readDouble('Gewünschte monatliche fixe Rate (Euro)');

    // nominal interest rate per month
    double interestRatePerMonthNominal = interestRatePerYearNominal / 100 / 12;

    // minimum monthly rate
    double minMonthlyRate = interestRatePerMonthNominal * loanAmount;

    // effektive interest rate per year
    double interestRatePerYearEffectiv =
        pow(1 + interestRatePerMonthNominal, 12) - 1;

    stdout.writeln('');
    stdout.writeln('\x1B[34m####################################################\x1B[0m');
    stdout.writeln('\x1B[34m###                   Tilgungsplan               ###\x1B[0m');
    stdout.writeln('\x1B[34m####################################################\x1B[0m');
    stdout.writeln('\x1B[34m######## Kreditsumme:            ${loanAmount.toStringAsFixed(2)} Euro\x1B[0m');
    stdout.writeln('\x1B[34m######## Effektiver Jahreszins:  ${(interestRatePerYearEffectiv * 100).toStringAsFixed(2)} %\x1B[0m');
    stdout.writeln('\x1B[34m######## Monatliche Rate:        ${monthlyRate.toStringAsFixed(2)} Euro\x1B[0m');
    stdout.writeln('\x1B[34m####################################################\x1B[0m');


    // Check if the monthly rate is sufficient
    while (minMonthlyRate > monthlyRate) {
      stdout.writeln('');
      stdout.writeln('\x1B[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\x1B[0m');
      stdout.writeln('\x1B[31m!!! Die monatliche Rate ist zu niedrig, um den Kredit zu tilgen. !!!!\x1B[0m');
      stdout.writeln('\x1B[31m!!! Die monatliche Rate muss mehr als ${(minMonthlyRate).toStringAsFixed(2)} Euro betragen.\x1B[0m');
      stdout.writeln('\x1B[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\x1B[0m');
      stdout.writeln('');
      monthlyRate = readDouble('Gewünschte monatliche fixe Rate (Euro)');
      stdout.writeln('');
    }

    // sumTotal stands for the total amount paid over the entire loan period.
    double sumTotal = 0;

    // monthsCounter counts the number of months until the loan is fully repaid.
    int monthsCounter = 0;

    // restDebt represents the remaining debt that still needs to be repaid.
    double restDebt = loanAmount;

    // Calculate the repayment plan
    while (restDebt > 0) {
      monthsCounter++;
      double interest = restDebt * interestRatePerMonthNominal;
      double principal = monthlyRate - interest < restDebt
          ? (monthlyRate - interest)
          : restDebt;
      restDebt -= principal;
      sumTotal += interest + principal;
      stdout.writeln(
        '### Monat $monthsCounter: \t' +
            'Rate: ${(interest + principal).toStringAsFixed(2)} \t' +
            'davon Zinsen: ${interest.toStringAsFixed(2)} Euro \t' +
            'davon Tilgung: ${principal.toStringAsFixed(2)} Euro \t' +
            'Restschuld: ${restDebt.toStringAsFixed(2)} Euro',
      );
    }

    stdout.writeln('\x1B[34m####################################################\x1B[0m');
    stdout.writeln('\x1B[34m######## Laufzeit:                ${monthsCounter ~/ 12} Jahre ${monthsCounter % 12} Monate\x1B[0m');
    stdout.writeln('\x1B[34m######## Gesamt bezahlter Betrag: ${sumTotal.toStringAsFixed(2)} EUR\x1B[0m');
    stdout.writeln('\x1B[34m######## Davon Zinsen:            ${(sumTotal - loanAmount).toStringAsFixed(2)} EUR\x1B[0m');
    stdout.writeln('\x1B[34m####################################################\x1B[0m');
    stdout.writeln('');
    stdout.write('Möchtest du eine neue Berechnung durchführen? (j/n) % ');
  } while (stdin.readLineSync()?.toLowerCase() == 'j');
}

/**
 * Read a double value from the standard input.
 */
double readDouble(String prompt) {
  while (true) {
    stdout.write('$prompt % ');
    String? input = stdin.readLineSync();
    if (input == null) {
      stdout.writeln('\x1B[31m*** Eingabe erforderlich! ***\x1B[0m');
      continue;
    }
    double? value = double.tryParse(input.replaceAll(',', '.'));
    if (value == null || value <= 0.0) {
      stdout.writeln('\x1B[31m*** Ungültige Eingabe, bitte eine positive Zahl eingeben! ***\x1B[0m');
      continue;
    }
    return value;
  }
}
