import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/profile_controller.dart';
import 'package:note_app/model/user_model.dart';

class Profile_Screen extends StatelessWidget {
  Profile_Screen({super.key});

  // UserModel? userss;
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final emailController =
        TextEditingController(text: authController.user.value?.email);
    final nameController =
        TextEditingController(text: authController.firestoreUser.value?.name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    "https://images.ctfassets.net/lh3zuq09vnm2/yBDals8aU8RWtb0xLnPkI/19b391bda8f43e16e64d40b55561e5cd/How_tracking_user_behavior_on_your_website_can_improve_customer_experience.png"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: nameController,
                readOnly: profileController.isRead.value,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (profileController.isRead.value) {
                            profileController.change();
                          } else {
                            profileController.updateName(nameController.text);
                            profileController.change();
                            print(nameController.text);
                          }
                        },
                        icon: Icon(profileController.isRead.value
                            ? Icons.edit
                            : Icons.check)),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(),
                    focusColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: TextField(
                controller: emailController,
                readOnly: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(),
                    focusColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
