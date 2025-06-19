import 'package:flutter/material.dart';
import 'dart:async';
import 'package:home_service/Pages/ChatBotWelcomePro.dart';

class StartchatbotPro extends StatefulWidget {
  const StartchatbotPro({super.key});

  @override
  State<StartchatbotPro> createState() => _StartChatBotProState();
}

class _StartChatBotProState extends State<StartchatbotPro> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatbotwelcomePro()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/animation.gif',
          fit: BoxFit.cover,
          width: 300,
          height: 297,
        ),
      ),
    );
  }
}
