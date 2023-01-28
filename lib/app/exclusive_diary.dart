import 'package:exclusive_diary/app/core/routes/names_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExclusiveDiary extends StatelessWidget {
  const ExclusiveDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exclusive Notes',
      debugShowCheckedModeBanner: false,
      getPages: getPages,
    );
  }
}
