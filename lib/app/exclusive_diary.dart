import 'package:exclusive_diary/app/services/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/custom_theme.dart';

class ExclusiveDiary extends StatelessWidget {
  const ExclusiveDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exclusive Notes',
      theme: customTheme(),
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    );
  }
}
