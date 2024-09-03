import 'package:get/get.dart';

class NavBarController extends GetxController {
  var currentIndex = 0.obs;
  var isVisible = true.obs;

  void tabIndex(int index) {
    currentIndex.value = index;
  }

  void changeVisible() {
    isVisible.value = !isVisible.value;
  }
}
