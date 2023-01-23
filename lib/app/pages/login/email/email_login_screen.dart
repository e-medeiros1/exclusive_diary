// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../google/widgets/custom_elevatedbutton.dart';
import 'controller/login_with_email_controller.dart';
import 'widgets/custom_text_field.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> pwdVisibility = false.obs;
    final loginWithEmailInstance = Get.put(LoginWithEmailController());
    final _formkey = GlobalKey<FormState>();

    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField.email(
            textEditingController: emailController,
            hintText: 'Email',
            validator: (_email) {
              final email = _email ?? '';
              if (email.trim().isEmpty) {
                return 'Email não pode ser vazio.';
              } else if (!email.trim().contains('@')) {
                return 'Informe um Email válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Obx(
            () => CustomTextField.password(
              textEditingController: passwordController,
              hintText: 'Senha',
              obscureText: !pwdVisibility.value,
              suffixIcon: GestureDetector(
                onTap: () {
                  pwdVisibility.value = !pwdVisibility.value;
                },
                child: Icon(
                  // ignore: unrelated_type_equality_checks
                  pwdVisibility == true
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppStyle.primaryColor,
                  size: 18,
                ),
              ),
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 6) {
                  return 'Informe uma senha válida.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomElevatedButton(
                image: const Icon(Icons.login, color: AppStyle.primaryColor),
                text: 'Entrar',
                onPressed: () {
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppStyle.primaryColor),
                    backgroundColor: AppStyle.backgroundColor,
                  );
                  if (_formkey.currentState!.validate()) {
                    loginWithEmailInstance.loginWithEmailAndPassword(
                        emailAddress: emailController.text.trim(),
                        password: passwordController.text.trim());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
