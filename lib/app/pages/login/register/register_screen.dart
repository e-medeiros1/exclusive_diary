// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:exclusive_diary/app/pages/login/email/controller/login_with_email_controller.dart';
import 'package:exclusive_diary/app/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../email/widgets/custom_text_field.dart';
import '../google/widgets/custom_elevatedbutton.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginWithEmailController loginWithEmailInstance =
      Get.find<LoginWithEmailController>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomTextField.email(
                  textEditingController: usernameController,
                  hintText: 'Nome de usuário',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome de usuário não pode ser vazio';
                    } else if (value.length < 6) {
                      return 'O nome de usuário precisa ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
              ),
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
                    icon: Icons.login,
                    text: 'Criar conta',
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        loginWithEmailInstance.createAccount(
                            username: usernameController.text.trim(),
                            emailAddress: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            context: context);
                      }
                    }),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'Já possui uma conta?',
                    style: TextStyle(fontSize: 16, letterSpacing: -1),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.black12)),
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: const Text(
                        'Faça login!',
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
      )),
    );
  }
}
