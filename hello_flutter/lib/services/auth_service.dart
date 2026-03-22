import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'api_exception.dart';

class AuthService {
  static const _tokenKey = 'jwt_token';
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> register(String email, String password, String? name) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = name?.trim();

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': normalizedEmail,
        'password': password,
        'name': normalizedName,
      }),
    );

    return _parseAuthResponse(response, 'Registration failed');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': normalizedEmail,
        'password': password,
      }),
    );

    return _parseAuthResponse(response, 'Login failed');
  }

  Future<Map<String, dynamic>> _parseAuthResponse(http.Response response, String defaultMessage) async {
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : <String, dynamic>{};
    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = body['token'] as String?;
      if (token == null || token.isEmpty) {
        throw ApiException('Token missing from response');
      }

      await _storage.write(key: _tokenKey, value: token);

      return {
        ...body,
        'requiresVerification': body['requiresVerification'] ?? false,
      };
    }

    switch (response.statusCode) {
      case 400:
        throw ApiException(body['message'] ?? 'Validation error');
      case 401:
        throw ApiException(body['message'] ?? 'Unauthorized');
      case 409:
        throw ApiException(body['message'] ?? 'User already exists');
      case 429:
        throw ApiException(body['message'] ?? 'Too many requests');
      case 500:
        throw ApiException(body['message'] ?? 'Server error');
      default:
        throw ApiException(body['message'] ?? defaultMessage);
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }
}
