import 'package:flutter/material.dart';
class Note{
  String title;
  String data;
  String id;
  Note({
    required this.title,
    required this.data,
    required this.id
});
  factory Note.database(Map<String ,dynamic>data, String id){
    return Note(title:data['title'], data: data['data'],
    id: id,
    );
  }

}
