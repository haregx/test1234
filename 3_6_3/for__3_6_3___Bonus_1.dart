void main() {
  Hammer(name: 'Hammer', price: 29.99, weight: 2.5).printWeight();
  Saw(name: 'Säge', price: 49.99, numberOfSawTeeth: 72).printNumberOfSawTeeth();
}

class Tool {
  double price;
  String name;

  Tool({
    required this.price,
    required this.name
  });
}

class Hammer extends Tool {
  
  double weight;

  Hammer({
    required this.weight,
    required super.price,
    required super.name
  });

  void printWeight() {
    print('Der Hammer wiegt $weight kg.');
  }
}

class Saw extends Tool {

  int numberOfSawTeeth;

  Saw({
    required this.numberOfSawTeeth,
    required super.price,
    required super.name
  });

  void printNumberOfSawTeeth() {
    print('Die Säge hat $numberOfSawTeeth Sägezähne.');
  }
}
