void main() {
  bool isLoggedIn = false;
  bool isBanned = false;
  bool isSubscribed = false;
  int age = 17;

// print(getString(isLoggedIn, isBanned, isSubscribed, age));
  print(getString(false, false, false, 17));
  print(getString(true, false, false, 17));
  print(getString(true, true, false, 17));
  print(getString(true, true, true, 17));
  print(getString(true, false, true, 19));
}

String getString(bool isLoggedIn, bool isBanned, bool isSubscribed, int age) {
  if (!isLoggedIn) 
  {
    return('Bitte logge dich ein');
  } 
  else 
  {
    if (isBanned) {
      return("Dein Account wurde gesperrt");
    } else if (!isSubscribed) {
      return("Bitte abonniere");
    } else if (age < 18) {
      return("Du bist zu jung");
    } else {
      return("Willkommen");
    }
  }
}
