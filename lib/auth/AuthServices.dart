import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:home_service/Pages/SuceesScreen.dart';
import 'package:home_service/Pages/SuceesScreenAsPro.dart';
import 'package:home_service/helper/ErrorMessage.dart';
import 'package:home_service/helper/OverlayMessage.dart';

class AuthService {
  // تسجيل دخول المستخدم باستخدام البريد الإلكتروني وكلمة المرور
  Future<UserCredential?> userLogin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  // تسجيل دخول باستخدام جوجل
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showErrorOverlayMessage(
          context,
          errorMessage: "Something went wrong!",
          subMessage: "Login cancelled by user",
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      showCustomOverlayMessage(
        context,
        message: "Login With Google Successful! Welcome",
      );
      Navigator.pushNamed(context, SuccessScreen.id);
    } catch (e) {
      showErrorOverlayMessage(
        context,
        errorMessage: "Something went wrong!",
        subMessage: "Error during Google Sign-In : ${e.toString()}",
      );
    }
  }

  // تسجيل دخول باستخدام جوجل pro
  Future<void> signInWithGooglePro(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showErrorOverlayMessage(
          context,
          errorMessage: "Something went wrong!",
          subMessage: "Login cancelled by user",
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      showCustomOverlayMessage(
        context,
        message: "Login With Google Successful! Welcome",
      );
      Navigator.pushNamed(context, Suceesscreenaspro.id);
    } catch (e) {
      showErrorOverlayMessage(
        context,
        errorMessage: "Something went wrong!",
        subMessage: "Error during Google Sign-In : ${e.toString()}",
      );
    }
  }
}
