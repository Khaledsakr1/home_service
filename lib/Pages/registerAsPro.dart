import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_service/constants/constants.dart';
import 'package:home_service/helper/ErrorMessage.dart';
import 'package:home_service/helper/OverlayMessage.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registeraspro extends StatefulWidget {
  Registeraspro({super.key});

  static String id = 'register page as pro';

  @override
  State<Registeraspro> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Registeraspro> {
  String? Email;

  String? Password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Image.asset(
                    ksignup,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 60),
                  const Row(
                    children: [
                      Text(
                        'Sign up as a pro',
                        style: TextStyle(
                          fontSize: 25,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Textfield(
                    onchanged: (data) {
                      Email = data;
                    },
                    title: 'Email address',
                    headtextfield: 'Create New Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Textfield(
                    obscuretext: true,
                    onchanged: (data) {
                      Password = data;
                    },
                    title: 'Password',
                    headtextfield: 'Create New Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          await UserRegister();
                          showCustomOverlayMessage(
                            context,
                            message: "Registering Successfully Go And Login",
                          );
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            showErrorOverlayMessage(
                              context,
                              errorMessage: "Weak Password",
                            );
                          } else if (ex.code == 'email-already-in-use') {
                            showErrorOverlayMessage(
                              context,
                              errorMessage: "Something went wrong!",
                              subMessage: "Email already exist",
                            );
                          } else {
                            showErrorOverlayMessage(
                              context,
                              errorMessage: "Something went wrong!",
                              subMessage: "Please try again later.",
                            );
                          }
                        }

                        isloading = false;
                        setState(() {});
                      } else {}
                    },
                    title: 'Create account',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'have an account?',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            height: 1.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '  Sign in',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> UserRegister() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email!, password: Password!);
  }
}
