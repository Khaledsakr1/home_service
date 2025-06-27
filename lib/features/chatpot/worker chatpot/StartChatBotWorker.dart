import 'package:flutter/material.dart';
import 'dart:async';

import 'package:home_service/features/chatpot/worker%20chatpot/ChatBotWelcomeWorker.dart';


class StartchatbotWorker extends StatefulWidget {
  const StartchatbotWorker({super.key});

  @override
  State<StartchatbotWorker> createState() => _StartChatBotProState();
}

class _StartChatBotProState extends State<StartchatbotWorker> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatbotwelcomeWorker()),
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
