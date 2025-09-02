
class LoginRequest {
  // the given email within the LoginScreen
  final String email;
  // the given password within the LoginScreen
  final String password;

  LoginRequest({
    required this.email, required this.password
  });
}

class LoginResult {
  final int code;
  final String username;
  final String userId;
  final String publicname;
  final String userImageBase64;
  final bool isFirstLogin;
  final bool needsPasswordChange;
  

  LoginResult({
    required this.code,
    required this.username,
    required this.userId,
    required this.publicname,
    required this.userImageBase64,
    this.isFirstLogin = false,
    this.needsPasswordChange = false,
  });
}

class RegisterRequest {
  // the given username within the LoginScreen
  final String username;
  // the given email within the LoginScreen
  final String email;
  // the given password within the LoginScreen
  final String password;

  RegisterRequest(
    {
      required this.username,
      required this.email,
      required this.password,
    });
}

class RegisterResult {
  final int code;

  RegisterResult({
    required this.code,
  });
}

class GameCard {
  final String gameId;
  final String title;
  final String description;
  final String imageUrl;
  final String expirationDate;

  GameCard({
    required this.gameId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.expirationDate,
  });
}


class GameCardsListResult {
  final List<GameCard> games;
  final int code;

  GameCardsListResult({
    required this.games, 
    required this.code
  });
}

class PrimaryButton{
  final String text;
  final String? icon;
  final String background;
  final String foreground;

  const PrimaryButton({
    required this.text,
    this.icon,
    this.background = '#0000FF',
    this.foreground = '#FFFFFF',
  });
}

class SecondaryButton{
  final String text;
  final String? icon;
  final String background;
  final String foreground;

  const SecondaryButton({
    required this.text,
    this.icon,
    this.background = '#FFFFFF',
    this.foreground = '#0000FF',
  });
}
