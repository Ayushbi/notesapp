import 'package:flutter/material.dart';
class Note{
  String title;
  String data;
  String id;
  bool favourite;
  Note({
    required this.title,
    required this.data,
    required this.id,
     this.favourite=false,
});
  factory Note.database(Map<String ,dynamic>data, String id){
    return Note(title:data['title'], data: data['data'],
    id: id,
      favourite: data['favourite'] ?? false,
    );
  }

}
