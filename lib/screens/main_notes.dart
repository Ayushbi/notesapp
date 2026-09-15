import 'package:flutter/material.dart';
import 'package:notes_app/model/Get_model.dart';
import 'package:notes_app/screens/add_Notes.dart';
import 'package:notes_app/screens/setting.dart';
import 'package:notes_app/services/database.dart';

class Main_notes extends StatefulWidget {
  const Main_notes({super.key});

  @override
  State<Main_notes> createState() => _Main_notesState();
}

class _Main_notesState extends State<Main_notes> {
  List<Note> notes = [];

  Future<void> load() async {
    try {
      notes = await firebase.get();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (item) async {
              if (item == 'New') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Note_editor()),
                );
              }
              if (item == 'Delete') {
                await firebase.delete_all();
                setState(() {
                  notes.clear();
                });
              }
            },

            itemBuilder: (context) => [
              const PopupMenuItem(child: Text("New note"), value: "New"),
              const PopupMenuItem(child: Text("Delete all"), value: "Delete"),

            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.format_bold)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.format_italic)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.format_underline),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.title)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.subject)),
                ],
              ),
              SizedBox(height: 17),

              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(Icons.note),
                        title: Text(notes[index].title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Note_editor(notes[index]),
                            ),
                          );
                        },
                        trailing:IconButton(
                            onPressed: ()async{
                          setState(() {
                            notes[index].favourite = !notes[index].favourite;
                          });
                            try{
                             await firebase.Favourite(notes[index].id, notes[index].favourite);
                            }
                            catch(e){
                              ScaffoldMessenger.of(context).showSnackBar
                                (SnackBar(content: Text("error $e")));
                            }

                        },
                            icon: notes[index].favourite
                                ?Icon(Icons.favorite,color: Colors.red,)
                                :Icon(Icons.favorite_border))
                      ),
                    );
                  },
                  itemCount: notes.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Note_editor()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (item) {
          if (item == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => setting()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(item.toString()),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
