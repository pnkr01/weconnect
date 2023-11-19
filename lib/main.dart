// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weconnect/firebase_options.dart';
import 'package:weconnect/src/app.dart';
import 'package:weconnect/src/constant/print.dart';
import 'package:weconnect/src/db/local_db.dart';
import 'src/global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB().localdbInstance();
  connectdebugPrint(
      "sharedPreferences is initialized ${sharedPreferences != null}");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

