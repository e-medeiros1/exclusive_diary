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
  final loginWithEmailInstance = Get.put(LoginWithEmailController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Visibility(
              visible: loginWithEmailInstance.isRegister.value,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomTextField.email(
                    textEditingController: usernameController,
                    hintText: 'Nome de usuário'),
              ),
            ),
          ),
          CustomTextField.email(
            textEditingController: emailController,
            hintText: 'Email',
          ),
          const SizedBox(height: 10),
          CustomTextField.password(
            textEditingController: passwordController,
            hintText: 'Senha',
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomElevatedButton(
                icon: Icons.login,
                text: 'Entrar',
                onPressed: () {
                  if (loginWithEmailInstance.isRegister.value == true) {
                    loginWithEmailInstance.createAccount(
                        username: usernameController.text,
                        emailAddress: emailController.text,
                        password: passwordController.text,
                        context: context);
                  } else {
                    loginWithEmailInstance.loginWithEmailAndPassword(
                        emailAddress: emailController.text,
                        password: passwordController.text,
                        context: context);
                  }
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    loginWithEmailInstance.isRegister.value == false
                        ? 'Ainda não possui uma conta?'
                        : 'Já possui uma conta?',
                    style: const TextStyle(fontSize: 16, letterSpacing: -1),
                  )),
              TextButton(
                  onPressed: () {
                    loginWithEmailInstance.swicthMode();
                    print(loginWithEmailInstance.isRegister.value);
                  },
                  child: Obx(() => Text(
                        loginWithEmailInstance.isRegister.value == false
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
      )),
    );
  }
}
