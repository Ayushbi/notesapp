
import 'package:flutter/material.dart';

class Bottom{
  static Widget Button(int index,Function(int ) ontap){
    return  BottomNavigationBar(
      currentIndex: index,
      onTap: ontap,
        items:[
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite"),
      BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Setting"),
    ]);

  }
}