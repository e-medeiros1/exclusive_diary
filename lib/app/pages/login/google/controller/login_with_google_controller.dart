import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/pages/home/home_screen.dart';
import 'package:exclusive_diary/app/pages/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogleController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GoogleSignIn googleSign = GoogleSignIn();
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  late Rx<User?> user;

  signInWithGoogle({required BuildContext context}) async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        await auth.signInWithPopup(authProvider);
      } catch (e) {
        log('Erro ao acessar credencial de usuário', error: e);
        throw Exception('Erro ao acessar credencial de usuário');
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          await auth.signInWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            Get.snackbar('Erro!', 'Conta já registrada.');
          } else if (e.code == 'invalid-credential') {
            Get.snackbar('Erro!', 'Login inválido. Tente novamente.');
          }
        } catch (e) {
          Get.snackbar('Erro!', 'Erro ao acessar a conta, tente novamente.');
          log('ERROR FIREBASE', error: e);
          throw Exception('Erro ao acessar credencial de usuário');
        }
      }
    }
  }


  void onReady() {

    final GoogleSignIn googleSignIn = GoogleSignIn();

    user = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);

    user.bindStream(auth.userChanges());
    ever(user, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  signOut({required BuildContext context}) async {
    GoogleSignIn googleSign = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSign.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar('Erro!', 'Erro ao sair. Tente novamente.');
      log('ERROR FIREBASE', error: e);
      throw Exception('Erro ao acessar credencial de usuário');
    }
  }
}
