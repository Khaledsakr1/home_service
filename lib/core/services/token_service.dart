import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenService {
  String? _token;

  // Singleton pattern
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  static const _tokenKey = 'jwt_token';

  String? get token => _token;

  /// 🔁 Call this once at app start or after login
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
  }

  /// 💾 Save token both in memory and persistent storage
  Future<void> saveToken(String? value) async {
    _token = value;
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      await prefs.setString(_tokenKey, value);
    } else {
      await prefs.remove(_tokenKey);
    }
  }

  /// ❌ Clear token (logout)
  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// ✅ Add this: Get token (from memory or SharedPreferences)
  Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    return _token;
  }

  /// 👤 Extract user role/type from JWT
  String? getUserType() {
    if (_token == null) return null;
    try {
      final decoded = JwtDecoder.decode(_token!);
      return decoded['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    } catch (_) {
      return null;
    }
  }

  /// 🧩 Get the full decoded payload
  Map<String, dynamic>? get decodedPayload {
    if (_token == null) return null;
    try {
      return JwtDecoder.decode(_token!);
    } catch (_) {
      return null;
    }
  }
}
