import 'package:flutter/material.dart';
import 'package:notes_app/Provider/theme_provider.dart';
import 'package:notes_app/screens/Login.dart';
import 'package:notes_app/screens/add_Notes.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class setting extends ConsumerStatefulWidget {
  const setting({super.key});

  @override
  ConsumerState<setting> createState() => _settingState();
}

class _settingState extends ConsumerState<setting> {
  bool isdark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Theme"),
              trailing: Switch(
                value: ref.watch(Theme_setting),
                onChanged: (value) {
                  ref.read(Theme_setting.notifier).state = value;
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () async {
                final SharedPreferences token =
                    await SharedPreferences.getInstance();
                token.remove("Login");
                if (token.getBool("Login") == null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>Login()));
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (item) {
          if (item == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Main_notes()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Note_editor()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Editor"),
        ],
      ),
    );
  }
}
