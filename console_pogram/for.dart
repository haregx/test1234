void main() {
  print('-----------------');
  for (int i = 1; i <= 5; i++) {
    print('Die Zahl (i++) ist: $i');
  }
  print('-----------------');
  for (int i = 1; i <= 5; ++i) {
    print('Die Zahl (++i) ist: $i');
  }
  print('-----------------');
}