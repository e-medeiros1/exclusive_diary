import 'package:exclusive_diary/app/pages/login/email_login/email_login_screen.dart';
import 'package:exclusive_diary/app/pages/login/register/register_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final loginWithGoogleInstance = Get.put(LoginWithGoogleController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EmailLoginScreen(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomElevatedButton(
                      onPressed: () => loginWithGoogleInstance.signInWithGoogle(
                          context: context),
                      icon: Icons.facebook_outlined,
                      text: 'Entre com Google',
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Ainda não possui uma conta?',
                            style: TextStyle(fontSize: 16, letterSpacing: -1),
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.black12)),
                              onPressed: () {
                                Get.to(()=>const RegisterScreen());
                              },
                              child: const Text(
                                'Cadastre-se!',
                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: -.9,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.black87,
                                ),
                              )),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
