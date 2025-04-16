import 'package:flutter/material.dart';
import 'package:home_service/Pages/login.dart';
import 'package:home_service/Pages/loginAsPro.dart';
import 'package:home_service/widgets/button.dart';

class Clientandprostart extends StatelessWidget {
  const Clientandprostart({super.key});

  static String id = 'Clientandprostart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose Sign in type:',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),

                // زر تسجيل الدخول كعميل
                Button(
                  title: 'Sign in as a client',
                  ontap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                ),
                const SizedBox(height: 15),

                // زر تسجيل الدخول كمحترف
                Button(
                  title: 'Sign in as a Pro',
                  ontap: () {
                    Navigator.pushNamed(context, Loginaspro.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
