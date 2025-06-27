import 'package:flutter/material.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class SettingsmyprofileAddressedit extends StatelessWidget {
  const SettingsmyprofileAddressedit({super.key});

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
          'Address Preferences',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Your address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your address is used to send you job opportunities nearest to you.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          const Textfield(
            title: 'Country',
            headtextfield: 'Enter your country',
          ),
          const SizedBox(height: 20),
          const Textfield(
            title: 'Governorate',
            headtextfield: 'Enter your governorate',
          ),
          const SizedBox(height: 20),
          const Textfield(
            title: 'Street name',
            headtextfield: 'Enter your street name',
          ),
          const SizedBox(height: 20),
          const Textfield(
            title: 'Building number',
            headtextfield: 'Enter your building number',
          ),
          const SizedBox(height: 70),
          Button(
            title: 'Save',
            ontap: () {
              // Handle save logic
            },
          ),
        ],
      ),
    );
  }
}
