import 'package:flutter/material.dart';
import 'package:home_service/features/authentication/presentation/pages/check_worker_already_login.dart';
import 'package:home_service/features/authentication/presentation/pages/login_as_worker_page.dart';
import 'package:home_service/features/authentication/presentation/pages/login_page.dart';
import 'package:home_service/widgets/button.dart';

class ClientandWorkerstart extends StatelessWidget {
  const ClientandWorkerstart({super.key});

  static String id = 'ClientandWorkerstart';

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
              mainAxisSize: MainAxisSize.min,
              children: [
                // صورة توضيحية بدلاً من الايقونة
                Image.asset(
                  'assets/images/what.png',
                  height: 200,
                ),
                const SizedBox(height: 30),

                // النص العلوي
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
                          text: 'logo',
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

                const Text(
                  'Before we begin, we want to know if you are a customer or a technician. Please choose which one you are.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 50),

                // زر تسجيل الدخول كعميل
                Button(
                  icon: Icons.person,
                  title: 'client',
                  ontap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                ),
                const SizedBox(height: 15),

                // زر تسجيل الدخول كمحترف
                Button(
                  icon: Icons.engineering,
                  title: 'technical',
                  ontap: () {
                    Navigator.pushNamed(context, WorkerAlreadLogin.id);
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
