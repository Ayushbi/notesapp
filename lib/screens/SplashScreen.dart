import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/Login.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    final SharedPreferences token = await SharedPreferences.getInstance();
    if (token.getBool("Login") == true) {
      Timer(Duration(seconds: 2), () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Main_notes()),
        );
      });
    }else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:(context)=>Login() ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
