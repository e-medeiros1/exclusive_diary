import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/carousel/controller/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/carousel_bottom.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late final PageController _pageController = PageController();
  final CarouselController controller = Get.put(CarouselController());

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      var next = _pageController.page!.round();

      if (controller.currentPage.value != next) {
        controller.currentPage.value = next;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppStyle.backgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: AppStyle.primaryColor,
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: controller.carouselTexts.length,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    controller.currentPage.value = page;
                  });
                },
                itemBuilder: (_, pagePosition) {
                  bool active = pagePosition == controller.currentPage.value;
                  double margin = active ? 10 : 20;
                  return controller.slider(
                      active: active,
                      margin: margin,
                      texts: controller.carouselTexts[pagePosition]['text']);
                },
              ),
            ),
            const SizedBox(height: 10),
            CarouselBottom(currentPage: controller.currentPage.value,)
          ],
        ),
      ),
    );
  }
}
