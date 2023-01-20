import 'package:exclusive_diary/app/pages/login/email/controller/login_with_email_controller.dart';
import 'package:exclusive_diary/app/pages/login/google/controller/login_with_google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginWithGoogleController googleInstance =
        Get.put(LoginWithGoogleController());
    final LoginWithEmailController emailInstance =
        Get.put(LoginWithEmailController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Exclusive Diary'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                googleInstance.signOut(context: context);
                emailInstance.signOut(context: context);
              },
              child: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: Container());
  }
}
