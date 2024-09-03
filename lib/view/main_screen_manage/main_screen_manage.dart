import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/navbar_controller.dart';
import 'package:note_app/view/homescreen/homescreen.dart';
import 'package:note_app/view/setting_screen/setting_screen.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MainScreenManage extends StatelessWidget {
  MainScreenManage({super.key});

  final controller = Get.put(NavBarController());
  var listPage = [HomeScreen(), Setting_Screen()];
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoading.value) {
        return Scaffold(
          body: Platform.isIOS
              ? Center(
                  child: CupertinoActivityIndicator(
                    color: CupertinoColors.activeBlue,
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
        );
      } else {
        return Scaffold(
          body: listPage[controller.currentIndex.value],
          bottomNavigationBar: _buildBottomNavBar(
              context, controller.currentIndex.value, controller.tabIndex),
        );
      }
    });
  }

  Widget _buildBottomNavBar(
      BuildContext context, int index, void Function(int)? onTap) {
    return BottomNavigationBar(currentIndex: index, onTap: onTap, items: [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: 'Setting'),
    ]);
  }
}
