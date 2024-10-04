import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/binding/authbinding.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/controller/theme_controller.dart';
import 'package:note_app/firebase_options.dart';
import 'package:note_app/view/add_note/addnote.dart';
import 'package:note_app/view/login/login_screen.dart';
import 'package:note_app/view/login/signup_screen.dart';
import 'package:note_app/view/main_screen_manage/main_screen_manage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  Get.put(NoteController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.put(ThemeController());

  final lightTheme = ThemeData.from(
      colorScheme: const ColorScheme.light(
    primary: Colors.blue,
  ));

  final darkTheme = ThemeData.from(
      colorScheme: const ColorScheme.dark(primary: Colors.blueGrey));
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      // theme: ThemeData.light(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      darkTheme: darkTheme,
      themeMode:
          themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      initialBinding: AuthBinding(),
      getPages: [
        GetPage(
            name: '/', page: () => MainScreen_Manage(), binding: AuthBinding()),
        GetPage(name: '/Login', page: (() => LoginScreen())),
        GetPage(
          name: '/addnote',
          page: () => AddNote(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpScreen(),
        )
      ],
    );
  }
}
