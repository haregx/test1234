String lila = '\x1B[35m'; // code for purple
String reset = '\x1B[0m'; // code to reset color

main() {

  Butter butter = Butter(
    name: 'Butter',
    manufacturer: 'RyanAir',
    price: 1.79,
    weight: 0.25,
    kilos: 82.0
  );

  Milk milk = Milk(
    name: 'Milch',
    manufacturer: 'Milka',
    price: 0.89,
    weight: 1.0,
    fatContent: 3.5
  );

  butter.printNonsense();
  milk.printNonsense();
}


class Grocery {
  String name;
  double price;
  String manufacturer;
  double weight;

  Grocery({
    required this.name,
    required this.manufacturer,
    required this.price,
    required this.weight
  });

  void printNonsense() {
    print('Produkt: $name, Hersteller: $manufacturer, Preis: $price €, Gewicht: $weight kg.');
  }
}


class Butter extends Grocery {
  double kilos;

  Butter({
    required this.kilos,
    required super.name,
    required super.manufacturer,
    required super.price,
    required super.weight
  });

  @override
  void printNonsense() {
    print('Wer $name von $manufacturer kauft, darf auch mit einem Übergewicht von $kilos kg günstig fliegen. 😊');
  }
} 

class Milk extends Grocery {
  double fatContent;

  Milk({
    required this.fatContent,
    required super.name,
    required super.manufacturer,
    required super.price,
    required super.weight
  });

    @override
  void printNonsense() {
    print('Wer $name mit einem Fettgehalt von $fatContent % von $manufacturer kauft, muss mit ${lila}lila Punkten${reset} auf der Nasenspitze rechnen.');
  }
}