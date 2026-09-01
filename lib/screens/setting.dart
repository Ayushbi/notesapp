import 'package:flutter/material.dart';
import 'package:notes_app/Provider/theme_provider.dart';
import 'package:notes_app/screens/add_Notes.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class setting extends ConsumerStatefulWidget{
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
                value:   ref.watch(Theme_setting),
                onChanged: (value) {
                  ref.read(Theme_setting.notifier).state = value;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (item) {
          if(item==0){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>Main_notes()));
          }else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>Note_editor())
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: "Editor"),

        ],
      ),
    );
  }
}
