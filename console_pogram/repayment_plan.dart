import 'dart:io';
import 'dart:math';

void main() {
  print('');
  print('####################################################');
  print('###    Ich kaufe mir ein Auto - Kreditplaner     ###');
  print('####################################################');
  double loanAmount = readDouble('Kreditsumme (Euro): ');
  double interestRatePerYearNominal = readDouble('Jährlicher Kreditzins [nominal](%): ');
  double monthlyRate = readDouble('Gewünschte monatliche fixe Rate (Euro): ');


  // nominal interest rate per month
  double interestRatePerMonthNominal = interestRatePerYearNominal / 100 / 12;

  // minimum monthly rate
  double minMonthlyRate = interestRatePerMonthNominal * loanAmount;

  // effektive interest rate per year
  double interestRatePerYearEffectiv = pow(1 + interestRatePerMonthNominal, 12) - 1;


  print('');
  print('####################################################');
  print('###                   Tilgungsplan               ###');
  print('####################################################');
  print ('######## Kreditsumme:           ${loanAmount.toStringAsFixed(2)} Euro');
  print ('######## Effektiver Jahreszins: ${(interestRatePerYearEffectiv * 100).toStringAsFixed(2)} %');
  print ('######## Monatlliche Rate:      ${monthlyRate.toStringAsFixed(2)} Euro');
  print('####################################################');


  // Check if the monthly rate is sufficient
  if (minMonthlyRate > monthlyRate) {
    print('');
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    print('!!! Die monatliche Rate ist zu niedrig, um den Kredit zu tilgen.');
    print('!!! Die monatliche Rate muss mehr als ${(minMonthlyRate).toStringAsFixed(2)} Euro betragen.');
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    return;
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
    double principal = monthlyRate - interest < restDebt ? (monthlyRate - interest) : restDebt;
    restDebt -= principal;
    sumTotal += interest + principal;
    print('### Monat $monthsCounter:\tZinsen: ${interest.toStringAsFixed(2)} Euro,\tTilgung: ${principal.toStringAsFixed(2)} Euro,\tRestschuld: ${restDebt.toStringAsFixed(2)} Euro');
  }

  print('####################################################');
  print ('######## Laufzeit:                ${monthsCounter ~/ 12} Jahre ${monthsCounter % 12} Monate');
  print ('######## Gesamt bezahlter Betrag: ${sumTotal.toStringAsFixed(2)} EUR');
  print ('######## Davon Zinsen:            ${(sumTotal - loanAmount).toStringAsFixed(2)} EUR');
  print('####################################################');

}

/**
 * Read a double value from the standard input.
 */
double readDouble(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input == null) {
      print('Eingabe erforderlich!');
      continue;
    }
    double? value = double.tryParse(input.replaceAll(',', '.'));
    if (value == null || value <= 0.0) {
      print('*** Ungültige Eingabe, bitte eine positive Zahl eingeben! ***');
      continue;
    }
    return value;
  }
}

/**
 * Read an integer value from the standard input.
 */
int readInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input == null) {
      print('Eingabe erforderlich!');
      continue;
    }
    int? value = int.tryParse(input);
    if (value == null || value <= 0) {
      print('*** Ungültige Eingabe, bitte eine positive ganze Zahl eingeben! ***');
      continue;
    }
    return value;
  }
}

