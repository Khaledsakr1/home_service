class TokenService {
  String? _token;

  // Singleton pattern
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  String? get token => _token;

  set token(String? value) {
    _token = value;
  }
}
