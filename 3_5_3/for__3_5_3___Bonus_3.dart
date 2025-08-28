void main() {

  List<List<int>> numbers = [
    [1, 2, 3],
    [4, 5, 6, 17, 56],
    [7, 8, 9]
  ];

  for (var element in numbers) {
    print('Die Summe von $element ist: ${sum(element)}');
    print('Die Summe von $element ist: ${sumAternative(element)}');
  }

}

int sum(List<int> nums) {
  return nums.reduce((a, b) => a + b);
}


int sumAternative(List<int> nums) {
  int sum = 0;
  for(int i = 0; i < nums.length; i++) {
    sum += nums[i];
  }
  return sum;
}
