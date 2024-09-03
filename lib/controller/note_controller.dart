import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/model/add_model.dart';
import 'package:note_app/model/user_model.dart';
import 'package:note_app/service/firestore_service.dart';

class NoteController extends GetxController {
  var notes = <Add_Model>[].obs;
  var isLoading = false.obs;
  var uid = Get.find<AuthController>().user.value?.uid;
  final FireStore_Service firestore =
      FireStore_Service(); // create obj for class firestore service

  @override
  void onInit() async {
    if (uid != null) {
      notes.bindStream(firestore.getNote(uid!));
      print('UID get notes stream.');
    } else {
      print('UID cannot get');
    }

    super.onInit();
  }

  void addNote(Add_Model note) async {
    firestore.AddNotes(note, uid!);
  }

  void updateNote(Add_Model note) {
    firestore.UpdateNote(note, uid!);
  }

  void removeNote(String id) {
    firestore.Delete(id, uid!);
  }
}
