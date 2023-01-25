// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';

Widget diaryCard({Function()? onTap, QueryDocumentSnapshot? doc}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppStyle.notesColor[doc?['color_id']],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(doc?['diary_title'], style: AppStyle.mainText)),
          const SizedBox(height: 8),
          Text(doc?['creation_date'], style: AppStyle.regularText),
          const SizedBox(height: 4),
          Text(doc?['diary_content'], style: AppStyle.regularText),
        ],
      ),
    ),
  );
}
