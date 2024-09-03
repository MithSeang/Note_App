import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/model/add_model.dart';
import 'package:note_app/model/user_model.dart';

class AddNote extends StatelessWidget {
  AddNote({
    super.key,
  }) : note = Get.arguments;
  Add_Model? note;
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final NoteController noteController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    if (note != null) {
      titleController.text = note!.title;
      desController.text = note!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? "Add Note" : "Update Note"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(label: Text('Title')),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
                controller: desController,
                maxLines: 5,
                minLines: 1,
                maxLength: 255,
                decoration: InputDecoration(label: Text('Description'))),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () async {
                if (note == null) {
                  Add_Model note = Add_Model(
                      title: titleController.text,
                      description: desController.text,
                      createAt: DateTime.now());
                  noteController.addNote(
                    note,
                  );
                } else {
                  Add_Model updatenote = Add_Model(
                      id: note!.id,
                      title: titleController.text,
                      description: desController.text,
                      createAt: DateTime.now());
                  noteController.updateNote(updatenote);
                }
                print('Added Note');
                Get.back();
                titleController.clear();
                desController.clear();
              },
              child: Text(note == null ? "Save" : "Update"))
        ],
      ),
    );
  }
}
