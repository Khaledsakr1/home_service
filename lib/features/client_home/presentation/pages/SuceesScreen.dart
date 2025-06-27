import 'package:flutter/material.dart';
import 'package:home_service/widgets/navigationbar.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});
  static String id = 'SuccessScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Done.png', // استبدل هذه برسمتك المناسبة
              height: 300,
            ),
            const SizedBox(height: 30),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: 'Welcome to '),
                  TextSpan(
                    text: 'logo!',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your profile has been created successfully!',
              style: TextStyle(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                 Navigator.pushAndRemoveUntil(context, 
                 MaterialPageRoute(builder: (context) => const Navigationbar()),
              (Route<dynamic> route) => false, // هذه المعاملات تحذف كل الصفحات السابقة
                 );
                },
                child: const Text(
                  'next',
                  style: TextStyle(fontSize: 16 , color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


