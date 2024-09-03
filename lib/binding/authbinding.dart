import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/navbar_controller.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/controller/theme_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => NoteController());
    Get.lazyPut(() => NavBarController());
    Get.lazyPut(() => ThemeController());
  }
}
