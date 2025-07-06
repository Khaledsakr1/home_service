import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:home_service/common/pages/landing_page.dart';

class SplashAnimatedPage extends StatelessWidget {
  const SplashAnimatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      duration: 10,
      animationDuration: const Duration(milliseconds: 500),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 300, // حجم مخصص للـ splash (لا يملأ الشاشة)
      splash: Center(
        child: Image.asset(
          'assets/images/Splash Animatedd.gif',
          height: 200, // الحجم المناسب لعرضه
          fit: BoxFit.contain,
        ),
      ),
      nextScreen: const LandingPage(),
    );
  }
}
