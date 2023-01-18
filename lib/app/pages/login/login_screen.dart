import 'package:exclusive_diary/app/pages/login/email_login/controller/login_with_email_controller.dart';
import 'package:exclusive_diary/app/pages/login/email_login/email_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'google_login/controller/login_with_google_controller.dart';
import 'google_login/widgets/custom_elevatedbutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginWithGoogleInstance = Get.put(LoginWithGoogleController());
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomElevatedButton(
                onPressed: () => loginWithGoogleInstance.signInWithGoogle(
                    context: context),
                icon: Icons.facebook_outlined,
                text: 'Entre com Google',
              ),
              const SizedBox(height: 10),
              CustomElevatedButton(
                onPressed: () {
                  Get.to(() => const RegisterScreen());
                },
                icon: Icons.email_outlined,
                text: 'Entre com Email',
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
