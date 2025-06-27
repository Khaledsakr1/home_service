import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/authentication/presentation/pages/sign_up_worker_name_page.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterAsWorker extends StatefulWidget {
  const RegisterAsWorker({super.key});

  static String id = 'register page as worker';

  @override
  State<RegisterAsWorker> createState() => _RegisterAsWorkerState();
}

class _RegisterAsWorkerState extends State<RegisterAsWorker> {
  String? email;
  String? password;
  String? confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is EmailCheckResult) {
          setState(() {
            isLoading = false;
          });
          if (state.exists) {
            showErrorOverlayMessage(context,
                errorMessage: 'Email already exists',
                subMessage: 'This email already exists, sign in to continue.');
          } else {
            final worker = WorkerModel(
              serviceId: 0, // temporary dummy value
              description: '',
              fullName: '', // you can fill later
              email: email!,
              password: password!,
              confirmPassword: password!,
              phoneNumber: '',
              address: '',
              buildingNumber: '',
              cityId: 0,
              experienceYears: 0,
            );
            Navigator.pushNamed(context, SignUpWorkerPage.id,
                arguments: worker);
          }
        } else if (state is AuthenticationError) {
          setState(() {
            isLoading = false;
          });
          showErrorOverlayMessage(context, errorMessage: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 120),
                      Image.asset(
                        ksignup,
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 60),
                      const Row(
                        children: [
                          Text(
                            'Sign up as a worker',
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
                          email = data;
                        },
                        title: 'Email',
                        headtextfield: 'Create New Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Textfield(
                        obscuretext: true,
                        onchanged: (data) {
                          password = data;
                        },
                        title: 'Password',
                        headtextfield: 'Create New Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters.';
                          }
                          if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\[\]`~]')
                              .hasMatch(value)) {
                            return 'Must include at least one non-alphanumeric character.';
                          }
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return 'Must include at least one digit.';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Must include at least one uppercase letter.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Textfield(
                        obscuretext: true,
                        onchanged: (data) {
                          confirmPassword = data;
                        },
                        title: 'Confirm Password',
                        headtextfield: 'Confirm Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }
                          if (value != password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                        ontap: () async {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            if (email != null) {
                              context
                                  .read<AuthenticationCubit>()
                                  .checkEmail(email!);
                            }
                          }
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
      },
    );
  }
}
