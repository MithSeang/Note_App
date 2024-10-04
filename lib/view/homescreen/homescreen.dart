import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/navbar_controller.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  NoteController noteController = Get.put(NoteController());
  AuthController authController = Get.put(AuthController());
  NavBarController navBarController = Get.put(NavBarController());
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
      body: Obx(() {
        // Future.delayed(Duration(milliseconds: 1000)).then((value) {
        if (noteController.isLoading.value) {
          return Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator(
                      color: Colors.blue,
                    )
                  : CircularProgressIndicator(
                      color: Colors.blue,
                    ));
        }

        if (noteController.notes.isEmpty) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: Text('Please add some note.'),
            ),
          );
        }

        return Container(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: MasonryGridView.count(
                // physics: BouncingScrollPhysics(),
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                controller: navBarController.controller.value,
                padding: EdgeInsets.symmetric(vertical: 12),
                itemCount: noteController.notes.length,
                itemBuilder: (BuildContext context, int index) {
                  var e = noteController.notes[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed('/addnote', arguments: e),
                    child: Dismissible(
                      key: ValueKey(e.id),
                      onDismissed: (direction) {
                        noteController.removeNote(e.id.toString());
                      },
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                e.description,
                                overflow: TextOverflow.ellipsis,
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
                                    color: Color.fromARGB(255, 112, 111, 111)),
                              )
                            ],
                          )),
                    ),
                  );
                }),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navBarController.scrollTop();
        },
        child: Icon(Icons.arrow_upward_rounded),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(
      Duration(seconds: 1),
      () {
        noteController.fetchNote(authController.user.value!.uid);
      },
    );
  }
}
