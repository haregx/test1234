// ignore_for_file: unnecessary_null_comparison

enum Sex { male, female }

void main() {

  Sex? sex;
  int? age;

  if (age == null) {
    print("Alter nicht angegeben");
    return;
  }
  switch (sex) {
    case Sex.male:
      switch (age) {
        case >= 20 && < 25:
        print("Im Schnitt 181,4m");
      case >= 25 && < 30:
        print("Im Schnitt 181,3m");
      case >= 30 && < 35:
        print("Im Schnitt 180,4m");
      default:
        print("Unbekannte Altersgruppe mit Hobbitgröße");
    }
    case Sex.female:
      switch (age) {
        case >= 20 && < 25:
          print("Im Schnitt 167,5m");
        case >= 25 && < 30:
          print("Im Schnitt 167,3 m");
        case >= 30 && < 35:
          print("Im Schnitt 167,2");
        default:
          print("Unbekannte Altersgruppe mit Hobbitgröße");
      }
    default:
      print("Unbekanntes Geschlecht");
  }
}
