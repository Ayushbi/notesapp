import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/Favourite.dart';
import 'package:notes_app/screens/main_notes.dart';
import 'package:notes_app/screens/setting.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/services/database.dart';
import 'package:notes_app/model/Get_model.dart';

class Note_editor extends StatefulWidget {
  final Note? index;

  const Note_editor([this.index]);

  @override
  State<Note_editor> createState() => _Note_editorState();
}

class _Note_editorState extends State<Note_editor> {
  final headingController = TextEditingController();
  final QuillController controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      headingController.text = widget.index!.title;
      controller.document = Document()
        ..insert(0, widget.index!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (item) async {
              if (item == "Save" &&
                  controller.document
                      .toPlainText()
                      .trim()
                      .isNotEmpty &&
                  headingController.text
                      .trim()
                      .isNotEmpty) {
                bool resposne = await firebase.Save(
                  headingController.text,
                  controller.document.toPlainText(),
                );
                if (resposne == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("save"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  headingController.clear();
                  controller.document = Document();
                }
              }
              if (item == "Discard") {
                headingController.clear();
                controller.clear();
              }
              if (item == "Delete") {
                var data = await firebase.delete(widget.index!.id);

                if (data == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("deleted"),duration: Duration(seconds: 1),)
                  );
                }
                Navigator.pushReplacement(context, MaterialPageRoute
                  (builder: (context) => Main_notes()));
              }
              if (item == "update") {
              final data =await firebase.update(
                  widget.index!.id,
                  headingController.text,
                  controller.document.toPlainText());
              if(data==true){
                ScaffoldMessenger.of(context).showSnackBar
                  (SnackBar(content: Text("updated"),
                  duration: Duration(seconds: 1),));
                Navigator.pushReplacement(context, MaterialPageRoute
                  (builder: (context)=>Main_notes()));
              }
              }
            },
            itemBuilder: (context) =>
            [
              PopupMenuItem(child: Text("Save"), value: "Save"),
              PopupMenuItem(child: Text("Discard"), value: "Discard"),
              PopupMenuItem(child: Text("Delete"), value: "Delete"),
              PopupMenuItem(child: Text("update"), value: "update"),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: QuillSimpleToolbar(
                  controller: controller,
                  config: const QuillSimpleToolbarConfig(
                    showUndo: false,
                    showDividers: false,
                    showFontFamily: false,
                    showSubscript: false,
                    showSuperscript: false,
                    showRedo: false,
                    showClipboardCut: false,
                    showClipboardCopy: false,
                    showClipboardPaste: false,
                    showSearchButton: false,
                    showQuote: false,
                    showCodeBlock: false,
                    showInlineCode: false,
                    showStrikeThrough: false,
                    showBackgroundColorButton: false,
                    showColorButton: false,
                    showAlignmentButtons: false,
                    showIndent: false,
                    showDirection: false,
                    showHeaderStyle: false,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 13),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: headingController,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 13),
                  child: QuillEditor.basic(
                    controller: controller,
                    config: const QuillEditorConfig(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (item) {
          if (item == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Main_notes()),
            );
          }
          if (item == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Favourite()),
            );
          }
          if (item == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => setting()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
