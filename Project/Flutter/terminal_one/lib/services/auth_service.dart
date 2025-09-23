import 'package:flutter/foundation.dart';
import 'api_service.dart';
import 'api_exceptions.dart';

/// Authentication-Service für Token-Management und Auth-Workflows
/// 
/// Verwaltet:
/// - Login/Logout-Funktionalität
/// - Token-Storage und -Refresh
/// - Automatische Token-Erneuerung
/// - User-Session-Management
class AuthService {
  final ApiService _apiService;
  
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  
  /// Callback für automatischen Logout bei Token-Problemen
  void Function()? onAuthenticationFailed;
  
  /// Singleton-Pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal() : _apiService = ApiService();

  /// Aktueller Access-Token
  String? get accessToken => _accessToken;
  
  /// Aktueller Refresh-Token
  String? get refreshToken => _refreshToken;
  
  /// Prüft ob User eingeloggt ist
  bool get isLoggedIn => _accessToken != null && !_isTokenExpired();
  
  /// Prüft ob Token abgelaufen ist
  bool _isTokenExpired() {
    if (_tokenExpiry == null) return false;
    return DateTime.now().isAfter(_tokenExpiry!);
  }

  /// Login mit Email und Passwort
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      // Token aus Response extrahieren
      final accessToken = response['access_token'] as String?;
      final refreshToken = response['refresh_token'] as String?;
      final expiresIn = response['expires_in'] as int?; // Sekunden

      if (accessToken == null) {
        throw AuthenticationException('No access token received');
      }

      // Token setzen
      await _setTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );

      return LoginResponse.fromJson(response);
    } catch (e) {
      debugPrint('Login failed: $e');
      rethrow;
    }
  }

  /// Registrierung neuer User
  Future<LoginResponse> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        ...?additionalData,
      };

      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/register',
        data: data,
      );

      // Bei erfolgreicher Registrierung automatisch einloggen
      final accessToken = response['access_token'] as String?;
      final refreshToken = response['refresh_token'] as String?;
      final expiresIn = response['expires_in'] as int?;

      if (accessToken != null) {
        await _setTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
        );
      }

      return LoginResponse.fromJson(response);
    } catch (e) {
      debugPrint('Registration failed: $e');
      rethrow;
    }
  }

  /// Passwort-Reset anfordern
  Future<void> requestPasswordReset(String email) async {
    try {
      await _apiService.post(
        '/auth/password/reset',
        data: {'email': email},
      );
    } catch (e) {
      debugPrint('Password reset request failed: $e');
      rethrow;
    }
  }

  /// Token aktualisieren
  Future<bool> refreshAccessToken() async {
    if (_refreshToken == null) {
      return false;
    }

    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': _refreshToken},
      );

      final accessToken = response['access_token'] as String?;
      final refreshToken = response['refresh_token'] as String?;
      final expiresIn = response['expires_in'] as int?;

      if (accessToken != null) {
        await _setTokens(
          accessToken: accessToken,
          refreshToken: refreshToken ?? _refreshToken,
          expiresIn: expiresIn,
        );
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      // Bei Refresh-Fehler komplett ausloggen
      await logout();
      return false;
    }
  }

  /// Token aus gespeicherten Daten laden (z.B. SharedPreferences)
  Future<void> loadTokensFromStorage() async {
    // TODO: Implementierung für SharedPreferences/SecureStorage
    // Beispiel:
    // final prefs = await SharedPreferences.getInstance();
    // _accessToken = prefs.getString('access_token');
    // _refreshToken = prefs.getString('refresh_token');
    // final expiryString = prefs.getString('token_expiry');
    // if (expiryString != null) {
    //   _tokenExpiry = DateTime.parse(expiryString);
    // }
    // 
    // if (_accessToken != null) {
    //   _apiService.setAuthToken(_accessToken!);
    // }
  }

  /// Token setzen und speichern
  Future<void> _setTokens({
    required String accessToken,
    String? refreshToken,
    int? expiresIn,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    
    if (expiresIn != null) {
      _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
    }

    // Token im ApiService setzen
    _apiService.setAuthToken(accessToken);

    // Token persistent speichern
    await _saveTokensToStorage();
  }

  /// Token persistent speichern
  Future<void> _saveTokensToStorage() async {
    // TODO: Implementierung für SharedPreferences/SecureStorage
    // Beispiel:
    // final prefs = await SharedPreferences.getInstance();
    // if (_accessToken != null) {
    //   await prefs.setString('access_token', _accessToken!);
    // }
    // if (_refreshToken != null) {
    //   await prefs.setString('refresh_token', _refreshToken!);
    // }
    // if (_tokenExpiry != null) {
    //   await prefs.setString('token_expiry', _tokenExpiry!.toIso8601String());
    // }
  }

  /// Logout und Token löschen
  Future<void> logout() async {
    try {
      // Server-seitiges Logout
      if (_accessToken != null) {
        await _apiService.post('/auth/logout', data: {});
      }
    } catch (e) {
      debugPrint('Server logout failed: $e');
      // Lokales Logout trotzdem durchführen
    }

    // Lokale Token löschen
    _accessToken = null;
    _refreshToken = null;
    _tokenExpiry = null;

    // Token aus ApiService entfernen
    _apiService.clearAuthToken();

    // Token aus Storage löschen
    await _clearTokensFromStorage();
  }

  /// Token aus persistentem Storage löschen
  Future<void> _clearTokensFromStorage() async {
    // TODO: Implementierung für SharedPreferences/SecureStorage
    // Beispiel:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('access_token');
    // await prefs.remove('refresh_token');
    // await prefs.remove('token_expiry');
  }

  /// Automatisches Token-Refresh vor Ablauf
  Future<void> ensureValidToken() async {
    if (_accessToken == null) {
      throw AuthenticationException('No access token available');
    }

    // Token erneuern wenn es in den nächsten 5 Minuten abläuft
    if (_tokenExpiry != null) {
      final fiveMinutesFromNow = DateTime.now().add(const Duration(minutes: 5));
      if (_tokenExpiry!.isBefore(fiveMinutesFromNow)) {
        final refreshed = await refreshAccessToken();
        if (!refreshed) {
          onAuthenticationFailed?.call();
          throw AuthenticationException('Token refresh failed');
        }
      }
    }
  }
}

/// Response-Model für Login/Register
class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final UserProfile? user;

  const LoginResponse({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      user: json['user'] != null 
          ? UserProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// User-Profile-Model
class UserProfile {
  final String id;
  final String email;
  final String? name;
  final String? avatar;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'].toString(),
      email: json['email'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}