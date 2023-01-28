import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/carousel/carousel_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      centered: true,
      splash: 'assets/images/exclusive-diary-icon.png',
      nextScreen: const CarouselScreen(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 500,
      curve: Curves.easeIn,
      backgroundColor: AppStyle.backgroundColor,
      splashIconSize: MediaQuery.of(context).size.height * .2,
    );
  }
}
