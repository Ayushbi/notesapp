import 'package:flutter/material.dart';
import 'package:notes_app/screens/add_Notes.dart';
import 'package:notes_app/screens/main_notes.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
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
                value: isdark,
                onChanged: (value) {
                  setState(() {
                    isdark= value;
                  });
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
