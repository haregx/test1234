void main() {
    for (int i = 1; i <= 100; i++) {
      i < 10
        ? print('Kleine Zahle: $i')
        : i >= 10 && i < 60
          ? print('Mittlere Zahl: $i')
          : print('Große Zahl: $i');
    }

}
