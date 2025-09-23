import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_exceptions.dart';

/// Zentrale API-Service-Klasse für alle HTTP-Kommunikation
/// 
/// Diese Klasse bietet:
/// - Standardisierte HTTP-Requests (GET, POST, PUT, DELETE, PATCH)
/// - Automatisches Error-Handling und Exception-Mapping
/// - Authentication-Header-Management
/// - Request/Response-Interceptors für Logging
/// - JSON-Serialization/Deserialization
/// - Retry-Logic für fehlgeschlagene Requests
class ApiService {
  late final Dio _dio;
  String? _authToken;
  Map<String, String> _defaultHeaders = {};

  /// Singleton-Pattern für globale Verwendung
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  /// Initialisierung der API-Service
  /// 
  /// [baseUrl] - Basis-URL der API (z.B. 'https://api.example.com/v1')
  /// [timeout] - Request-Timeout in Millisekunden
  /// [headers] - Standard-Headers für alle Requests
  void initialize({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? headers,
  }) {
    _defaultHeaders = headers ?? {};

    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      headers: _defaultHeaders,
      contentType: 'application/json',
      responseType: ResponseType.json,
    ));

    _setupInterceptors();
  }

  /// Setup von Request/Response-Interceptors
  void _setupInterceptors() {
    // Request-Interceptor für Authentication und Logging
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Auth-Token hinzufügen, falls vorhanden
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }

        // Debug-Logging für Development
        if (kDebugMode) {
          debugPrint('🚀 REQUEST: ${options.method} ${options.uri}');
          debugPrint('📤 Headers: ${options.headers}');
          if (options.data != null) {
            debugPrint('📤 Body: ${options.data}');
          }
        }

        handler.next(options);
      },
      onResponse: (response, handler) {
        // Debug-Logging für Development
        if (kDebugMode) {
          debugPrint('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
          debugPrint('📥 Data: ${response.data}');
        }
        handler.next(response);
      },
      onError: (error, handler) {
        // Debug-Logging für Errors
        if (kDebugMode) {
          debugPrint('❌ ERROR: ${error.requestOptions.method} ${error.requestOptions.uri}');
          debugPrint('❌ Status: ${error.response?.statusCode}');
          debugPrint('❌ Message: ${error.message}');
        }
        handler.next(error);
      },
    ));

    // Retry-Interceptor für automatische Wiederholung
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: 2,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
      ],
    ));
  }

  /// Authentication-Token setzen
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Authentication-Token entfernen
  void clearAuthToken() {
    _authToken = null;
  }

  /// Aktueller Authentication-Token
  String? get authToken => _authToken;

  /// GET-Request
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// POST-Request
  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT-Request
  Future<T> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// PATCH-Request
  Future<T> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE-Request
  Future<T> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// File-Upload
  Future<T> uploadFile<T>(
    String endpoint,
    File file, {
    String fileField = 'file',
    Map<String, dynamic>? additionalData,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
    void Function(int, int)? onProgress,
  }) async {
    try {
      final formData = FormData();
      
      // Datei hinzufügen
      formData.files.add(MapEntry(
        fileField,
        await MultipartFile.fromFile(file.path),
      ));

      // Zusätzliche Daten hinzufügen
      if (additionalData != null) {
        additionalData.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: onProgress,
      );

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Response-Handling
  T _handleResponse<T>(Response response, T Function(Map<String, dynamic>)? fromJson) {
    final data = response.data;
    
    if (fromJson != null && data is Map<String, dynamic>) {
      return fromJson(data);
    }
    
    return data as T;
  }

  /// Error-Handling und Exception-Mapping
  ApiException _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException(
            'Request timeout. Please check your internet connection.',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.connectionError:
          return NetworkException(
            'No internet connection. Please check your network settings.',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.badResponse:
          return _handleStatusCodeError(error);

        case DioExceptionType.cancel:
          return NetworkException('Request was cancelled');

        case DioExceptionType.unknown:
          return NetworkException(
            'Unknown network error: ${error.message}',
            statusCode: error.response?.statusCode,
          );

        default:
          return NetworkException(
            'Network error occurred',
            statusCode: error.response?.statusCode,
          );
      }
    }

    return NetworkException('Unexpected error: ${error.toString()}');
  }

  /// Status-Code-spezifisches Error-Handling
  ApiException _handleStatusCodeError(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    final data = error.response?.data;
    final message = _extractErrorMessage(data) ?? 'Unknown error occurred';

    switch (statusCode) {
      case 400:
        // Validation-Error prüfen
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          return ValidationException(
            message,
            statusCode: statusCode,
            validationErrors: _extractValidationErrors(data['errors']),
          );
        }
        return ClientException(message, statusCode: statusCode, data: data);

      case 401:
        return AuthenticationException(
          'Authentication failed. Please log in again.',
          statusCode: statusCode,
          data: data,
        );

      case 403:
        return AuthenticationException(
          'Access denied. You don\'t have permission for this action.',
          statusCode: statusCode,
          data: data,
        );

      case 404:
        return ClientException(
          'Resource not found.',
          statusCode: statusCode,
          data: data,
        );

      case 422:
        return ValidationException(
          message,
          statusCode: statusCode,
          validationErrors: _extractValidationErrors(data),
        );

      case 429:
        return RateLimitException(
          'Too many requests. Please try again later.',
          statusCode: statusCode,
          data: data,
          retryAfter: _extractRetryAfter(error.response?.headers),
        );

      default:
        if (statusCode >= 500) {
          return ServerException(
            'Server error occurred. Please try again later.',
            statusCode: statusCode,
            data: data,
          );
        }
        return ClientException(message, statusCode: statusCode, data: data);
    }
  }

  /// Error-Message aus Response extrahieren
  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? data['detail'];
    }
    if (data is String) {
      return data;
    }
    return null;
  }

  /// Validation-Errors aus Response extrahieren
  Map<String, List<String>>? _extractValidationErrors(dynamic errors) {
    if (errors is Map<String, dynamic>) {
      final result = <String, List<String>>{};
      errors.forEach((key, value) {
        if (value is List) {
          result[key] = value.map((e) => e.toString()).toList();
        } else {
          result[key] = [value.toString()];
        }
      });
      return result;
    }
    return null;
  }

  /// Retry-After-Header extrahieren
  DateTime? _extractRetryAfter(Headers? headers) {
    final retryAfter = headers?.value('retry-after');
    if (retryAfter != null) {
      final seconds = int.tryParse(retryAfter);
      if (seconds != null) {
        return DateTime.now().add(Duration(seconds: seconds));
      }
    }
    return null;
  }
}

/// Retry-Interceptor für automatische Wiederholung fehlgeschlagener Requests
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final List<Duration> retryDelays;

  RetryInterceptor({
    required this.dio,
    this.retries = 2,
    this.retryDelays = const [Duration(seconds: 1), Duration(seconds: 2)],
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    
    // Retry-Count aus Request-Options lesen
    final retriesCount = requestOptions.extra['retries'] ?? 0;
    
    // Prüfen ob Retry möglich ist
    if (retriesCount < retries && _shouldRetry(err)) {
      // Retry-Count erhöhen
      requestOptions.extra['retries'] = retriesCount + 1;
      
      // Delay vor Retry
      final delay = retryDelays.length > retriesCount 
          ? retryDelays[retriesCount]
          : retryDelays.last;
      
      await Future.delayed(delay);
      
      try {
        // Request wiederholen
        final response = await dio.fetch(requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Bei erneutem Fehler weitergeben
      }
    }
    
    handler.next(err);
  }
  
  /// Prüft ob Request wiederholt werden soll
  bool _shouldRetry(DioException error) {
    // Nur bei bestimmten Fehlertypen wiederholen
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // Bei Server-Errors wiederholen
        final statusCode = error.response?.statusCode;
        return statusCode != null && statusCode >= 500;
      default:
        return false;
    }
  }
}