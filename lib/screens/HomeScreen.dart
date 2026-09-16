
import 'package:flutter/material.dart';
import 'package:notes_app/Provider/theme_provider.dart';
import 'package:notes_app/screens/BottomNavigation/common_buttons.dart';
import 'package:notes_app/screens/Favourite.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:notes_app/screens/setting.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Widget>pages=[Main_notes(),Favourite(),Main_setting()];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Bottom.Button(index,(item){
        setState(() {
          index=item;
        });
      } ),
    );
  }
}
