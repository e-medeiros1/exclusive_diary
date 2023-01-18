import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar extends GetxController{
  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        content,
        style: const TextStyle(
            color: Colors.black, letterSpacing: 0.5, fontSize: 18),
      ),
    );
  }
}
