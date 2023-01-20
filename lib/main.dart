import 'package:exclusive_diary/app/pages/login/email_login/controller/login_with_email_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/exclusive_diary.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(LoginWithEmailController()));
  runApp(const ExclusiveDiary());
}
