import 'package:flutter/material.dart';
import 'package:home_service/Pages/login.dart';
import 'package:home_service/constants/constants.dart';
import 'package:home_service/widgets/button.dart';

class Startpage extends StatelessWidget {
  const Startpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Image.asset(
              klogo,
              ),
            ),

            const Text(
            'Let\'s get Start',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:20,
            ),
            ),

            const SizedBox(height: 25,),

            const Text(
            'Connecting you with skilled professionals for all your home and personal needs.',
            style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            letterSpacing: 0.5,
            height: 1.5,
            ),
            textAlign: TextAlign.center,
            ),

            const SizedBox(height: 105,),

            Button(
                ontap: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                title: 'Let\'s Start....'),
          ],
        ),
      ),
    );
  }
}