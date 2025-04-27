import 'package:flutter/material.dart';
import 'package:home_service/widgets/navigationbar.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Navigationbar()),
              (Route<dynamic> route) => false, // هذه تقوم بحذف كل الصفحات السابقة
            );
          },
        ),
        title: const Text('ChatBot'),
      ),
      body: const Center(
        child: Text('Welcome to ChatBot Screen'),
      ),
    );
  }
}
