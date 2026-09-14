import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/Provider/theme_provider.dart';
import 'package:notes_app/screens/Login.dart';
import 'package:notes_app/screens/SplashScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/screens/add_Notes.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:notes_app/screens/setting.dart';
import 'package:notes_app/services/database.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Step 1: Prepare Flutter
  WidgetsFlutterBinding.ensureInitialized();
  // Step 2: Initialize Firebase and wait until it's ready
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");
  // if (token != null) {
  //   await firebase.SaveToken(token);
  // }
  runApp(
    ProviderScope(
        child: const Notes()
    )
  );
}

class Notes extends ConsumerStatefulWidget {
  const Notes({super.key});

  @override
  ConsumerState<Notes> createState() => _NotesState();
}

class _NotesState extends ConsumerState<Notes> {

  @override
  Widget build(BuildContext context) {
    final isDark=ref.watch(Theme_setting);
    return MaterialApp(
      localizationsDelegates: FlutterQuillLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: isDark
            ? ThemeMode.dark
            : ThemeMode.light,
      home: Splashscreen()
    );
  }
}
