import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/core/components/custom_app_bar.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/home/diary/controller/diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'diary/diary_detail.dart/diary_detail_screen.dart';
import 'diary/diary_edit/diary_edit_screen.dart';
import 'diary/widgets/diary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final CustomAppBar customAppBarInstance = Get.put(CustomAppBar());
    final DiaryController diaryInstance = Get.put(DiaryController());

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppStyle.backgroundColor,
          appBar: customAppBarInstance.buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: diaryInstance.getDiarySnap(),
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
                                  onLongPress: () {
                                    diaryInstance.deleteDiary();
                                  },
                                  onTap: () {
                                    Get.to(() => DiaryDetailScreen(
                                          doc: notes,
                                        ));
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
            icon: const Icon(Icons.add, color: AppStyle.primaryColor),
            backgroundColor: AppStyle.secondaryColor,
            onPressed: () {
              Get.to(() => const DiaryEditScreen());
            },
            label: Text(
              'Crie uma história',
              style: AppStyle.regularText,
            ),
          )),
    );
  }
}
