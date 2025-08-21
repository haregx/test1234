enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

void main() {
  Weekday? weekday;

  switch (weekday) {
    case Weekday.monday:
    case Weekday.tuesday:
      print('Montage und Dienstage sind anstrengend');
      break;
    case Weekday.wednesday:
    case Weekday.thursday:
      print('Mittwoch und Donnerstag sind ok');
      break;
    case Weekday.friday:
      print('Freitag ist super');
      break;
    case Weekday.saturday:
    case Weekday.sunday:
      print('Wochenende ist genial');
      break;
    default:
      print('Kein Tag ausgewählt');
  }
}
