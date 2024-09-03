import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/navbar_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final nameController = TextEditingController();
  final AuthController controller = Get.find<AuthController>();
  final NavBarController navController = Get.put(NavBarController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is Require";
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(label: Text('Name')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is Require";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(label: Text('Email')),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is Require";
                      }
                      return null;
                    },
                    obscureText: navController.isVisible.value,
                    controller: pwController,
                    decoration: InputDecoration(
                        label: Text('Password'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              navController.changeVisible();
                            },
                            icon: Icon(
                              navController.isVisible.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility,
                            )))),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(18),
                height: height * 0.06,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signUp(
                          emailController.text.trim(),
                          nameController.text.trim(),
                          pwController.text.trim(),
                        );
                      }
                    },
                    child: Text("Sign Up"))),
          ],
        ),
      ),
    );
  }
}
