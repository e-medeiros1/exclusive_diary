import 'package:exclusive_diary/app/pages/carousel/carousel_screen.dart';
import 'package:exclusive_diary/app/pages/home/diary/diary_edit/diary_edit_screen.dart';
import 'package:exclusive_diary/app/pages/home/home_screen.dart';
import 'package:exclusive_diary/app/pages/login/login_screen.dart';
import 'package:exclusive_diary/app/pages/login/register/register_screen.dart';
import 'package:exclusive_diary/app/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? getPages = [
    GetPage(
    name: '/',
    page: () => const SplashScreen(),
    curve: Curves.easeIn,
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/carousel',
    page: () => const CarouselScreen(),
    curve: Curves.easeIn,
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),

  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
    curve: Curves.easeIn,
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/register',
    page: () => const RegisterScreen(),
    curve: Curves.easeIn,
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    curve: Curves.easeIn,
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/edit',
    page: () => const DiaryEditScreen(),
    curve: Curves.easeIn,
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
