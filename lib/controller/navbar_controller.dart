import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  var currentIndex = 0.obs;
  var isVisible = true.obs;
  final controller = ScrollController().obs;

  void tabIndex(int index) {
    currentIndex.value = index;
  }

  //scroll controller
  void scrollTop() {
    print('Current Scroll Position: ${controller.value.position.pixels}');

    controller.value.animateTo(controller.value.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    print('scroll Top called');
  }

  //for textfield
  void changeVisible() {
    isVisible.value = !isVisible.value;
  }
}
