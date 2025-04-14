import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_service/Pages/homepage.dart';
import 'package:home_service/Pages/login.dart';
import 'package:home_service/Pages/register.dart';
import 'package:home_service/Pages/startpage.dart';
import 'package:home_service/firebase_options.dart';
import 'package:home_service/widgets/navigationbar.dart';

void main() async{
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
        Homepage.id: (context) => Homepage(),
        Navigationbar.id: (context) => Navigationbar(),
      },
      debugShowCheckedModeBanner: false,
      home: Startpage(),
    );
  }
}