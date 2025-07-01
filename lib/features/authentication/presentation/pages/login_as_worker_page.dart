import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/authentication/presentation/pages/register_as_worker_page.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'package:home_service/widgets/navigationbarWorker.dart';
import 'package:home_service/widgets/social_icon_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginAsWorker extends StatefulWidget {
  const LoginAsWorker({super.key});

  static String id = 'login page as worker';
  @override
  State<LoginAsWorker> createState() => _LoginAsWorkerState();
}

class _LoginAsWorkerState extends State<LoginAsWorker> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? errorText;

  void _handleLoginSuccess(Map<String, dynamic> userData) async {
    final userType = await di.sl<TokenService>().getUserType();
    if (userType == 'Worker') {
      Navigator.pushNamed(context, NavigationbarWorker.id, arguments: userData);
    } else {
      await di.sl<TokenService>().clearToken();
      setState(() {
        errorText = "You cannot login here with this account type.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          setState(() {
            isLoading = true;
            errorText = null;
          });
        } else if (state is LoginSuccess) {
          setState(() {
            isLoading = false;
          });
          _handleLoginSuccess(state.userData);
        } else if (state is AuthenticationError) {
          setState(() {
            isLoading = false;
            errorText = state.message;
          });
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    'Sign in as a worker',
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
                                  email = data;
                                },
                                title: 'Email',
                                headtextfield: 'Enter Your Email',
                              ),
                              const SizedBox(height: 20),
                              Textfield(
                                obscuretext: true,
                                onchanged: (data) {
                                  password = data;
                                },
                                title: 'Password',
                                headtextfield: 'Enter Your Password',
                              ),
                              if (errorText != null) ...[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      errorText!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 60),
                              Button(
                                ontap: () async {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    if (email != null && password != null) {
                                      context
                                          .read<AuthenticationCubit>()
                                          .login(email!, password!);
                                    }
                                  }
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
                                          context, RegisterAsWorker.id);
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
                              const Row(
                                children: [
                                  Expanded(
                                    child: Divider(thickness: 1),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                      // TODO: Implement Apple sign-in
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  SocialIconButton(
                                    imagePath: 'assets/images/google.png',
                                    onTap: () {
                                      // TODO: Implement Google sign-in
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  SocialIconButton(
                                    imagePath: 'assets/images/facebook.png',
                                    onTap: () {
                                      // TODO: Implement Facebook sign-in
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
      },
    );
  }
}
