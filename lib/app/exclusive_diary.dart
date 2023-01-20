import 'package:exclusive_diary/app/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/custom_theme.dart';

class ExclusiveDiary extends StatelessWidget {
  const ExclusiveDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exclusive Notes',
      theme: customTheme().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF0EBE5),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
