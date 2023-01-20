import 'package:exclusive_diary/app/pages/login/google/controller/login_with_google_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/exclusive_diary.dart';
import 'app/pages/login/email/controller/login_with_email_controller.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(LoginWithEmailController());
    Get.put(LoginWithGoogleController());
  });
  runApp(const ExclusiveDiary());
}
