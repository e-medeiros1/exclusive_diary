import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DiaryController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshots;
  QueryDocumentSnapshot? documentSnapshot;
  FirebaseFirestore instance = FirebaseFirestore.instance;
  getDiarySnap() {
    snapshots = instance.collection('Diary').snapshots();
    return snapshots;
  }

  diaryEdit({title, time, content}) {
    instance
        .collection('Diary')
        .doc('users')
        .set({
          'diary_title': title,
          'creation_date': time,
          'diary_content': content,
        })
        .then((value) => Get.offNamed('/home'))
        .catchError(
          (error) {
            log('Não foi possível salvar sua anotação!', error: error);
            throw Get.snackbar(
                'Erro!', 'Não foi possível salvar suas anotações.');
          },
        );
  }

  deleteDiary() {
    instance.collection('Diary').doc('users').delete().then(
        (doc) => Get.snackbar('Excluído!', 'Diário excluído com sucesso!'));
    update();
  }
}
