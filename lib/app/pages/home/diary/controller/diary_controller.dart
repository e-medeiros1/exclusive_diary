import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DiaryController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshots;
  QueryDocumentSnapshot? documentSnapshot;
  FirebaseFirestore instance = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  getDiary() {
    snapshots = instance.collection('Diary').snapshots();
    return snapshots;
  }

  getUser() async {
    final myUser = user!.uid;
    return myUser;
  }

  diaryEdit({title, time, content}) {
    final myUserUid = getUser();
    if (myUserUid == instance.collection('Diary').doc('users').id) {
      instance
          .collection('Diary')
          .doc('users')
          .set({
            'diary_title': title,
            'creation_date': time,
            'diary_content': content,
          })
          .then((value) => Get.toNamed('/home'))
          .catchError(
            (error) {
              log('Não foi possível salvar sua anotação!', error: error);
              throw Get.snackbar(
                  'Erro!', 'Não foi possível salvar suas anotações.');
            },
          );
    } else {
      instance
          .collection('Diary')
          .add({
            'diary_title': title,
            'creation_date': time,
            'diary_content': content,
          })
          .then((value) => Get.toNamed('/home'))
          .catchError(
            (error) {
              log('Não foi possível salvar sua anotação!', error: error);
              throw Get.snackbar(
                  'Erro!', 'Não foi possível salvar suas anotações.');
            },
          );
    }
  }

  deleteDiary() {
    instance.collection('Diary').doc('users').delete().then(
        (doc) => Get.snackbar('Excluído!', 'Anotação excluídas com sucesso!'));

    update();
  }
}
