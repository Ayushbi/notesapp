import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/screens/Login.dart';
import 'package:notes_app/screens/SplashScreen.dart';

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
  runApp(const Notes());
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      localizationsDelegates: FlutterQuillLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      home: Splashscreen()
    );
  }
}
