import 'package:flutter/material.dart';
import 'package:home_service/features/chatpot/client%20chatpot/presentation/pages/ChatBotScreen.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/widgets/navigationbar.dart';

class Chatbotwelcome extends StatelessWidget {
  const Chatbotwelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Navigationbar()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // صورة
                Image.asset(
                  'assets/images/chatbot.png',
                  height: 200,
                ),
                const SizedBox(height: 30),

                // نص ترحيبي
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      TextSpan(
                          text: 'chatbot',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      TextSpan(
                          text: '!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // وصف إضافي
                const Text(
                  'Start chatting with ChattyAI now.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const Text(
                  'You can ask me anything.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 50),
                Button(
                  title: 'Get Started',
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FurnitureImagePage()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
