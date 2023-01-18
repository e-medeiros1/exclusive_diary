import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/exclusive_diary.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ExclusiveDiary());
}
