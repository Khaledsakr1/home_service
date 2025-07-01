import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/widgets/navigationbar.dart';
import 'package:home_service/widgets/navigationbarWorker.dart';
import 'package:home_service/common/pages/start_page.dart';
import 'package:home_service/common/pages/client_and_worker_start_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Add this package!

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String? _userType;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, decideWhereToGo);
  }

  Future<void> decideWhereToGo() async {
    final prefs = await SharedPreferences.getInstance();

    // Onboarding not seen? Show onboarding
    final bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    if (!onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Startpage()),
      );
      return;
    }

    // Token exists? Go to home
    final token = di.sl<TokenService>().token;
    if (token != null && token.isNotEmpty) {
      // Decode token to get userType
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _userType = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

      print('Decoded user type: $_userType');
      print(decodedToken);

      // Adjust the string to match your backend user type values
      if (_userType == 'Worker') {
        Navigator.pushReplacementNamed(context, NavigationbarWorker.id);
      } else {
        Navigator.pushReplacementNamed(context, Navigationbar.id);
      }
      return;
    }

    // Otherwise: Show the "Client or Worker" start page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ClientandWorkerstart()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Simple splash
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
