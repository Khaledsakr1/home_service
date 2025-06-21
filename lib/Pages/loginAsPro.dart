import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_service/Pages/SuceesScreenAsPro.dart';
import 'package:home_service/Pages/registerAsPro.dart';
import 'package:home_service/auth/AuthServices.dart';
import 'package:home_service/constants/constants.dart';
import 'package:home_service/helper/ErrorMessage.dart';
import 'package:home_service/helper/OverlayMessage.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/widgets/social_icon_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginaspro extends StatefulWidget {
  Loginaspro({super.key});

  static String id = 'login page as pro';
  @override
  State<Loginaspro> createState() => _LoginPageState();
}

class _LoginPageState extends State<Loginaspro> {
  String? Email;
  String? Password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isloading = false;
  AuthService _authService = AuthService(); // إنشاء كائن من AuthService

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(), // منع السحب
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // توزيع كل العناصر
                        children: [
                          const SizedBox(height: 40),
                          Image.asset(
                            ksignin,
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            children: [
                              Text(
                                'Sign in as a pro',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Textfield(
                            onchanged: (data) {
                              Email = data;
                            },
                            title: 'Email address',
                            headtextfield: 'Enter Your Email',
                          ),
                          const SizedBox(height: 20),
                          Textfield(
                            obscuretext: true,
                            onchanged: (data) {
                              Password = data;
                            },
                            title: 'Password',
                            headtextfield: 'Enter Your Password',
                          ),
                          const SizedBox(height: 20),
                          Button(
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                isloading = true;
                                setState(() {});
                                try {
                                  await UserLogin();
                                  showCustomOverlayMessage(
                                    context,
                                    message: "Login Successful! Welcome",
                                  );
                                  Navigator.pushNamed(
                                      context, Suceesscreenaspro.id,
                                      arguments: Email);
                                } on FirebaseAuthException {
                                  showErrorOverlayMessage(
                                    context,
                                    errorMessage: "Something went wrong!",
                                    subMessage:
                                        "There was an error in your email or password",
                                  );
                                }

                                isloading = false;
                                setState(() {});
                              } else {}
                            },
                            title: 'Login',
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  height: 1.5,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Registeraspro.id);
                                },
                                child: const Text(
                                  '  Sign up',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: const [
                              Expanded(
                                child: Divider(thickness: 1),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Or Sign Up with',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(thickness: 1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialIconButton(
                                imagePath: 'assets/images/apple.png',
                                onTap: () {
                                  // تسجيل بأبل
                                },
                              ),
                              const SizedBox(width: 20),
                              SocialIconButton(
                                imagePath: 'assets/images/google.png',
                                onTap: () {
                                  _authService.signInWithGooglePro(
                                      context); // تسجيل بجوجل
                                },
                              ),
                              const SizedBox(width: 20),
                              SocialIconButton(
                                imagePath: 'assets/images/facebook.png',
                                onTap: () {
                                  // تسجيل بفيسبوك
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> UserLogin() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email!, password: Password!);
  }
}
