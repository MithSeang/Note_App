import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/auth_controller.dart';

class ProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isRead = true.obs;
  final _uid = Get.find<AuthController>().user.value?.uid;
  final _auth = Get.find<AuthController>();

  void change() {
    isRead.value = !isRead.value;
  }

  void updateName(String newName) async {
    _auth.firestoreUser.value?.name = newName;
    _auth.firestoreUser.refresh(); //refresh ui after changed
    await firestore.collection('users').doc(_uid).update({'name': newName});
  }
}
