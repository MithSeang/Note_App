import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/navbar_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  final AuthController controller = Get.find<AuthController>();
  final NavBarController navController = Get.find<NavBarController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(label: Text('Email')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is Require.";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => TextFormField(
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
                          ))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Require.";
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  controller.login(emailController.text, pwController.text);
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(18),
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Login")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot password?'),
                TextButton(
                    onPressed: () {
                      emailController.clear();
                      pwController.clear();
                      _formKey.currentState!.reset();
                      Get.toNamed('/signup');
                    },
                    child: Text("SignUp"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
