import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_style.dart';

class CarouselController extends GetxController {
  var currentPage = 0.obs;

  List<Map<String, dynamic>> carouselTexts = [
    {'id': 0, 'text': "O lugar ideal para anotar a melhor parte do seu dia."},
    {'id': 1, 'text': "Nunca esqueça daquele momento especial."},
    {'id': 2, 'text': "Bem vindo ao seu diário."}
  ].obs;

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
            color: currentPage == i['id']
                ? AppStyle.primaryColor
                : AppStyle.secondaryColor,
            shape: BoxShape.circle,
          ),
        );
      },
    ).toList();
  }
}
