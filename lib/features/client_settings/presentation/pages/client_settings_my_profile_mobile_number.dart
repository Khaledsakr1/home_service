import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/Button.dart';

class SettingsmyprofileMobilenumber extends StatelessWidget {
  const SettingsmyprofileMobilenumber({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

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
          'Mobile phone number',
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
            'Your phone number',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your number is only displayed to customers you respond to and to the logo. '
            'If you want to change it, we\'ll send you a text message to verify it.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // +20 Container
              Container(
                height: 58,
                margin: const EdgeInsets.only(top: 34),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Text(
                      '+20',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Textfield مع title
              Expanded(
                child: Textfield(
                  controller: phoneController,
                  title: 'Phone number',
                  headtextfield: 'Enter your phone Number',
                ),
              ),
            ],
          ),
          const SizedBox(height: 380),
          Button(
            title: 'Save',
            ontap: () {
              // هنا منطق الحفظ
            },
          ),
        ],
      ),
    );
  }
}
