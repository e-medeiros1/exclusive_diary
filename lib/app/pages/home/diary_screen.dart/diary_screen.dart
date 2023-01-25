import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/home/diary_detail.dart/diary_detail_screen.dart';
import 'package:exclusive_diary/app/pages/home/diary_edit/diary_edit_screen.dart';
import 'package:exclusive_diary/app/pages/home/diary_screen.dart/widgets/diary_card.dart';
import 'package:exclusive_diary/app/pages/login/email/controller/login_with_email_controller.dart';
import 'package:exclusive_diary/app/pages/login/google/controller/login_with_google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginWithGoogleController googleInstance =
        Get.find<LoginWithGoogleController>();
    final LoginWithEmailController emailInstance =
        Get.find<LoginWithEmailController>();
    return Scaffold(
        backgroundColor: AppStyle.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Exclusive Diary',
            style: AppStyle.mainText
                .copyWith(fontFamily: 'DancingScript-Regular', fontSize: 32),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppStyle.backgroundColor,
          iconTheme: AppStyle.themeAppBar.iconTheme,
          actions: [
            GestureDetector(
              onTap: () {
                googleInstance.signOut(context: context);
                emailInstance.signOut(context: context);
              },
              child: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meu diário',
                style: AppStyle.mainText.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Diary').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: AppStyle.backgroundColor,
                          color: AppStyle.primaryColor),
                    );
                  }
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((notes) => diaryCard(
                                onTap: () {
                                  Get.to(() => DiaryDetailScreen(doc: notes));
                                },
                                doc: notes))
                            .toList(),
                      ),
                    );
                  }
                  return Center(
                    child: Text('Você ainda não possui anotações.',
                        style: AppStyle.regularText),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(
            Icons.add,
            color: AppStyle.primaryColor,
          ),
          backgroundColor: AppStyle.secondaryColor,
          onPressed: () {
            Get.to(() => const DiaryEditScreen());
          },
          label: Text(
            'Crie uma história',
            style: AppStyle.mainText,
          ),
        ));
  }
}
