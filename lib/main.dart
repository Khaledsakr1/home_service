import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_service/Pages/ClientAndProStart.dart';
import 'package:home_service/Pages/SuceesScreen.dart';
import 'package:home_service/Pages/SuceesScreenAsPro.dart';
import 'package:home_service/Pages/homepage.dart';
import 'package:home_service/Pages/homepageForPro.dart';
import 'package:home_service/Pages/login.dart';
import 'package:home_service/Pages/loginAsPro.dart';
import 'package:home_service/Pages/register.dart';
import 'package:home_service/Pages/registerAsPro.dart';
import 'package:home_service/Pages/startpage.dart';
import 'package:home_service/firebase_options.dart';
import 'package:home_service/widgets/navigationbar.dart';
import 'package:home_service/widgets/navigationbarPro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Homeservice());
}

class Homeservice extends StatelessWidget {
  const Homeservice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        Loginaspro.id: (context) => Loginaspro(),
        Registeraspro.id: (context) => Registeraspro(),
        Homepage.id: (context) => Homepage(),
        Homepageforpro.id: (context) => Homepageforpro(),
        Navigationbar.id: (context) => Navigationbar(),
        NavigationbarPro.id: (context) => NavigationbarPro(),
        Clientandprostart.id: (context) => Clientandprostart(),
        SuccessScreen.id: (context) => SuccessScreen(),
        Suceesscreenaspro.id: (context) => Suceesscreenaspro(),
      },
      debugShowCheckedModeBanner: false,
      home: Startpage(),
    );
  }
}
