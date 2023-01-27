// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';

Widget diaryCard({Function()? onTap, Function()? onLongPress, QueryDocumentSnapshot? doc}) {
  return GestureDetector(
    onTap: onTap,
    onLongPress: onLongPress,
    child: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppStyle.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppStyle.primaryColor),
        boxShadow: const [
          BoxShadow(
              color: AppStyle.primaryColor,
              blurRadius: 5,
              spreadRadius: -4,
              offset: Offset(0, 5))
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              doc?['diary_title'],
              style: AppStyle.mainText,
              softWrap: true,
            ),
            const SizedBox(height: 8),
            Text(doc?['creation_date'], style: AppStyle.regularText),
            const SizedBox(height: 4),
            Text(
              doc?['diary_content'],
              style: AppStyle.regularText,
              softWrap: true,
            ),
          ],
        ),
      ),
    ),
  );
}
