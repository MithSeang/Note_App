import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> _user = Rx<User?>(_auth.currentUser);
  var isLoading = false.obs;

  loadingData() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  Rx<User?> get user => _user;
  Rx<UserModel?> firestoreUser = Rx<UserModel?>(null);

  @override
  void onReady() {
    _user.bindStream(_auth.authStateChanges());
    ever(_user, initScreen);
    super.onReady();
  }

  //handle user login or not
  void initScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/Login');
    } else {
      isLoading.value = true;
      // print("Login: isLoading set to true");

      // Fetch user(name) data from Firestore because firebase auth have problem null
      try {
        fetchFirestoreName(user.uid);
        Get.offAllNamed('/');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> fetchFirestoreName(String uid) async {
    print("Fetching Firestore name...");

    try {
      // isLoading.value = true;
      var doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        firestoreUser.value = UserModel.fromJson(doc.data()!, doc.id);
        print("Fetched user from Firestore: ${firestoreUser.value?.name}");
      } else {
        Get.snackbar('Error', 'User data not found in Firestore.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data from Firestore: $e');
      print("Failed to fetch user data from Firestore: $e");
    } finally {
      // isLoading.value = false;
    }
  }

  void login(
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;
      print("Login: isLoading set to true");

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => loadingData());
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.snackbar('Error', "${e.message}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(
    String email,
    String name,
    String password,
  ) async {
    isLoading.value = true;
    print('isLoading is true');
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //get the information user
      User? user = userCredential.user;

      if (user != null) {
        UserModel users = UserModel(
            uid: user.uid, email: email, name: name, createAt: Timestamp.now());
        await firestore
            .collection('users')
            .doc(user.uid)
            .set(users.UserToMap())
            .then((value) => loadingData());
        print('isLoading is false');
      }

      // store user information to firestore
      print("User registered and data stored successfully.");
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.snackbar('Error', "${e.message}");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/Login');
    } catch (e) {}
  }
}
