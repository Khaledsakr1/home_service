import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/Button.dart';

class SettingsmyprofileInformation extends StatelessWidget {
  const SettingsmyprofileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
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
          'Profile Information',
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
          const SizedBox(height: 16),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/Image.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kPrimaryColor,
                  child: const Icon(Icons.camera_alt,
                      size: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Textfield(
            title: 'First name',
            headtextfield: 'Enter your first name',
          ),
          const SizedBox(height: 7),
          const Textfield(
            title: 'Last name',
            headtextfield: 'Enter your last name',
          ),
          const SizedBox(height: 7),
          const Textfield(
          title: 'Company name',
            headtextfield: 'Enter your company name',
          ),
          const SizedBox(height: 4),
          const Text(
            'This is your public profile name.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 7),
          const Textfield(
          title: 'Email address',
            headtextfield: 'Enter your email',
          ),
          const SizedBox(height: 20),
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
