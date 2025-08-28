void main() {

  List<int> numbers = [2, 1, 3, 4, 2, 6, 6, 6, 1];

  for (int number in numbers) {
    print('$number ist eine ${isEven(number) ? 'gerade' : 'ungerade'} Zahl.');
  }
}


bool isEven(int number) {
  return number % 2 == 0;
}