import 'package:flutter/material.dart';
import 'dart:async';

import 'package:home_service/features/ai/client%20chatpot/presentation/pages/ai_welcome.dart';

class Startchatbot extends StatefulWidget {
  const Startchatbot({super.key});

  @override
  State<Startchatbot> createState() => _StartChatBotState();
}

class _StartChatBotState extends State<Startchatbot> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Chatbotwelcome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/animation.gif', // غير المسار حسب مكان الصورة
          fit: BoxFit.cover,
          width: 300,
          height: 297,
        ),
      ),
    );
  }
}
