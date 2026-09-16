import 'package:flutter/material.dart';
import 'package:notes_app/Provider/theme_provider.dart';
import 'package:notes_app/screens/Login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Main_setting extends ConsumerStatefulWidget {
  const Main_setting({super.key});

  @override
  ConsumerState<Main_setting> createState() => _Main_settingState();
}

class _Main_settingState extends ConsumerState<Main_setting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main_settings", style: TextStyle(fontWeight: FontWeight.bold)),
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
               await token.remove("Login");
                if (!mounted) return;
                if (token.getBool("Login") == null) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=>Login()),
                        (route) => false,);
                }
              },
            ),
          ],
        ),
      ),

    );
  }
}
