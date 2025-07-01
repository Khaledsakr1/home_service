import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearTokenOnLogout() async {
await TokenService().clearToken();

}