
//////////////////////
/// Login          ///
//////////////////////

class LoginResult {
  final String userGuid;
  final String publicname;
  final String imageBase64;

  LoginResult({
    required this.userGuid,
    required this.publicname,
    required this.imageBase64,
  });
}

class LoginRequest {
  final String loginname;
  final String password;

  LoginRequest({
    required this.loginname,
    required this.password,
  });
}

//////////////////////
/// Register          ///
//////////////////////

class RegisterResult {
  final String userGuid;


  RegisterResult({
    required this.userGuid,
  });
}

class RegisterRequest {
  final String email;
  final String password;
  final String loginname;
  
  RegisterRequest({
    required this.email,
    required this.password,
    required this.loginname,
  });
}

//////////////////////
/// Password          ///
//////////////////////

class PasswordResult {
  final int resultCode;

  PasswordResult({
    required this.resultCode,
  });
}

class PasswordRequest {
  final String email;

  PasswordRequest({
    required this.email,
  });
}



//////////////////////
/// Game           ///
//////////////////////

class QuizQuestion {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex
  });
}

class QuizResponse {
  final int numberOfQuestions;
  final List<QuizQuestion> questionsList;

  QuizResponse({
    required this.numberOfQuestions,
    required this.questionsList
  });
}

class QuizRequest {
  final String promoRowGuid;
  
  QuizRequest({
    required this.promoRowGuid,
  });
}



///////////////////////
/// Promo           ///
//////////////////////

class PromoCodeResult {
  List<PromoCode> promoCodesList;

  PromoCodeResult({
    required this.promoCodesList,
  });
}

class PromoCode {
  final String title;
  final String description;
  final String promocode;
  final String rowGuid;
  final DateTime startDate;
  final DateTime endDate;
  final String imageBase64;

  PromoCode({
    required this.promocode,
    required this.description,
    required this.title,
    required this.rowGuid,
    required this.startDate,
    required this.endDate,
    required this.imageBase64,
  });
}



  

