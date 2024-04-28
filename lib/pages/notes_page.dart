import 'package:superapp/theme/theme_provider.dart';
import 'package:superapp/components/drawer.dart';
import 'package:superapp/components/note_tile.dart';
import 'package:superapp/models/note.dart';
import 'package:flutter/material.dart';
import 'package:superapp/models/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:moon_phase/moon_phase.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // text controller
  
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();

    readNotes();
  }

  // create
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              // add to db
              context.read<NoteDatabase>().addNote(textController.text);
              // clear controller
              textController.clear();
              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }

  // read
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Note"),
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: (){
              context
                .read<NoteDatabase>().updateNote(note.id, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }
  
  // delete
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();
    // current note
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text('Notes')
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Notes', 
                  style: GoogleFonts.dmSerifText(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: () {
                      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                      themeProvider.toggleTheme();
                    },
                    child: MoonWidget(
                    date: DateTime.now(),
                    resolution: 128,
                    size: 48,
                    moonColor: const Color.fromARGB(255, 255, 255, 255),
                    earthshineColor: Theme.of(context).colorScheme.secondary
                  )
                ),
              ),
            ],
          ),
          // List of Notes
          Expanded(
            child: (
              ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  return NoteTile(
                    text: note.text,
                    onEditPressed: () => updateNote(note),
                    onDeletePressed: () => deleteNote(note.id),
                  );
                },
              )
            ),
          )
        ],
      )
    );
  }
}