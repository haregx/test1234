void main() {

  print('Fläche: ${Rectangle(width: 10, height: 5).area()}');
  print('Umfang: ${Rectangle(width: 10, height: 5).perimeter()}');
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
