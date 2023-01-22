import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/home_screen.dart';
import '../../login_screen.dart';

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
        Get.snackbar('Erro', 'Usuário não cadastrado');
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Erro!', 'Senha incorreta');
        log('Wrong password provided for that user.');
      }
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao acessar a conta. Tente novamente.');
      log('ERROR FIREBASE', error: e);
    }
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
      if (e.code == 'weak-password') {
        Get.snackbar('Erro!', 'Senha muito fraca');

        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Erro!', 'Esse email já está sendo utilizado');
        log('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        Get.snackbar('Erro!', 'Usuário não cadastrado');
        log('User not found, maybe have been deleted.');
      }
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao acessar a conta. Tente novamente.');
      log('ERROR FIREBASE', error: e);
      throw Exception('Erro ao acessar credencial de usuário');
    }
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
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  signOut({required BuildContext context}) async {
    try {
      await instance.signOut();
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao sair, tente novamente.');
      log('Não foi possível sair, tente novamente', error: e);
      throw Exception('Erro ao acessar credencial de usuário');
    }
  }
}
