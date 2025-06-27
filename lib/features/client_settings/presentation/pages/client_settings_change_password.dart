import 'package:flutter/material.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class Settingschangepassword extends StatelessWidget {
  const Settingschangepassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Change password',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text(
          'Change password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'To update your credentials, please enter your old password and your new password.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Textfield(
          title: 'Old password',
          headtextfield: 'Enter your old password',
          obscuretext: true,
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Color(0xFF6C8090),
          thickness: 2,
          indent: 40,
          endIndent: 40,
          height: 15,
        ),
        const SizedBox(height: 20),
        const Textfield(
          title: 'New password',
          headtextfield: 'Enter your new password',
          obscuretext: true,
        ),
        const SizedBox(height: 20),
        const Textfield(
          title: 'Repeat new password',
          headtextfield: 'Enter your new password',
          obscuretext: true,
        ),
        const SizedBox(height: 135),
        Button(
          title: 'Save',
          ontap: () {
            // Handle save logic
          },
        ),
      ]),
    );
  }
}
