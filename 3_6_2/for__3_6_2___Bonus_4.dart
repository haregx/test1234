
void main() {

  print('Fläche: ${Rectangle(width: 10, height: 5).area()}');
  print('Umfang: ${Rectangle(width: 10, height: 5).perimeter()}');

  Rectangle rect = Rectangle(width: 10, height: 5);
  rect.width = 15;
  rect.height = 20;
  print('Fläche: ${rect.area()}');
  print('Umfang: ${rect.perimeter()}');
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
}
