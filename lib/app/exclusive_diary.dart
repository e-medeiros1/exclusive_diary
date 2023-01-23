import 'package:exclusive_diary/app/pages/carousel/carousel_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExclusiveDiary extends StatelessWidget {
  const ExclusiveDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Exclusive Notes',
      debugShowCheckedModeBanner: false,
      home: CarouselScreen(),
    );
  }
}
