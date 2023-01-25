// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class DiaryDetailScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;

  DiaryDetailScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.notesColor[colorId],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppStyle.primaryColor),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppStyle.notesColor[colorId],
        title: Text(
          widget.doc['diary_title'],
          style: AppStyle.mainText
              .copyWith(fontFamily: 'DancingScript-Regular', fontSize: 32),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['creation_date'], style: AppStyle.mainText),
            const SizedBox(height: 28),
            Text(widget.doc['diary_content'], style: AppStyle.regularText),
          ],
        ),
      ),
    );
  }
}
