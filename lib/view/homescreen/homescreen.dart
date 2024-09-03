import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/add_note/addnote.dart';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  NoteController noteController = Get.put(NoteController());
  AuthController authController = Get.put(AuthController());
  // Color getRandomColors() {
  //   final random = Random();
  //   return Color.fromARGB(
  //     255,
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     random.nextInt(256),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/addnote');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Obx(() {
            if (noteController.isLoading.value)
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            return Column(children: [
              if (noteController.notes.isEmpty)
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height -
                          200, // Adjust height
                      alignment: Alignment.center,
                      child: Text("Please add some note.")),
                )
              else
                MasonryGridView.count(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    itemCount: noteController.notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      var e = noteController.notes[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed('/addnote', arguments: e),
                        child: Dismissible(
                          key: ValueKey(e.id),
                          onDismissed: (direction) {
                            return noteController.removeNote(e.id.toString());
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 22, right: 24),
                              // height: 80,
                              // width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.amber[(index % 9 + 1) * 100],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    e.description,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    e.dateFormat,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 112, 111, 111)),
                                  )
                                ],
                              )),
                        ),
                      );
                    }),
              ElevatedButton(
                  onPressed: () {
                    authController.signOut();
                  },
                  child: Text('Logout'))
            ]);
          }),
        ),
      ),
    );
  }
}
