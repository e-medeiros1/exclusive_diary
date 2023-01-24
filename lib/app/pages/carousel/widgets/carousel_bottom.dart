import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/carousel/controller/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/google/widgets/custom_elevatedbutton.dart';
import '../../login/login_screen.dart';

// ignore: must_be_immutable
class CarouselBottom extends StatelessWidget {
  int currentPage;
  CarouselBottom({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final CarouselController carouselInstance = Get.find<CarouselController>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage != 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselInstance.indicators(),
            ),
          if (currentPage == 2)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1),
              child: CustomElevatedButton(
                  onPressed: () => Get.off(() => const LoginScreen()),
                  image: const Icon(
                    Icons.navigate_next_outlined,
                    color: AppStyle.primaryColor,
                  ),
                  text: 'Avançar'),
            ),
        ],
      ),
    );
  }
}
