import 'dart:io';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/api_exceptions.dart';

/// Beispiel-Service für API-Integration
/// 
/// Zeigt wie die ApiService-Klasse für spezifische API-Endpoints
/// verwendet werden kann. Dient als Template für eigene Services.
class ExampleApiUsage {
  final ApiService _api = ApiService();
  final AuthService _auth = AuthService();

  /// Initialisierung der API-Services
  /// 
  /// Diese Methode sollte beim App-Start aufgerufen werden
  Future<void> initializeApi() async {
    // API-Service konfigurieren
    _api.initialize(
      baseUrl: 'https://your-api.example.com/api/v1',
      timeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    // Gespeicherte Auth-Token laden
    await _auth.loadTokensFromStorage();

    // Callback für automatischen Logout bei Auth-Fehlern
    _auth.onAuthenticationFailed = () {
      // Hier zur Login-Seite navigieren
      debugPrint('Authentication failed - redirecting to login');
    };
  }

  /// Beispiel: User-Login
  Future<void> performLogin(String email, String password) async {
    try {
      final loginResponse = await _auth.login(
        email: email,
        password: password,
      );
      
      debugPrint('Login successful: ${loginResponse.user?.email}');
    } on ValidationException catch (e) {
      // Validation-Fehler anzeigen
      debugPrint('Validation errors: ${e.validationErrors}');
    } on AuthenticationException catch (e) {
      // Login-Fehler anzeigen
      debugPrint('Login failed: ${e.message}');
    } on NetworkException catch (e) {
      // Network-Fehler anzeigen
      debugPrint('Network error: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  /// Beispiel: Daten abrufen (GET)
  Future<List<UserProfile>> fetchUsers() async {
    try {
      // Token-Gültigkeit prüfen
      await _auth.ensureValidToken();

      final response = await _api.get<Map<String, dynamic>>(
        '/users',
        queryParameters: {
          'page': 1,
          'per_page': 20,
        },
      );

      // Response parsen
      final usersData = response['data'] as List;
      return usersData
          .map((userData) => UserProfile.fromJson(userData))
          .toList();

    } on AuthenticationException {
      // Automatisch zur Login-Seite
      rethrow;
    } on NetworkException catch (e) {
      debugPrint('Network error: ${e.message}');
      rethrow;
    }
  }

  /// Beispiel: Daten erstellen (POST)
  Future<UserProfile> createUser({
    required String name,
    required String email,
  }) async {
    try {
      await _auth.ensureValidToken();

      final response = await _api.post<Map<String, dynamic>>(
        '/users',
        data: {
          'name': name,
          'email': email,
        },
      );

      return UserProfile.fromJson(response['data']);

    } on ValidationException catch (e) {
      // Validation-Fehler anzeigen
      debugPrint('Validation errors: ${e.validationErrors}');
      rethrow;
    }
  }

  /// Beispiel: Daten aktualisieren (PUT)
  Future<UserProfile> updateUser(
    String userId, {
    String? name,
    String? email,
  }) async {
    try {
      await _auth.ensureValidToken();

      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;

      final response = await _api.put<Map<String, dynamic>>(
        '/users/$userId',
        data: data,
      );

      return UserProfile.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  /// Beispiel: Daten löschen (DELETE)
  Future<void> deleteUser(String userId) async {
    try {
      await _auth.ensureValidToken();

      await _api.delete(
        '/users/$userId',
      );

    } catch (e) {
      rethrow;
    }
  }

  /// Beispiel: File-Upload
  Future<String> uploadProfilePicture(
    String userId,
    String filePath,
  ) async {
    try {
      await _auth.ensureValidToken();

      final response = await _api.uploadFile<Map<String, dynamic>>(
        '/users/$userId/avatar',
        File(filePath),
        fileField: 'avatar',
        onProgress: (sent, total) {
          final progress = (sent / total * 100).round();
          debugPrint('Upload progress: $progress%');
        },
      );

      return response['avatar_url'] as String;

    } catch (e) {
      rethrow;
    }
  }

  /// Beispiel: Paginierte Daten abrufen
  Future<PaginatedResult<UserProfile>> fetchUsersPaginated({
    int page = 1,
    int perPage = 20,
    String? search,
  }) async {
    try {
      await _auth.ensureValidToken();

      final queryParams = <String, dynamic>{
        'page': page,
        'per_page': perPage,
      };
      
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _api.get<Map<String, dynamic>>(
        '/users',
        queryParameters: queryParams,
      );

      // Pagination-Metadaten extrahieren
      final meta = response['meta'] as Map<String, dynamic>;
      final usersData = response['data'] as List;

      return PaginatedResult<UserProfile>(
        data: usersData
            .map((userData) => UserProfile.fromJson(userData))
            .toList(),
        currentPage: meta['current_page'] as int,
        lastPage: meta['last_page'] as int,
        perPage: meta['per_page'] as int,
        total: meta['total'] as int,
      );

    } catch (e) {
      rethrow;
    }
  }

  /// Beispiel: Error-Handling in UI
  Future<T?> handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on ValidationException catch (e) {
      // Validation-Fehler in UI anzeigen
      _showValidationErrors(e.validationErrors);
      return null;
    } on AuthenticationException {
      // Zur Login-Seite navigieren
      _redirectToLogin();
      return null;
    } on NetworkException catch (e) {
      // Network-Fehler anzeigen
      _showNetworkError(e.message);
      return null;
    } on ServerException catch (e) {
      // Server-Fehler anzeigen
      _showServerError(e.message);
      return null;
    } catch (e) {
      // Unbekannter Fehler
      _showUnknownError(e.toString());
      return null;
    }
  }

  // Helper-Methoden für UI-Feedback
  void _showValidationErrors(Map<String, List<String>>? errors) {
    debugPrint('Validation errors: $errors');
    // TODO: Hier UI-spezifische Error-Anzeige implementieren
  }

  void _redirectToLogin() {
    debugPrint('Redirecting to login...');
    // TODO: Hier Navigation zur Login-Seite implementieren
  }

  void _showNetworkError(String message) {
    debugPrint('Network error: $message');
    // TODO: Hier SnackBar oder Dialog anzeigen
  }

  void _showServerError(String message) {
    debugPrint('Server error: $message');
    // TODO: Hier SnackBar oder Dialog anzeigen
  }

  void _showUnknownError(String message) {
    debugPrint('Unknown error: $message');
    // TODO: Hier SnackBar oder Dialog anzeigen
  }
}

/// Helper-Klasse für paginierte Ergebnisse
class PaginatedResult<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const PaginatedResult({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
  int get totalPages => lastPage;
}

// Verwende dart:io File für File-Upload
// Die lokale File-Klasse unten ist nur als Placeholder