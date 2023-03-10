import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/core/components/custom_app_bar.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:exclusive_diary/app/pages/home/diary/controller/diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'diary/diary_detail.dart/diary_detail_screen.dart';
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
                    stream: diaryInstance.getDiary(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Você ainda não possui anotações.',
                              style: AppStyle.regularText),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                                backgroundColor: AppStyle.backgroundColor,
                                color: AppStyle.primaryColor),
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Text('Você ainda não possui anotações.',
                              style: AppStyle.regularText),
                        );
                      }

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
                                        Get.to(
                                            () => DiaryDetailScreen(doc: notes),
                                            curve: Curves.easeIn,
                                            transition: Transition.fadeIn,
                                            routeName: '/detail');
                                      },
                                      doc: notes))
                                  .toList()
                                  .cast()));
                    }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.add, color: AppStyle.primaryColor),
            backgroundColor: AppStyle.secondaryColor,
            onPressed: () {
              Get.toNamed('/edit');
            },
            label: Text(
              'Crie uma história',
              style: AppStyle.regularText,
            ),
          )),
    );
  }
}
