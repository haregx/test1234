

// ignore_for_file: unused_local_variable

void main() {

  print(add3(23));

}


int countLetter (String text, String letter) {
  int count = 0;
  for (String i in text.split('')) {
    if (i.toLowerCase() == letter.toLowerCase()) {
      count++;
    }
  }
  return count;
}

int add3(int i) {
 // print (i),
   i = i*i;
   i += 4;
   return i;
}

bool funcB() {
  print('true');
  return true;
}

bool funcA() {
  print('false');
  return false;
}
