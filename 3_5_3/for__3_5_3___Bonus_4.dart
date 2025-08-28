void main() {

  List<List<int>> numbers = [
    [1, 2, 3],
    [4, 5, 6, 17, 56],
    [7, 8, 9]
  ];

  for (var element in numbers) {
    print('Der Durchschnitt von $element ist: ${average(element).toStringAsFixed(1)}');
    print('Der Durchschnitt von $element ist: ${averageAternative(element).toStringAsFixed(1)}');
  }

}

double average(List<int> nums) {
  return nums.reduce((a, b) => a + b) / nums.length;
}


double averageAternative(List<int> nums) {
  int sum = 0;
  for(int i = 0; i < nums.length; i++) {
    sum += nums[i];
  }
  return sum / nums.length;
}
