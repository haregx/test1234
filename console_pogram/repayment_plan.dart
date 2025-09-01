import 'dart:io';
import 'dart:math';

String red = '\x1B[31m';
String green = '\x1B[32m';
String blue = '\x1B[34m';
String yellow = '\x1B[33m';
String colReset = '\x1B[0m';

void main() {

  stdout.writeln('');
  stdout.writeln('${blue}####################################################${colReset}');
  stdout.writeln('${blue}###    Ich kaufe mir ein Auto - Kreditplaner     ###${colReset}');
  stdout.writeln('${blue}####################################################${colReset}');

  do {
    // read user input
    stdout.writeln('');
    double loanAmount = readDouble('Kreditsumme (Euro)');
    double interestRatePerYearNominal = readDouble('Jährlicher Kreditzins [nominal](%)');
    double monthlyRate = readDouble('Gewünschte monatliche fixe Rate (Euro)');

    // nominal interest rate per month
    double interestRatePerDayNominal = interestRatePerYearNominal / 100 / 360;

    // effektive interest rate per year
    double interestRatePerYearEffectiv = pow(1 + interestRatePerDayNominal, 360) - 1;
    double interestRatePerMonthEffectiv = pow(1 + interestRatePerDayNominal, 30) - 1;

    // minimum monthly rate
    double minMonthlyRate = interestRatePerMonthEffectiv * loanAmount;  

    printPlan(loanAmount, interestRatePerYearEffectiv, monthlyRate);

   

    // Check if the monthly rate is sufficient
    while (minMonthlyRate > monthlyRate) {
      monthlyRate = reReadMonthlyRate(minMonthlyRate);
    }

    // pre settings
    // sumTotallyPaid stands for the total amount paid over the entire loan period.
    double sumTotallyPaid = 0;

    // monthsCounter counts the number of months until the loan is fully repaid.
    int monthsCounter = 0;

    // restDebt represents the remaining debt that still needs to be repaid.
    double restDebt = loanAmount;
    //////

    // Calculate the repayment plan
    while (restDebt > 0) {
      monthsCounter++;
      // Calculate interest and principal for the current month.
      double monthlyInterest = restDebt * interestRatePerMonthEffectiv;
      double monthlyPrincipal = monthlyRate - monthlyInterest < restDebt
          ? (monthlyRate - monthlyInterest)
          : restDebt;
      restDebt -= monthlyPrincipal;
      sumTotallyPaid += monthlyInterest + monthlyPrincipal;

      printMonthlyPayment(monthsCounter, monthlyInterest, monthlyPrincipal, restDebt);
    }
    ///////
    
    /// printing total payment
    printTotal(monthsCounter, loanAmount, sumTotallyPaid );
  } while (readInput('Möchtest du eine neue Berechnung durchführen? (J/n)'));
}





/**
 * Print the monthly payment.
 */
void printMonthlyPayment(int monthsCounter, double monthlyInterest, double monthlyPrincipal, double restDebt) {
  stdout.writeln(
    '### Monat $monthsCounter: \t' +
        '${blue}Rate: ${(monthlyInterest + monthlyPrincipal).toStringAsFixed(2)} Euro$colReset \t' +
        'davon ${red}Zinsen:  ${monthlyInterest.toStringAsFixed(2)} Euro$colReset [${(monthlyInterest / (monthlyInterest + monthlyPrincipal) * 100).toStringAsFixed(2)}%] \t' +
        'davon ${green}Tilgung: ${monthlyPrincipal.toStringAsFixed(2)} Euro$colReset [${(monthlyPrincipal / (monthlyInterest + monthlyPrincipal) * 100).toStringAsFixed(2)}%] \t' +
        '${yellow}Restschuld: ${restDebt.toStringAsFixed(2)} Euro$colReset',
  );
}


/**
 * Print the repayment plan.
 */
void printPlan(double loanAmount, double interestRatePerYearEffectiv, double monthlyRate) {
  stdout.writeln('');
  stdout.writeln('$blue####################################################$colReset');
  stdout.writeln('$blue###                   Tilgungsplan               ###$colReset');
  stdout.writeln('$blue####################################################$colReset');
  stdout.writeln('$blue######## Kreditsumme:            ${loanAmount.toStringAsFixed(2)} Euro$colReset');
  stdout.writeln('$blue######## Effektiver Jahreszins:  ${(interestRatePerYearEffectiv * 100).toStringAsFixed(2)} %$colReset');
  stdout.writeln('$blue######## Monatliche Rate:        ${monthlyRate.toStringAsFixed(2)} Euro$colReset');
  stdout.writeln('$blue####################################################$colReset');
  stdout.writeln('');
}



/**
 * Print the total payment.
 */
void printTotal(int monthsCounter, double loanAmount, double sumTotal) {
  stdout.writeln('');
  stdout.writeln('$blue####################################################$colReset');
  stdout.writeln('$blue######## Laufzeit:                ${monthsCounter ~/ 12} Jahre ${monthsCounter % 12} Monate$colReset');
  stdout.writeln('$blue######## Gesamt bezahlter Betrag: ${sumTotal.toStringAsFixed(2)} EUR$colReset');
  stdout.writeln('$red######## Davon Zinsen:            ${(sumTotal - loanAmount).toStringAsFixed(2)} EUR$colReset');
  stdout.writeln('$blue####################################################$colReset');
  stdout.writeln('');
}

/**
 * Read the monthly rate again if it's too low.
 */
double reReadMonthlyRate(double monthlyRate) {
  stdout.writeln('$red!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$colReset');
  stdout.writeln('$red!!! Die monatliche Rate ist zu niedrig, um den Kredit zu tilgen. !!!!$colReset');
  stdout.writeln('$red!!! Die monatliche Rate muss mehr als ${(monthlyRate).toStringAsFixed(2)} Euro betragen.$colReset');
  stdout.writeln('$red!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$colReset');
  stdout.writeln('');
  return readDouble('Gewünschte monatliche fixe Rate (Euro)');
}

/**
 * Read user input.
 */
bool readInput(String prompt) {
  stdout.write('$prompt % ');
  String input = stdin.readLineSync() ?? '';
  return input.isEmpty || input.toLowerCase() == 'j' || input.toLowerCase() == 'y';
}

/**
 * Read a double value from the standard input.
 */
double readDouble(String prompt) {
  while (true) {
    stdout.write('$prompt % ');
    String? input = stdin.readLineSync();
    if (input == null) {
      stdout.writeln('$red*** Eingabe erforderlich! ***$colReset');
      continue;
    }
    double? value = double.tryParse(input.replaceAll(',', '.'));
    if (value == null || value <= 0.0) {
      stdout.writeln('$red*** Ungültige Eingabe, bitte eine positive Zahl eingeben! ***$colReset');
      continue;
    }
    return value;
  }
}
