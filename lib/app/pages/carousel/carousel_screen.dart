import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/google/widgets/custom_elevatedbutton.dart';
import '../login/login_screen.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _currentPage = 0;
  late final PageController _pageController = PageController();

  var carouselTexts = [
    {'id': 0, 'text': "O lugar ideal para anotar a melhor parte do seu dia."},
    {'id': 1, 'text': "Nunca esqueça daquele momento especial."},
    {'id': 2, 'text': "Bem vindo ao seu diário."}
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();

      if (_currentPage != next) {
        _currentPage = next;
      }
    });
  }

  slider({texts, margin, active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      margin: EdgeInsets.all(margin),
      child: Center(
        child: Text(
          texts.toString(),
          softWrap: true,
          style: AppStyle.mainText.copyWith(fontSize: 45),
        ),
      ),
    );
  }

  indicators() {
    return carouselTexts.map(
      (i) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: _currentPage == i['id']
                ? AppStyle.primaryColor
                : AppStyle.secondaryColor,
            shape: BoxShape.circle,
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              itemCount: carouselTexts.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (_, pagePosition) {
                bool active = pagePosition == _currentPage;
                double margin = active ? 10 : 20;
                return slider(
                    active: active,
                    margin: margin,
                    texts: carouselTexts[pagePosition]['text']);
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentPage != 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicators(),
                  ),
                if (_currentPage == 2)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .1),
                    child: CustomElevatedButton(
                        onPressed: () => Get.off(() => const LoginScreen()),
                        text: 'Avançar'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
