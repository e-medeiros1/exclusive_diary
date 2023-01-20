// ignore_for_file: no_leading_underscores_for_local_identifiers

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
          CustomTextField.password(
            textEditingController: passwordController,
            hintText: 'Senha',
            validator: (_password) {
              final password = _password ?? '';
              if (password.isEmpty || password.length < 6) {
                return 'Informe uma senha válida.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomElevatedButton(
                image: const Icon(Icons.login, color: Color(0xFF87575C)),
                text: 'Entrar',
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    loginWithEmailInstance.loginWithEmailAndPassword(
                      emailAddress: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      context: context,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
