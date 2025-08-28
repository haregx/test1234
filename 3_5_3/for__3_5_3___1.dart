void main() {

  List<List<int>> numbers = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];

  for (var element in numbers) {
    print('Die Summe von $element ist: ${sum(element[0], element[1], element[2])}');
  }

}

int sum(int num1, int num2, int num3) {
  return num1 + num2 + num3;
}