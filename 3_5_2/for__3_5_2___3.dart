import 'dart:mirrors';

void main() {

  List<List<String>> names = [
    ['Johnny', 'Depp'],
    ['Tom', 'Cruise'],
    ['Hans', 'Dampf'],
    ['Otto', 'Normalverbraucher'],
    ['Max', 'Mustermann'],
  ];

  for (List<String> name in names) {
    reversIntitials(name[0], name[1]);
  }
}


void reversIntitials(String firstName, String lastName) {
  print('Die Initialen von $firstName $lastName sind: ${lastName[0]}. ${firstName[0]}.');
}