import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/model/add_model.dart';
import 'package:note_app/service/firestore_service.dart';

class NoteController extends GetxController {
  var notes = <Add_Model>[].obs;
  var uidd = ''.obs; //new
  var isLoading = true.obs;
  final FireStore_Service firestore =
      FireStore_Service(); // create obj for class firestore service

  // var uid = Get.find<AuthController>().user.value?.uid;

  @override
  void onInit() {
    super.onInit();
    // ever(Get.find<AuthController>().user, (User? user) {
    //   if (user == null) {
    //     clearNotes(); // Clear notes when the user logs out
    //     isLoading.value = true;
    //   } else {
    //     fetchNote(user.uid); // Fetch notes for the logged-in user
    //   }
    // });

    //new
    ever(Get.find<AuthController>().user, _handleUserChange);
  }

  //new version
  void _handleUserChange(User? user) {
    if (user == null) {
      clearNotes();
      uidd.value = '';
    } else {
      uidd.value = user.uid;
      fetchNote(user.uid);
    }
  }

  void clearNotes() {
    notes.clear();
    isLoading.value = true; // Ensure loading indicator is shown
  }

  Future<void> fetchNote(String uid) async {
    try {
      print('fetch note for user id:$uid');
      isLoading.value = true;
      notes.bindStream(firestore.getNote(uid));
      // notes.listen((_) {
      //   isLoading.value = false;
      // });

      //new
      // await notes.stream.first;
    } catch (e) {
      print('message:${e}');
    } finally {
      isLoading.value = false;
    }

    // if (uid != null) {
    //   notes.bindStream(firestore.getNote(uid));
    //   print('UID get notes stream.');
    // } else {
    //   print('UID cannot get');
    // }
  }

  Future<void> addNote(Add_Model note) async {
    // if (uid != null) {
    try {
      if (uidd.isNotEmpty) {
        await firestore.AddNotes(note, uidd.value);
        print('Note added. Fetching notes...');
        // fetchNote(uid!);
        fetchNote(uidd.value);
      }
    } catch (e) {
      print("message:$e");
    }
  }

  Future<void> updateNote(Add_Model note) async {
    if (uidd.isNotEmpty) {
      await firestore.UpdateNote(note, uidd.value);
    }
  }

  Future<void> removeNote(String id) async {
    if (uidd.isNotEmpty) {
      firestore.Delete(id, uidd.value);
    }
  }
}
