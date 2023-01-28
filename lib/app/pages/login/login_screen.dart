import 'package:exclusive_diary/app/core/components/line_separator.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/login/email/controller/login_with_email_controller.dart';
import 'package:exclusive_diary/app/pages/login/email/email_login_screen.dart';
import 'package:exclusive_diary/app/pages/login/email/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'google/controller/login_with_google_controller.dart';
import 'google/widgets/custom_elevatedbutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final recoveryEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String assetName = 'assets/images/google-logo.svg';
    final Widget svgImage = SvgPicture.asset(assetName);
    final loginWithGoogleInstance = Get.put(LoginWithGoogleController());
    final loginWithEmailInstance = Get.put(LoginWithEmailController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: SafeArea(
          child: Scaffold(
              backgroundColor: AppStyle.backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const TopLoginScreen(),
                    BottomLoginScreen(
                        loginWithEmailInstance: loginWithEmailInstance,
                        loginWithGoogleInstance: loginWithGoogleInstance,
                        svgImage: svgImage),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class TopLoginScreen extends StatelessWidget {
  const TopLoginScreen({
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

class BottomLoginScreen extends StatelessWidget {
  const BottomLoginScreen({
    super.key,
    required this.loginWithEmailInstance,
    required this.loginWithGoogleInstance,
    required this.svgImage,
  });

  final LoginWithGoogleController loginWithGoogleInstance;
  final LoginWithEmailController loginWithEmailInstance;
  final Widget svgImage;

  @override
  Widget build(BuildContext context) {
    TextEditingController recoveryEmail = TextEditingController();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .57,
      width: MediaQuery.of(context).size.width * .95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmailLoginScreen(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Get.defaultDialog(
                    backgroundColor: AppStyle.backgroundColor,
                    titleStyle: AppStyle.mainText,
                    title: 'Recuperação de senha!',
                    titlePadding: const EdgeInsets.only(top: 20),
                    contentPadding: const EdgeInsets.all(20),
                    content: CustomTextField.email(
                        textEditingController: recoveryEmail,
                        hintText: 'Digite um email de recuperação'),
                    confirm: CustomElevatedButton(
                      image: const Icon(
                        Icons.mail_outline,
                        color: AppStyle.primaryColor,
                      ),
                      text: 'Enviar email',
                      onPressed: () {
                        loginWithEmailInstance.resetPassword(
                            email: recoveryEmail.text);
                        Navigator.of(context).pop();
                      },
                    ),
                    cancel: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancelar',
                        style: AppStyle.regularText,
                      ),
                    )),
                child: Text('Esqueceu sua senha?    ',
                    style: AppStyle.regularText),
              ),
            ],
          ),
          const LineSeparator(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomElevatedButton(
                  onPressed: () => loginWithGoogleInstance.signInWithGoogle(),
                  image: svgImage,
                  text: 'Entre com Google')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ainda não possui uma conta?',
                      style: AppStyle.regularText),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              AppStyle.secondaryColor)),
                      onPressed: () => Get.toNamed('/register'),
                      child: Text('Cadastre-se!',
                          style: AppStyle.mainText
                              .copyWith(decoration: TextDecoration.underline))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
