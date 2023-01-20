// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../google_login/widgets/custom_elevatedbutton.dart';
import 'controller/login_with_email_controller.dart';
import 'widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    final formkey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Visibility(
                visible: loginWithEmailInstance.isRegister.value,
                child: Padding(
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
                child: Obx(
                  () => CustomElevatedButton(
                      icon: Icons.login,
                      text: !loginWithEmailInstance.isRegister.value
                          ? 'Entrar'
                          : 'Criar conta',
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          if (loginWithEmailInstance.isRegister.value == true) {
                            loginWithEmailInstance.createAccount(
                                username: usernameController.text.trim(),
                                emailAddress: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context);
                          } else {
                            loginWithEmailInstance.loginWithEmailAndPassword(
                                emailAddress: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context);
                          }
                        }
                      }),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                      !loginWithEmailInstance.isRegister.value
                          ? 'Ainda não possui uma conta?'
                          : 'Já possui uma conta?',
                      style: const TextStyle(fontSize: 16, letterSpacing: -1),
                    )),
                TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.black12)),
                    onPressed: () {
                      loginWithEmailInstance.swicthMode();
                    },
                    child: Obx(() => Text(
                          !loginWithEmailInstance.isRegister.value
                              ? 'Cadastre-se!'
                              : 'Faça login!',
                          style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: -.9,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.black87),
                        ))),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
