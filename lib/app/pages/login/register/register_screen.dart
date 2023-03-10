// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/login/email/controller/login_with_email_controller.dart';
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
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppStyle.backgroundColor,
            body: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const TopRegisterScreen(),
                    BottomRegisterScreen(
                        usernameController: usernameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        formkey: _formkey,
                        loginWithEmailInstance: loginWithEmailInstance)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class TopRegisterScreen extends StatelessWidget {
  const TopRegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .43,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/exclusive-diary-icon.png',
            height: MediaQuery.of(context).size.height * .2,
          ),
          const SizedBox(height: 10),
          Text('Exclusive Diary',
              style: AppStyle.mainText.copyWith(
                fontSize: 55,
                fontFamily: 'DancingScript-Regular',
              ))
        ],
      )),
    );
  }
}

class BottomRegisterScreen extends StatelessWidget {
  const BottomRegisterScreen({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formkey,
    required this.loginWithEmailInstance,
  }) : _formkey = formkey;

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formkey;
  final LoginWithEmailController loginWithEmailInstance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .52,
      width: MediaQuery.of(context).size.width * .95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField.email(
            textEditingController: usernameController,
            hintText: 'Nome de usu??rio',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'O nome de usu??rio n??o pode ser vazio';
              } else if (value.length < 6) {
                return 'O nome de usu??rio precisa ter no m??nimo 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField.email(
            textEditingController: emailController,
            hintText: 'Email',
            validator: (_email) {
              final email = _email ?? '';
              if (email.trim().isEmpty) {
                return 'Email n??o pode ser vazio.';
              } else if (!email.trim().contains('@')) {
                return 'Informe um Email v??lido.';
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
                return 'Informe uma senha v??lida.';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomElevatedButton(
                image: const Icon(Icons.login, color: AppStyle.primaryColor),
                text: 'Criar conta',
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    loginWithEmailInstance.createAccount(
                      username: usernameController.text.trim(),
                      emailAddress: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  }
                }),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('J?? possui uma conta?', style: AppStyle.regularText),
              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(AppStyle.secondaryColor)),
                  onPressed: () => Get.offNamed('/login'),
                  child: Text(
                    'Fa??a login!',
                    style: AppStyle.mainText
                        .copyWith(decoration: TextDecoration.underline),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
