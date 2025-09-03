
void main() {

  print('Fläche bei Breite 10 und Höhe 5: ${Rectangle(width: 10, height: 5).area()}');
  print('Umfang bei Breite 10 und Höhe 5: ${Rectangle(width: 10, height: 5).perimeter()}');

  Rectangle rect = Rectangle(width: 10, height: 5);
  rect.width = 15;
  rect.height = 20;
  print('Fläche bei Breite ${rect.width} und Höhe ${rect.height}: ${rect.area()}');
  print('Umfang bei Breite ${rect.width} und Höhe ${rect.height}: ${rect.perimeter()}');

  double factor = 2;
  print('Neue Fläche nach Skalierung mit Faktor $factor: ${rect.scale(factor).area()}');
  print('Neuer Umfang nach Skalierung mit Faktor $factor: ${rect.scale(factor).perimeter()}');

  factor = 2.5;
  print('Neue Fläche nach Skalierung mit Faktor $factor: ${rect.scale(factor).area()}');
  print('Neuer Umfang nach Skalierung mit Faktor $factor: ${rect.scale(factor).perimeter()}');

}


class Rectangle {
  double width;
  double height;

  Rectangle({
    required this.width,
    required this.height
  });

  double area() {
    return width * height;
  }

  double perimeter() {
    return  (width + height) * 2;
  }

  Rectangle scale(double factor) {
    width *= factor;
    height *= factor;
    return Rectangle(width: width, height: height);
  }
}


