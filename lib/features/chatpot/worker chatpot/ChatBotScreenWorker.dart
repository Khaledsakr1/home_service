import 'package:flutter/material.dart';

class ChatBotScreenPro extends StatelessWidget {
  const ChatBotScreenPro.ChatBotScreenWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('ChatBot'),
      ),
      body: const Center(
        child: Text('Welcome to ChatBot Screen for technical'),
      ),
    );
  }
}
