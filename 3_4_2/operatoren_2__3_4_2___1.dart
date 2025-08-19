void main() {
  
  int movieAgeRating = 16;

  // Test 1
  int age = 15;
  bool hasParentalConsent = true;
  
  final String test1 = 'Test1';
  print(getString(test1, isAllowed(age, hasParentalConsent, movieAgeRating)));

  // Test 2
  age = 13;
  hasParentalConsent = false;
  final String test2 = 'Test2';
  print(getString(test2, isAllowed(age, hasParentalConsent, movieAgeRating)));
}

String getString(String test, bool allowed) {
  return '$test: Film ansehen erlaubt? ${allowed ? 'Ja' : 'Nein'}';
}

bool isAllowed (int age, bool hasParentConsent, int movieAgeRating) {
  print ('Altersfreigabe: $movieAgeRating, Kind: $age, Eltern erlauben: ${hasParentConsent ? 'Ja' : 'Nein'}');
  return age >= movieAgeRating || (hasParentConsent && (movieAgeRating - age <= 2));
}