

// ignore_for_file: unused_local_variable

void main() {

  bool res = funcA() & funcB();
  print('-----');
  res = funcA() && funcB();

}

bool funcB() {
  print('true');
  return true;
}

bool funcA() {
  print('false');
  return false;
}
