import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_style.dart';
import '../controller/diary_controller.dart';

class DiaryEditScreen extends StatefulWidget {
  const DiaryEditScreen({super.key});

  @override
  State<DiaryEditScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends State<DiaryEditScreen> {
  final DiaryController diaryInstance = Get.find<DiaryController>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();
    String convertedDateTime =
        "${now.day.toString()}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppStyle.backgroundColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppStyle.primaryColor),
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppStyle.backgroundColor,
            title: Text(
              'Escreva sua história',
              style: AppStyle.mainText
                  .copyWith(fontFamily: 'DancingScript-Regular', fontSize: 32),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  style: AppStyle.mainText,
                  controller: titleController,
                  cursorColor: AppStyle.primaryColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Adicione um título',
                    hintStyle: AppStyle.mainText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(convertedDateTime, style: AppStyle.mainText),
                const SizedBox(height: 28),
                TextFormField(
                  style: AppStyle.regularText,
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: AppStyle.primaryColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descreva como foi seu dia',
                      hintStyle: AppStyle.regularText),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppStyle.secondaryColor,
            onPressed: () {
              diaryInstance.diaryEdit(
                  title: titleController.text,
                  time: convertedDateTime,
                  content: contentController.text);
            },
            child: const Icon(Icons.check_outlined, color: AppStyle.primaryColor),
          ),
        ),
      ),
    );
  }
}
