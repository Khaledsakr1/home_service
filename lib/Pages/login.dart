import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_service/Pages/SuceesScreen.dart';
import 'package:home_service/Pages/register.dart';
import 'package:home_service/auth/AuthServices.dart';
import 'package:home_service/constants/constants.dart';
import 'package:home_service/helper/show_snackbar.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/widgets/social_icon_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id = 'loginpage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                          const SizedBox(height: 55),
                          Image.asset(
                            ksignin,
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            children: [
                              Text(
                                'Sign in as a client',
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
                            headtextfield: 'Enter Your Email',
                          ),
                          const SizedBox(height: 20),
                          Textfield(
                            obscuretext: true,
                            onchanged: (data) {
                              Password = data;
                            },
                            headtextfield: 'Enter Your Password',
                          ),
                          const SizedBox(height: 60),
                          Button(
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                isloading = true;
                                setState(() {});
                                try {
                                  await UserLogin();
                                  ShowSnackBar(
                                      context, 'Login Successful! Welcome');
                                  Navigator.pushNamed(context, SuccessScreen.id,
                                      arguments: Email);
                                } on FirebaseAuthException {
                                  ShowSnackBar(context,
                                      'There was an error in your email or password');
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
                                  Navigator.pushNamed(context, RegisterPage.id);
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
                                  _authService
                                      .signInWithGoogle(context); // تسجيل بجوجل
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
