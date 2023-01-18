import 'dart:developer';

import 'package:exclusive_diary/app/core/components/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogleController {
  final CustomSnackbar snackbarInstance = Get.put(CustomSnackbar());
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    final navigator = ScaffoldMessenger.of(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
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
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            navigator.showSnackBar(
              snackbarInstance.customSnackBar(
                content: 'Conta já registrada',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            navigator.showSnackBar(
              snackbarInstance.customSnackBar(
                content: 'Login inválido. Tente novamente.',
              ),
            );
          }
        } catch (e) {
          navigator.showSnackBar(
            snackbarInstance.customSnackBar(
              content: 'Erro ao acessar a conta. Tente novamente.',
            ),
          );
        }
      }
    }
    return user;
  }

  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackbarInstance.customSnackBar(
          content: 'Erro ao sair. Tente novamente.',
        ),
      );
    }
  }
}
