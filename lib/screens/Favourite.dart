import 'package:flutter/material.dart';
import 'package:notes_app/Provider/theme_provider.dart';
import 'package:notes_app/model/Get_model.dart';
import 'package:notes_app/screens/add_Notes.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:notes_app/services/database.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<Note> fav = [];

  Future<void>Favourite()async{
    try{
       final data=await firebase.getFavourite();
        setState(() {
          fav=data;
        });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error:$e"))
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Favourite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite  Notes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child:
            ListView.builder(
              itemCount: fav.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.note),
                  title: Text(fav[index].title),
                trailing: Icon(Icons.favorite,color: Colors.red,),
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => Note_editor(fav[index]),
                     ),
                   );
                 },
                );
              },

        ),
      ),

    );
  }
}
