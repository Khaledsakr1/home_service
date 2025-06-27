import 'package:flutter/material.dart';
import 'package:home_service/features/authentication/presentation/pages/login_as_worker_page.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/widgets/navigationbarWorker.dart'; // Or your main/home page

class WorkerAlreadLogin extends StatefulWidget {
  const WorkerAlreadLogin({super.key});
  static String id = 'worker already login';

  @override
  State<WorkerAlreadLogin> createState() => _WorkerAlreadLoginState();
}


class _WorkerAlreadLoginState extends State<WorkerAlreadLogin> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, checkLoginStatus);
  }

  void checkLoginStatus() {
    final token = di.sl<TokenService>().token;
    if (token != null && token.isNotEmpty) {
      // Token exists, go directly to main/worker/home
      Navigator.pushReplacementNamed(context, NavigationbarWorker.id);
    } else {
      // No token, go to start/login page
      Navigator.pushReplacementNamed(context, LoginAsWorker.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Simple splash while checking
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
