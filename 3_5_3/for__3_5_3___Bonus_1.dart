void main() {

  List<List<int>> numbers = [
    [1, 2],
    [4, 5],
    [7, 8],
    [19, 10]
  ];

  for (var element in numbers) {
    print('Die größere Zahl von $element ist: ${max(element[0], element[1])}');
  }

}

int max(int num1, int num2) {
  return num1 > num2 ? num1 : num2;
}