import 'dart:developer';

import 'package:exclusive_diary/app/core/components/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWithEmailController extends GetxController {
  final FirebaseAuth instance = FirebaseAuth.instance;
  final CustomSnackbar snackbarInstance = Get.put(CustomSnackbar());
  var isRegister = false.obs;

  loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    final navigator = ScaffoldMessenger.of(context);
    try {
      instance.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.showSnackBar(
          snackbarInstance.customSnackBar(
            content: 'Usuário não cadastrado.',
          ),
        );
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.showSnackBar(
          snackbarInstance.customSnackBar(
            content: 'Senha incorreta.',
          ),
        );
        log('Wrong password provided for that user.');
      }
    }
  }

  createAccount({
    required String username,
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    final navigator = ScaffoldMessenger.of(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.showSnackBar(
            snackbarInstance.customSnackBar(content: 'Senha muito fraca.'));
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.showSnackBar(snackbarInstance.customSnackBar(
            content: 'Este Email já está sendo utilizado.'));
        log('The account already exists for that email.');
      }
    }
  }

  signOut({required BuildContext context}) async {
    final navigator = ScaffoldMessenger.of(context);
    try {
      await instance.signOut();
    } catch (e) {
      navigator.showSnackBar(
        snackbarInstance.customSnackBar(
            content: 'Erro ao sair. Tente novamente.'),
      );
      log('Não foi possível sair, tente novamente');
    }
  }

  swicthMode() {
    isRegister.value = !isRegister.value;
    update();
  }
}
