import 'dart:developer';

import 'package:exclusive_diary/app/pages/carousel/carousel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/home_screen.dart';

class LoginWithEmailController extends GetxController {
  final FirebaseAuth instance = FirebaseAuth.instance;
  late final Rx<User?> user;

  Future<void> loginWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      instance.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        throw Get.snackbar('Erro', 'Usuário não cadastrado');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        throw Get.snackbar('Erro!', 'Senha incorreta');
      }
    } catch (e) {
      log('ERROR FIREBASE', error: e);
      throw Get.snackbar('Erro!', 'Erro ao acessar a conta. Tente novamente.');
    }
    update();
  }

  Future<void> createAccount({
    required String username,
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        throw Get.snackbar('Erro!', 'Esse email já está sendo utilizado');
      } else if (e.code == 'user-not-found') {
        log('User not found, maybe have been deleted.');
        throw Get.snackbar('Erro!', 'Usuário não cadastrado');
      }
    } catch (e) {
      log('ERROR FIREBASE', error: e);
      throw Get.snackbar('Erro!', 'Erro ao acessar a conta. Tente novamente.');
    }
    update();
  }

  resetPassword({required String email}) async {
    await instance.sendPasswordResetEmail(email: email).catchError((error) =>
        Get.snackbar(
            'Recuperação de senha!', 'Erro ao enviar email de recuperação.'));
  }

  @override
  void onReady() {
    super.onReady();

    user = Rx<User?>(instance.currentUser);
    user.bindStream(instance.userChanges());

    ever(user, _authenticationUser);
  }

  _authenticationUser(User? user) {
    if (user == null) {
      Get.offAll(() => const CarouselScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  signOut({required BuildContext context}) async {
    try {
      await instance.signOut();
    } on FirebaseAuthException catch (e) {
      log('Não foi possível sair, tente novamente', error: e);

      throw Get.snackbar('Erro!', 'Erro ao sair, tente novamente.');
    }
    update();
  }
}
